import React, { useEffect, useMemo, useState } from 'react'
import { Link } from 'react-router-dom'
import Navbar from '../Components/Navbar'
import { TEXT } from '../../constants/text'
import {
  formatPrice,
  getFoodImage,
  getOrders,
  getPlacedOrders,
  getProfile,
  isLoggedIn,
  saveOrders,
  savePlacedOrders,
  saveProfile,
} from '../../utils/foodData'

function OrdersPage() {
  const loggedIn = isLoggedIn()
  const [cart, setCart] = useState([])
  const [placedOrders, setPlacedOrders] = useState([])
  const [profile, setProfile] = useState({ fullname: '', email: '', phone: '', address: '' })
  const [paymentMethod, setPaymentMethod] = useState('cod')
  const [note, setNote] = useState('')
  const [success, setSuccess] = useState('')
  const [selectedOrder, setSelectedOrder] = useState(null)

  useEffect(() => {
    setCart(getOrders())
    setPlacedOrders(getPlacedOrders())
    setProfile(getProfile() || { fullname: '', email: '', phone: '', address: '' })
  }, [])

  useEffect(() => {
    if (!loggedIn) return undefined
    const syncOrders = () => {
      setCart(getOrders())
      setPlacedOrders(getPlacedOrders())
    }
    const timer = setInterval(syncOrders, 1200)
    window.addEventListener('storage', syncOrders)
    window.addEventListener('foodhub-storage-sync', syncOrders)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', syncOrders)
      window.removeEventListener('foodhub-storage-sync', syncOrders)
    }
  }, [loggedIn])

  const statusClass = (status) => ({
    'Đã xác nhận': 'bg-blue-50 text-blue-700',
    'Đang chuẩn bị': 'bg-purple-50 text-purple-700',
    'Đang giao': 'bg-amber-50 text-amber-700',
    'Hoàn tất': 'bg-emerald-50 text-emerald-700',
    'Đã hủy': 'bg-red-50 text-red-600',
  }[status] || 'bg-slate-100 text-slate-700')

  const subtotal = useMemo(() => cart.reduce((total, item) => total + (item.food.price || 0) * (item.quantity || 1), 0), [cart])
  const deliveryFee = subtotal > 0 && subtotal < 150000 ? 18000 : 0
  const discount = subtotal >= 300000 ? 25000 : 0
  const total = Math.max(subtotal + deliveryFee - discount, 0)

  const updateCart = (next) => {
    setCart(next)
    saveOrders(next)
  }

  const changeQty = (id, delta) => {
    updateCart(cart.map((item) => item.id === id ? { ...item, quantity: Math.max(1, (item.quantity || 1) + delta) } : item))
  }

  const removeItem = (id) => {
    updateCart(cart.filter((item) => item.id !== id))
  }

  const updateProfile = (field, value) => {
    setProfile((current) => ({ ...current, [field]: value }))
  }

  const placeOrder = () => {
    if (!profile.phone.trim() || !profile.address.trim()) {
      setSuccess('Vui lòng nhập số điện thoại và địa chỉ giao hàng.')
      return
    }
    const order = {
      id: `FH${Date.now()}`,
      items: cart,
      subtotal,
      deliveryFee,
      discount,
      total,
      paymentMethod,
      note,
      profile,
      customer: profile,
      status: 'Đang xác nhận',
      createdAt: new Date().toISOString(),
    }
    saveProfile(profile)
    savePlacedOrders([order, ...placedOrders])
    saveOrders([])
    setPlacedOrders([order, ...placedOrders])
    setCart([])
    setSuccess(`Đặt hàng thành công. Mã đơn: ${order.id}`)
  }

  if (!loggedIn) {
    return (
      <div className="min-h-screen bg-gray-50">
        <Navbar />
        <main className="max-w-4xl mx-auto px-4 py-12">
          <h1 className="text-3xl font-extrabold text-gray-900">{TEXT.page_orders_title}</h1>
          <div className="mt-8 bg-white border border-gray-100 rounded-2xl p-10">
            <p className="text-gray-600">{TEXT.page_orders_login}</p>
            <Link to="/login" className="inline-flex mt-6 rounded-xl bg-orange-500 px-5 py-3 text-white font-semibold">
              {TEXT.nav_login}
            </Link>
          </div>
        </main>
      </div>
    )
  }

  return (
    <div className="min-h-screen bg-gray-50">
      <Navbar />
      <main className="mx-auto w-full max-w-7xl px-4 py-8 sm:px-6 sm:py-10 lg:px-8">
        <div className="flex flex-col gap-3 sm:flex-row sm:items-end sm:justify-between">
          <div className="min-w-0">
            <h1 className="text-2xl font-extrabold text-gray-900 sm:text-3xl">Giỏ hàng và đặt món</h1>
            <p className="text-gray-500 mt-1">Kiểm tra món, số lượng, giao hàng và thanh toán.</p>
          </div>
          <Link to="/" className="inline-flex min-h-11 items-center text-sm font-semibold text-orange-500">Tiếp tục chọn món</Link>
        </div>

        {success && (
          <div className={`mt-6 rounded-2xl px-5 py-4 text-sm font-medium ${success.includes('thành công') ? 'bg-green-50 text-green-700' : 'bg-red-50 text-red-600'}`}>
            {success}
          </div>
        )}

        <div className="mt-6 grid min-w-0 grid-cols-1 gap-6 lg:mt-8 lg:grid-cols-[minmax(0,1fr)_minmax(320px,380px)]">
          <section className="min-w-0 space-y-4">
            {cart.length === 0 ? (
              <div className="bg-white border border-gray-100 rounded-2xl p-10 text-gray-500">
                Giỏ hàng trống. Hãy chọn món từ trang chủ.
              </div>
            ) : cart.map((item, index) => (
              <article key={item.id} className="flex min-w-0 flex-wrap gap-3 rounded-2xl border border-gray-100 bg-white p-4 shadow-sm sm:flex-nowrap sm:gap-4">
                <img src={getFoodImage(item.food, index)} alt={item.food.title} className="h-20 w-20 shrink-0 rounded-xl bg-gray-100 object-cover sm:h-24 sm:w-24" />
                <div className="min-w-0 flex-1">
                  <h2 className="break-words font-bold text-gray-900">{item.food.title}</h2>
                  <p className="text-sm text-gray-500 mt-1">{item.restaurant?.title}</p>
                  <p className="text-sm font-semibold text-orange-600 mt-2">{formatPrice(item.food.price)}</p>
                </div>
                <div className="flex w-full items-center justify-between gap-3 sm:w-auto sm:flex-col sm:items-end">
                  <div className="flex items-center rounded-xl border border-gray-200 overflow-hidden">
                    <button aria-label="Giảm số lượng" onClick={() => changeQty(item.id, -1)} className="h-11 w-11 hover:bg-gray-50">−</button>
                    <span className="px-3 py-2 text-sm font-semibold">{item.quantity || 1}</span>
                    <button aria-label="Tăng số lượng" onClick={() => changeQty(item.id, 1)} className="h-11 w-11 hover:bg-gray-50">+</button>
                  </div>
                  <button onClick={() => removeItem(item.id)} className="min-h-11 px-2 text-sm font-semibold text-red-500">Xóa</button>
                </div>
              </article>
            ))}

            {placedOrders.length > 0 && (
              <section className="bg-white border border-gray-100 rounded-2xl p-5">
                <h2 className="text-lg font-bold text-gray-900">Lịch sử đơn hàng</h2>
                <div className="divide-y divide-gray-100 mt-3">
                  {placedOrders.slice(0, 8).map((order) => (
                    <button key={order.id} onClick={() => setSelectedOrder(order)} className="w-full py-3 flex items-center justify-between text-left hover:bg-gray-50">
                      <div>
                        <p className="font-semibold text-gray-900">{order.id}</p>
                        <p className="text-sm text-gray-500">{order.items.length} món</p>
                        <span className={`mt-2 inline-flex rounded-full px-3 py-1 text-xs font-bold ${statusClass(order.status)}`}>{order.status}</span>
                      </div>
                      <div className="text-right">
                        <p className="font-bold text-orange-600">{formatPrice(order.total)}</p>
                        <span className="mt-2 inline-flex text-xs font-bold text-gray-500">Xem chi tiết</span>
                      </div>
                    </button>
                  ))}
                </div>
              </section>
            )}
          </section>

          <aside className="space-y-5">
            <section className="bg-white border border-gray-100 rounded-2xl p-5 shadow-sm">
              <h2 className="text-lg font-bold text-gray-900">Thông tin giao hàng</h2>
              <div className="space-y-3 mt-4">
                <input value={profile.fullname} onChange={(e) => updateProfile('fullname', e.target.value)} placeholder="Họ và tên" className="w-full rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-orange-400" />
                <input value={profile.phone} onChange={(e) => updateProfile('phone', e.target.value)} placeholder="Số điện thoại" className="w-full rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-orange-400" />
                <textarea value={profile.address} onChange={(e) => updateProfile('address', e.target.value)} rows="3" placeholder="Địa chỉ giao hàng" className="w-full rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-orange-400" />
                <textarea value={note} onChange={(e) => setNote(e.target.value)} rows="2" placeholder="Ghi chú cho shipper/nhà hàng" className="w-full rounded-xl border border-gray-200 px-4 py-3 text-sm outline-none focus:ring-2 focus:ring-orange-400" />
              </div>
            </section>

            <section className="bg-white border border-gray-100 rounded-2xl p-5 shadow-sm">
              <h2 className="text-lg font-bold text-gray-900">Thanh toán</h2>
              <div className="space-y-2 mt-4">
                {[
                  ['cod', 'Thanh toán khi nhận hàng'],
                  ['bank', 'Chuyển khoản ngân hàng'],
                  ['wallet', 'Ví điện tử'],
                ].map(([value, label]) => (
                  <label key={value} className="flex items-center gap-2 rounded-xl border border-gray-100 px-3 py-2">
                    <input type="radio" name="payment" checked={paymentMethod === value} onChange={() => setPaymentMethod(value)} className="accent-orange-500" />
                    <span className="text-sm font-medium text-gray-700">{label}</span>
                  </label>
                ))}
              </div>
            </section>

            <section className="bg-white border border-gray-100 rounded-2xl p-5 shadow-sm">
              <h2 className="text-lg font-bold text-gray-900">Tóm tắt đơn hàng</h2>
              <div className="space-y-3 mt-4 text-sm">
                <div className="flex justify-between"><span>Tạm tính</span><span>{formatPrice(subtotal)}</span></div>
                <div className="flex justify-between"><span>Phí giao hàng</span><span>{deliveryFee ? formatPrice(deliveryFee) : 'Miễn phí'}</span></div>
                <div className="flex justify-between"><span>Giảm giá</span><span>-{formatPrice(discount)}</span></div>
                <div className="border-t border-gray-100 pt-3 flex justify-between text-lg font-extrabold text-gray-900">
                  <span>Tổng cộng</span><span>{formatPrice(total)}</span>
                </div>
              </div>
              <button disabled={cart.length === 0} onClick={placeOrder} className="mt-5 w-full rounded-xl bg-orange-500 px-5 py-3 text-sm font-bold text-white hover:bg-orange-600 disabled:bg-gray-300">
                Đặt hàng và giao ngay
              </button>
              <p className="text-xs text-gray-400 mt-3">Sau khi đặt, nhà hàng sẽ xác nhận và shipper sẽ giao đến địa chỉ của bạn.</p>
            </section>
          </aside>
        </div>
        {selectedOrder && (
          <div className="fixed inset-0 z-50 grid place-items-center bg-gray-950/50 p-3">
            <div className="max-h-[calc(100dvh-24px)] w-full max-w-3xl overflow-y-auto rounded-2xl bg-white p-4 shadow-2xl sm:p-6">
              <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
                <div className="min-w-0">
                  <h2 className="break-words text-xl font-extrabold text-gray-900 sm:text-2xl">Chi tiết đơn {selectedOrder.id}</h2>
                  <p className="mt-1 text-sm text-gray-500">{selectedOrder.createdAt ? new Date(selectedOrder.createdAt).toLocaleString('vi-VN') : 'Chưa có thời gian'}</p>
                </div>
                <button onClick={() => setSelectedOrder(null)} className="min-h-11 self-start rounded-xl border border-gray-200 px-4 py-2 text-sm font-bold text-gray-700">Đóng</button>
              </div>
              <div className="mt-5 grid grid-cols-1 gap-3 md:grid-cols-3">
                <div className="rounded-xl bg-gray-50 p-4">
                  <p className="text-xs font-bold uppercase text-gray-500">Trạng thái</p>
                  <span className={`mt-2 inline-flex rounded-full px-3 py-1 text-xs font-bold ${statusClass(selectedOrder.status)}`}>{selectedOrder.status}</span>
                </div>
                <div className="rounded-xl bg-gray-50 p-4">
                  <p className="text-xs font-bold uppercase text-gray-500">Người nhận</p>
                  <p className="mt-2 font-bold text-gray-900">{(selectedOrder.customer || selectedOrder.profile)?.fullname || profile.fullname}</p>
                  <p className="text-sm text-gray-500">{(selectedOrder.customer || selectedOrder.profile)?.phone || 'Chưa có SĐT'}</p>
                </div>
                <div className="rounded-xl bg-gray-50 p-4">
                  <p className="text-xs font-bold uppercase text-gray-500">Thanh toán</p>
                  <p className="mt-2 font-bold text-gray-900">{selectedOrder.paymentMethod === 'bank' ? 'Chuyển khoản' : selectedOrder.paymentMethod === 'wallet' ? 'Ví điện tử' : 'COD'}</p>
                  <p className="text-sm text-gray-500">{selectedOrder.note || 'Không có ghi chú'}</p>
                </div>
              </div>
              <div className="mt-4 rounded-xl bg-gray-50 p-4">
                <p className="text-xs font-bold uppercase text-gray-500">Địa chỉ giao hàng</p>
                <p className="mt-2 font-medium text-gray-800">{(selectedOrder.customer || selectedOrder.profile)?.address || 'Chưa cập nhật'}</p>
              </div>
              <div className="mt-5 overflow-hidden rounded-xl border border-gray-100">
                {(selectedOrder.items || []).map((item, index) => (
                  <div key={item.id || index} className="flex min-w-0 flex-wrap items-center gap-3 border-b border-gray-100 p-3 sm:flex-nowrap sm:gap-4 sm:p-4">
                    <img src={getFoodImage(item.food, index)} alt={item.food?.title} className="h-16 w-16 rounded-xl object-cover bg-gray-100" />
                    <div className="min-w-0 flex-1">
                      <p className="font-bold text-gray-900">{item.food?.title}</p>
                      <p className="text-sm text-gray-500">{item.restaurant?.title}</p>
                    </div>
                    <p className="text-sm font-semibold text-gray-700">x{item.quantity || 1}</p>
                    <p className="ml-auto font-bold text-orange-600">{formatPrice((item.food?.price || 0) * (item.quantity || 1))}</p>
                  </div>
                ))}
              </div>
              <div className="mt-5 space-y-2 rounded-xl bg-orange-50 p-4 text-sm">
                <div className="flex justify-between"><span>Tạm tính</span><span>{formatPrice(selectedOrder.subtotal)}</span></div>
                <div className="flex justify-between"><span>Phí giao hàng</span><span>{selectedOrder.deliveryFee ? formatPrice(selectedOrder.deliveryFee) : 'Miễn phí'}</span></div>
                <div className="flex justify-between"><span>Giảm giá</span><span>-{formatPrice(selectedOrder.discount)}</span></div>
                <div className="flex justify-between border-t border-orange-100 pt-3 text-lg font-extrabold text-gray-900"><span>Tổng cộng</span><span>{formatPrice(selectedOrder.total)}</span></div>
              </div>
            </div>
          </div>
        )}
      </main>
    </div>
  )
}

export default OrdersPage
