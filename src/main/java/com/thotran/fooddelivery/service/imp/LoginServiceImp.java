package com.thotran.fooddelivery.service.imp;

import com.thotran.fooddelivery.dto.UserDto;
import com.thotran.fooddelivery.payload.request.SignUpRequest;

import java.util.List;

public interface LoginServiceImp {
    List<UserDto> getAllUser();
    boolean checkLogin(String username, String password);
    boolean addUser(SignUpRequest signUpRequest);

}
