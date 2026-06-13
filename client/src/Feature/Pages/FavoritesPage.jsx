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
      <main className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
        <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">{TEXT.page_favorites_title}</h1>
        {favorites.length === 0 ? (
          <div className="mt-6 rounded-2xl border border-gray-100 bg-white p-8 text-center sm:mt-8 sm:p-12">
            <div className="text-5xl mb-4">♡</div>
            <p className="text-gray-500">{TEXT.page_favorites_empty}</p>
            <Link to="/" className="inline-block mt-5 text-orange-500 font-semibold">
              Xem nhà hàng
            </Link>
          </div>
        ) : (
          <div className="mt-6 grid grid-cols-1 gap-4 min-[425px]:grid-cols-2 lg:mt-8 lg:grid-cols-4 lg:gap-5">
            {favorites.map((restaurant) => (
              <article key={restaurant.id} className="bg-white rounded-2xl overflow-hidden border border-gray-100 shadow-sm">
                <Link to={`/restaurant/detail/${restaurant.id}`}>
                  <img src={getRestaurantImage(restaurant)} alt={restaurant.title} className="h-44 w-full object-cover" />
                </Link>
                <div className="p-4">
                  <h2 className="break-words font-bold text-gray-900">{restaurant.title}</h2>
                  <p className="mt-1 line-clamp-2 text-sm text-gray-500">{restaurant.subtitle}</p>
                  <button onClick={() => removeFavorite(restaurant)} className="mt-3 min-h-11 text-sm font-semibold text-red-500">
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
