package com.thotran.fooddelivery.service;

import com.thotran.fooddelivery.dto.UserDto;
import com.thotran.fooddelivery.entity.Roles;
import com.thotran.fooddelivery.entity.Users;
import com.thotran.fooddelivery.service.imp.LoginServiceImp;
import com.thotran.fooddelivery.payload.request.SignUpRequest;
import com.thotran.fooddelivery.repository.UserRepository;
import com.thotran.fooddelivery.repository.RoleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class LoginService implements LoginServiceImp {
    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    RoleRepository roleRepository;

    @Override
    public List<UserDto> getAllUser(){
        List<Users> listUser = userRepository.findAll();
        List<UserDto> userDtoList = new ArrayList<>();

        for (Users users: listUser){

            UserDto userDto = new UserDto();
            userDto.setId(users.getId());
            userDto.setUserName(users.getUserName());
            userDto.setFullname(users.getFullname());
            userDto.setPassword(users.getPassword());

            userDtoList.add(userDto);
        }
        return userDtoList;
    }

    @Override
    public Users authenticate(String username, String password) {
        Users users = userRepository.findByUserName(username);
        if (users == null || !passwordEncoder.matches(password, users.getPassword())) {
            return null;
        }
        return users;
    }

    @Override
    public boolean addUser(SignUpRequest signUpRequest) {
        String username = signUpRequest.getEmail().trim().toLowerCase();
        if (userRepository.existsByUserName(username)) {
            return false;
        }
        Roles roles = roleRepository.findByRoleName("USER");
        if (roles == null) {
            return false;
        }

        Users users = new Users();
        users.setFullname(signUpRequest.getFullname().trim());
        users.setUserName(username);
        users.setCreateDate(new Date());

        String encodedPassword = passwordEncoder.encode(signUpRequest.getPassword());

        users.setPassword(encodedPassword);
        users.setRoles(roles);

        try {
            userRepository.save(users);
            return true;
        } catch (RuntimeException e) {
            return false;
        }
    }

}
