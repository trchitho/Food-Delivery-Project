import React, { Fragment, useEffect, useState } from 'react'
import { Menu, Transition } from '@headlessui/react'
import { BellIcon, ChevronLeftIcon, ChevronRightIcon } from '@heroicons/react/24/outline'
import { Link, useLocation, useNavigate } from 'react-router-dom'
import { clearCurrentUser, getCurrentUser } from '../../utils/foodData'

const ADMIN_NAV = [
  { label: 'Tổng quan', href: '/admin', icon: '▦' },
  { label: 'Người dùng', href: '/admin/users', icon: '◎' },
  { label: 'Danh mục', href: '/admin/categories', icon: '▤' },
  { label: 'Nhà hàng', href: '/admin/restaurants', icon: '⌂' },
  { label: 'Món ăn', href: '/admin/foods', icon: '◌' },
  { label: 'Đơn hàng & giao hàng', href: '/admin/shipping', icon: '↗' },
  { label: 'Tin nhắn hỗ trợ', href: '/admin/messages', icon: '□' },
  { label: 'Báo cáo doanh thu', href: '/admin/salesreport', icon: '↥' },
  { label: 'Cài đặt', href: '/admin/setting', icon: '⚙' },
]

function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

function NavbarAdmin({ title = 'Bảng điều khiển', subtitle = '', action, children }) {
  const location = useLocation()
  const navigate = useNavigate()
  const currentUser = getCurrentUser()
  const [adminAlerts, setAdminAlerts] = useState(0)
  const [adminNotifications, setAdminNotifications] = useState([])
  const recentAdminNotifications = adminNotifications.slice(0, 5)
  const [collapsed, setCollapsed] = useState(() => localStorage.getItem('adminSidebarCollapsed') === 'true')

  useEffect(() => {
    const countAlerts = () => {
      let count = 0
      try {
        const notifications = JSON.parse(localStorage.getItem('notifications:admin') || '[]')
        setAdminNotifications(notifications)
        count += notifications.filter((item) => !item.read).length
      } catch {
        setAdminNotifications([])
        // Ignore invalid admin notification cache.
      }
      setAdminAlerts(count)
    }
    countAlerts()
    const timer = setInterval(countAlerts, 1200)
    window.addEventListener('storage', countAlerts)
    window.addEventListener('foodhub-storage-sync', countAlerts)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', countAlerts)
      window.removeEventListener('foodhub-storage-sync', countAlerts)
    }
  }, [])

  const signOut = () => {
    clearCurrentUser()
    navigate('/login', { replace: true })
  }

  const isActive = (href) => {
    if (href === '/admin') return location.pathname === '/admin' || location.pathname === '/admin/'
    return location.pathname.startsWith(href)
  }

  const toggleSidebar = () => {
    const next = !collapsed
    setCollapsed(next)
    localStorage.setItem('adminSidebarCollapsed', String(next))
  }

  return (
    <div className="min-h-screen bg-slate-50 text-slate-950">
      <aside className={`fixed inset-y-0 left-0 z-30 hidden border-r border-slate-200 bg-white transition-all duration-200 lg:flex lg:flex-col ${collapsed ? 'w-20' : 'w-72'}`}>
        <div className={`border-b border-slate-100 ${collapsed ? 'px-3 py-5' : 'px-6 py-6'}`}>
          <div className="flex items-start justify-between gap-3">
            {!collapsed && (
              <div>
                <p className="text-xs font-bold uppercase tracking-[0.2em] text-orange-500">FoodHub Admin</p>
                <h1 className="mt-2 text-xl font-black text-slate-950">Trung tâm quản trị</h1>
                <p className="mt-1 text-sm text-slate-500">Theo dõi vận hành, đơn hàng và dữ liệu bán hàng.</p>
              </div>
            )}
            <button
              type="button"
              onClick={toggleSidebar}
              title={collapsed ? 'Mở rộng menu' : 'Thu gọn menu'}
              className="grid h-10 w-10 shrink-0 place-items-center rounded-lg border border-slate-200 bg-white text-slate-600 hover:bg-slate-50"
            >
              {collapsed ? <ChevronRightIcon className="h-5 w-5" /> : <ChevronLeftIcon className="h-5 w-5" />}
            </button>
          </div>
        </div>

        <nav className={`flex-1 overflow-y-auto py-5 space-y-1 ${collapsed ? 'px-3' : 'px-4'}`}>
          {ADMIN_NAV.map((item) => (
            <Link
              key={item.href}
              to={item.href}
              title={collapsed ? item.label : undefined}
              className={[
                'flex items-center rounded-lg px-3 py-2.5 text-sm font-semibold transition',
                collapsed ? 'justify-center gap-0' : 'gap-3',
                isActive(item.href)
                  ? 'bg-orange-50 text-orange-700 ring-1 ring-orange-100'
                  : 'text-slate-600 hover:bg-slate-100 hover:text-slate-950',
              ].join(' ')}
            >
              <span className="grid h-8 w-8 place-items-center rounded-md bg-white text-slate-500 ring-1 ring-slate-200">
                {item.icon}
              </span>
              {!collapsed && <span>{item.label}</span>}
            </Link>
          ))}
        </nav>

        <div className="border-t border-slate-100 p-4">
          {!collapsed && <div className="rounded-xl bg-slate-50 p-3">
            <p className="text-sm font-bold text-slate-900">{currentUser?.displayName || 'Admin'}</p>
            <p className="mt-0.5 text-xs text-slate-500">{currentUser?.username || 'admin'}</p>
          </div>}
          <button
            type="button"
            onClick={signOut}
            title={collapsed ? 'Đăng xuất' : undefined}
            className="mt-3 w-full rounded-lg border border-slate-200 bg-white px-4 py-2.5 text-sm font-bold text-slate-700 hover:border-red-200 hover:bg-red-50 hover:text-red-600"
          >
            {collapsed ? '↪' : 'Đăng xuất'}
          </button>
        </div>
      </aside>

      <div className={`transition-all duration-200 ${collapsed ? 'lg:pl-20' : 'lg:pl-72'}`}>
        <header className="sticky top-0 z-20 border-b border-slate-200 bg-white/95 backdrop-blur">
          <div className="px-4 py-4 sm:px-6 lg:px-8">
            <div className="flex min-w-0 flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
              <div className="min-w-0">
                <p className="text-xs font-bold uppercase tracking-[0.2em] text-orange-500 lg:hidden">FoodHub Admin</p>
                <h2 className="break-words text-xl font-black text-slate-950 sm:text-2xl">{title}</h2>
                {subtitle && <p className="mt-1 text-sm text-slate-500">{subtitle}</p>}
              </div>
              <div className="flex min-w-0 flex-wrap items-center gap-2 sm:gap-3">
                {action}
                <Menu as="div" className="relative">
                  <Menu.Button aria-label="Mở thông báo quản trị" title="Thông báo" className="relative grid h-11 w-11 place-items-center rounded-lg border border-slate-200 bg-white text-slate-700 hover:bg-slate-50 focus-visible:ring-2 focus-visible:ring-orange-300">
                    <BellIcon className="h-5 w-5" />
                    {adminAlerts > 0 && <span className="absolute -right-2 -top-2 grid h-5 min-w-5 place-items-center rounded-full bg-red-500 px-1 text-[11px] font-bold text-white">{adminAlerts > 9 ? '9+' : adminAlerts}</span>}
                  </Menu.Button>
                  <Transition
                    as={Fragment}
                    enter="transition ease-out duration-100"
                    enterFrom="transform opacity-0 scale-95"
                    enterTo="transform opacity-100 scale-100"
                    leave="transition ease-in duration-75"
                    leaveFrom="transform opacity-100 scale-100"
                    leaveTo="transform opacity-0 scale-95"
                  >
                    <Menu.Items className="fixed inset-x-3 top-20 z-40 max-h-[calc(100dvh-6rem)] origin-top-right overflow-y-auto rounded-2xl bg-white shadow-xl ring-1 ring-black/5 focus:outline-none sm:absolute sm:inset-x-auto sm:right-0 sm:top-auto sm:mt-3 sm:w-96">
                      <div className="flex items-center justify-between border-b border-slate-100 px-4 py-3">
                        <p className="text-sm font-black text-slate-950">Thông báo quản trị</p>
                        <Menu.Item>
                          {({ active }) => (
                            <Link
                              to="/notifications"
                              className={classNames(active ? 'bg-orange-50 text-orange-700' : 'text-orange-600', 'rounded-lg px-2 py-1 text-xs font-bold')}
                            >
                              Xem tất cả
                            </Link>
                          )}
                        </Menu.Item>
                      </div>
                      <div className="max-h-96 overflow-y-auto">
                        {recentAdminNotifications.length === 0 ? (
                          <div className="px-4 py-5 text-sm text-slate-500">
                            Chưa có thông báo quản trị mới.
                          </div>
                        ) : (
                          recentAdminNotifications.map((item) => (
                            <Menu.Item key={item.id}>
                              {({ active }) => (
                                <Link
                                  to="/notifications"
                                  className={classNames(
                                    active ? 'bg-slate-50' : '',
                                    !item.read ? 'bg-orange-50/70' : 'bg-white',
                                    'block border-b border-slate-100 px-4 py-3 last:border-b-0'
                                  )}
                                >
                                  <div className="flex items-start justify-between gap-3">
                                    <p className="text-sm font-black text-slate-950">{item.title || 'Thông báo'}</p>
                                    {item.createdAt && (
                                      <span className="shrink-0 text-xs text-slate-400">
                                        {new Date(item.createdAt).toLocaleString('vi-VN')}
                                      </span>
                                    )}
                                  </div>
                                  {item.message && <p className="mt-1 line-clamp-2 text-sm text-slate-600">{item.message}</p>}
                                  {item.orderId && <p className="mt-2 text-xs font-bold text-orange-600">Mã đơn: {item.orderId}</p>}
                                </Link>
                              )}
                            </Menu.Item>
                          ))
                        )}
                      </div>
                    </Menu.Items>
                  </Transition>
                </Menu>
                <button
                  type="button"
                  onClick={signOut}
                  className="hidden rounded-lg border border-slate-200 bg-white px-4 py-2 text-sm font-bold text-slate-700 hover:border-red-200 hover:bg-red-50 hover:text-red-600 sm:inline-flex"
                >
                  Đăng xuất
                </button>
              </div>
            </div>

            <div className="mt-4 flex gap-2 overflow-x-auto pb-1 lg:hidden">
              {ADMIN_NAV.map((item) => (
                <Link
                  key={item.href}
                  to={item.href}
                  className={[
                    'whitespace-nowrap rounded-full px-4 py-2 text-sm font-bold',
                    isActive(item.href) ? 'bg-orange-500 text-white' : 'bg-slate-100 text-slate-600',
                  ].join(' ')}
                >
                  {item.label}
                </Link>
              ))}
            </div>
          </div>
        </header>

        <main className="px-4 py-6 sm:px-6 lg:px-8">{children}</main>
      </div>
    </div>
  )
}

export default NavbarAdmin
