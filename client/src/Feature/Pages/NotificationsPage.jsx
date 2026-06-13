import React, { useEffect, useState } from 'react'
import Navbar from '../Components/Navbar'
import NavbarAdmin from '../AdminPage/NavbarAdmin'
import { TEXT } from '../../constants/text'
import { getCurrentUser, getNotifications, isLoggedIn, saveNotifications } from '../../utils/foodData'

function NotificationsPage() {
  const [notifications, setNotifications] = useState([])
  const currentUser = getCurrentUser()
  const isAdmin = currentUser?.role === 'ADMIN'

  useEffect(() => {
    if (!isLoggedIn()) return undefined
    const sync = () => {
      if (isAdmin) {
        try {
          setNotifications(JSON.parse(localStorage.getItem('notifications:admin') || '[]'))
        } catch {
          setNotifications([])
        }
        return
      }
      setNotifications(getNotifications())
    }
    sync()
    const timer = setInterval(sync, 1200)
    window.addEventListener('storage', sync)
    window.addEventListener('foodhub-storage-sync', sync)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', sync)
      window.removeEventListener('foodhub-storage-sync', sync)
    }
  }, [isAdmin])

  const markAllRead = () => {
    const next = notifications.map((item) => ({ ...item, read: true }))
    setNotifications(next)
    if (isAdmin) {
      localStorage.setItem('notifications:admin', JSON.stringify(next))
      window.dispatchEvent(new Event('foodhub-storage-sync'))
    } else {
      saveNotifications(next)
    }
  }

  const content = (
    <main className="mx-auto w-full max-w-4xl px-4 py-8 sm:py-12">
      <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">{TEXT.page_notifications_title}</h1>
        {notifications.length > 0 && <button onClick={markAllRead} className="min-h-11 self-start rounded-xl bg-gray-900 px-4 py-2 text-sm font-bold text-white">Đánh dấu đã đọc</button>}
      </div>
      <div className="mt-8 overflow-hidden rounded-2xl border border-gray-100 bg-white">
        {notifications.length === 0 ? (
          <div className="p-10 text-gray-500">{TEXT.page_notifications_empty}</div>
        ) : notifications.map((item) => (
          <article key={item.id} className={`border-b border-gray-100 p-4 sm:p-5 ${item.read ? 'bg-white' : 'bg-orange-50'}`}>
            <div className="flex flex-col gap-2 sm:flex-row sm:items-start sm:justify-between sm:gap-4">
              <div className="min-w-0">
                <p className="font-bold text-gray-900">{item.title}</p>
                <p className="mt-1 text-sm text-gray-600">{item.message}</p>
                {item.orderId && <p className="mt-2 text-xs font-bold text-orange-600">Mã đơn: {item.orderId}</p>}
              </div>
              <span className="text-xs text-gray-400 sm:shrink-0">{new Date(item.createdAt).toLocaleString('vi-VN')}</span>
            </div>
          </article>
        ))}
      </div>
    </main>
  )

  if (isAdmin) {
    return (
      <NavbarAdmin title="Thông báo" subtitle="Theo dõi đơn hàng mới, tin nhắn hỗ trợ và cập nhật hệ thống realtime.">
        {content}
      </NavbarAdmin>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      {content}
    </div>
  )
}

export default NotificationsPage
