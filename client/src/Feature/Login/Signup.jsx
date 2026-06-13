import axios from 'axios'
import React, { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import { TEXT } from '../../constants/text'
import { API_BASE } from '../../utils/foodData'

function SignupPage() {
  const [formData, setFormData] = useState({
    email: '',
    password: '',
    fullname: '',
    roleId: 2,
  })
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()

  const handleInputChange = (e) => {
    const { name, value } = e.target
    setFormData((current) => ({
      ...current,
      [name]: value,
    }))
  }

  const handleSubmit = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      const response = await axios.post(`${API_BASE}/client/signup`, formData)
      if (response.data.successful || response.data.data === true) {
        navigate('/login', { replace: true })
      } else {
        setError('Không thể tạo tài khoản. Vui lòng kiểm tra lại thông tin.')
      }
    } catch {
      setError(TEXT.login_error_server)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="flex min-h-dvh items-center justify-center bg-gradient-to-br from-orange-50 via-white to-red-50 px-3 py-6 sm:px-4 sm:py-10">
      <div className="w-full max-w-md">
        <Link to="/" className="mb-4 inline-flex min-h-11 items-center text-sm font-semibold text-gray-500 hover:text-orange-500 sm:mb-6">
          ← {TEXT.login_back_home}
        </Link>
        <div className="rounded-2xl border border-orange-100 bg-white p-5 shadow-xl sm:rounded-3xl sm:p-8">
          <div className="mb-6 text-center sm:mb-8">
            <div className="inline-flex items-center justify-center w-16 h-16 bg-orange-500 rounded-2xl mb-4 shadow-lg">
              <span className="text-3xl">🍜</span>
            </div>
            <h1 className="text-xl font-extrabold text-gray-900 sm:text-2xl">{TEXT.signup_title}</h1>
            <p className="text-gray-500 text-sm mt-1">Tạo tài khoản để đặt món nhanh hơn.</p>
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-600 text-sm rounded-xl px-4 py-3 mb-5">
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">{TEXT.signup_email}</label>
              <input
                className="w-full px-4 py-3 rounded-xl border border-gray-200 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400"
                type="email"
                name="email"
                value={formData.email}
                onChange={handleInputChange}
                required
                placeholder="email@example.com"
              />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">{TEXT.signup_fullname}</label>
              <input
                className="w-full px-4 py-3 rounded-xl border border-gray-200 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400"
                type="text"
                name="fullname"
                value={formData.fullname}
                onChange={handleInputChange}
                required
                minLength="2"
                maxLength="50"
                placeholder="Nguyễn Văn A"
              />
            </div>
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">{TEXT.signup_password}</label>
              <input
                className="w-full px-4 py-3 rounded-xl border border-gray-200 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400"
                type="password"
                name="password"
                value={formData.password}
                onChange={handleInputChange}
                required
                minLength="6"
                placeholder="Tối thiểu 6 ký tự"
              />
            </div>
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-orange-500 hover:bg-orange-600 disabled:bg-orange-300 text-white font-semibold py-3 rounded-xl text-sm transition-colors shadow-md shadow-orange-200"
            >
              {loading ? 'Đang tạo tài khoản...' : TEXT.signup_save}
            </button>
          </form>

          <p className="text-center text-sm text-gray-500 mt-6">
            {TEXT.signup_have_account}{' '}
            <Link to="/login" className="font-semibold text-orange-500 hover:text-orange-600">
              {TEXT.nav_login}
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}

export default SignupPage
