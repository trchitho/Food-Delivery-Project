import axios from 'axios'
import React, { useEffect, useMemo, useState } from 'react'
import NavbarAdmin from './NavbarAdmin'
import { API_BASE, addNotificationForAccount, broadcastNotification, formatPrice, getActivityLog, getAuthToken, getFoodImage, logActivity, mergeAdminRestaurants, mergeCatalogCategories } from '../../utils/foodData'

const ORDER_STATUS = ['Đang xác nhận', 'Đã xác nhận', 'Đang chuẩn bị', 'Đang giao', 'Hoàn tất', 'Đã hủy']
const ADMIN_ORDER_ACTIONS = ['Đã xác nhận', 'Đang chuẩn bị', 'Đang giao', 'Hoàn tất']

function statusClass(status) {
  return {
    'Đã xác nhận': 'bg-blue-50 text-blue-700',
    'Đang chuẩn bị': 'bg-purple-50 text-purple-700',
    'Đang giao': 'bg-amber-50 text-amber-700',
    'Hoàn tất': 'bg-emerald-50 text-emerald-700',
    'Đã hủy': 'bg-red-50 text-red-600',
  }[status] || 'bg-slate-100 text-slate-700'
}

function readJson(key, fallback) {
  try {
    return JSON.parse(localStorage.getItem(key) || 'null') ?? fallback
  } catch {
    return fallback
  }
}

function saveJson(key, value) {
  localStorage.setItem(key, JSON.stringify(value))
  window.dispatchEvent(new Event('foodhub-storage-sync'))
}

function readAdminFoodTombstones() {
  return readJson('adminFoods', []).filter((food) => (food.status || 'Có sẵn') === 'Ẩn')
}

function useAdminData() {
  const [users, setUsers] = useState([])
  const [restaurants, setRestaurants] = useState([])
  const [categories, setCategories] = useState([])
  const [activities, setActivities] = useState([])

  useEffect(() => {
    const token = getAuthToken()
    const headers = token ? { Authorization: `Bearer ${token}` } : {}
    Promise.all([
      axios.get(`${API_BASE}/user`, { headers }).catch(() => ({ data: [] })),
      axios.get(`${API_BASE}/restaurant`).catch(() => ({ data: { data: [] } })),
      axios.get(`${API_BASE}/category`).catch(() => ({ data: { data: [] } })),
    ]).then(([userRes, restaurantRes, categoryRes]) => {
      const apiUsers = Array.isArray(userRes.data) ? userRes.data : []
      const apiRestaurants = mergeAdminRestaurants(restaurantRes.data.data || [])
      const apiCategories = mergeCatalogCategories(categoryRes.data.data || []).map((category) => ({
        ...category,
        title: category.title || category.name,
      }))
      setUsers(readJson('adminUsers', apiUsers.length ? apiUsers : []))
      setRestaurants(apiRestaurants)
      setCategories(apiCategories)
      setActivities(getActivityLog())
    })
  }, [])

  const foods = useMemo(() => readJson('adminFoods', categories.flatMap((category) => (
    (category.menus || []).map((food) => ({ ...food, categoryId: category.id, categoryName: category.title || category.name }))
  ))), [categories])

  const orders = useMemo(() => readOrders(), [])
  const messages = useMemo(() => readMessageThreads(), [])

  return { users, restaurants, categories, foods, orders, messages, activities }
}

function readOrders() {
  const rows = []
  for (let index = 0; index < localStorage.length; index += 1) {
    const key = localStorage.key(index)
    if (!key || !key.startsWith('placedOrders:')) continue
    try {
      const account = key.replace('placedOrders:', '')
      const value = JSON.parse(localStorage.getItem(key) || '[]')
      value.forEach((order) => rows.push({ ...order, account, customer: order.customer || order.profile || {}, status: order.status || 'Đang xác nhận' }))
    } catch {
      // Ignore invalid snapshots.
    }
  }
  return rows.sort((a, b) => new Date(b.createdAt || 0) - new Date(a.createdAt || 0))
}

function updateStoredOrder(account, orderId, updater) {
  const key = `placedOrders:${account}`
  const orders = readJson(key, [])
  const next = orders.map((order) => order.id === orderId ? updater(order) : order)
  saveJson(key, next)
  logActivity('Admin cập nhật đơn hàng', { orderId })
  return readOrders()
}

function readMessageThreads() {
  const rows = []
  for (let index = 0; index < localStorage.length; index += 1) {
    const key = localStorage.key(index)
    if (!key || !key.startsWith('messages:')) continue
    try {
      const account = key.replace('messages:', '')
      const threads = JSON.parse(localStorage.getItem(key) || '[]')
      threads.filter((thread) => thread.id !== 'shipper').forEach((thread) => rows.push({ ...thread, account, storageKey: key }))
    } catch {
      // Ignore invalid snapshots.
    }
  }
  return rows.sort((a, b) => {
    const lastA = a.messages?.[a.messages.length - 1]?.time || 0
    const lastB = b.messages?.[b.messages.length - 1]?.time || 0
    return new Date(lastB) - new Date(lastA)
  })
}

function upsertById(rows, item) {
  if (item.id) return rows.map((row) => row.id === item.id ? item : row)
  const nextId = Math.max(0, ...rows.map((row) => Number(row.id) || 0)) + 1
  return [{ ...item, id: nextId }, ...rows]
}

function AdminTable({ columns, rows, empty = 'Chưa có dữ liệu.' }) {
  return (
    <div className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
      <div className="overflow-x-auto">
        <table className="min-w-full divide-y divide-slate-100">
          <thead className="bg-slate-50">
            <tr>{columns.map((column) => <th key={column.key} className="px-5 py-3 text-left text-xs font-black uppercase tracking-wide text-slate-500">{column.label}</th>)}</tr>
          </thead>
          <tbody className="divide-y divide-slate-100 bg-white">
            {rows.map((row, index) => (
              <tr key={row.id || row.key || `${row.title || row.account || 'row'}-${index}`} className="hover:bg-slate-50">
                {columns.map((column) => <td key={column.key} className="px-5 py-4 text-sm text-slate-700">{column.render ? column.render(row, index) : row[column.key]}</td>)}
              </tr>
            ))}
            {rows.length === 0 && <tr><td colSpan={columns.length} className="px-5 py-12 text-center text-slate-500">{empty}</td></tr>}
          </tbody>
        </table>
      </div>
    </div>
  )
}

function StatRow({ label, value, tone = 'slate' }) {
  const toneClass = tone === 'orange' ? 'bg-orange-50 text-orange-700' : 'bg-slate-100 text-slate-700'
  return <div className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm"><p className="text-sm font-bold text-slate-500">{label}</p><p className={`mt-3 inline-flex rounded-lg px-3 py-1 text-2xl font-black ${toneClass}`}>{value}</p></div>
}

function ResourceModal({ title, fields, form, setForm, onClose, onSubmit }) {
  return (
    <div className="fixed inset-0 z-50 grid place-items-center bg-slate-950/50 px-4">
      <form onSubmit={onSubmit} className="w-full max-w-2xl rounded-xl bg-white p-6 shadow-2xl">
        <div className="mb-5 flex items-center justify-between">
          <h3 className="text-xl font-black text-slate-950">{title}</h3>
          <button type="button" onClick={onClose} className="rounded-lg border border-slate-200 px-3 py-1 text-sm font-bold">Đóng</button>
        </div>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          {fields.map((field) => (
            <label key={field.name} className={field.full ? 'md:col-span-2' : ''}>
              <span className="text-sm font-bold text-slate-700">{field.label}</span>
              {field.type === 'select' ? (
                <select value={form[field.name] ?? ''} onChange={(event) => setForm({ ...form, [field.name]: event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400">
                  {field.options.map((option) => <option key={option.value} value={option.value}>{option.label}</option>)}
                </select>
              ) : field.type === 'checkbox' ? (
                <input type="checkbox" checked={Boolean(form[field.name])} onChange={(event) => setForm({ ...form, [field.name]: event.target.checked })} className="mt-4 h-5 w-5 accent-orange-500" />
              ) : (
                <input type={field.type || 'text'} value={form[field.name] ?? ''} onChange={(event) => setForm({ ...form, [field.name]: field.type === 'number' ? Number(event.target.value) : event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" required={field.required !== false} />
              )}
            </label>
          ))}
        </div>
        <div className="mt-6 flex justify-end gap-3">
          <button type="button" onClick={onClose} className="rounded-lg border border-slate-200 px-4 py-2 font-bold text-slate-700">Hủy</button>
          <button className="rounded-lg bg-orange-500 px-4 py-2 font-bold text-white hover:bg-orange-600">Lưu</button>
        </div>
      </form>
    </div>
  )
}

export function AdminCategoriesPage() {
  const { categories } = useAdminData()
  const [rows, setRows] = useState([])
  const [form, setForm] = useState(null)
  const [filters, setFilters] = useState({ query: '', status: 'all' })
  useEffect(() => setRows(categories), [categories])

  const filteredRows = rows.filter((row) => {
    const keyword = filters.query.trim().toLowerCase()
    const matchQuery = !keyword || String(row.title || row.name || '').toLowerCase().includes(keyword)
    const hasFoods = (row.menus || []).length > 0
    const matchStatus = filters.status === 'all' || (filters.status === 'active' ? hasFoods : !hasFoods)
    return matchQuery && matchStatus
  })

  const save = (event) => {
    event.preventDefault()
    const next = upsertById(rows, { ...form, menus: form.menus || [] })
    setRows(next)
    saveJson('adminCategories', next)
    broadcastNotification({ title: 'Danh mục được cập nhật', message: `Admin vừa cập nhật danh mục ${form.title}.`, type: 'category' })
    setForm(null)
  }

  return (
    <NavbarAdmin title="Danh mục" subtitle="Admin có toàn quyền thêm, sửa, xóa danh mục món ăn." action={<button onClick={() => setForm({ title: '', menus: [] })} className="rounded-lg bg-orange-500 px-4 py-2 text-sm font-black text-white">Thêm danh mục</button>}>
      <div className="mb-6 grid grid-cols-1 gap-4 md:grid-cols-3">
        <StatRow label="Tổng danh mục" value={rows.length} tone="orange" />
        <StatRow label="Đang bán" value={rows.filter((item) => (item.menus || []).length > 0).length} />
        <StatRow label="Tổng món" value={rows.reduce((sum, item) => sum + (item.menus || []).length, 0)} />
      </div>
      <div className="mb-4 grid grid-cols-1 gap-3 md:grid-cols-[1fr_220px]">
        <input value={filters.query} onChange={(event) => setFilters({ ...filters, query: event.target.value })} placeholder="Tìm danh mục..." className="rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" />
        <select value={filters.status} onChange={(event) => setFilters({ ...filters, status: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400">
          <option value="all">Tất cả trạng thái</option>
          <option value="active">Đang bán</option>
          <option value="empty">Cần bổ sung</option>
        </select>
      </div>
      <AdminTable rows={filteredRows} columns={[
        { key: 'id', label: 'ID' },
        { key: 'title', label: 'Tên danh mục', render: (row) => <span className="font-bold text-slate-950">{row.title || row.name}</span> },
        { key: 'menus', label: 'Số món', render: (row) => (row.menus || []).length },
        { key: 'status', label: 'Trạng thái', render: (row) => <span className={`rounded-full px-3 py-1 text-xs font-black ${(row.menus || []).length ? 'bg-emerald-50 text-emerald-700' : 'bg-amber-50 text-amber-700'}`}>{(row.menus || []).length ? 'Đang bán' : 'Cần bổ sung'}</span> },
        { key: 'actions', label: 'Thao tác', render: (row) => <div className="flex gap-2"><button onClick={() => setForm(row)} className="rounded-lg bg-slate-100 px-3 py-1 font-bold">Sửa</button><button onClick={() => { const next = rows.filter((item) => item.id !== row.id); setRows(next); saveJson('adminCategories', next) }} className="rounded-lg bg-red-50 px-3 py-1 font-bold text-red-600">Xóa</button></div> },
      ]} />
      {form && <ResourceModal title={form.id ? 'Sửa danh mục' : 'Thêm danh mục'} fields={[{ name: 'title', label: 'Tên danh mục' }]} form={form} setForm={setForm} onClose={() => setForm(null)} onSubmit={save} />}
    </NavbarAdmin>
  )
}

export function AdminRestaurantsPage() {
  const { restaurants } = useAdminData()
  const [rows, setRows] = useState([])
  const [form, setForm] = useState(null)
  const [filters, setFilters] = useState({ query: '', status: 'all', ship: 'all', rating: 'all' })
  useEffect(() => setRows(restaurants), [restaurants])

  const filteredRows = rows.filter((row) => {
    const keyword = filters.query.trim().toLowerCase()
    const haystack = [row.title, row.subtitle, row.description, row.address, ...(row.categoryNames || [])].join(' ').toLowerCase()
    const matchQuery = !keyword || haystack.includes(keyword)
    const matchStatus = filters.status === 'all' || (row.status || 'Đang hoạt động') === filters.status
    const matchShip = filters.ship === 'all' || (filters.ship === 'free' ? row.freeShip : !row.freeShip)
    const matchRating = filters.rating === 'all' || Number(row.rating || 0) >= Number(filters.rating)
    return matchQuery && matchStatus && matchShip && matchRating
  })

  const save = (event) => {
    event.preventDefault()
    const next = upsertById(rows, form)
    setRows(next)
    saveJson('adminRestaurants', next)
    broadcastNotification({ title: 'Nhà hàng được cập nhật', message: `Admin vừa cập nhật nhà hàng ${form.title}.`, type: 'restaurant' })
    setForm(null)
  }

  return (
    <NavbarAdmin title="Nhà hàng" subtitle="CRUD nhà hàng, trạng thái vận hành và ưu đãi giao hàng." action={<button onClick={() => setForm({ title: '', subtitle: '', address: '', rating: 4.8, freeShip: true, status: 'Đang hoạt động' })} className="rounded-lg bg-orange-500 px-4 py-2 text-sm font-black text-white">Thêm nhà hàng</button>}>
      <div className="mb-4 grid grid-cols-1 gap-3 lg:grid-cols-[1fr_180px_180px_180px]">
        <input value={filters.query} onChange={(event) => setFilters({ ...filters, query: event.target.value })} placeholder="Tìm nhà hàng, địa chỉ, danh mục..." className="rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" />
        <select value={filters.status} onChange={(event) => setFilters({ ...filters, status: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi trạng thái</option><option>Đang hoạt động</option><option>Tạm ngưng</option><option>Ẩn</option></select>
        <select value={filters.ship} onChange={(event) => setFilters({ ...filters, ship: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi giao hàng</option><option value="free">Miễn phí</option><option value="paid">Có phí</option></select>
        <select value={filters.rating} onChange={(event) => setFilters({ ...filters, rating: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi đánh giá</option><option value="4">Từ 4 sao</option><option value="4.5">Từ 4.5 sao</option></select>
      </div>
      <AdminTable rows={filteredRows} columns={[
        { key: 'title', label: 'Nhà hàng', render: (row) => <span className="font-bold text-slate-950">{row.title}</span> },
        { key: 'subtitle', label: 'Mô tả', render: (row) => row.subtitle || row.description || 'Đang cập nhật' },
        { key: 'address', label: 'Địa chỉ', render: (row) => row.address || 'Chưa cập nhật' },
        { key: 'rating', label: 'Đánh giá', render: (row) => row.rating || '4.8' },
        { key: 'freeShip', label: 'Giao hàng', render: (row) => row.freeShip ? 'Miễn phí' : 'Tiêu chuẩn' },
        { key: 'status', label: 'Trạng thái', render: (row) => <span className="rounded-full bg-emerald-50 px-3 py-1 text-xs font-black text-emerald-700">{row.status || 'Đang hoạt động'}</span> },
        { key: 'actions', label: 'Thao tác', render: (row) => <div className="flex gap-2"><button onClick={() => setForm(row)} className="rounded-lg bg-slate-100 px-3 py-1 font-bold">Sửa</button><button onClick={() => { const next = rows.filter((item) => item.id !== row.id); setRows(next); saveJson('adminRestaurants', next) }} className="rounded-lg bg-red-50 px-3 py-1 font-bold text-red-600">Xóa</button></div> },
      ]} />
      {form && <ResourceModal title={form.id ? 'Sửa nhà hàng' : 'Thêm nhà hàng'} fields={[
        { name: 'title', label: 'Tên nhà hàng' },
        { name: 'subtitle', label: 'Mô tả ngắn' },
        { name: 'address', label: 'Địa chỉ', full: true },
        { name: 'rating', label: 'Đánh giá', type: 'number' },
        { name: 'status', label: 'Trạng thái', type: 'select', options: ['Đang hoạt động', 'Tạm ngưng', 'Ẩn'].map((value) => ({ value, label: value })) },
        { name: 'freeShip', label: 'Miễn phí giao hàng', type: 'checkbox', required: false },
      ]} form={form} setForm={setForm} onClose={() => setForm(null)} onSubmit={save} />}
    </NavbarAdmin>
  )
}

export function AdminFoodsPage() {
  const { foods, categories, restaurants } = useAdminData()
  const [rows, setRows] = useState([])
  const [form, setForm] = useState(null)
  const [filters, setFilters] = useState({ query: '', category: 'all', restaurant: 'all', status: 'all', ship: 'all' })
  useEffect(() => setRows(foods.filter((food) => (food.status || 'Có sẵn') !== 'Ẩn')), [foods])

  const filteredRows = rows.filter((row) => {
    const keyword = filters.query.trim().toLowerCase()
    const haystack = [row.title, row.description, row.categoryName, row.restaurantTitle, row.timeShip].join(' ').toLowerCase()
    return (!keyword || haystack.includes(keyword))
      && (filters.category === 'all' || String(row.categoryId) === String(filters.category) || row.categoryName === filters.category)
      && (filters.restaurant === 'all' || String(row.restaurantId) === String(filters.restaurant) || row.restaurantTitle === filters.restaurant)
      && (filters.status === 'all' || (row.status || 'Có sẵn') === filters.status)
      && (filters.ship === 'all' || (filters.ship === 'free' ? row.freeShip : !row.freeShip))
  })

  const save = (event) => {
    event.preventDefault()
    const category = categories.find((item) => String(item.id) === String(form.categoryId))
    const restaurant = restaurants.find((item) => String(item.id) === String(form.restaurantId))
    const next = upsertById(rows, { ...form, categoryName: category?.title || category?.name || form.categoryName, restaurantTitle: restaurant?.title || form.restaurantTitle })
    setRows(next)
    const tombstones = readAdminFoodTombstones().filter((food) => !next.some((item) => String(item.id) === String(food.id)))
    saveJson('adminFoods', [...next, ...tombstones])
    broadcastNotification({ title: 'Món ăn được cập nhật', message: `Admin vừa cập nhật món ${form.title}.`, type: 'food' })
    setForm(null)
  }

  const removeFood = (row) => {
    const next = rows.filter((item) => String(item.id) !== String(row.id))
    const tombstones = readAdminFoodTombstones().filter((food) => String(food.id) !== String(row.id))
    setRows(next)
    saveJson('adminFoods', [...next, ...tombstones, { ...row, status: 'Ẩn' }])
    broadcastNotification({ title: 'Món ăn đã ngừng bán', message: `Admin vừa xóa hoặc ẩn món ${row.title}.`, type: 'food' })
  }

  return (
    <NavbarAdmin title="Món ăn" subtitle="CRUD món ăn đầy đủ: hình ảnh, mô tả, thời gian giao, giá, danh mục, nhà hàng và trạng thái." action={<button onClick={() => setForm({ title: '', description: '', image: '', timeShip: '20-30 phút', categoryId: categories[0]?.id || '', restaurantId: restaurants[0]?.id || '', price: 0, freeShip: true, status: 'Có sẵn' })} className="rounded-lg bg-orange-500 px-4 py-2 text-sm font-black text-white">Thêm món</button>}>
      <div className="mb-4 grid grid-cols-1 gap-3 xl:grid-cols-[1fr_180px_180px_160px_160px]">
        <input value={filters.query} onChange={(event) => setFilters({ ...filters, query: event.target.value })} placeholder="Tìm món, mô tả, nhà hàng..." className="rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" />
        <select value={filters.category} onChange={(event) => setFilters({ ...filters, category: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi danh mục</option>{categories.map((item) => <option key={item.id} value={item.id}>{item.title || item.name}</option>)}</select>
        <select value={filters.restaurant} onChange={(event) => setFilters({ ...filters, restaurant: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi nhà hàng</option>{restaurants.map((item) => <option key={item.id} value={item.id}>{item.title}</option>)}</select>
        <select value={filters.status} onChange={(event) => setFilters({ ...filters, status: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi trạng thái</option><option>Có sẵn</option><option>Hết món</option><option>Ẩn</option></select>
        <select value={filters.ship} onChange={(event) => setFilters({ ...filters, ship: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi giao hàng</option><option value="free">Miễn phí</option><option value="paid">Có phí</option></select>
      </div>
      <AdminTable rows={filteredRows} columns={[
        { key: 'title', label: 'Món ăn', render: (row, index) => <div className="flex min-w-[240px] items-center gap-3"><img src={row.image || getFoodImage(row, index)} alt={row.title} className="h-14 w-14 rounded-lg object-cover bg-slate-100" /><div><p className="font-bold text-slate-950">{row.title}</p><p className="line-clamp-1 text-xs text-slate-500">{row.description || 'Chưa có mô tả'}</p></div></div> },
        { key: 'categoryName', label: 'Danh mục' },
        { key: 'restaurantTitle', label: 'Nhà hàng', render: (row) => row.restaurantTitle || 'Chưa gắn' },
        { key: 'price', label: 'Giá', render: (row) => <span className="font-bold text-orange-600">{formatPrice(row.price)}</span> },
        { key: 'timeShip', label: 'Thời gian', render: (row) => row.timeShip || '20-30 phút' },
        { key: 'status', label: 'Trạng thái', render: (row) => <span className="rounded-full bg-emerald-50 px-3 py-1 text-xs font-black text-emerald-700">{row.status || 'Có sẵn'}</span> },
        { key: 'actions', label: 'Thao tác', render: (row) => <div className="flex gap-2"><button onClick={() => setForm(row)} className="rounded-lg bg-slate-100 px-3 py-1 font-bold">Sửa</button><button onClick={() => removeFood(row)} className="rounded-lg bg-red-50 px-3 py-1 font-bold text-red-600">Xóa</button></div> },
      ]} />
      {form && <ResourceModal title={form.id ? 'Sửa món ăn' : 'Thêm món ăn'} fields={[
        { name: 'title', label: 'Tên món' },
        { name: 'image', label: 'URL hình ảnh', required: false },
        { name: 'description', label: 'Mô tả món', full: true },
        { name: 'timeShip', label: 'Thời gian giao' },
        { name: 'price', label: 'Giá bán', type: 'number' },
        { name: 'categoryId', label: 'Danh mục', type: 'select', options: categories.map((item) => ({ value: item.id, label: item.title || item.name })) },
        { name: 'restaurantId', label: 'Nhà hàng', type: 'select', options: restaurants.map((item) => ({ value: item.id, label: item.title })) },
        { name: 'status', label: 'Trạng thái', type: 'select', options: ['Có sẵn', 'Hết món', 'Ẩn'].map((value) => ({ value, label: value })) },
        { name: 'freeShip', label: 'Miễn phí giao hàng', type: 'checkbox', required: false },
      ]} form={form} setForm={setForm} onClose={() => setForm(null)} onSubmit={save} />}
    </NavbarAdmin>
  )
}

export function AdminShippingPage() {
  const [orders, setOrders] = useState(() => readOrders())
  const [filters, setFilters] = useState({ query: '', status: 'all', payment: 'all', date: '' })
  const [selectedOrder, setSelectedOrder] = useState(null)

  useEffect(() => {
    const sync = () => setOrders(readOrders())
    const timer = setInterval(sync, 1200)
    window.addEventListener('storage', sync)
    window.addEventListener('foodhub-storage-sync', sync)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', sync)
      window.removeEventListener('foodhub-storage-sync', sync)
    }
  }, [])

  const revenue = orders.filter((order) => order.status !== 'Đã hủy').reduce((sum, order) => sum + Number(order.total || 0), 0)
  const filteredOrders = orders.filter((order) => {
    const keyword = filters.query.trim().toLowerCase()
    const customer = order.customer || order.profile || {}
    const haystack = [order.id, order.account, customer.fullname, customer.phone, customer.address, order.note].join(' ').toLowerCase()
    const matchDate = !filters.date || (order.createdAt || '').slice(0, 10) === filters.date
    return (!keyword || haystack.includes(keyword))
      && (filters.status === 'all' || order.status === filters.status)
      && (filters.payment === 'all' || order.paymentMethod === filters.payment)
      && matchDate
  })

  const setStatus = (order, status) => {
    setOrders(updateStoredOrder(order.account, order.id, (item) => ({ ...item, status, updatedAt: new Date().toISOString() })))
    addNotificationForAccount(order.account, { title: 'Cập nhật đơn hàng', message: `Đơn ${order.id} chuyển sang trạng thái: ${status}.`, type: 'order', orderId: order.id })
  }
  const removeOrder = (order) => {
    setOrders(updateStoredOrder(order.account, order.id, (item) => ({ ...item, status: 'Đã hủy', cancelReason: 'Admin hủy đơn', updatedAt: new Date().toISOString() })))
    addNotificationForAccount(order.account, { title: 'Đơn hàng đã bị hủy', message: `Đơn ${order.id} đã bị admin hủy.`, type: 'order', orderId: order.id })
  }

  return (
    <NavbarAdmin title="Đơn hàng & giao hàng" subtitle="Gộp quản lý đơn hàng và vận chuyển: xác nhận, chuẩn bị, giao hàng, hoàn tất hoặc hủy.">
      <div className="mb-6 grid grid-cols-1 gap-4 md:grid-cols-4">
        <StatRow label="Tổng đơn" value={orders.length} tone="orange" />
        <StatRow label="Cần xác nhận" value={orders.filter((row) => row.status === 'Đang xác nhận').length} />
        <StatRow label="Đang giao" value={orders.filter((row) => row.status === 'Đang giao').length} />
        <StatRow label="Doanh thu hợp lệ" value={formatPrice(revenue)} />
      </div>
      <div className="mb-4 grid grid-cols-1 gap-3 xl:grid-cols-[1fr_180px_180px_180px]">
        <input value={filters.query} onChange={(event) => setFilters({ ...filters, query: event.target.value })} placeholder="Tìm mã đơn, khách, SĐT, địa chỉ..." className="rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" />
        <select value={filters.status} onChange={(event) => setFilters({ ...filters, status: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi trạng thái</option>{ORDER_STATUS.map((status) => <option key={status}>{status}</option>)}</select>
        <select value={filters.payment} onChange={(event) => setFilters({ ...filters, payment: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi thanh toán</option><option value="cod">COD</option><option value="bank">Ngân hàng</option><option value="wallet">Ví điện tử</option></select>
        <input type="date" value={filters.date} onChange={(event) => setFilters({ ...filters, date: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3" />
      </div>
      <AdminTable rows={filteredOrders} empty="Chưa có đơn hàng. Khi khách đặt hàng, đơn sẽ xuất hiện ở đây." columns={[
        { key: 'id', label: 'Mã đơn' },
        { key: 'customer', label: 'Khách hàng', render: (row) => <div><p className="font-bold text-slate-950">{(row.customer || row.profile)?.fullname || row.account}</p><p className="text-xs text-slate-500">{(row.customer || row.profile)?.phone || 'Chưa có SĐT'}</p></div> },
        { key: 'address', label: 'Địa chỉ giao', render: (row) => (row.customer || row.profile)?.address || 'Chưa cập nhật' },
        { key: 'items', label: 'Món', render: (row) => `${(row.items || []).reduce((sum, item) => sum + Number(item.quantity || 1), 0)} món` },
        { key: 'total', label: 'Tổng tiền', render: (row) => <span className="font-bold text-orange-600">{formatPrice(row.total)}</span> },
        { key: 'status', label: 'Trạng thái', render: (row) => <span className={`rounded-full px-3 py-1 text-xs font-black ${statusClass(row.status)}`}>{row.status}</span> },
        { key: 'actions', label: 'Quyền admin', render: (row) => <div className="flex min-w-[420px] flex-wrap gap-2"><button onClick={() => setSelectedOrder(row)} className="rounded-lg bg-slate-900 px-3 py-1 text-xs font-bold text-white">Chi tiết</button>{ADMIN_ORDER_ACTIONS.map((status) => <button key={status} onClick={() => setStatus(row, status)} className={`rounded-lg px-3 py-1 text-xs font-bold ${statusClass(status)}`}>{status}</button>)}<button onClick={() => removeOrder(row)} className="rounded-lg bg-red-50 px-3 py-1 text-xs font-bold text-red-600">Hủy bỏ</button></div> },
      ]} />
      {selectedOrder && (
        <div className="fixed inset-0 z-50 grid place-items-center bg-slate-950/50 px-4">
          <div className="max-h-[90vh] w-full max-w-4xl overflow-y-auto rounded-xl bg-white p-6 shadow-2xl">
            <div className="flex items-start justify-between gap-4">
              <div><h3 className="text-2xl font-black text-slate-950">Chi tiết đơn {selectedOrder.id}</h3><p className="mt-1 text-sm text-slate-500">Tạo lúc {selectedOrder.createdAt ? new Date(selectedOrder.createdAt).toLocaleString('vi-VN') : 'Chưa có'}</p></div>
              <button onClick={() => setSelectedOrder(null)} className="rounded-lg border border-slate-200 px-4 py-2 font-bold">Đóng</button>
            </div>
            <div className="mt-6 grid grid-cols-1 gap-4 md:grid-cols-3">
              <div className="rounded-xl bg-slate-50 p-4"><p className="text-xs font-bold uppercase text-slate-500">Khách hàng</p><p className="mt-2 font-black">{(selectedOrder.customer || selectedOrder.profile)?.fullname || selectedOrder.account}</p><p className="text-sm text-slate-500">{(selectedOrder.customer || selectedOrder.profile)?.phone || 'Chưa có SĐT'}</p></div>
              <div className="rounded-xl bg-slate-50 p-4"><p className="text-xs font-bold uppercase text-slate-500">Giao hàng</p><p className="mt-2 font-black">{(selectedOrder.customer || selectedOrder.profile)?.address || 'Chưa cập nhật'}</p><p className="text-sm text-slate-500">{selectedOrder.note || 'Không có ghi chú'}</p></div>
              <div className="rounded-xl bg-slate-50 p-4"><p className="text-xs font-bold uppercase text-slate-500">Thanh toán</p><p className="mt-2 font-black">{formatPrice(selectedOrder.total)}</p><p className="text-sm text-slate-500">{selectedOrder.paymentMethod || 'cod'}</p></div>
            </div>
            <div className="mt-6 overflow-hidden rounded-xl border border-slate-200">
              {(selectedOrder.items || []).map((item, index) => <div key={item.id || index} className="flex items-center gap-4 border-b border-slate-100 p-4"><img src={getFoodImage(item.food, index)} alt={item.food?.title} className="h-16 w-16 rounded-lg object-cover" /><div className="flex-1"><p className="font-bold">{item.food?.title}</p><p className="text-sm text-slate-500">{item.restaurant?.title}</p></div><p className="text-sm">SL: {item.quantity || 1}</p><p className="font-bold text-orange-600">{formatPrice(item.food?.price)}</p></div>)}
            </div>
          </div>
        </div>
      )}
    </NavbarAdmin>
  )
}

export const AdminOrdersPage = AdminShippingPage

export function AdminSalesReportPage() {
  const { categories, foods } = useAdminData()
  const orders = readOrders()
  const [filters, setFilters] = useState({ status: 'all', from: '', to: '' })
  const reportOrders = orders.filter((order) => {
    const day = (order.createdAt || '').slice(0, 10)
    return (filters.status === 'all' || order.status === filters.status)
      && (!filters.from || day >= filters.from)
      && (!filters.to || day <= filters.to)
  })
  const validOrders = reportOrders.filter((order) => order.status !== 'Đã hủy')
  const revenue = validOrders.reduce((sum, order) => sum + Number(order.total || 0), 0)
  const cancelled = reportOrders.filter((order) => order.status === 'Đã hủy').length
  const maxCategoryFoods = Math.max(1, ...categories.map((category) => (category.menus || []).length))
  const statusRows = ORDER_STATUS.map((status) => ({ status, count: reportOrders.filter((order) => order.status === status).length }))

  return (
    <NavbarAdmin title="Báo cáo doanh thu" subtitle="Dashboard doanh thu theo đơn, trạng thái vận hành và năng lực danh mục.">
      <div className="grid grid-cols-1 gap-4 md:grid-cols-4">
        <StatRow label="Doanh thu hợp lệ" value={formatPrice(revenue)} tone="orange" />
        <StatRow label="Đơn thành công" value={validOrders.length} />
        <StatRow label="Tỷ lệ hủy" value={`${reportOrders.length ? Math.round((cancelled / reportOrders.length) * 100) : 0}%`} />
        <StatRow label="AOV" value={formatPrice(validOrders.length ? revenue / validOrders.length : 0)} />
      </div>
      <div className="mt-6 grid grid-cols-1 gap-3 lg:grid-cols-[220px_180px_180px]">
        <select value={filters.status} onChange={(event) => setFilters({ ...filters, status: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3"><option value="all">Mọi trạng thái</option>{ORDER_STATUS.map((status) => <option key={status}>{status}</option>)}</select>
        <input type="date" value={filters.from} onChange={(event) => setFilters({ ...filters, from: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3" />
        <input type="date" value={filters.to} onChange={(event) => setFilters({ ...filters, to: event.target.value })} className="rounded-xl border border-slate-200 px-4 py-3" />
      </div>
      <div className="mt-6 grid grid-cols-1 gap-6 xl:grid-cols-[1.1fr_0.9fr]">
        <section className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
          <h3 className="text-xl font-black text-slate-950">Hiệu suất danh mục</h3>
          <p className="mt-1 text-sm text-slate-500">Danh mục càng nhiều món càng có khả năng phủ nhu cầu tốt hơn.</p>
          <div className="mt-6 space-y-4">{categories.map((category) => {
            const foodCount = (category.menus || []).length
            return <div key={category.id}><div className="mb-1 flex justify-between text-sm"><span className="font-bold">{category.title || category.name}</span><span>{foodCount} món</span></div><div className="h-3 rounded-full bg-slate-100"><div className="h-3 rounded-full bg-orange-500" style={{ width: `${Math.max(8, (foodCount / maxCategoryFoods) * 100)}%` }} /></div></div>
          })}</div>
        </section>
        <section className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
          <h3 className="text-xl font-black text-slate-950">Pipeline đơn hàng</h3>
          <div className="mt-5 space-y-3">{statusRows.map((row) => <div key={row.status} className="flex items-center justify-between rounded-lg bg-slate-50 px-4 py-3"><span className="font-bold text-slate-700">{row.status}</span><span className="rounded-full bg-white px-3 py-1 text-sm font-black text-slate-950">{row.count}</span></div>)}</div>
          <div className="mt-5 rounded-xl bg-slate-950 p-5 text-white"><p className="text-sm text-slate-300">Tổng món đang bán</p><p className="mt-2 text-4xl font-black">{foods.length}</p></div>
        </section>
      </div>
    </NavbarAdmin>
  )
}

export function AdminMessagesPage() {
  const [threads, setThreads] = useState(() => readMessageThreads())
  const [activeKey, setActiveKey] = useState('')
  const [reply, setReply] = useState('')
  const active = threads.find((thread) => `${thread.account}:${thread.id}` === activeKey) || threads[0]

  useEffect(() => {
    const sync = () => setThreads(readMessageThreads())
    const timer = setInterval(sync, 1200)
    window.addEventListener('storage', sync)
    window.addEventListener('foodhub-storage-sync', sync)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', sync)
      window.removeEventListener('foodhub-storage-sync', sync)
    }
  }, [])

  const sendReply = (event) => {
    event.preventDefault()
    if (!reply.trim() || !active) return
    const stored = readJson(active.storageKey, [])
    const next = stored.map((thread) => thread.id === active.id ? {
      ...thread,
      messages: [...(thread.messages || []), { from: 'them', text: reply.trim(), time: new Date().toISOString(), sender: 'admin' }],
    } : thread)
    saveJson(active.storageKey, next)
    addNotificationForAccount(active.account, { title: 'Tin nhắn hỗ trợ mới', message: `Admin đã phản hồi trong ${active.name}.`, type: 'message' })
    logActivity('Admin phản hồi hỗ trợ', { user: active.account, thread: active.name })
    setReply('')
    setThreads(readMessageThreads())
  }

  return (
    <NavbarAdmin title="Tin nhắn hỗ trợ" subtitle="Admin thấy toàn bộ hội thoại hỗ trợ và phản hồi lại tài khoản user gần realtime.">
      <div className="grid min-h-[650px] grid-cols-1 gap-6 xl:grid-cols-[360px_1fr]">
        <aside className="overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
          {threads.map((thread) => {
            const key = `${thread.account}:${thread.id}`
            const last = thread.messages?.[thread.messages.length - 1]
            return <button key={key} onClick={() => setActiveKey(key)} className={`w-full border-b border-slate-100 px-5 py-4 text-left hover:bg-orange-50 ${active === thread ? 'bg-orange-50' : ''}`}><p className="font-black text-slate-950">{thread.account}</p><p className="text-sm font-bold text-slate-600">{thread.name}</p><p className="mt-2 line-clamp-1 text-xs text-slate-500">{last?.text || 'Chưa có tin nhắn'}</p></button>
          })}
          {threads.length === 0 && <div className="p-8 text-center text-slate-500">Chưa có hội thoại hỗ trợ.</div>}
        </aside>
        <section className="flex overflow-hidden rounded-xl border border-slate-200 bg-white shadow-sm">
          {active ? <div className="flex min-w-0 flex-1 flex-col">
            <div className="border-b border-slate-100 px-5 py-4"><h3 className="text-lg font-black text-slate-950">{active.name}</h3><p className="text-sm text-slate-500">Tài khoản: {active.account}</p></div>
            <div className="flex-1 space-y-3 overflow-y-auto bg-slate-50 p-5">{(active.messages || []).map((message, index) => <div key={index} className={`flex ${message.from === 'me' ? 'justify-start' : 'justify-end'}`}><div className={`max-w-[75%] rounded-2xl px-4 py-3 text-sm ${message.from === 'me' ? 'border border-slate-200 bg-white text-slate-700' : 'bg-orange-500 text-white'}`}><p>{message.text}</p><p className="mt-1 text-[11px] opacity-70">{message.time ? new Date(message.time).toLocaleString('vi-VN') : ''}</p></div></div>)}</div>
            <form onSubmit={sendReply} className="flex gap-3 border-t border-slate-100 p-4"><input value={reply} onChange={(event) => setReply(event.target.value)} placeholder="Nhập phản hồi cho user..." className="flex-1 rounded-xl border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" /><button className="rounded-xl bg-orange-500 px-5 py-3 font-black text-white">Gửi phản hồi</button></form>
          </div> : <div className="grid flex-1 place-items-center text-slate-500">Chọn hội thoại để phản hồi.</div>}
        </section>
      </div>
    </NavbarAdmin>
  )
}

export function AdminSettingsPage() {
  const defaultSettings = { storeName: 'FoodHub', supportPhone: '0900000000', autoConfirmOrders: true, notifyAdmin: true, maintenanceMode: false }
  const [settings, setSettings] = useState(() => readJson('adminSettings', defaultSettings))
  const updateSetting = (key, value) => {
    const next = { ...settings, [key]: value }
    setSettings(next)
    saveJson('adminSettings', next)
  }

  return (
    <NavbarAdmin title="Cài đặt" subtitle="Cấu hình vận hành cho trang quản trị và quy trình đơn hàng.">
      <div className="grid grid-cols-1 gap-6 xl:grid-cols-[0.9fr_1.1fr]">
        <section className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
          <h3 className="text-xl font-black text-slate-950">Thông tin hệ thống</h3>
          <div className="mt-5 space-y-4">
            <label className="block"><span className="text-sm font-bold text-slate-700">Tên hệ thống</span><input className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" value={settings.storeName} onChange={(event) => updateSetting('storeName', event.target.value)} /></label>
            <label className="block"><span className="text-sm font-bold text-slate-700">Số hỗ trợ</span><input className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" value={settings.supportPhone} onChange={(event) => updateSetting('supportPhone', event.target.value)} /></label>
          </div>
        </section>
        <section className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm">
          <h3 className="text-xl font-black text-slate-950">Tùy chọn vận hành</h3>
          <div className="mt-2 divide-y divide-slate-100">{[
            ['autoConfirmOrders', 'Tự động tiếp nhận đơn mới'],
            ['notifyAdmin', 'Thông báo khi có tin nhắn hỗ trợ'],
            ['maintenanceMode', 'Chế độ bảo trì'],
          ].map(([key, label]) => <label key={key} className="flex cursor-pointer items-center justify-between gap-4 py-4"><span className="font-bold text-slate-950">{label}</span><input type="checkbox" checked={Boolean(settings[key])} onChange={(event) => updateSetting(key, event.target.checked)} className="h-5 w-5 accent-orange-500" /></label>)}</div>
        </section>
      </div>
    </NavbarAdmin>
  )
}
