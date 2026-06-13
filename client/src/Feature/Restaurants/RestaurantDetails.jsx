import axios from 'axios'
import React, { useEffect, useMemo, useState } from 'react'
import { Link, useNavigate, useParams } from 'react-router-dom'
import { TEXT, CATEGORY_EMOJIS } from '../../constants/text'
import { API_BASE, addOrder, formatPrice, getAdminFoodsFallback, getAdminRestaurantsFallback, getCatalogRestaurantDetail, getFoodImage, getRestaurantImage, isLoggedIn, sanitizeCategoryMenus } from '../../utils/foodData'

function RestaurantDetails() {
  const { id } = useParams()
  const navigate = useNavigate()
  const [restaurantDetail, setRestaurantDetail] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchRestaurantDetail = async () => {
      try {
        const response = await axios.get(`${API_BASE}/restaurant/detail?id=${id}`)
        const apiDetail = response.data.data
        if (!apiDetail?.id) {
          setRestaurantDetail(null)
          return
        }
        const adminRestaurant = (getAdminRestaurantsFallback() || []).find((item) => String(item.id) === String(id))
        const adminFoods = (getAdminFoodsFallback() || []).filter((food) => String(food.restaurantId) === String(id) && (food.status || 'Có sẵn') !== 'Ẩn')
        const categories = sanitizeCategoryMenus(apiDetail.categories || [])
        adminFoods.forEach((food) => {
          const categoryName = food.categoryName || categories.find((category) => String(category.id) === String(food.categoryId))?.name || 'Khác'
          let category = categories.find((item) => item.name === categoryName || String(item.id) === String(food.categoryId))
          if (!category) {
            category = { id: `admin-${categoryName}`, name: categoryName, menus: [] }
            categories.push(category)
          }
          const exists = category.menus.some((item) => String(item.id) === String(food.id))
          category.menus = exists
            ? category.menus.map((item) => String(item.id) === String(food.id) ? { ...item, ...food } : item)
            : [{ ...food, restaurantId: Number(id), restaurantTitle: adminRestaurant?.title || apiDetail.title }, ...category.menus]
        })
        setRestaurantDetail({ ...apiDetail, ...(adminRestaurant || {}), categories: sanitizeCategoryMenus(categories) })
      } catch (error) {
        console.error(error)
        setRestaurantDetail(getCatalogRestaurantDetail(id))
      } finally {
        setLoading(false)
      }
    }

    fetchRestaurantDetail()
  }, [id])

  const menuCount = useMemo(() => {
    return (restaurantDetail?.categories || []).reduce((total, category) => total + (category.menus || []).length, 0)
  }, [restaurantDetail])

  const handleOrder = (food) => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: `/restaurant/detail/${id}` } })
      return
    }
    if (food) {
      addOrder(food, restaurantDetail)
    }
    navigate('/orders')
  }

  if (loading) {
    return (
      <div className="max-w-7xl mx-auto px-4 py-12">
        <div className="animate-pulse h-80 rounded-2xl bg-gray-200" />
      </div>
    )
  }

  if (!restaurantDetail?.id) {
    return (
      <section className="max-w-7xl mx-auto px-4 py-20 text-center">
        <h1 className="text-2xl font-bold text-gray-900">{TEXT.detail_not_found}</h1>
        <Link to="/" className="inline-flex mt-6 text-orange-500 font-semibold">
          {TEXT.detail_back_home}
        </Link>
      </section>
    )
  }

  return (
    <main className="bg-gray-50 min-h-screen">
      <section className="bg-white border-b border-gray-100">
        <div className="mx-auto w-full max-w-7xl px-4 py-6 sm:px-6 sm:py-8 lg:px-8">
          <div className="grid min-w-0 grid-cols-1 items-center gap-6 lg:grid-cols-[1.1fr_0.9fr] lg:gap-8">
            <div className="min-w-0">
              <Link to="/" className="text-sm font-semibold text-orange-500 hover:text-orange-600">
                ← {TEXT.detail_back_home}
              </Link>
              <h1 className="mt-4 break-words text-3xl font-extrabold text-gray-900 sm:text-4xl">{restaurantDetail.title}</h1>
              <p className="mt-2 text-base text-gray-600 sm:text-lg">{restaurantDetail.subtitle}</p>
              <p className="text-gray-600 mt-5 leading-7">{restaurantDetail.description}</p>

              <div className="grid grid-cols-1 sm:grid-cols-3 gap-3 mt-6">
                <div className="rounded-xl bg-orange-50 px-4 py-3">
                  <p className="text-xs font-semibold text-orange-600">{TEXT.detail_rating}</p>
                  <p className="text-xl font-bold text-gray-900">★ {(restaurantDetail.rating || 0).toFixed(1)}</p>
                </div>
                <div className="rounded-xl bg-green-50 px-4 py-3">
                  <p className="text-xs font-semibold text-green-600">Giao hàng</p>
                  <p className="text-xl font-bold text-gray-900">{restaurantDetail.freeShip ? 'Miễn phí' : 'Có phí'}</p>
                </div>
                <div className="rounded-xl bg-gray-100 px-4 py-3">
                  <p className="text-xs font-semibold text-gray-500">Số món</p>
                  <p className="text-xl font-bold text-gray-900">{menuCount}</p>
                </div>
              </div>

              <p className="mt-5 text-sm text-gray-500">
                {TEXT.detail_address}: <span className="font-medium text-gray-700">{restaurantDetail.address}</span>
              </p>

              <button
                onClick={() => handleOrder()}
                className="mt-7 inline-flex min-h-11 w-full items-center justify-center rounded-xl bg-orange-500 px-6 py-3 text-sm font-bold text-white transition-colors hover:bg-orange-600 sm:w-auto"
              >
                {isLoggedIn() ? TEXT.detail_order : TEXT.detail_login_to_order}
              </button>
            </div>

            <div className="aspect-[16/10] overflow-hidden rounded-2xl bg-gray-100 shadow-sm lg:h-96 lg:aspect-auto">
              <img
                src={getRestaurantImage(restaurantDetail, Number(id))}
                alt={restaurantDetail.title}
                className="w-full h-full object-cover"
              />
            </div>
          </div>
        </div>
      </section>

      <section className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <h2 className="text-2xl font-bold text-gray-900 mb-6">{TEXT.detail_menu}</h2>
        {menuCount === 0 ? (
          <div className="rounded-2xl bg-white border border-gray-100 p-10 text-center text-gray-500">
            {TEXT.detail_no_menu}
          </div>
        ) : (
          <div className="space-y-8">
            {(restaurantDetail.categories || []).map((category) => {
              const menus = category.menus || []
              if (menus.length === 0) return null
              return (
                <div key={category.id}>
                  <div className="flex items-center gap-2 mb-4">
                    <span className="text-2xl">{CATEGORY_EMOJIS[category.name] || '🍽️'}</span>
                    <h3 className="text-xl font-bold text-gray-900">{category.name}</h3>
                  </div>
                  <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-5">
                    {menus.map((food, index) => (
                      <article key={food.id} className="bg-white border border-gray-100 rounded-2xl overflow-hidden shadow-sm">
                        <Link to={`/food/detail/${food.id}`}>
                          <img
                          src={getFoodImage(food)}
                            alt={food.title}
                            className="w-full h-40 object-cover bg-gray-100"
                          />
                        </Link>
                        <div className="p-4">
                          <Link to={`/food/detail/${food.id}`} className="font-bold text-gray-900 hover:text-orange-500">{food.title}</Link>
                          <p className="text-sm text-gray-500 line-clamp-2 mt-1">{food.description}</p>
                          <div className="flex items-center justify-between mt-4">
                            <span className="text-orange-600 font-bold">{formatPrice(food.price)}</span>
                            <div className="flex gap-2">
                              <Link to={`/food/detail/${food.id}`} className="rounded-lg bg-gray-100 px-3 py-2 text-xs font-semibold text-gray-700 hover:bg-orange-50">Chi tiết</Link>
                              <button onClick={() => handleOrder(food)} className="rounded-lg bg-gray-900 text-white text-xs font-semibold px-3 py-2 hover:bg-orange-500 transition-colors">{TEXT.detail_order}</button>
                            </div>
                          </div>
                        </div>
                      </article>
                    ))}
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </section>
    </main>
  )
}

export default RestaurantDetails
