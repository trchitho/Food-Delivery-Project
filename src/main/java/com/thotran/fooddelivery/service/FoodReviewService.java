package com.thotran.fooddelivery.service;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class FoodReviewService {
    private final JdbcTemplate jdbc;

    public FoodReviewService(JdbcTemplate jdbc) {
        this.jdbc = jdbc;
    }

    public List<Map<String, Object>> findByFood(int foodId) {
        return jdbc.queryForList("""
            SELECT rf.id, rf.rating_point rating, rf.content comment,
                   COALESCE(u.fullname, u.user_name) userName
            FROM rating_food rf
            JOIN users u ON u.id = rf.user_id
            WHERE rf.food_id = ?
            ORDER BY rf.id DESC
            """, foodId);
    }

    public boolean canReview(String username, int foodId) {
        Integer count = jdbc.queryForObject("""
            SELECT COUNT(*) FROM order_item oi
            JOIN orders o ON o.id = oi.order_id
            JOIN users u ON u.id = o.user_id
            WHERE u.user_name = ? AND oi.food_id = ?
              AND UPPER(o.status) IN ('COMPLETED', 'DELIVERED', 'HOAN_TAT')
            """, Integer.class, username, foodId);
        return count != null && count > 0;
    }

    public Map<String, Object> reviewStatus(String username, int foodId) {
        List<Map<String, Object>> existing = jdbc.queryForList("""
            SELECT id, rating_point rating, content comment
            FROM rating_food
            WHERE user_id = (SELECT id FROM users WHERE user_name = ?)
              AND food_id = ?
            """, username, foodId);
        return Map.of("canReview", canReview(username, foodId),
                "review", existing.isEmpty() ? Map.of() : existing.get(0));
    }
}
