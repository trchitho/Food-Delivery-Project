import axios from "axios";
import { API_BASE, getAuthToken } from "../utils/foodData";

const fetchRestaurantDetail = async (id) => {
    const token = getAuthToken();

    if (!token) {

        return;
    }

    try {
        const response = await axios.get(`${API_BASE}/restaurant/detail?id=${id}`, {
            headers: { Authorization: `Bearer ${token}` }
        });
        return response;
    } catch {
    }
};
