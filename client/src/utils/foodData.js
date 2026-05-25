import { FOOD_IMAGES, RESTAURANT_IMAGES } from '../constants/text'
import { CURATED_CATEGORIES, CURATED_FOOD_IMAGES, CURATED_RESTAURANT_IMAGES, CURATED_RESTAURANTS } from '../data/curatedCatalog'

export const API_BASE = process.env.REACT_APP_API_BASE || 'http://localhost:8080'

const RESTAURANT_FALLBACKS = [
  'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=700&q=80',
  'https://images.unsplash.com/photo-1582878826629-29b7ad1cdc43?w=700&q=80',
  'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=700&q=80',
  'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=700&q=80',
  'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=700&q=80',
  'https://images.unsplash.com/photo-1547592180-85f173990554?w=700&q=80',
  'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=700&q=80',
  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=700&q=80',
]

const FOOD_FALLBACKS = [
  'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=360&q=80',
  'https://images.unsplash.com/photo-1555126634-323283e090fa?w=360&q=80',
  'https://images.unsplash.com/photo-1509722747041-616f39b57569?w=360&q=80',
  'https://images.unsplash.com/photo-1626645738196-c2a7c87a8f58?w=360&q=80',
  'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=360&q=80',
  'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=360&q=80',
  'https://images.unsplash.com/photo-1617196034183-421b4040ed20?w=360&q=80',
  'https://images.unsplash.com/photo-1547592180-85f173990554?w=360&q=80',
]

function stableIndex(value, length) {
  const text = String(value || 'foodhub')
  let hash = 0
  for (let index = 0; index < text.length; index += 1) {
    hash = ((hash << 5) - hash) + text.charCodeAt(index)
    hash |= 0
  }
  return Math.abs(hash) % length
}

function stableSortKey(item) {
  const id = Number(item?.id)
  if (Number.isFinite(id)) return `${String(id).padStart(12, '0')}|${normalizeText(item?.title || item?.name)}`
  return `999999999999|${normalizeText(item?.title || item?.name)}`
}

function sortStableItems(items = []) {
  return [...items].sort((first, second) => stableSortKey(first).localeCompare(stableSortKey(second)))
}

function sameFoodIdentity(first, second) {
  if (!first || !second) return false
  if (String(first.id) === String(second.id)) return true
  const sameTitle = normalizeText(first.title) === normalizeText(second.title)
  if (!sameTitle) return false
  const firstRestaurantKeys = [first.restaurantId, first.restaurantTitle].filter(Boolean).map((value) => normalizeText(value))
  const secondRestaurantKeys = [second.restaurantId, second.restaurantTitle].filter(Boolean).map((value) => normalizeText(value))
  return firstRestaurantKeys.some((key) => secondRestaurantKeys.includes(key))
}

function uniqueFoods(foods = []) {
  return foods.reduce((result, food) => {
    const index = result.findIndex((item) => sameFoodIdentity(item, food))
    if (index >= 0) {
      result[index] = { ...result[index], ...food }
      return result
    }
    return [...result, food]
  }, [])
}

export function getRestaurantImage(restaurant, index = 0) {
  if (restaurant?.image && restaurant.image.startsWith('/')) return restaurant.image
  if (restaurant?.title && CURATED_RESTAURANT_IMAGES[restaurant.title]) return CURATED_RESTAURANT_IMAGES[restaurant.title]
  if (restaurant?.title && RESTAURANT_IMAGES[restaurant.title]) return RESTAURANT_IMAGES[restaurant.title]
  if (restaurant?.image && /^https?:\/\//.test(restaurant.image)) return restaurant.image
  if (restaurant?.image) return `${API_BASE}/restaurant/file/${restaurant.image}`
  return RESTAURANT_FALLBACKS[stableIndex(restaurant?.id || restaurant?.title || index, RESTAURANT_FALLBACKS.length)]
}

export function getFoodImage(food, index = 0) {
  if (food?.image && food.image.startsWith('/')) return food.image
  if (food?.image && /^https?:\/\//.test(food.image)) return food.image
  if (food?.title && CURATED_FOOD_IMAGES[food.title]) return CURATED_FOOD_IMAGES[food.title]
  if (food?.title && FOOD_IMAGES[food.title]) return FOOD_IMAGES[food.title]
  if (food?.image) return `${API_BASE}/menu/file/${food.image}`
  return FOOD_FALLBACKS[stableIndex(food?.id || food?.title || index, FOOD_FALLBACKS.length)]
}

export function getAdminRestaurantsFallback() {
  try {
    return JSON.parse(localStorage.getItem('adminRestaurants') || 'null')
  } catch {
    return null
  }
}

export function getAdminFoodsFallback() {
  try {
    return JSON.parse(localStorage.getItem('adminFoods') || 'null')
  } catch {
    return null
  }
}

export function getAdminCategoriesFallback() {
  try {
    return JSON.parse(localStorage.getItem('adminCategories') || 'null')
  } catch {
    return null
  }
}

export function sanitizeCategoryMenus(categories = []) {
  return sortStableItems(categories).map((category) => {
    const name = category.name || category.title
    const menus = (category.menus || []).filter((food) => {
      if (name === 'Bún - Phở' && normalizeText(food.title).includes('chao')) return false
      return true
    })
    return { ...category, name, title: category.title || name, menus: sortStableItems(menus) }
  })
}

export function mergeAdminFoodsIntoCategories(categories = []) {
  const adminFoods = getAdminFoodsFallback()
  if (!adminFoods || adminFoods.length === 0) return sanitizeCategoryMenus(categories)
  const normalizedCategories = sanitizeCategoryMenus(categories)
  const byName = new Map(normalizedCategories.map((category) => [category.name || category.title, { ...category, menus: [...(category.menus || [])] }]))
  adminFoods.forEach((food) => {
    const categoryName = food.categoryName || normalizedCategories.find((category) => String(category.id) === String(food.categoryId))?.name || 'Khác'
    byName.forEach((category) => {
      category.menus = category.menus.filter((item) => !sameFoodIdentity(item, food))
    })
    if ((food.status || 'Có sẵn') === 'Ẩn') return
    if (!byName.has(categoryName)) {
      byName.set(categoryName, { id: `admin-${categoryName}`, name: categoryName, title: categoryName, menus: [] })
    }
    const category = byName.get(categoryName)
    category.menus = uniqueFoods([{ ...food, categoryName }, ...category.menus])
  })
  return sanitizeCategoryMenus(Array.from(byName.values()))
}

function mergeAdminFoodsIntoRestaurantDetail(restaurant, categories) {
  const adminFoods = getAdminFoodsFallback() || []
  const nextCategories = categories.map((category) => ({
    ...category,
    menus: [...(category.menus || [])],
  }))

  adminFoods.forEach((food) => {
    nextCategories.forEach((category) => {
      category.menus = category.menus.filter((item) => !sameFoodIdentity(item, food))
    })

    if ((food.status || 'Có sẵn') === 'Ẩn') return

    const belongsToRestaurant = String(food.restaurantId) === String(restaurant.id)
      || food.restaurantTitle === restaurant.title
    if (!belongsToRestaurant) return

    const categoryName = food.categoryName
      || nextCategories.find((category) => String(category.id) === String(food.categoryId))?.name
      || restaurant.categoryNames?.[0]
      || 'Khác'

    let category = nextCategories.find((item) => item.name === categoryName || item.title === categoryName || String(item.id) === String(food.categoryId))
    if (!category) {
      category = { id: `admin-${restaurant.id}-${categoryName}`, name: categoryName, title: categoryName, menus: [] }
      nextCategories.push(category)
    }

    category.menus = uniqueFoods([{
      ...food,
      categoryName,
      restaurantId: restaurant.id,
      restaurantTitle: restaurant.title,
    }, ...category.menus])
  })

  return sanitizeCategoryMenus(nextCategories.map((category) => ({
    ...category,
    menus: uniqueFoods(category.menus || []),
  })))
}

export function getCatalogCategories() {
  return sanitizeCategoryMenus(CURATED_CATEGORIES.map((category) => ({
    ...category,
    menus: (category.menus || []).map((food) => ({ ...food })),
  })))
}

export function getCatalogRestaurants() {
  return sortStableItems(CURATED_RESTAURANTS.map((restaurant) => ({ ...restaurant })))
}

export function getCatalogRestaurantDetail(value) {
  const key = String(value || '')
  const restaurant = CURATED_RESTAURANTS.find((item) => String(item.id) === key || item.title === value)
  if (!restaurant) return null
  const categories = getCatalogCategories()
    .filter((category) => (restaurant.categoryNames || []).includes(category.name))
    .map((category) => ({
      ...category,
      menus: category.menus.filter((food) => String(food.restaurantId) === String(restaurant.id)),
    }))
  return { ...restaurant, categories: mergeAdminFoodsIntoRestaurantDetail(restaurant, categories) }
}

export function mergeCatalogCategories(categories = []) {
  return mergeAdminFoodsIntoCategories(getCatalogCategories())
}

export function mergeAdminRestaurants(restaurants = []) {
  const adminRestaurants = getAdminRestaurantsFallback()
  const map = new Map(getCatalogRestaurants().map((restaurant) => [String(restaurant.id), restaurant]))
  ;(adminRestaurants || []).forEach((restaurant) => {
    if ((restaurant.status || 'Đang hoạt động') === 'Ẩn') return
    const key = String(restaurant.id)
    map.set(key, { ...(map.get(key) || {}), ...restaurant })
  })
  return sortStableItems(Array.from(map.values()))
}

export function formatPrice(price) {
  if (!price) return 'Liên hệ'
  return new Intl.NumberFormat('vi-VN', {
    style: 'currency',
    currency: 'VND',
    maximumFractionDigits: 0,
  }).format(price)
}

export function isLoggedIn() {
  return Boolean(getAuthToken())
}

export function getAuthToken() {
  return sessionStorage.getItem('token')
}

export function getCurrentUser() {
  try {
    const storedUser = JSON.parse(sessionStorage.getItem('currentUser') || 'null')
    if (storedUser) return storedUser
    const token = getAuthToken()
    if (!token) return null
    const payload = JSON.parse(atob(token.split('.')[1] || ''))
    const username = payload.sub || payload.username || 'user'
    return {
      username,
      displayName: username.includes('@') ? username.split('@')[0] : username,
    }
  } catch {
    return null
  }
}

export function setCurrentUser(user) {
  sessionStorage.setItem('currentUser', JSON.stringify(user))
  localStorage.removeItem('token')
  localStorage.removeItem('currentUser')
}

export function clearCurrentUser() {
  sessionStorage.removeItem('token')
  sessionStorage.removeItem('currentUser')
}

export function getAccountKey(suffix) {
  const user = getCurrentUser()
  if (!user?.username) return null
  return `${suffix}:${user.username}`
}

export function getFavorites() {
  const key = getAccountKey('favorites')
  if (!key) return []
  try {
    return JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    return []
  }
}

export function logActivity(action, detail = {}) {
  const user = getCurrentUser()
  const logs = JSON.parse(localStorage.getItem('activityLog') || '[]')
  const next = [
    {
      id: `${Date.now()}-${Math.random().toString(16).slice(2)}`,
      user: user?.username || 'guest',
      displayName: user?.displayName || user?.username || 'Khách',
      action,
      detail,
      createdAt: new Date().toISOString(),
    },
    ...logs,
  ].slice(0, 200)
  localStorage.setItem('activityLog', JSON.stringify(next))
  return next
}

export function getActivityLog() {
  try {
    return JSON.parse(localStorage.getItem('activityLog') || '[]')
  } catch {
    return []
  }
}

export function toggleFavorite(restaurant) {
  const key = getAccountKey('favorites')
  if (!key) return null
  const favorites = getFavorites()
  const exists = favorites.some((item) => item.id === restaurant.id)
  const next = exists
    ? favorites.filter((item) => item.id !== restaurant.id)
    : [...favorites, restaurant]
  localStorage.setItem(key, JSON.stringify(next))
  logActivity(exists ? 'Bỏ yêu thích' : 'Thêm yêu thích', { restaurant: restaurant.title })
  return next
}

export function getOrders() {
  const key = getAccountKey('orders')
  if (!key) return []
  try {
    return JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    return []
  }
}

export function saveOrders(orders) {
  const key = getAccountKey('orders')
  if (!key) return null
  localStorage.setItem(key, JSON.stringify(orders))
  return orders
}

export function addOrder(food, restaurant) {
  const key = getAccountKey('orders')
  if (!key) return null
  const orders = getOrders()
  const existingIndex = orders.findIndex((order) => order.food.id === food.id)
  if (existingIndex >= 0) {
    const next = orders.map((order, index) => index === existingIndex
      ? { ...order, quantity: (order.quantity || 1) + 1 }
      : order)
    localStorage.setItem(key, JSON.stringify(next))
    return next
  }
  const next = [
    {
      id: `${Date.now()}-${food.id}`,
      food,
      restaurant,
      quantity: 1,
      createdAt: new Date().toISOString(),
    },
    ...orders,
  ]
  localStorage.setItem(key, JSON.stringify(next))
  logActivity('Thêm vào giỏ hàng', { food: food.title, restaurant: restaurant?.title })
  return next
}

export function getProfile() {
  const key = getAccountKey('profile')
  const user = getCurrentUser()
  if (!key || !user) return null
  try {
    return JSON.parse(localStorage.getItem(key) || 'null') || {
      fullname: user.displayName || user.username,
      email: user.username,
      phone: '',
      address: '',
    }
  } catch {
    return null
  }
}

export function saveProfile(profile) {
  const key = getAccountKey('profile')
  if (!key) return null
  localStorage.setItem(key, JSON.stringify(profile))
  logActivity('Cập nhật hồ sơ', { phone: profile.phone, address: profile.address })
  return profile
}

export function getMessages() {
  const key = getAccountKey('messages')
  if (!key) return []
  try {
    return JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    return []
  }
}

export function saveMessages(messages) {
  const key = getAccountKey('messages')
  if (!key) return null
  const user = getCurrentUser()
  const latestUserMessage = messages
    .flatMap((thread) => (thread.messages || []).map((message) => ({ ...message, thread: thread.name })))
    .filter((message) => message.from === 'me')
    .sort((first, second) => new Date(second.time || 0) - new Date(first.time || 0))[0]
  localStorage.setItem(key, JSON.stringify(messages))
  window.dispatchEvent(new Event('foodhub-storage-sync'))
  if (latestUserMessage) {
    addNotificationForAccount('admin', {
      title: 'Tin nhắn hỗ trợ mới',
      message: `${user?.displayName || user?.username || 'User'} vừa nhắn: ${latestUserMessage.text}`,
      type: 'message',
      account: user?.username,
    })
  }
  logActivity('Nhắn tin hỗ trợ')
  return messages
}

export function getPlacedOrders() {
  const key = getAccountKey('placedOrders')
  if (!key) return []
  try {
    return JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    return []
  }
}

export function savePlacedOrders(orders) {
  const key = getAccountKey('placedOrders')
  if (!key) return null
  const user = getCurrentUser()
  const previousOrders = getPlacedOrders()
  const previousIds = new Set(previousOrders.map((order) => order.id))
  const newOrder = orders.find((order) => !previousIds.has(order.id))
  localStorage.setItem(key, JSON.stringify(orders))
  window.dispatchEvent(new Event('foodhub-storage-sync'))
  if (newOrder) {
    addNotificationForAccount('admin', {
      title: 'Đơn hàng mới',
      message: `${user?.displayName || user?.username || 'User'} vừa đặt đơn ${newOrder.id} trị giá ${formatPrice(newOrder.total)}.`,
      type: 'order',
      orderId: newOrder.id,
      account: user?.username,
    })
    addNotificationForAccount(user?.username, {
      title: 'Đặt hàng thành công',
      message: `Đơn ${newOrder.id} đã được ghi nhận và đang chờ xác nhận.`,
      type: 'order',
      orderId: newOrder.id,
    })
    logActivity('Đặt hàng', { orderId: newOrder.id, total: newOrder.total })
  }
  return orders
}

export function getNotifications() {
  const key = getAccountKey('notifications')
  if (!key) return []
  try {
    return JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    return []
  }
}

export function saveNotifications(notifications) {
  const key = getAccountKey('notifications')
  if (!key) return []
  localStorage.setItem(key, JSON.stringify(notifications))
  window.dispatchEvent(new Event('foodhub-storage-sync'))
  return notifications
}

export function addNotificationForAccount(account, notification) {
  if (!account) return []
  const key = `notifications:${account}`
  let notifications = []
  try {
    notifications = JSON.parse(localStorage.getItem(key) || '[]')
  } catch {
    notifications = []
  }
  const next = [
    {
      id: `${Date.now()}-${Math.random().toString(16).slice(2)}`,
      read: false,
      createdAt: new Date().toISOString(),
      ...notification,
    },
    ...notifications,
  ].slice(0, 100)
  localStorage.setItem(key, JSON.stringify(next))
  window.dispatchEvent(new Event('foodhub-storage-sync'))
  return next
}

export function getKnownAccounts() {
  const accounts = new Set()
  try {
    const adminUsers = JSON.parse(localStorage.getItem('adminUsers') || '[]')
    adminUsers.forEach((user) => user?.userName && accounts.add(user.userName))
  } catch {
    // Ignore invalid admin user cache.
  }
  for (let index = 0; index < localStorage.length; index += 1) {
    const key = localStorage.key(index)
    if (!key) continue
    ;['placedOrders:', 'messages:', 'profile:', 'orders:', 'favorites:'].forEach((prefix) => {
      if (key.startsWith(prefix)) accounts.add(key.replace(prefix, ''))
    })
  }
  return Array.from(accounts)
}

export function broadcastNotification(notification) {
  getKnownAccounts().forEach((account) => addNotificationForAccount(account, notification))
}

export function normalizeText(value) {
  return String(value || '')
    .toLowerCase()
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
}
