import React, { useState } from 'react'
import Navbar from '../Components/Navbar'
import ExploreRestaurant from '../Homepage/ExploreRestaurant'
import ExploreFood from '../Homepage/ExploreFood'
import { CATEGORY_PILLS, TEXT } from '../../constants/text'

function ExplorePage() {
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedCategory, setSelectedCategory] = useState('Tất cả')

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <section className="bg-white border-b border-gray-100">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
          <h1 className="text-3xl font-extrabold text-gray-900">{TEXT.page_explore_title}</h1>
          <p className="text-gray-500 mt-2">{TEXT.page_explore_subtitle}</p>
          <div className="mt-6 max-w-xl flex gap-2 rounded-2xl bg-gray-100 p-1.5">
            <input
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder={TEXT.hero_search_placeholder}
              className="flex-1 bg-white rounded-xl px-4 py-3 text-sm outline-none"
            />
            <button className="bg-orange-500 text-white font-semibold rounded-xl px-5 text-sm">
              {TEXT.hero_search_btn}
            </button>
          </div>
          <div className="flex gap-2 overflow-x-auto mt-5 pb-1">
            {CATEGORY_PILLS.map((cat) => (
              <button
                key={cat.label}
                onClick={() => setSelectedCategory(cat.label)}
                className={`flex items-center gap-1.5 px-4 py-2 rounded-full text-sm font-medium whitespace-nowrap ${
                  selectedCategory === cat.label ? 'bg-orange-500 text-white' : 'bg-gray-100 text-gray-600 hover:bg-orange-50'
                }`}
              >
                <span>{cat.emoji}</span>
                <span>{cat.label}</span>
              </button>
            ))}
          </div>
        </div>
      </section>
      <ExploreRestaurant searchTerm={searchTerm} selectedCategory={selectedCategory} />
      <ExploreFood searchTerm={searchTerm} selectedCategory={selectedCategory} expanded />
    </div>
  )
}

export default ExplorePage
