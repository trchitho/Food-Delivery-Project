import axios from 'axios'
import React, { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { API_BASE, addOrder, formatPrice, getFoodImage, isLoggedIn, mergeAdminRestaurants, mergeCatalogCategories } from '../../utils/foodData'

function FoodDetailPage() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [categories, setCategories] = useState([])
  const [restaurants, setRestaurants] = useState([])

  useEffect(() => {
    Promise.all([
      axios.get(`${API_BASE}/category`).catch(() => ({ data: { data: [] } })),
      axios.get(`${API_BASE}/restaurant`).catch(() => ({ data: { data: [] } })),
    ]).then(([categoryRes, restaurantRes]) => {
      setCategories(mergeCatalogCategories(categoryRes.data.data || []))
      setRestaurants(mergeAdminRestaurants(restaurantRes.data.data || []))
    })
  }, [])

  const food = useMemo(() => categories.flatMap((category) => (category.menus || []).map((item) => ({
    ...item,
    categoryName: item.categoryName || category.title || category.name,
  }))).find((item) => String(item.id) === String(id)), [categories, id])
  const restaurant = useMemo(() => restaurants.find((item) => String(item.id) === String(food?.restaurantId) || item.title === food?.restaurantTitle), [restaurants, food])

  const orderFood = () => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: `/food/detail/${id}` } })
      return
    }
    addOrder(food, restaurant)
    navigate('/orders')
  }

  if (!food) {
    return <div className="min-h-screen bg-gray-50"><Navbar /><main className="max-w-5xl mx-auto px-4 py-16"><h1 className="text-2xl font-black">Không tìm thấy món ăn</h1><Link to="/" className="mt-4 inline-flex text-orange-500 font-bold">Về trang chủ</Link></main></div>
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="mx-auto w-full max-w-6xl px-4 py-6 sm:py-10">
        <Link to={restaurant?.id ? `/restaurant/detail/${restaurant.id}` : '/'} className="text-sm font-bold text-orange-500">← Quay lại</Link>
        <section className="mt-5 grid min-w-0 grid-cols-1 gap-6 rounded-2xl border border-gray-100 bg-white p-4 shadow-sm sm:rounded-3xl sm:p-5 lg:grid-cols-[1fr_0.9fr] lg:gap-8">
          <img src={food.image || getFoodImage(food)} alt={food.title} className="aspect-square w-full rounded-2xl bg-gray-100 object-cover sm:aspect-[4/3] lg:h-[420px] lg:aspect-auto" />
          <div className="flex min-w-0 flex-col">
            <p className="text-sm font-bold text-orange-500">{food.categoryName}</p>
            <h1 className="mt-2 break-words text-3xl font-black text-gray-900 sm:text-4xl">{food.title}</h1>
            <p className="mt-4 text-gray-600 leading-7">{food.description || 'Món ăn đang được nhà hàng cập nhật mô tả chi tiết.'}</p>
            <div className="mt-6 grid grid-cols-1 gap-3 min-[380px]:grid-cols-2">
              <div className="rounded-2xl bg-orange-50 p-4"><p className="text-xs font-bold text-orange-600">Giá bán</p><p className="mt-1 text-2xl font-black text-orange-700">{formatPrice(food.price)}</p></div>
              <div className="rounded-2xl bg-slate-50 p-4"><p className="text-xs font-bold text-slate-500">Thời gian giao</p><p className="mt-1 text-2xl font-black text-slate-900">{food.timeShip || '20-30 phút'}</p></div>
              <div className="rounded-2xl bg-green-50 p-4"><p className="text-xs font-bold text-green-600">Ưu đãi</p><p className="mt-1 font-black text-green-800">{food.freeShip ? 'Miễn phí giao hàng' : 'Giao hàng tiêu chuẩn'}</p></div>
              <div className="rounded-2xl bg-blue-50 p-4"><p className="text-xs font-bold text-blue-600">Nhà hàng</p><p className="mt-1 font-black text-blue-900">{restaurant?.title || food.restaurantTitle || 'Đang cập nhật'}</p></div>
            </div>
            <div className="mt-6 rounded-2xl bg-gray-50 p-4 text-sm text-gray-600">
              <p><span className="font-bold text-gray-900">Mô tả nhà hàng:</span> {restaurant?.subtitle || restaurant?.description || 'Đang cập nhật'}</p>
              <p className="mt-2"><span className="font-bold text-gray-900">Địa chỉ:</span> {restaurant?.address || 'Đang cập nhật'}</p>
            </div>
            <button onClick={orderFood} className="mt-6 min-h-12 rounded-2xl bg-orange-500 px-6 py-3 text-sm font-black text-white hover:bg-orange-600 lg:mt-auto">Đặt món này</button>
          </div>
        </section>
      </main>
    </div>
  )
}

export default FoodDetailPage
