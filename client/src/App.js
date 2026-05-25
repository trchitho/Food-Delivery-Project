import './App.css';
import { Navigate, Route, Routes, BrowserRouter } from 'react-router-dom';
import Homepage from './Feature/Homepage/Homepage'
import LoginPage from './Feature/Login/LoginPage'
import RestaurantDetailPage from './Feature/Restaurants/RestaurantDetailPage';
import AdminPage from './Feature/AdminPage/AdminPage';
import ManageUsersPage from './Feature/AdminPage/Users/ManageUsersPage';
import CreateUserPage from './Feature/AdminPage/Users/CreateUserPage';
import {
  AdminCategoriesPage,
  AdminFoodsPage,
  AdminMessagesPage,
  AdminRestaurantsPage,
  AdminSalesReportPage,
  AdminSettingsPage,
  AdminShippingPage,
} from './Feature/AdminPage/AdminResourcePages';
import SignupPage from './Feature/Login/Signup';
import ExplorePage from './Feature/Pages/ExplorePage';
import FavoritesPage from './Feature/Pages/FavoritesPage';
import OrdersPage from './Feature/Pages/OrdersPage';
import MessagesPage from './Feature/Pages/MessagesPage';
import NotificationsPage from './Feature/Pages/NotificationsPage';
import ForgotPasswordPage from './Feature/Login/ForgotPasswordPage';
import ProfilePage from './Feature/Pages/ProfilePage';
import SettingsPage from './Feature/Pages/SettingsPage';
import FoodDetailPage from './Feature/Pages/FoodDetailPage';

export default function App() {
  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Homepage />}></Route>
        <Route path="/login" element={<LoginPage />}></Route>
        <Route path="/signup" element={<SignupPage />} ></Route>
        <Route path="/forgot-password" element={<ForgotPasswordPage />} ></Route>
        <Route path="/explore" element={<ExplorePage />} ></Route>
        <Route path="/favorites" element={<FavoritesPage />} ></Route>
        <Route path="/orders" element={<OrdersPage />} ></Route>
        <Route path="/messages" element={<MessagesPage />} ></Route>
        <Route path="/notifications" element={<NotificationsPage />} ></Route>
        <Route path="/profile" element={<ProfilePage />} ></Route>
        <Route path="/settings" element={<SettingsPage />} ></Route>
        <Route path="/restaurant/detail/:id" element={<RestaurantDetailPage />}></Route>
        <Route path="/food/detail/:id" element={<FoodDetailPage />}></Route>
        <Route path="/admin" element={<AdminPage />} ></Route>
        <Route path="/admin/users" element={<ManageUsersPage />} ></Route>
        <Route path="/admin/users/create" element={<CreateUserPage />} ></Route>
        <Route path="/admin/categories" element={<AdminCategoriesPage />} ></Route>
        <Route path="/admin/restaurants" element={<AdminRestaurantsPage />} ></Route>
        <Route path="/admin/foods" element={<AdminFoodsPage />} ></Route>
        <Route path="/admin/customers" element={<Navigate to="/admin/users" replace />} ></Route>
        <Route path="/admin/shipping" element={<AdminShippingPage />} ></Route>
        <Route path="/admin/orders" element={<Navigate to="/admin/shipping" replace />} ></Route>
        <Route path="/admin/messages" element={<AdminMessagesPage />} ></Route>
        <Route path="/admin/salesreport" element={<AdminSalesReportPage />} ></Route>
        <Route path="/admin/setting" element={<AdminSettingsPage />} ></Route>
        <Route path="/admin/settings" element={<AdminSettingsPage />} ></Route>
      </Routes>
    </BrowserRouter>
  )
}
