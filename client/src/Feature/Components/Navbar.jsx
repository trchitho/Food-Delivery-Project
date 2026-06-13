import { Fragment, useEffect, useState } from 'react'
import { Disclosure, Menu, Transition } from '@headlessui/react'
import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/react/24/outline'
import { useNavigate, Link } from 'react-router-dom'
import logo from '../../images/logo.png'
import { TEXT } from '../../constants/text'
import { clearCurrentUser, getCurrentUser, getNotifications, isLoggedIn as hasSession } from '../../utils/foodData'

const NAV_ITEMS = [
  { key: 'nav_favourites', href: '/favorites' },
  { key: 'nav_orders', href: '/orders' },
  { key: 'nav_messages', href: '/messages' },
]

function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

function Navbar() {
  const navigate = useNavigate()
  const isLoggedIn = hasSession()
  const currentUser = getCurrentUser()
  const accountName = currentUser?.displayName || currentUser?.username || 'Tài khoản'
  const accountInitial = accountName.charAt(0).toUpperCase()
  const [notifications, setNotifications] = useState([])
  const unreadNotifications = notifications.filter((item) => !item.read).length
  const recentNotifications = notifications.slice(0, 4)

  useEffect(() => {
    const syncNotifications = () => {
      setNotifications(getNotifications())
    }
    syncNotifications()
    const timer = setInterval(syncNotifications, 1200)
    window.addEventListener('storage', syncNotifications)
    window.addEventListener('foodhub-storage-sync', syncNotifications)
    return () => {
      clearInterval(timer)
      window.removeEventListener('storage', syncNotifications)
      window.removeEventListener('foodhub-storage-sync', syncNotifications)
    }
  }, [])

  const handleSignOut = () => {
    clearCurrentUser()
    navigate('/login')
  }

  return (
    <Disclosure as="nav" className="bg-gray-900 shadow-lg">
      {({ open }) => (
        <>
          <div className="mx-auto w-full max-w-7xl px-3 sm:px-6 lg:px-8">
            <div className="flex h-16 min-w-0 items-center gap-2">
              {/* Mobile button */}
              <div className="flex shrink-0 items-center sm:hidden">
                <Disclosure.Button aria-label={open ? 'Đóng menu' : 'Mở menu'} className="inline-flex h-11 w-11 items-center justify-center rounded-lg text-gray-300 hover:bg-gray-700 hover:text-white focus-visible:ring-2 focus-visible:ring-orange-400">
                  {open
                    ? <XMarkIcon className="block h-6 w-6" aria-hidden="true" />
                    : <Bars3Icon className="block h-6 w-6" aria-hidden="true" />}
                </Disclosure.Button>
              </div>

              {/* Logo + Nav links */}
              <div className="flex min-w-0 flex-1 items-center sm:items-stretch">
                <Link to="/" className="flex min-w-0 flex-shrink items-center gap-2">
                  <img className="h-8 w-auto" src={logo} alt="FoodHub" />
                  <span className="truncate text-base font-bold text-white min-[360px]:inline sm:text-lg">FoodHub</span>
                </Link>
                <div className="hidden sm:ml-8 sm:flex sm:items-center sm:space-x-1">
                  {NAV_ITEMS.map((item) => (
                    <Link
                      key={item.key}
                      to={item.href}
                      className="text-gray-300 hover:bg-gray-700 hover:text-white rounded-lg px-3 py-2 text-sm font-medium transition-colors"
                    >
                      {TEXT[item.key]}
                    </Link>
                  ))}
                </div>
              </div>

              {/* Right side */}
              <div className="flex shrink-0 items-center gap-1.5 sm:gap-2">
                <Menu as="div" className="relative">
                  <Menu.Button aria-label="Mở thông báo" className="relative grid h-11 w-11 place-items-center rounded-full bg-gray-800 text-gray-300 transition-colors hover:bg-gray-700 hover:text-white focus-visible:ring-2 focus-visible:ring-orange-400">
                    <BellIcon className="h-5 w-5" />
                    {unreadNotifications > 0 && (
                      <span className="absolute -right-1 -top-1 grid h-5 min-w-5 place-items-center rounded-full bg-red-500 px-1 text-[11px] font-bold text-white">
                        {unreadNotifications > 9 ? '9+' : unreadNotifications}
                      </span>
                    )}
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
                    <Menu.Items className="absolute right-0 z-30 mt-3 w-80 origin-top-right overflow-hidden rounded-2xl bg-white shadow-xl ring-1 ring-black/5 focus:outline-none sm:w-96">
                      <div className="flex items-center justify-between border-b border-gray-100 px-4 py-3">
                        <p className="text-sm font-black text-gray-950">Thông báo</p>
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
                        {!isLoggedIn ? (
                          <div className="px-4 py-5 text-sm text-gray-500">
                            Đăng nhập để xem thông báo của bạn.
                          </div>
                        ) : recentNotifications.length === 0 ? (
                          <div className="px-4 py-5 text-sm text-gray-500">
                            Chưa có thông báo mới.
                          </div>
                        ) : (
                          recentNotifications.map((item) => (
                            <Menu.Item key={item.id}>
                              {({ active }) => (
                                <Link
                                  to="/notifications"
                                  className={classNames(
                                    active ? 'bg-gray-50' : '',
                                    !item.read ? 'bg-orange-50/70' : 'bg-white',
                                    'block border-b border-gray-100 px-4 py-3 last:border-b-0'
                                  )}
                                >
                                  <div className="flex items-start justify-between gap-3">
                                    <p className="text-sm font-black text-gray-950">{item.title || 'Thông báo'}</p>
                                    {item.createdAt && (
                                      <span className="shrink-0 text-xs text-gray-400">
                                        {new Date(item.createdAt).toLocaleString('vi-VN')}
                                      </span>
                                    )}
                                  </div>
                                  {item.message && <p className="mt-1 line-clamp-2 text-sm text-gray-600">{item.message}</p>}
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

                {isLoggedIn ? (
                  <Menu as="div" className="relative">
                    <Menu.Button className="flex items-center gap-2 rounded-full bg-orange-500 px-3 py-2 text-sm font-semibold text-white focus:outline-none focus:ring-2 focus:ring-orange-400 focus:ring-offset-2 focus:ring-offset-gray-900">
                      <span className="inline-flex h-6 w-6 items-center justify-center rounded-full bg-white/20">{accountInitial}</span>
                      <span className="hidden sm:inline">{accountName}</span>
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
                      <Menu.Items className="absolute right-0 z-20 mt-2 w-48 origin-top-right rounded-xl bg-white py-1 shadow-xl ring-1 ring-black ring-opacity-5 focus:outline-none">
                        <Menu.Item>
                          {({ active }) => (
                            <Link to="/profile" className={classNames(active ? 'bg-gray-50' : '', 'flex items-center gap-2 w-full px-4 py-2 text-sm text-gray-700')}>
                              {TEXT.nav_profile}
                            </Link>
                          )}
                        </Menu.Item>
                        <Menu.Item>
                          {({ active }) => (
                            <Link to="/settings" className={classNames(active ? 'bg-gray-50' : '', 'flex items-center gap-2 w-full px-4 py-2 text-sm text-gray-700')}>
                              {TEXT.nav_settings}
                            </Link>
                          )}
                        </Menu.Item>
                        <div className="border-t border-gray-100 my-1" />
                        <Menu.Item>
                          {({ active }) => (
                            <button
                              onClick={handleSignOut}
                              className={classNames(active ? 'bg-red-50' : '', 'flex items-center gap-2 w-full px-4 py-2 text-sm text-red-600')}
                            >
                              {TEXT.nav_logout}
                            </button>
                          )}
                        </Menu.Item>
                      </Menu.Items>
                    </Transition>
                  </Menu>
                ) : (
                  <Link
                    to="/login"
                    className="bg-orange-500 hover:bg-orange-600 text-white text-sm font-semibold px-4 py-2 rounded-lg transition-colors"
                  >
                    {TEXT.nav_login}
                  </Link>
                )}
              </div>
            </div>
          </div>

          {/* Mobile menu */}
          <Disclosure.Panel className="sm:hidden border-t border-gray-700">
            <div className="space-y-1 px-3 pb-3 pt-2">
              {NAV_ITEMS.map((item) => (
                <Disclosure.Button
                  key={item.key}
                  as="a"
                  href={item.href}
                  className="block rounded-lg px-3 py-2 text-base font-medium text-gray-300 hover:bg-gray-700 hover:text-white"
                >
                  {TEXT[item.key]}
                </Disclosure.Button>
              ))}
            </div>
          </Disclosure.Panel>
        </>
      )}
    </Disclosure>
  )
}

export default Navbar
