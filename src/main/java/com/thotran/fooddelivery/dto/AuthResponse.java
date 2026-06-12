package com.thotran.fooddelivery.dto;

public record AuthResponse(
        String token,
        String username,
        String displayName,
        String role
) {
}
