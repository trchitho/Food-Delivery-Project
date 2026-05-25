import axios from 'axios';
import React, { useState } from 'react'
import { useNavigate } from 'react-router-dom';
import { TEXT } from '../../../constants/text';
import { API_BASE, getAuthToken } from '../../../utils/foodData';
import NavbarAdmin from '../NavbarAdmin';

function CreateUserPage() {
    const [formData, setFormData] = useState({
        email: '',
        password: '',
        fullname: '',
        roleId: null
    });

    const navigate = useNavigate();

    const handleInputChange = (e) => {
        const { name, value } = e.target;
        const roleIdValue = name === "roleId" ? parseInt(value, 10) : value;
        setFormData({
            ...formData,
            [name]: roleIdValue,
        });
    }

    const handleSubmit = async (e) => {
        e.preventDefault();

        const token = getAuthToken();

        if (!token) {
            // redirect to login
            return;
        }

        try {
            const response = await axios.post(`${API_BASE}/client/signup`, formData, {
                headers: { Authorization: `Bearer ${token}` }
            });
            if (response.data.successful) {
                navigate('/admin/users', { replace: true });
            }

        } catch (error) {
            console.log(error);
        }
    }

    return (
        <NavbarAdmin title="Tạo người dùng" subtitle="Thêm tài khoản mới cho hệ thống quản trị và khách hàng.">
        <div className="max-w-2xl rounded-xl border border-slate-200 bg-white p-6 shadow-sm">
            <h2 className="text-xl font-black text-slate-950 mb-6">{TEXT.admin_users_title} | {TEXT.admin_create_user}</h2>
            <form onSubmit={handleSubmit}>
                <div className="mb-4">
                    <label className="block text-sm font-medium text-gray-600">{TEXT.admin_email}:</label>
                    <input
                        className="w-full p-2 border border-gray-300 rounded-md"
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleInputChange}
                        required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-sm font-medium text-gray-600">{TEXT.admin_fullname}:</label>
                    <input
                        className="w-full p-2 border border-gray-300 rounded-md"
                        type="text"
                        name="fullname"
                        value={formData.fullname}
                        onChange={handleInputChange}
                        required
                        minLength="8"
                        maxLength="20"
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-sm font-medium text-gray-600">{TEXT.admin_password}:</label>
                    <input
                        className="w-full p-2 border border-gray-300 rounded-md"
                        type="password"
                        name="password"
                        value={formData.password}
                        onChange={handleInputChange}
                        required
                    />
                </div>
                <div className="mb-4">
                    <label className="block text-sm font-medium text-gray-600">{TEXT.admin_roles}:</label>
                    <div className="grid grid-cols-2 gap-4">
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="1"
                                    checked={formData.roleId === 1}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_admin}
                            </label>
                        </div>
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="2"
                                    checked={formData.roleId === 2}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_user}
                            </label>
                        </div>
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="3"
                                    checked={formData.roleId === 3}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_salesperson}
                            </label>
                        </div>
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="4"
                                    checked={formData.roleId === 4}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_editor}
                            </label>
                        </div>
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="5"
                                    checked={formData.roleId === 5}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_shipper}
                            </label>
                        </div>
                        <div>
                            <label className="flex items-center">
                                <input
                                    type="radio"
                                    name="roleId"
                                    value="6"
                                    checked={formData.roleId === 6}
                                    onChange={handleInputChange}
                                    className="mr-2" />
                                {TEXT.role_assistant}
                            </label>
                        </div>
                    </div>
                </div>
                <div className="flex space-x-4">
                    <input
                        type="submit"
                        value={TEXT.admin_save}
                        className="bg-blue-500 text-white px-4 py-2 rounded-md hover:bg-blue-700 cursor-pointer"
                    />
                    <input
                        type="button"
                        value={TEXT.admin_cancel}
                        onClick={() => navigate('/admin/users')}
                        className="bg-gray-300 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-400 cursor-pointer"
                    />
                </div>
            </form>
        </div>
        </NavbarAdmin>
    )
}

export default CreateUserPage
