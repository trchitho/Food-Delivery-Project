import axios from 'axios'
import React, { useEffect, useMemo, useState } from 'react'
import NavbarAdmin from './NavbarAdmin'
import { API_BASE, formatPrice, getActivityLog, getAuthToken } from '../../utils/foodData'

function readAllPlacedOrders() {
  const orders = []
  for (let index = 0; index < localStorage.length; index += 1) {
    const key = localStorage.key(index)
    if (!key || !key.startsWith('placedOrders:')) continue
    try {
      const account = key.replace('placedOrders:', '')
      const value = JSON.parse(localStorage.getItem(key) || '[]')
      value.forEach((order) => orders.push({ ...order, account }))
    } catch {
      // Ignore corrupted local order snapshots.
    }
  }
  return orders
}

function AdminPage() {
  const [users, setUsers] = useState([])
  const [restaurants, setRestaurants] = useState([])
  const [categories, setCategories] = useState([])
  const [activities, setActivities] = useState([])
  const [orders, setOrders] = useState([])

  useEffect(() => {
    const token = getAuthToken()
    const headers = token ? { Authorization: `Bearer ${token}` } : {}
    Promise.all([
      axios.get(`${API_BASE}/user`, { headers }).catch(() => ({ data: [] })),
      axios.get(`${API_BASE}/restaurant`).catch(() => ({ data: { data: [] } })),
      axios.get(`${API_BASE}/category`).catch(() => ({ data: { data: [] } })),
    ]).then(([userRes, restaurantRes, categoryRes]) => {
      setUsers(Array.isArray(userRes.data) ? userRes.data : [])
      setRestaurants(restaurantRes.data.data || [])
      setCategories(categoryRes.data.data || [])
      setActivities(getActivityLog())
      setOrders(readAllPlacedOrders())
    })
  }, [])

  const totalFoods = useMemo(() => categories.reduce((sum, cat) => sum + (cat.menus || []).length, 0), [categories])
  const revenue = useMemo(() => orders.reduce((sum, order) => sum + Number(order.total || 0), 0), [orders])
  const activeCustomers = users.filter((user) => user.role !== 'ADMIN')

  const cards = [
    { label: 'Người dùng', value: users.length, helper: `${activeCustomers.length} tài khoản khách hàng` },
    { label: 'Nhà hàng', value: restaurants.length, helper: 'Đang hiển thị trên website' },
    { label: 'Món ăn', value: totalFoods, helper: `${categories.length} danh mục đang hoạt động` },
    { label: 'Doanh thu', value: formatPrice(revenue), helper: `${orders.length} đơn đã ghi nhận` },
  ]

  return (
    <NavbarAdmin
      title="Tổng quan vận hành"
      subtitle="Theo dõi nhanh người dùng, danh mục, đơn hàng và hành vi trong hệ thống."
    >
      <section className="grid grid-cols-1 gap-4 md:grid-cols-2 xl:grid-cols-4">
        {cards.map((card) => (
          <div key={card.label} className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
            <p className="text-sm font-bold text-slate-500">{card.label}</p>
            <p className="mt-3 text-3xl font-black text-slate-950">{card.value}</p>
            <p className="mt-2 text-sm text-slate-500">{card.helper}</p>
          </div>
        ))}
      </section>

      <section className="mt-6 grid grid-cols-1 gap-6 xl:grid-cols-[1.1fr_0.9fr]">
        <div className="rounded-xl border border-slate-200 bg-white shadow-sm">
          <div className="flex items-center justify-between border-b border-slate-100 px-5 py-4">
            <div>
              <h3 className="text-lg font-black text-slate-950">Người dùng gần đây</h3>
              <p className="text-sm text-slate-500">Tài khoản mới nhất trong cơ sở dữ liệu.</p>
            </div>
            <a href="/admin/users" className="rounded-lg bg-slate-950 px-3 py-2 text-sm font-bold text-white">Quản lý</a>
          </div>
          <div className="divide-y divide-slate-100">
            {users.slice(0, 8).map((user) => (
              <div key={user.id} className="flex items-center justify-between gap-4 px-5 py-4">
                <div>
                  <p className="font-bold text-slate-950">{user.fullname || user.userName}</p>
                  <p className="text-sm text-slate-500">{user.userName}</p>
                </div>
                <span className="rounded-full bg-slate-100 px-3 py-1 text-xs font-black text-slate-600">{user.role}</span>
              </div>
            ))}
            {users.length === 0 && <div className="px-5 py-10 text-center text-slate-500">Chưa tải được dữ liệu người dùng.</div>}
          </div>
        </div>

        <div className="rounded-xl border border-slate-200 bg-white shadow-sm">
          <div className="border-b border-slate-100 px-5 py-4">
            <h3 className="text-lg font-black text-slate-950">Hành động mới</h3>
            <p className="text-sm text-slate-500">Admin theo dõi được thao tác đặt hàng, hồ sơ và hỗ trợ.</p>
          </div>
          {activities.length === 0 ? (
            <div className="px-5 py-10 text-center text-slate-500">Chưa có hành động nào được ghi nhận.</div>
          ) : (
            <div className="max-h-[520px] divide-y divide-slate-100 overflow-y-auto">
              {activities.slice(0, 20).map((activity) => (
                <div key={activity.id} className="px-5 py-4">
                  <div className="flex items-start justify-between gap-4">
                    <div>
                      <p className="font-bold text-slate-950">{activity.action}</p>
                      <p className="mt-1 text-sm text-slate-500">{activity.displayName} ({activity.user})</p>
                    </div>
                    <span className="shrink-0 text-xs text-slate-400">{new Date(activity.createdAt).toLocaleString('vi-VN')}</span>
                  </div>
                  {activity.detail && Object.keys(activity.detail).length > 0 && (
                    <p className="mt-2 rounded-lg bg-slate-50 px-3 py-2 text-xs text-slate-500">
                      {Object.entries(activity.detail).map(([key, value]) => `${key}: ${value}`).join(' • ')}
                    </p>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      </section>
    </NavbarAdmin>
  )
}

export default AdminPage
