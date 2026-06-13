import axios from 'axios'
import { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import { API_BASE, getAuthToken, isLoggedIn } from '../../utils/foodData'
import RatingStars from './RatingStars'

function FoodReviewSection({ foodId }) {
  const [reviews, setReviews] = useState([])
  const [eligibility, setEligibility] = useState(null)
  const [rating, setRating] = useState(5)
  const [comment, setComment] = useState('')
  const [message, setMessage] = useState('')
  const loggedIn = isLoggedIn()

  const loadReviews = () => axios.get(`${API_BASE}/reviews/food/${foodId}`)
    .then(({ data }) => setReviews(Array.isArray(data) ? data : []))
    .catch(() => setReviews([]))

  useEffect(() => {
    loadReviews()
    if (!loggedIn) return
    axios.get(`${API_BASE}/reviews/food/${foodId}/status`, {
      headers: { Authorization: `Bearer ${getAuthToken()}` },
    }).then(({ data }) => {
      setEligibility(data)
      if (data.review?.rating) setRating(data.review.rating)
      if (data.review?.comment) setComment(data.review.comment)
    }).catch(() => setEligibility({ canReview: false }))
  }, [foodId, loggedIn])

  const average = useMemo(() => reviews.length
    ? reviews.reduce((sum, item) => sum + Number(item.rating || 0), 0) / reviews.length
    : 0, [reviews])

  const submitReview = async (event) => {
    event.preventDefault()
    setMessage('')
    try {
      const { data } = await axios.post(`${API_BASE}/reviews/food/${foodId}`,
        { rating, comment },
        { headers: { Authorization: `Bearer ${getAuthToken()}` } })
      setMessage(data.message || 'Đã lưu đánh giá.')
      await loadReviews()
      setEligibility((current) => ({ ...current, review: { rating, comment } }))
    } catch (error) {
      setMessage(error.response?.data?.message || 'Không thể lưu đánh giá lúc này.')
    }
  }

  return (
    <section className="mt-8 rounded-3xl border border-gray-100 bg-white p-5 shadow-sm dark:border-slate-800 dark:bg-slate-900 sm:p-7">
      <div className="flex flex-wrap items-end justify-between gap-3">
        <div><h2 className="text-2xl font-black">Đánh giá từ khách hàng</h2>
          <p className="mt-1 text-sm text-gray-500">{reviews.length} đánh giá đã xác thực</p></div>
        <div className="text-right"><p className="text-3xl font-black text-orange-500">{average.toFixed(1)}</p>
          <RatingStars value={Math.round(average)} readonly /></div>
      </div>
      <div className="mt-6 space-y-3">
        {reviews.length === 0 ? (
          <p className="rounded-2xl bg-gray-50 p-5 text-gray-500 dark:bg-slate-800">
            Chưa có đánh giá nào cho món này.
          </p>
        ) : reviews.map((review) => (
          <article key={review.id} className="rounded-2xl border border-gray-100 p-4 dark:border-slate-700">
            <div className="flex items-center justify-between gap-3">
              <p className="font-bold">{review.userName}</p>
              <RatingStars value={Number(review.rating)} readonly />
            </div>
            <p className="mt-2 text-sm leading-6 text-gray-600 dark:text-slate-300">{review.comment}</p>
          </article>
        ))}
      </div>
      {!loggedIn && (
        <div className="mt-6 rounded-2xl bg-orange-50 p-4 text-sm text-orange-800">
          <Link to="/login" className="font-black underline">Đăng nhập</Link> để đánh giá món ăn.
        </div>
      )}
