package com.thotran.fooddelivery.controller;

import com.thotran.fooddelivery.dto.AuthResponse;
import com.thotran.fooddelivery.entity.Users;
import com.thotran.fooddelivery.service.imp.LoginServiceImp;
import com.thotran.fooddelivery.payload.ResponseData;
import com.thotran.fooddelivery.payload.request.LoginRequest;
import com.thotran.fooddelivery.payload.request.SignUpRequest;
import com.thotran.fooddelivery.utils.JwtUtilsHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

@RestController
@RequestMapping("/client")
public class LoginController {
    @Autowired
    LoginServiceImp loginServiceImp;

    @Autowired
    JwtUtilsHelper jwtUtilsHelper;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @PostMapping("/login")
    public ResponseEntity<?> signin(@Valid @RequestBody LoginRequest loginRequest){
        ResponseData responseData = new ResponseData();

        Users user = loginServiceImp.authenticate(loginRequest.getUsername().trim(), loginRequest.getPassword());
        if (user != null){
            String token = jwtUtilsHelper.generateToken(user.getUserName());
            responseData.setData(new AuthResponse(
                    token,
                    user.getUserName(),
                    user.getFullname(),
                    user.getRoles().getRoleName()
            ));
        } else {
            responseData.setStatus(HttpStatus.UNAUTHORIZED.value());
            responseData.setSuccessful(false);
            responseData.setDescription("Tên đăng nhập hoặc mật khẩu không đúng.");
            return new ResponseEntity<>(responseData, HttpStatus.UNAUTHORIZED);
        }
        return new ResponseEntity<>(responseData, HttpStatus.OK);
    }

    @PostMapping("/signup")
    public ResponseEntity<?> signup(@Valid @RequestBody SignUpRequest signUpRequest){
        ResponseData responseData = new ResponseData();
        boolean created = loginServiceImp.addUser(signUpRequest);
        responseData.setData(created);
        if (!created) {
            responseData.setStatus(HttpStatus.CONFLICT.value());
            responseData.setSuccessful(false);
            responseData.setDescription("Tài khoản đã tồn tại hoặc dữ liệu không hợp lệ.");
            return new ResponseEntity<>(responseData, HttpStatus.CONFLICT);
        }
        return new ResponseEntity<>(responseData, HttpStatus.CREATED);
    }
}
