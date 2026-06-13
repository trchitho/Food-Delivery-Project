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
        <div className="mx-auto w-full max-w-7xl px-4 py-7 sm:px-6 sm:py-8 lg:px-8">
          <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">{TEXT.page_explore_title}</h1>
          <p className="text-gray-500 mt-2">{TEXT.page_explore_subtitle}</p>
          <div className="mt-6 flex w-full max-w-xl flex-col gap-2 rounded-2xl bg-gray-100 p-1.5 min-[380px]:flex-row">
            <input
              aria-label="Tìm món ăn hoặc nhà hàng"
              value={searchTerm}
              onChange={(e) => setSearchTerm(e.target.value)}
              placeholder={TEXT.hero_search_placeholder}
              className="h-12 min-w-0 flex-1 rounded-xl bg-white px-4 text-sm outline-none focus-visible:ring-2 focus-visible:ring-orange-400"
            />
            <button className="h-12 shrink-0 rounded-xl bg-orange-500 px-5 text-sm font-semibold text-white focus-visible:ring-2 focus-visible:ring-orange-400">
              {TEXT.hero_search_btn}
            </button>
          </div>
          <div className="mt-5 flex snap-x gap-3 overflow-x-auto pb-1">
            {CATEGORY_PILLS.map((cat) => (
              <button
                key={cat.label}
                onClick={() => setSelectedCategory(cat.label)}
                className={`flex min-h-11 shrink-0 snap-start items-center gap-1.5 whitespace-nowrap rounded-full px-4 py-2 text-sm font-medium ${
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
