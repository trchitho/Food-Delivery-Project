import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { TEXT, CATEGORY_EMOJIS } from '../../constants/text'
import { API_BASE, addOrder, getFoodImage, isLoggedIn, mergeCatalogCategories, normalizeText } from '../../utils/foodData'

function SkeletonCategory() {
  return (
    <div className="animate-pulse bg-white rounded-2xl p-4">
      <div className="bg-gray-200 rounded h-5 w-1/2 mb-4" />
      {[...Array(3)].map((_, j) => (
        <div key={j} className="flex gap-3 mb-3">
          <div className="bg-gray-200 rounded-xl w-14 h-14 flex-shrink-0" />
          <div className="flex-1">
            <div className="bg-gray-200 rounded h-3 w-3/4 mb-2" />
            <div className="bg-gray-200 rounded h-3 w-1/2" />
          </div>
        </div>
      ))}
    </div>
  )
}

function ExploreFood({ searchTerm = '', selectedCategory = 'Tất cả', expanded = false }) {
  const navigate = useNavigate()
  const [categories, setCategories] = useState([])
  const [expandedCategories, setExpandedCategories] = useState({})
  const [selectedFood, setSelectedFood] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get(`${API_BASE}/category`)
        setCategories(mergeCatalogCategories(res.data.data || []))
      } catch {
        setCategories(mergeCatalogCategories())
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  useEffect(() => {
    const syncAdminFoods = () => {
      setCategories((current) => mergeCatalogCategories(current))
    }
    const timer = setInterval(syncAdminFoods, 1200)
    window.addEventListener('storage', syncAdminFoods)
    window.addEventListener('foodhub-storage-sync', syncAdminFoods)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', syncAdminFoods)
      window.removeEventListener('foodhub-storage-sync', syncAdminFoods)
    }
  }, [])

  const keyword = normalizeText(searchTerm)
  const filteredCategories = categories
    .filter((cat) => selectedCategory === 'Tất cả' || cat.name === selectedCategory)
    .map((cat) => ({
      ...cat,
      menus: (cat.menus || []).filter((item) => {
        return !keyword || normalizeText(`${item.title} ${item.description} ${cat.name}`).includes(keyword)
      }),
    }))
    .filter((cat) => cat.menus.length > 0 || !keyword)

  const handleAddToCart = (item, category) => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: '/orders' } })
      return
    }
    addOrder(item, { id: item.restaurantId, title: item.restaurantTitle || category.name })
    navigate('/orders')
  }

  return (
    <div className="bg-gray-50">
      <div className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-xl font-bold text-gray-900 sm:text-2xl">{TEXT.food_title}</h2>
            <p className="text-sm text-gray-500 mt-1">{TEXT.food_subtitle}</p>
          </div>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-4 lg:gap-6">
            {[...Array(4)].map((_, i) => <SkeletonCategory key={i} />)}
          </div>
        ) : filteredCategories.length === 0 ? (
          <div className="text-center py-16 text-gray-400">
            <div className="text-5xl mb-4">🍽️</div>
            <p className="text-lg font-medium">{TEXT.food_empty}</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {filteredCategories.map((cat) => {
              const emoji = CATEGORY_EMOJIS[cat.name] || '🍽️'
              return (
                <div key={cat.id} className="bg-white rounded-2xl shadow-sm border border-gray-100 overflow-hidden hover:shadow-md transition-shadow">
                  {/* Header */}
                  <div className="px-4 pt-4 pb-3 flex items-center gap-2 border-b border-gray-50">
                    <span className="text-2xl">{emoji}</span>
                    <h3 className="text-base font-bold text-gray-900">{cat.name}</h3>
                  </div>

                  {/* Food items */}
                  <div className="px-3 py-2 space-y-1">
                    {(cat.menus || []).slice(0, expanded || expandedCategories[cat.id] ? 8 : 3).map((item, idx) => (
                      <div
                        key={item.id}
                        onClick={() => navigate(`/food/detail/${item.id}`)}
                        className="group flex min-h-20 min-w-0 cursor-pointer items-center gap-3 rounded-xl p-2 transition-colors hover:bg-orange-50 focus-within:bg-orange-50"
                      >
                        <div className="w-14 h-14 rounded-xl overflow-hidden flex-shrink-0 bg-gray-100">
                          <img
                            src={getFoodImage(item)}
                            alt={item.title}
                            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-200"
                            onError={(e) => {
                              e.currentTarget.style.display = 'none'
                            }}
                          />
                        </div>
                        <div className="flex-1 min-w-0">
                          <p className="text-sm font-medium text-gray-800 line-clamp-1 group-hover:text-orange-500 transition-colors">
                            {item.title}
                          </p>
                          {item.freeShip && (
                            <span className="inline-block text-xs text-green-600 font-medium bg-green-50 px-1.5 py-0.5 rounded-full mt-0.5">
                              {TEXT.free_ship}
                            </span>
                          )}
                        </div>
                      </div>
                    ))}
                  </div>

                  {/* View more */}
                  <div className="px-4 pb-3 pt-1">
                    <button
                      onClick={() => setExpandedCategories((current) => ({ ...current, [cat.id]: !current[cat.id] }))}
                      className="min-h-11 w-full rounded-xl border border-orange-100 py-2 text-center text-xs font-semibold text-orange-500 transition-colors hover:bg-orange-50 hover:text-orange-600 focus-visible:ring-2 focus-visible:ring-orange-400"
                    >
                      {expandedCategories[cat.id] ? 'Thu gọn' : TEXT.food_view_more}
                    </button>
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>
      {selectedFood && (
        <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/40 p-3">
          <div className="max-h-[calc(100dvh-24px)] w-full max-w-lg overflow-y-auto rounded-2xl bg-white shadow-2xl">
            <img src={getFoodImage(selectedFood, selectedFood.id)} alt={selectedFood.title} className="h-48 w-full bg-gray-100 object-cover sm:h-56" />
            <div className="p-4 sm:p-5">
              <div className="flex items-start justify-between gap-4">
                <div>
                  <h3 className="break-words text-xl font-extrabold text-gray-900 sm:text-2xl">{selectedFood.title}</h3>
                  <p className="text-sm text-gray-500 mt-1">{selectedFood.restaurantTitle || selectedFood.categoryName}</p>
                </div>
                <button aria-label="Đóng chi tiết món" onClick={() => setSelectedFood(null)} className="grid h-11 w-11 shrink-0 place-items-center rounded-full bg-gray-100 text-gray-500 hover:bg-gray-200">×</button>
              </div>
              <p className="text-gray-600 mt-4">{selectedFood.description || 'Món ăn đang sẵn sàng phục vụ.'}</p>
              <div className="mt-6 flex flex-col gap-3 sm:flex-row">
                {selectedFood.restaurantId && (
                  <Link to={`/restaurant/detail/${selectedFood.restaurantId}`} className="flex-1 text-center rounded-xl bg-gray-100 px-4 py-3 text-sm font-semibold text-gray-800 hover:bg-gray-200">
                    Xem nhà hàng
                  </Link>
                )}
                <button
                  onClick={() => handleAddToCart(selectedFood, { name: selectedFood.categoryName })}
                  className="flex-1 rounded-xl bg-orange-500 px-4 py-3 text-sm font-semibold text-white hover:bg-orange-600"
                >
                  Thêm vào giỏ
                </button>
              </div>
            </div>
          </div>
        </div>
      )}
    </div>
  )
}

export default ExploreFood
