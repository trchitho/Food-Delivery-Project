import React, { useEffect, useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { TEXT } from '../../constants/text'
import { getCurrentUser, getProfile, isLoggedIn, saveProfile, setCurrentUser } from '../../utils/foodData'

function ProfilePage() {
  const navigate = useNavigate()
  const [profile, setProfile] = useState({ fullname: '', email: '', phone: '', address: '' })
  const [saved, setSaved] = useState(false)

  useEffect(() => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: '/profile' } })
      return
    }
    setProfile(getProfile() || { fullname: '', email: '', phone: '', address: '' })
  }, [navigate])

  const updateField = (field, value) => {
    setProfile((current) => ({ ...current, [field]: value }))
  }

  const handleSubmit = (e) => {
    e.preventDefault()
    saveProfile(profile)
    const currentUser = getCurrentUser()
    setCurrentUser({ ...currentUser, displayName: profile.fullname || currentUser?.displayName || currentUser?.username })
    setSaved(true)
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="max-w-3xl mx-auto px-4 py-10">
        <h1 className="text-3xl font-extrabold text-gray-900">{TEXT.page_profile_title}</h1>
        <form onSubmit={handleSubmit} className="mt-8 bg-white rounded-2xl border border-gray-100 p-6 shadow-sm space-y-4">
          {saved && <div className="rounded-xl bg-green-50 text-green-700 px-4 py-3 text-sm">{TEXT.profile_saved}</div>}
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1.5">Họ và tên</label>
            <input value={profile.fullname} onChange={(e) => updateField('fullname', e.target.value)} className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:ring-2 focus:ring-orange-400" />
          </div>
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1.5">Email</label>
            <input value={profile.email} onChange={(e) => updateField('email', e.target.value)} type="email" className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:ring-2 focus:ring-orange-400" />
          </div>
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1.5">Số điện thoại</label>
            <input value={profile.phone} onChange={(e) => updateField('phone', e.target.value)} className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:ring-2 focus:ring-orange-400" />
          </div>
          <div>
            <label className="block text-sm font-semibold text-gray-700 mb-1.5">Địa chỉ giao hàng</label>
            <textarea value={profile.address} onChange={(e) => updateField('address', e.target.value)} rows="3" className="w-full rounded-xl border border-gray-200 px-4 py-3 outline-none focus:ring-2 focus:ring-orange-400" />
          </div>
          <div className="flex gap-3">
            <button className="rounded-xl bg-orange-500 px-5 py-3 text-sm font-semibold text-white hover:bg-orange-600">Lưu hồ sơ</button>
            <Link to="/" className="rounded-xl bg-gray-100 px-5 py-3 text-sm font-semibold text-gray-700 hover:bg-gray-200">Về trang chủ</Link>
          </div>
        </form>
      </main>
    </div>
  )
}

export default ProfilePage
