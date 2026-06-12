package com.thotran.fooddelivery.service.imp;

import com.thotran.fooddelivery.dto.UserDto;
import com.thotran.fooddelivery.entity.Users;
import com.thotran.fooddelivery.payload.request.SignUpRequest;

import java.util.List;

public interface LoginServiceImp {
    List<UserDto> getAllUser();
    Users authenticate(String username, String password);
    boolean addUser(SignUpRequest signUpRequest);

}
