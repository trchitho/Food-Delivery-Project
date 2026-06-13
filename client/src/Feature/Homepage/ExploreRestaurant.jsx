import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { TEXT } from '../../constants/text'
import { API_BASE, getFavorites, getRestaurantImage, isLoggedIn, mergeAdminRestaurants, normalizeText, toggleFavorite } from '../../utils/foodData'

const PLACEHOLDER_COLORS = [
  'from-orange-400 to-red-500',
  'from-pink-400 to-purple-500',
  'from-blue-400 to-cyan-500',
  'from-green-400 to-teal-500',
  'from-yellow-400 to-orange-500',
  'from-indigo-400 to-blue-500',
  'from-rose-400 to-pink-500',
  'from-teal-400 to-green-500',
]

function SkeletonCard() {
  return (
    <div className="animate-pulse">
      <div className="bg-gray-200 rounded-2xl h-44 mb-3" />
      <div className="bg-gray-200 rounded h-4 w-3/4 mb-2" />
      <div className="bg-gray-200 rounded h-3 w-1/2" />
    </div>
  )
}

function ExploreRestaurant({ searchTerm = '', selectedCategory = 'Tất cả', limit }) {
  const navigate = useNavigate()
  const [restaurants, setRestaurants] = useState([])
  const [favorites, setFavorites] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const res = await axios.get(`${API_BASE}/restaurant`)
        setRestaurants(mergeAdminRestaurants(res.data.data || []))
      } catch (e) {
        console.error(e)
        setRestaurants(mergeAdminRestaurants())
      } finally {
        setLoading(false)
      }
    }
    fetchData()
    setFavorites(getFavorites())
  }, [])

  const keyword = normalizeText(searchTerm)
  const filteredRestaurants = restaurants.filter((restaurant) => {
    const matchesSearch = !keyword || normalizeText(`${restaurant.title} ${restaurant.subtitle} ${restaurant.description} ${restaurant.address}`).includes(keyword)
    const isChaoInBunPho = selectedCategory === 'Bún - Phở' && normalizeText(`${restaurant.title} ${restaurant.subtitle}`).includes('chao')
    const matchesCategory = selectedCategory === 'Tất cả' || ((restaurant.categoryNames || []).some((name) => name === selectedCategory) && !isChaoInBunPho)
    return matchesSearch && matchesCategory
  })
  const visibleRestaurants = typeof limit === 'number' ? filteredRestaurants.slice(0, limit) : filteredRestaurants

  return (
    <div id="restaurants" className="bg-white">
      <div className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
        <div className="mb-6 flex min-w-0 items-end justify-between gap-4">
          <div className="min-w-0">
            <h2 className="text-xl font-bold text-gray-900 sm:text-2xl">{TEXT.restaurant_title}</h2>
            <p className="text-sm text-gray-500 mt-1">{TEXT.restaurant_subtitle}</p>
          </div>
          <Link to="/explore" className="shrink-0 text-sm font-semibold text-orange-500 transition-colors hover:text-orange-600">
            {TEXT.restaurant_view_all}
          </Link>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 gap-4 min-[425px]:grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 lg:gap-5">
            {[...Array(8)].map((_, i) => <SkeletonCard key={i} />)}
          </div>
        ) : visibleRestaurants.length === 0 ? (
          <div className="text-center py-16 text-gray-400">
            <div className="text-5xl mb-4">🍽️</div>
            <p className="text-lg font-medium">{TEXT.restaurant_empty}</p>
            <p className="text-sm mt-1">{TEXT.restaurant_empty_sub}</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 gap-4 min-[425px]:grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 lg:gap-5">
            {visibleRestaurants.map((r, i) => {
              const colorIndex = (Number(r.id) || i) % PLACEHOLDER_COLORS.length
              return (
              <Link
                key={r.id}
                to={`/restaurant/detail/${r.id}`}
                className="group min-w-0 overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm transition-all duration-200 hover:shadow-lg"
              >
                <div className="relative aspect-[16/10] overflow-hidden bg-gray-100">
                  <img
                    src={getRestaurantImage(r)}
                    alt={r.title}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                    onError={(e) => {
                      e.target.style.display = 'none'
                      e.target.nextSibling.style.display = 'flex'
                    }}
                  />
                  <div
                    className={`w-full h-full bg-gradient-to-br ${PLACEHOLDER_COLORS[colorIndex]} items-center justify-center text-5xl hidden absolute inset-0`}
                  >
                    🍜
                  </div>
                  {r.freeShip && (
                    <span className="absolute top-2 left-2 bg-green-500 text-white text-xs font-semibold px-2 py-0.5 rounded-full shadow">
                      {TEXT.free_ship}
                    </span>
                  )}
                  <button
                    type="button"
                    onClick={(e) => {
                      e.preventDefault()
                      if (!isLoggedIn()) {
                        navigate('/login', { state: { from: '/favorites' } })
                        return
                      }
                      setFavorites(toggleFavorite(r) || [])
                    }}
                    className="absolute top-2 right-2 w-8 h-8 rounded-full bg-white/90 text-orange-500 shadow flex items-center justify-center hover:bg-orange-500 hover:text-white transition-colors"
                    aria-label="Yêu thích"
                  >
                    {favorites.some((item) => item.id === r.id) ? '♥' : '♡'}
                  </button>
                </div>
                <div className="p-3">
                  <h3 className="font-semibold text-gray-900 text-sm leading-tight line-clamp-1 group-hover:text-orange-500 transition-colors">
                    {r.title}
                  </h3>
                  {r.subtitle && (
                    <p className="text-xs text-gray-500 mt-0.5 line-clamp-1">{r.subtitle}</p>
                  )}
                  <div className="flex items-center gap-1 mt-2">
                    <span className="text-yellow-400 text-xs">★★★★☆</span>
                    <span className="text-xs text-gray-400">({(r.rating || 0).toFixed(1)})</span>
                  </div>
                </div>
              </Link>
            )})}
          </div>
        )}
      </div>
    </div>
  )
}

export default ExploreRestaurant
