import React, { useState } from 'react'
import ExploreRestaurant from './ExploreRestaurant'
import ExploreFood from './ExploreFood'
import Navbar from '../Components/Navbar'
import { TEXT, CATEGORY_PILLS } from '../../constants/text'

function Homepage() {
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedCategory, setSelectedCategory] = useState('Tất cả')

  return (
    <div className="min-h-dvh w-full overflow-x-hidden bg-gray-50 dark:bg-slate-950">
      <Navbar />

      {/* Hero Banner */}
      <div className="bg-gradient-to-r from-orange-500 to-red-500 text-white">
        <div className="mx-auto w-full max-w-7xl px-5 py-12 sm:px-6 sm:py-16 lg:px-8 lg:py-20">
          <div className="max-w-2xl">
            <h1 className="mb-4 text-[clamp(2rem,10vw,3.75rem)] font-extrabold leading-[1.08]">
              {TEXT.hero_title_1}<br />{TEXT.hero_title_2}
            </h1>
            <p className="mb-7 max-w-xl text-base leading-relaxed text-orange-50 sm:text-lg">{TEXT.hero_subtitle}</p>
            <div className="flex w-full max-w-xl flex-col gap-2 rounded-2xl bg-white p-1.5 shadow-lg min-[380px]:flex-row">
              <input
                aria-label="Tìm món ăn hoặc nhà hàng"
                type="text"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder={TEXT.hero_search_placeholder}
                className="h-12 min-w-0 flex-1 rounded-xl px-4 text-sm text-gray-800 outline-none placeholder-gray-400 focus-visible:ring-2 focus-visible:ring-orange-400"
              />
              <button
                onClick={() => document.getElementById('restaurants')?.scrollIntoView({ behavior: 'smooth' })}
                className="h-12 shrink-0 rounded-xl bg-orange-500 px-5 text-sm font-semibold text-white transition-colors hover:bg-orange-600 focus-visible:ring-2 focus-visible:ring-orange-400 focus-visible:ring-offset-2"
              >
                {TEXT.hero_search_btn}
              </button>
            </div>
          </div>
        </div>
      </div>

      {/* Category pills */}
      <div className="sticky top-0 z-10 border-b border-gray-100 bg-white shadow-sm dark:border-slate-800 dark:bg-slate-900">
        <div className="mx-auto w-full max-w-7xl">
          <div className="flex snap-x gap-3 overflow-x-auto px-4 py-3 sm:flex-wrap sm:justify-center sm:px-6 lg:px-8">
            {CATEGORY_PILLS.map((cat, i) => (
              <button
                key={i}
                onClick={() => setSelectedCategory(cat.label)}
                className={`flex min-h-11 shrink-0 snap-start items-center gap-1.5 whitespace-nowrap rounded-full px-4 py-2 text-sm font-medium transition-colors focus-visible:ring-2 focus-visible:ring-orange-400 ${
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

      <ExploreRestaurant searchTerm={searchTerm} selectedCategory={selectedCategory} paginateAll />
      <ExploreFood searchTerm={searchTerm} selectedCategory={selectedCategory} />

      <footer className="mt-8 bg-gray-800 px-4 py-6 text-center text-sm leading-relaxed text-gray-300 dark:bg-black">
        {TEXT.footer}
      </footer>
    </div>
  )
}

export default Homepage
