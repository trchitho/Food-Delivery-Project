package com.thotran.fooddelivery.service;

import com.thotran.fooddelivery.dto.UserDto;
import com.thotran.fooddelivery.entity.Roles;
import com.thotran.fooddelivery.entity.Users;
import com.thotran.fooddelivery.repository.RoleRepository;
import com.thotran.fooddelivery.repository.UserRepository;
import com.thotran.fooddelivery.service.imp.UserServiceImp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserService implements UserServiceImp {
    @Autowired
    UserRepository userRepository;

    @Override
    public List<UserDto> getAllUser() {
        List<Users> usersList = userRepository.findAll();

        List<UserDto> userDtoList = new ArrayList<>();

        for (Users users : usersList){
            UserDto userDto = new UserDto();
            userDto.setId(users.getId());
            userDto.setUserName(users.getUserName());
            userDto.setFullname(users.getFullname());
            userDto.setRole(users.getRoles().getRoleName());
            userDto.setCreateDate(users.getCreateDate());
            userDtoList.add(userDto);
        }

        return userDtoList;
    }
}
