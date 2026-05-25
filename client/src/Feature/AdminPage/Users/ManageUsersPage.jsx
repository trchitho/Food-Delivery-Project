import axios from 'axios'
import React, { useEffect, useMemo, useState } from 'react'
import NavbarAdmin from '../NavbarAdmin'
import { API_BASE, getAuthToken } from '../../../utils/foodData'

const ROLES = ['ADMIN', 'USER', 'SALESPERSON', 'SHIPPER']

function readUsers(fallback = []) {
  try {
    const cached = JSON.parse(localStorage.getItem('adminUsers') || 'null') || fallback
    const hasAdminSystem = cached.some((user) => user.userName === 'admin' || user.fullname === 'Admin System')
    const normalized = cached.map((user) => ROLES.includes(user.role) ? user : { ...user, role: 'USER' })
    return hasAdminSystem ? normalized : [{ id: 1, userName: 'admin', fullname: 'Admin System', role: 'ADMIN', status: 'Hoạt động', createDate: new Date().toISOString() }, ...normalized]
  } catch {
    return fallback
  }
}

function saveUsers(users) {
  localStorage.setItem('adminUsers', JSON.stringify(users))
}

function UserModal({ form, setForm, onClose, onSubmit }) {
  return (
    <div className="fixed inset-0 z-50 grid place-items-center bg-slate-950/50 px-4">
      <form onSubmit={onSubmit} className="w-full max-w-2xl rounded-xl bg-white p-6 shadow-2xl">
        <div className="mb-5 flex items-center justify-between">
          <h3 className="text-xl font-black text-slate-950">{form.id ? 'Sửa người dùng' : 'Tạo người dùng'}</h3>
          <button type="button" onClick={onClose} className="rounded-lg border border-slate-200 px-3 py-1 text-sm font-bold">Đóng</button>
        </div>
        <div className="grid grid-cols-1 gap-4 md:grid-cols-2">
          <label>
            <span className="text-sm font-bold text-slate-700">Tài khoản</span>
            <input value={form.userName || ''} onChange={(event) => setForm({ ...form, userName: event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" required />
          </label>
          <label>
            <span className="text-sm font-bold text-slate-700">Họ tên</span>
            <input value={form.fullname || ''} onChange={(event) => setForm({ ...form, fullname: event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400" required />
          </label>
          <label>
            <span className="text-sm font-bold text-slate-700">Vai trò</span>
            <select value={form.role || 'USER'} onChange={(event) => setForm({ ...form, role: event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400">
              {ROLES.map((role) => <option key={role} value={role}>{role}</option>)}
            </select>
          </label>
          <label>
            <span className="text-sm font-bold text-slate-700">Trạng thái</span>
            <select value={form.status || 'Hoạt động'} onChange={(event) => setForm({ ...form, status: event.target.value })} className="mt-2 w-full rounded-lg border border-slate-200 px-4 py-3 outline-none focus:border-orange-400">
              {['Hoạt động', 'Tạm khóa', 'Chờ duyệt'].map((status) => <option key={status} value={status}>{status}</option>)}
            </select>
          </label>
        </div>
        <div className="mt-6 flex justify-end gap-3">
          <button type="button" onClick={onClose} className="rounded-lg border border-slate-200 px-4 py-2 font-bold text-slate-700">Hủy</button>
          <button className="rounded-lg bg-orange-500 px-4 py-2 font-bold text-white hover:bg-orange-600">Lưu</button>
        </div>
      </form>
    </div>
  )
}

function ManageUsersPage() {
  const [users, setUsers] = useState([])
  const [query, setQuery] = useState('')
  const [form, setForm] = useState(null)

  useEffect(() => {
    const token = getAuthToken()
    const headers = token ? { Authorization: `Bearer ${token}` } : {}
    axios.get(`${API_BASE}/user`, { headers })
      .then((response) => {
        const apiUsers = Array.isArray(response.data) ? response.data : []
        setUsers(readUsers(apiUsers))
      })
      .catch(() => setUsers(readUsers([])))
  }, [])

  const filteredUsers = useMemo(() => {
    const keyword = query.trim().toLowerCase()
    if (!keyword) return users
    return users.filter((user) => [user.userName, user.fullname, user.role, user.status].filter(Boolean).some((value) => String(value).toLowerCase().includes(keyword)))
  }, [query, users])

  const roleCounts = users.reduce((result, user) => ({ ...result, [user.role]: (result[user.role] || 0) + 1 }), {})

  const saveForm = (event) => {
    event.preventDefault()
    const next = form.id
      ? users.map((user) => user.id === form.id ? form : user)
      : [{ ...form, id: Math.max(0, ...users.map((user) => Number(user.id) || 0)) + 1, createDate: new Date().toISOString() }, ...users]
    setUsers(next)
    saveUsers(next)
    setForm(null)
  }

  const removeUser = (user) => {
    if (user.role === 'ADMIN' && users.filter((item) => item.role === 'ADMIN').length <= 1) return
    const next = users.filter((item) => item.id !== user.id)
    setUsers(next)
    saveUsers(next)
  }

  const toggleLock = (user) => {
    const next = users.map((item) => item.id === user.id ? { ...item, status: item.status === 'Tạm khóa' ? 'Hoạt động' : 'Tạm khóa' } : item)
    setUsers(next)
    saveUsers(next)
  }

  return (
    <NavbarAdmin
      title="Người dùng"
      subtitle="Admin có toàn quyền thêm, sửa, khóa/mở và xóa tài khoản."
      action={<button onClick={() => setForm({ userName: '', fullname: '', role: 'USER', status: 'Hoạt động' })} className="rounded-lg bg-orange-500 px-4 py-2 text-sm font-black text-white hover:bg-orange-600">Tạo người dùng</button>}
    >
      <div className="mb-6 grid grid-cols-1 gap-4 md:grid-cols-4">
        {[
          ['Tổng tài khoản', users.length],
          ['Admin', roleCounts.ADMIN || 0],
          ['Khách hàng', roleCounts.USER || 0],
          ['Nhân viên', (roleCounts.SALESPERSON || 0) + (roleCounts.SHIPPER || 0)],
        ].map(([label, value]) => <div key={label} className="rounded-xl border border-slate-200 bg-white p-5 shadow-sm"><p className="text-sm font-bold text-slate-500">{label}</p><p className="mt-2 text-3xl font-black text-slate-950">{value}</p></div>)}
      </div>

      <section className="rounded-xl border border-slate-200 bg-white shadow-sm">
        <div className="flex flex-col gap-3 border-b border-slate-100 px-5 py-4 md:flex-row md:items-center md:justify-between">
          <div><h3 className="text-lg font-black text-slate-950">Danh sách tài khoản</h3><p className="text-sm text-slate-500">CRUD đang hoạt động trên lớp dữ liệu admin cục bộ.</p></div>
          <input value={query} onChange={(event) => setQuery(event.target.value)} placeholder="Tìm theo tên, email, vai trò..." className="w-full rounded-lg border border-slate-200 px-4 py-2 text-sm outline-none focus:border-orange-400 md:w-80" />
        </div>
        <div className="overflow-x-auto">
          <table className="min-w-full divide-y divide-slate-100">
            <thead className="bg-slate-50"><tr>{['ID', 'Tài khoản', 'Họ tên', 'Ngày tạo', 'Vai trò', 'Trạng thái', 'Thao tác'].map((header) => <th key={header} className="px-5 py-3 text-left text-xs font-black uppercase tracking-wide text-slate-500">{header}</th>)}</tr></thead>
            <tbody className="divide-y divide-slate-100">
              {filteredUsers.map((user) => (
                <tr key={user.id} className="hover:bg-slate-50">
                  <td className="px-5 py-4 text-sm text-slate-500">{user.id}</td>
                  <td className="px-5 py-4 text-sm font-bold text-slate-950">{user.userName}</td>
                  <td className="px-5 py-4 text-sm text-slate-700">{user.fullname || 'Chưa cập nhật'}</td>
                  <td className="px-5 py-4 text-sm text-slate-500">{user.createDate ? new Date(user.createDate).toLocaleDateString('vi-VN') : 'Chưa có'}</td>
                  <td className="px-5 py-4 text-sm"><span className="rounded-full bg-slate-100 px-3 py-1 text-xs font-black text-slate-700">{user.role}</span></td>
                  <td className="px-5 py-4 text-sm"><span className="rounded-full bg-emerald-50 px-3 py-1 text-xs font-black text-emerald-700">{user.status || 'Hoạt động'}</span></td>
                  <td className="px-5 py-4 text-sm"><div className="flex gap-2"><button onClick={() => setForm(user)} className="rounded-lg bg-slate-100 px-3 py-1 font-bold">Sửa</button><button onClick={() => toggleLock(user)} className="rounded-lg bg-amber-50 px-3 py-1 font-bold text-amber-700">Khóa/Mở</button><button onClick={() => removeUser(user)} className="rounded-lg bg-red-50 px-3 py-1 font-bold text-red-600">Xóa</button></div></td>
                </tr>
              ))}
              {filteredUsers.length === 0 && <tr><td colSpan="7" className="px-5 py-12 text-center text-slate-500">Không tìm thấy người dùng phù hợp.</td></tr>}
            </tbody>
          </table>
        </div>
      </section>
      {form && <UserModal form={form} setForm={setForm} onClose={() => setForm(null)} onSubmit={saveForm} />}
    </NavbarAdmin>
  )
}

export default ManageUsersPage
