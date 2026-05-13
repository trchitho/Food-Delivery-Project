import axios from 'axios'
import React, { useEffect, useState } from 'react'
import { TEXT, CATEGORY_EMOJIS, FOOD_IMAGES } from '../../constants/text'

// Fallback food images by category
const CATEGORY_FALLBACKS = {
  '\u0043\u01a1\u006d': [
    'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=200&q=80',
    'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=200&q=80',
    'https://images.unsplash.com/photo-1516684732162-798a0062be99?w=200&q=80',
  ],
  '\u0042\u00fa\u006e\u0020\u002d\u0020\u0050\u0068\u1edf': [
    'https://images.unsplash.com/photo-1555126634-323283e090fa?w=200&q=80',
    'https://images.unsplash.com/photo-1569050467447-ce54b3bbc37d?w=200&q=80',
    'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=200&q=80',
  ],
  '\u0042\u00e1\u006e\u0068\u0020\u006d\u00ec': [
    'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=200&q=80',
    'https://images.unsplash.com/photo-1619740455993-9d622f9e7e5e?w=200&q=80',
    'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=200&q=80',
  ],
  '\u0110\u1ed3\u0020\u0075\u1ed1\u006e\u0067': [
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=200&q=80',
    'https://images.unsplash.com/photo-1515823064-d6e0c04616a7?w=200&q=80',
    'https://images.unsplash.com/photo-1544145945-f90425340c7e?w=200&q=80',
  ],
  '\u0047\u00e0\u0020\u0072\u00e1\u006e': [
    'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=200&q=80',
    'https://images.unsplash.com/photo-1562967914-608f82629710?w=200&q=80',
    'https://images.unsplash.com/photo-1598514983318-2f64f8f4796c?w=200&q=80',
  ],
  '\u0050\u0069\u007a\u007a\u0061': [
    'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=200&q=80',
    'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&q=80',
    'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=200&q=80',
  ],
  '\u004c\u1ea9\u0075': [
    'https://images.unsplash.com/photo-1547592180-85f173990554?w=200&q=80',
    'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=200&q=80',
    'https://images.unsplash.com/photo-1615361200141-f45040f367be?w=200&q=80',
  ],
  '\u0043\u0068\u0061\u0079': [
    'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200&q=80',
    'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?w=200&q=80',
    'https://images.unsplash.com/photo-1498837167922-ddd27525d352?w=200&q=80',
  ],
}

const DEFAULT_FOOD_IMGS = [
  'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&q=80',
  'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=200&q=80',
  'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=200&q=80',
]

function getFoodImage(item, categoryName, index) {
  if (FOOD_IMAGES[item.title]) return FOOD_IMAGES[item.title]
  if (item.image) return `http://localhost:8080/menu/file/${item.image}`
  const catFallbacks = CATEGORY_FALLBACKS[categoryName]
  if (catFallbacks) return catFallbacks[index % catFallbacks.length]
  return DEFAULT_FOOD_IMGS[index % DEFAULT_FOOD_IMGS.length]
}

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

function ExploreFood() {
  const [categories, setCategories] = useState([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const token = localStorage.getItem('token')
        const headers = token ? { Authorization: `Bearer ${token}` } : {}
        const res = await axios.get('http://localhost:8080/category', { headers })
        setCategories(res.data.data || [])
      } catch (e) {
        console.error(e)
      } finally {
        setLoading(false)
      }
    }
    fetchData()
  }, [])

  return (
    <div className="bg-gray-50">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <div className="flex items-center justify-between mb-6">
          <div>
            <h2 className="text-2xl font-bold text-gray-900">{TEXT.food_title}</h2>
            <p className="text-sm text-gray-500 mt-1">{TEXT.food_subtitle}</p>
          </div>
        </div>

        {loading ? (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {[...Array(4)].map((_, i) => <SkeletonCategory key={i} />)}
          </div>
        ) : categories.length === 0 ? (
          <div className="text-center py-16 text-gray-400">
            <div className="text-5xl mb-4">🍽️</div>
            <p className="text-lg font-medium">{TEXT.food_empty}</p>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {categories.map((cat) => {
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
                    {(cat.menus || []).slice(0, 3).map((item, idx) => (
                      <div
                        key={item.id}
                        className="flex items-center gap-3 p-2 rounded-xl hover:bg-orange-50 cursor-pointer transition-colors group"
                      >
                        <div className="w-14 h-14 rounded-xl overflow-hidden flex-shrink-0 bg-gray-100">
                          <img
                            src={getFoodImage(item, cat.name, idx)}
                            alt={item.title}
                            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-200"
                            onError={(e) => {
                              e.target.src = DEFAULT_FOOD_IMGS[idx % DEFAULT_FOOD_IMGS.length]
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
                    <button className="w-full text-center text-xs font-semibold text-orange-500 hover:text-orange-600 py-1.5 border border-orange-100 rounded-xl hover:bg-orange-50 transition-colors">
                      {TEXT.food_view_more}
                    </button>
                  </div>
                </div>
              )
            })}
          </div>
        )}
      </div>
    </div>
  )
}

export default ExploreFood
