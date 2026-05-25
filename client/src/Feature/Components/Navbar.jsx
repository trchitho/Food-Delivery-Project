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
  const [unreadNotifications, setUnreadNotifications] = useState(0)

  useEffect(() => {
    const syncNotifications = () => {
      setUnreadNotifications(getNotifications().filter((item) => !item.read).length)
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
          <div className="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
            <div className="relative flex h-16 items-center justify-between">
              {/* Mobile button */}
              <div className="absolute inset-y-0 left-0 flex items-center sm:hidden">
                <Disclosure.Button className="inline-flex items-center justify-center rounded-md p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none">
                  {open
                    ? <XMarkIcon className="block h-6 w-6" aria-hidden="true" />
                    : <Bars3Icon className="block h-6 w-6" aria-hidden="true" />}
                </Disclosure.Button>
              </div>

              {/* Logo + Nav links */}
              <div className="flex flex-1 items-center justify-center sm:items-stretch sm:justify-start">
                <Link to="/" className="flex flex-shrink-0 items-center gap-2">
                  <img className="h-8 w-auto" src={logo} alt="FoodHub" />
                  <span className="text-white font-bold text-lg hidden sm:block">FoodHub</span>
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
              <div className="flex items-center gap-2">
                <Link to="/notifications" className="relative rounded-full bg-gray-800 p-2 text-gray-400 hover:text-white hover:bg-gray-700 transition-colors">
                  <BellIcon className="h-5 w-5" />
                  {unreadNotifications > 0 && (
                    <span className="absolute -right-1 -top-1 grid h-5 min-w-5 place-items-center rounded-full bg-red-500 px-1 text-[11px] font-bold text-white">
                      {unreadNotifications > 9 ? '9+' : unreadNotifications}
                    </span>
                  )}
                </Link>

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
