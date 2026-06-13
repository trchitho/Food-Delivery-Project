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
