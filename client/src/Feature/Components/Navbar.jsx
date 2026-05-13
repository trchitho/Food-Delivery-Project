import { Fragment } from 'react'
import { Disclosure, Menu, Transition } from '@headlessui/react'
import { Bars3Icon, BellIcon, XMarkIcon } from '@heroicons/react/24/outline'
import { useNavigate, Link } from 'react-router-dom'
import logo from '../../images/logo.png'
import { TEXT } from '../../constants/text'

const NAV_ITEMS = [
  { key: 'nav_explore', href: '/' },
  { key: 'nav_favourites', href: '#' },
  { key: 'nav_orders', href: '#' },
  { key: 'nav_messages', href: '#' },
]

function classNames(...classes) {
  return classes.filter(Boolean).join(' ')
}

function Navbar() {
  const navigate = useNavigate()
  const isLoggedIn = !!localStorage.getItem('token')

  const handleSignOut = () => {
    localStorage.removeItem('token')
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
                <button className="rounded-full bg-gray-800 p-2 text-gray-400 hover:text-white hover:bg-gray-700 transition-colors">
                  <BellIcon className="h-5 w-5" />
                </button>

                {isLoggedIn ? (
                  <Menu as="div" className="relative">
                    <Menu.Button className="flex rounded-full focus:outline-none focus:ring-2 focus:ring-orange-400 focus:ring-offset-2 focus:ring-offset-gray-900">
                      <img
                        className="h-8 w-8 rounded-full object-cover"
                        src="https://ui-avatars.com/api/?name=User&background=f97316&color=fff&size=64"
                        alt="avatar"
                      />
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
                            <a href="#" className={classNames(active ? 'bg-gray-50' : '', 'flex items-center gap-2 px-4 py-2 text-sm text-gray-700')}>
                              {TEXT.nav_profile}
                            </a>
                          )}
                        </Menu.Item>
                        <Menu.Item>
                          {({ active }) => (
                            <a href="#" className={classNames(active ? 'bg-gray-50' : '', 'flex items-center gap-2 px-4 py-2 text-sm text-gray-700')}>
                              {TEXT.nav_settings}
                            </a>
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
