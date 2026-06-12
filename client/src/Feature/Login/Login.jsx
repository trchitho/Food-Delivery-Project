import { useState } from 'react'
import axios from 'axios'
import { useLocation, useNavigate, Link } from 'react-router-dom'
import { TEXT } from '../../constants/text'
import { API_BASE, setCurrentUser } from '../../utils/foodData'

function Login() {
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')
  const [loading, setLoading] = useState(false)
  const navigate = useNavigate()
  const location = useLocation()

  const handleSignIn = async (e) => {
    e.preventDefault()
    setError('')
    setLoading(true)
    try {
      const res = await axios.post(`${API_BASE}/client/login`, { username, password })
      if (res.data.successful) {
        const auth = typeof res.data.data === 'string'
          ? { token: res.data.data, username, displayName: username, role: username === 'admin' ? 'ADMIN' : 'USER' }
          : res.data.data
        sessionStorage.setItem('token', auth.token)
        setCurrentUser({
          username: auth.username,
          displayName: auth.displayName,
          role: auth.role,
        })
        navigate(auth.role === 'ADMIN' ? '/admin' : (location.state?.from || '/'), { replace: true })
      } else {
        setError(TEXT.login_error_wrong)
      }
    } catch {
      setError(TEXT.login_error_server)
    } finally {
      setLoading(false)
    }
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-orange-50 to-red-50 flex items-center justify-center px-4">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-3xl shadow-xl p-8">
          {/* Logo */}
          <div className="text-center mb-8">
            <div className="inline-flex items-center justify-center w-16 h-16 bg-orange-500 rounded-2xl mb-4 shadow-lg">
              <span className="text-3xl">🍜</span>
            </div>
            <h1 className="text-2xl font-extrabold text-gray-900">{TEXT.login_welcome}</h1>
            <p className="text-gray-500 text-sm mt-1">{TEXT.login_subtitle}</p>
          </div>

          {/* Error */}
          {error && (
            <div className="bg-red-50 border border-red-200 text-red-600 text-sm rounded-xl px-4 py-3 mb-5 flex items-center gap-2">
              <span>⚠️</span> {error}
            </div>
          )}

          <form onSubmit={handleSignIn} className="space-y-4">
            <div>
              <label className="block text-sm font-semibold text-gray-700 mb-1.5">
                {TEXT.login_username}
              </label>
              <input
                type="text"
                required
                placeholder={TEXT.login_username_placeholder}
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                className="w-full px-4 py-3 rounded-xl border border-gray-200 text-gray-900 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400 focus:border-transparent transition-all placeholder-gray-400"
              />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1.5">
                <label className="block text-sm font-semibold text-gray-700">
                  {TEXT.login_password}
                </label>
                <Link to="/forgot-password" className="text-xs text-orange-500 hover:text-orange-600 font-medium">
                  {TEXT.login_forgot}
                </Link>
              </div>
              <input
                type="password"
                required
                placeholder={TEXT.login_password_placeholder}
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                className="w-full px-4 py-3 rounded-xl border border-gray-200 text-gray-900 text-sm focus:outline-none focus:ring-2 focus:ring-orange-400 focus:border-transparent transition-all placeholder-gray-400"
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-orange-500 hover:bg-orange-600 disabled:bg-orange-300 text-white font-semibold py-3 rounded-xl text-sm transition-colors shadow-md shadow-orange-200 mt-2"
            >
              {loading ? (
                <span className="flex items-center justify-center gap-2">
                  <svg className="animate-spin h-4 w-4" viewBox="0 0 24 24" fill="none">
                    <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                    <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8v8z" />
                  </svg>
                  {TEXT.login_loading}
                </span>
              ) : TEXT.login_btn}
            </button>
          </form>

          <p className="text-center text-sm text-gray-500 mt-6">
            {TEXT.login_no_account}{' '}
            <Link to="/signup" className="font-semibold text-orange-500 hover:text-orange-600">
              {TEXT.login_signup}
            </Link>
          </p>
          <p className="text-center text-sm mt-3">
            <Link to="/" className="font-semibold text-gray-500 hover:text-orange-500">
              {TEXT.login_back_home}
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}

export default Login
