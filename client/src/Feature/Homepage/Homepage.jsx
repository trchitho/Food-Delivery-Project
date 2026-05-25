import React, { useState } from 'react'
import ExploreRestaurant from './ExploreRestaurant'
import ExploreFood from './ExploreFood'
import Navbar from '../Components/Navbar'
import { TEXT, CATEGORY_PILLS } from '../../constants/text'

function Homepage() {
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedCategory, setSelectedCategory] = useState('Tất cả')

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />

      {/* Hero Banner */}
      <div className="bg-gradient-to-r from-orange-500 to-red-500 text-white">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-14">
          <div className="max-w-xl">
            <h1 className="text-4xl font-extrabold leading-tight mb-3">
              {TEXT.hero_title_1}<br />{TEXT.hero_title_2}
            </h1>
            <p className="text-orange-100 text-base mb-6">{TEXT.hero_subtitle}</p>
            <div className="flex gap-2 bg-white rounded-2xl p-1.5 shadow-lg max-w-md">
              <input
                type="text"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder={TEXT.hero_search_placeholder}
                className="flex-1 px-4 py-2 text-gray-800 text-sm rounded-xl outline-none placeholder-gray-400"
              />
              <button
                onClick={() => document.getElementById('restaurants')?.scrollIntoView({ behavior: 'smooth' })}
                className="bg-orange-500 hover:bg-orange-600 text-white px-5 py-2 rounded-xl text-sm font-semibold transition-colors"
              >
                {TEXT.hero_search_btn}
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Category pills */}
      <div className="bg-white border-b border-gray-100 sticky top-0 z-10 shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex gap-2 py-3 overflow-x-auto">
            {CATEGORY_PILLS.map((cat, i) => (
              <button
                key={i}
                onClick={() => setSelectedCategory(cat.label)}
                className={`flex items-center gap-1.5 px-4 py-1.5 rounded-full text-sm font-medium whitespace-nowrap transition-colors ${
                  selectedCategory === cat.label
                    ? 'bg-orange-500 text-white'
                    : 'bg-gray-100 text-gray-600 hover:bg-orange-50 hover:text-orange-500'
                }`}
              >
                <span>{cat.emoji}</span>
                <span>{cat.label}</span>
              </button>
            ))}
          </div>
        </div>
      </div>

      <ExploreRestaurant searchTerm={searchTerm} selectedCategory={selectedCategory} />
      <ExploreFood searchTerm={searchTerm} selectedCategory={selectedCategory} />

      <footer className="bg-gray-800 text-gray-400 text-center py-6 text-sm mt-8">
        {TEXT.footer}
      </footer>
    </div>
  )
}

export default Homepage
