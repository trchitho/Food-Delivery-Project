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
}
