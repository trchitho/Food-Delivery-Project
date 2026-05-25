import React, { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { TEXT } from '../../constants/text'
import { getFavorites, getRestaurantImage, isLoggedIn, toggleFavorite } from '../../utils/foodData'

function FavoritesPage() {
  const navigate = useNavigate()
  const [favorites, setFavorites] = useState([])

  useEffect(() => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: '/favorites' } })
      return
    }
    setFavorites(getFavorites())
  }, [navigate])

  const removeFavorite = (restaurant) => {
    setFavorites(toggleFavorite(restaurant))
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-10">
        <h1 className="text-3xl font-extrabold text-gray-900">{TEXT.page_favorites_title}</h1>
        {favorites.length === 0 ? (
          <div className="mt-8 bg-white rounded-2xl border border-gray-100 p-12 text-center">
            <div className="text-5xl mb-4">♡</div>
            <p className="text-gray-500">{TEXT.page_favorites_empty}</p>
            <Link to="/" className="inline-block mt-5 text-orange-500 font-semibold">
              Xem nhà hàng
            </Link>
          </div>
        ) : (
          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-5 mt-8">
            {favorites.map((restaurant) => (
              <article key={restaurant.id} className="bg-white rounded-2xl overflow-hidden border border-gray-100 shadow-sm">
                <Link to={`/restaurant/detail/${restaurant.id}`}>
                  <img src={getRestaurantImage(restaurant)} alt={restaurant.title} className="h-44 w-full object-cover" />
                </Link>
                <div className="p-4">
                  <h2 className="font-bold text-gray-900">{restaurant.title}</h2>
                  <p className="text-sm text-gray-500 mt-1">{restaurant.subtitle}</p>
                  <button onClick={() => removeFavorite(restaurant)} className="mt-4 text-sm font-semibold text-red-500">
                    Bỏ yêu thích
                  </button>
                </div>
              </article>
            ))}
          </div>
        )}
      </main>
    </div>
  )
}

export default FavoritesPage
