import React, { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { TEXT } from '../../constants/text'
import { getAccountKey, isLoggedIn } from '../../utils/foodData'

function SettingsPage() {
  const navigate = useNavigate()
  const [settings, setSettings] = useState({ emailNotify: true, promoNotify: true, darkHeader: true })
  const [saved, setSaved] = useState(false)

  useEffect(() => {
    if (!isLoggedIn()) {
      navigate('/login', { state: { from: '/settings' } })
      return
    }
    const key = getAccountKey('settings')
    if (key) {
      setSettings(JSON.parse(localStorage.getItem(key) || '{"emailNotify":true,"promoNotify":true,"darkHeader":true}'))
    }
  }, [navigate])

  const toggle = (field) => {
    setSettings((current) => ({ ...current, [field]: !current[field] }))
  }

  const save = () => {
    const key = getAccountKey('settings')
    if (key) localStorage.setItem(key, JSON.stringify(settings))
    setSaved(true)
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="mx-auto w-full max-w-3xl px-4 py-8 sm:py-10">
        <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">{TEXT.page_settings_title}</h1>
        <div className="mt-6 space-y-4 rounded-2xl border border-gray-100 bg-white p-4 shadow-sm sm:mt-8 sm:p-6">
          {saved && <div className="rounded-xl bg-green-50 text-green-700 px-4 py-3 text-sm">{TEXT.settings_saved}</div>}
          {[
            ['emailNotify', 'Nhận thông báo đơn hàng qua email'],
            ['promoNotify', 'Nhận khuyến mãi và ưu đãi'],
            ['darkHeader', 'Giữ thanh điều hướng nền tối'],
          ].map(([key, label]) => (
            <label key={key} className="flex min-h-14 items-center justify-between gap-4 rounded-xl border border-gray-100 px-4 py-3">
              <span className="min-w-0 text-sm font-medium text-gray-800 sm:text-base">{label}</span>
              <input type="checkbox" checked={settings[key]} onChange={() => toggle(key)} className="h-6 w-6 shrink-0 accent-orange-500" />
            </label>
          ))}
          <button onClick={save} className="min-h-11 w-full rounded-xl bg-orange-500 px-5 py-3 text-sm font-semibold text-white hover:bg-orange-600 sm:w-auto">Lưu cài đặt</button>
        </div>
      </main>
    </div>
  )
}

export default SettingsPage
