import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { TEXT, RESTAURANT_IMAGES } from '../../constants/text'

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

function ExploreRestaurant() {
  const [restaurants, setRestaurants] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token')
        const headers = token ? { Authorization: `Bearer ${token}` } : {}
        const res = await axios.get('http://localhost:8080/restaurant', { headers })
        setRestaurants(res.data.data || [])
      } catch (e) {
        console.error(e)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  const getImage = (restaurant, index) => {
    // 1. Try online image map by title
    if (RESTAURANT_IMAGES[restaurant.title]) return RESTAURANT_IMAGES[restaurant.title]
    // 2. Try server-uploaded image
    if (restaurant.image) return `http://localhost:8080/restaurant/file/${restaurant.image}`
    // 3. Fallback: Unsplash food photo by index
    const fallbacks = [
      'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=400&q=80',
      'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&q=80',
      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=400&q=80',
      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=400&q=80',
      'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&q=80',
      'https://images.unsplash.com/photo-1547592180-85f173990554?w=400&q=80',
      'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=400&q=80',
      'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&q=80',
    ]
    return fallbacks[index % fallbacks.length]
  }

  return (
    <div className="bg-white">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-2xl font-bold text-gray-900">{TEXT.restaurant_title}</h2>
            <p className="text-sm text-gray-500 mt-1">{TEXT.restaurant_subtitle}</p>
          </div>
          <button className="text-sm font-semibold text-orange-500 hover:text-orange-600 transition-colors">
            {TEXT.restaurant_view_all}
          </button>
        </div>

        {loading ? (
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-5">
            {[...Array(8)].map((_, i) => <SkeletonCard key={i} />)}
          </div>
        ) : restaurants.length === 0 ? (
          <div className="text-center py-16 text-gray-400">
            <div className="text-5xl mb-4">🍽️</div>
            <p className="text-lg font-medium">{TEXT.restaurant_empty}</p>
            <p className="text-sm mt-1">{TEXT.restaurant_empty_sub}</p>
          </div>
        ) : (
          <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-5">
            {restaurants.map((r, i) => (
              <Link
                key={r.id}
                to={`/restaurant/detail/${r.id}`}
                className="group bg-white rounded-2xl shadow-sm hover:shadow-lg transition-all duration-200 overflow-hidden border border-gray-100"
              >
                <div className="relative h-44 overflow-hidden bg-gray-100">
                  <img
                    src={getImage(r, i)}
                    alt={r.title}
                    className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
                    onError={(e) => {
                      e.target.style.display = 'none'
                      e.target.nextSibling.style.display = 'flex'
                    }}
                  />
                  <div
                    className={`w-full h-full bg-gradient-to-br ${PLACEHOLDER_COLORS[i % PLACEHOLDER_COLORS.length]} items-center justify-center text-5xl hidden absolute inset-0`}
                  >
                    🍜
                  </div>
                  {r.freeShip && (
                    <span className="absolute top-2 left-2 bg-green-500 text-white text-xs font-semibold px-2 py-0.5 rounded-full shadow">
                      {TEXT.free_ship}
                    </span>
                  )}
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
                    <span className="text-xs text-gray-400">(4.0)</span>
                  </div>
                </div>
              </Link>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

export default ExploreRestaurant
