package com.thotran.fooddelivery.controller;
import com.thotran.fooddelivery.service.FoodReviewService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
@RestController
@RequestMapping("/reviews")
public class FoodReviewController {
    private final FoodReviewService reviews;
    public FoodReviewController(FoodReviewService reviews) { this.reviews = reviews; }
    @GetMapping("/food/{foodId}")
    public Object list(@PathVariable int foodId) { return reviews.findByFood(foodId); }
    @GetMapping("/food/{foodId}/status")
    public Object status(@PathVariable int foodId, Authentication auth) {
        return reviews.reviewStatus(auth.getName(), foodId);
    }
    @PostMapping("/food/{foodId}")
    public ResponseEntity<?> save(@PathVariable int foodId, @RequestBody ReviewRequest body, Authentication auth) {
        try {
            reviews.save(auth.getName(), foodId, body.rating(), body.comment());
            return ResponseEntity.ok(Map.of("message", "Đã lưu đánh giá."));
        } catch (IllegalArgumentException | IllegalStateException error) {
            return ResponseEntity.badRequest().body(Map.of("message", error.getMessage()));
        }
    }
    public record ReviewRequest(int rating, String comment) {}
}
