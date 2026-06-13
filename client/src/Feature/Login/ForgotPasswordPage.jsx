import React, { useState } from 'react'
import { Link } from 'react-router-dom'
import { TEXT } from '../../constants/text'

function ForgotPasswordPage() {
  const [email, setEmail] = useState('')
  const [sent, setSent] = useState(false)

  const handleSubmit = (e) => {
    e.preventDefault()
    setSent(true)
  }

  return (
    <div className="flex min-h-dvh items-center justify-center bg-gradient-to-br from-orange-50 via-white to-red-50 px-3 py-6 sm:px-4 sm:py-10">
      <div className="w-full max-w-md">
        <Link to="/login" className="mb-4 inline-flex min-h-11 items-center text-sm font-semibold text-gray-500 hover:text-orange-500 sm:mb-6">
          ← {TEXT.nav_login}
        </Link>
        <div className="rounded-2xl border border-orange-100 bg-white p-5 shadow-xl sm:rounded-3xl sm:p-8">
          <div className="mb-6 text-center sm:mb-8">
            <div className="inline-flex items-center justify-center w-16 h-16 bg-orange-500 rounded-2xl mb-4 shadow-lg">
              <span className="text-3xl">🔐</span>
            </div>
            <h1 className="text-xl font-extrabold text-gray-900 sm:text-2xl">{TEXT.forgot_title}</h1>
            <p className="text-gray-500 text-sm mt-1">{TEXT.forgot_subtitle}</p>
          </div>

          {sent ? (
            <div className="bg-green-50 border border-green-200 text-green-700 text-sm rounded-xl px-4 py-3">
              {TEXT.forgot_success}
            </div>
          ) : (
            <form onSubmit={handleSubmit} className="space-y-4">
              <div>
                <label className="block text-sm font-semibold text-gray-700 mb-1.5">{TEXT.signup_email}</label>
                <input
                  className="w-full px-4 py-3 rounded-xl border border-gray-200 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400"
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  required
                  placeholder="email@example.com"
                />
              </div>
              <button className="w-full bg-orange-500 hover:bg-orange-600 text-white font-semibold py-3 rounded-xl text-sm transition-colors">
                {TEXT.forgot_send}
              </button>
            </form>
          )}
        </div>
      </div>
    </div>
  )
}

export default ForgotPasswordPage
