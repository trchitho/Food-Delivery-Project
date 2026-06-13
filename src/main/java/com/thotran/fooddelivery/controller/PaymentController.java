package com.thotran.fooddelivery.controller;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@RestController
@RequestMapping("/payments")
public class PaymentController {
    @Value("${VNPAY_TMN_CODE:}") private String vnpayCode;
    @Value("${VNPAY_HASH_SECRET:}") private String vnpaySecret;
    @Value("${ZALOPAY_APP_ID:}") private String zaloAppId;
    @Value("${ZALOPAY_KEY1:}") private String zaloKey;

    @PostMapping("/create")
    public ResponseEntity<?> create(@RequestBody PaymentRequest request) {
        if (request.amount() <= 0) return ResponseEntity.badRequest()
                .body(Map.of("message", "Số tiền thanh toán không hợp lệ."));
        boolean configured = "vnpay".equals(request.method())
                ? !vnpayCode.isBlank() && !vnpaySecret.isBlank()
                : "zalopay".equals(request.method()) && !zaloAppId.isBlank() && !zaloKey.isBlank();
        if (!configured) return ResponseEntity.status(503)
                .body(Map.of("message", "Cổng thanh toán chưa được cấu hình trên server."));
        return ResponseEntity.status(501)
                .body(Map.of("message", "Cổng sandbox đã có cấu hình nhưng chưa bật giao dịch."));
    }
    public record PaymentRequest(String method, long amount, String orderId) {}
}
