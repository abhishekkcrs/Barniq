package com.sizzle.auth.sizzle_auth.service;

import com.nimbusds.jose.crypto.opts.UserAuthenticationRequired;
import com.sizzle.auth.sizzle_auth.DTO.RoleEntity;
import com.sizzle.auth.sizzle_auth.DTO.UserEntity;
import com.sizzle.auth.sizzle_auth.repo.RoleRepository;
import com.sizzle.auth.sizzle_auth.repo.UserRepository;
import org.apache.catalina.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    UserFeignInterface userFeignInterface;

    @Autowired
    RoleRepository roleRepository;

    public Long isValidUser(String email, String phoneNo) {
        if (phoneNo != null){
            UserEntity user = userRepository.findByPhoneNumber(phoneNo).orElse(null);
            if(user != null)
                return user.getUserId();
        }
        if (email != null) {
            UserEntity user = userRepository.findByEmail(email).orElse(null);
            if(user != null)
                return user.getUserId();
        }
        return -1L;
    }

    public boolean saveUser(UserEntity newUser, String token) {
        System.out.println("Token is:" + token);
        UserEntity user = userFeignInterface.addUser(newUser,token);
        if(user!= null) return true;
        return  false;
    }

    public List<String> getRolesByUserId(Long id) {
        UserEntity user = userRepository.findById(id)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: " + id));

        List<String> roleNames = user.getRoles().stream()
                .map(RoleEntity::getRoleName)
                .toList();
// Or .collect(Collectors.toList()) in Java < 16
        return roleNames;
    }

}
