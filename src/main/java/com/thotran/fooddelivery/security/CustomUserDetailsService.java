package com.thotran.fooddelivery.security;

import com.thotran.fooddelivery.entity.Users;
import com.thotran.fooddelivery.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustomUserDetailsService implements UserDetailsService {
    @Autowired
    UserRepository userRepository;
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Users users = userRepository.findByUserName(username);
        if (users == null) {
            throw new UsernameNotFoundException("Username does not exist");
        }
        return new User(
                username,
                users.getPassword(),
                List.of(new SimpleGrantedAuthority("ROLE_" + users.getRoles().getRoleName()))
        );
    }
}
