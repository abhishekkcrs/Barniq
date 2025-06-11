package com.sizzle.user.sizzle_user.controllers;

import com.sizzle.user.sizzle_user.DTO.UserDTO;
import com.sizzle.user.sizzle_user.entites.Address;
import com.sizzle.user.sizzle_user.entites.UserEntity;
import com.sizzle.user.sizzle_user.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Slf4j
@RestController
@RequestMapping("/users")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping
    public ResponseEntity<UserDTO> addUser(@RequestBody UserEntity userEntity) {
        UserDTO createdUser = userService.addUser(userEntity);
        return ResponseEntity.status(HttpStatus.CREATED).body(createdUser);
    }

    @GetMapping
    public ResponseEntity<UserDTO> getUserById(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        log.info(String.valueOf(userId));
        UserDTO user = userService.getUserById(userId);
        return ResponseEntity.ok(user);
    }

    @PutMapping
    public ResponseEntity<UserDTO> updateUser(Authentication authentication, @RequestBody UserEntity updatedUserEntity) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        UserDTO updatedUser = userService.updateUser(userId, updatedUserEntity);
        return ResponseEntity.ok(updatedUser);
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteUser(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        userService.deleteUser(userId);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/addresses")
    public ResponseEntity<Void> addAddress(Authentication authentication, @RequestBody Address newAddress) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        userService.addAddress(userId, newAddress);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

    @PutMapping("/addresses/{index}")
    public ResponseEntity<Void> updateAddress(Authentication authentication, @PathVariable int index, @RequestBody Address updatedAddress) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        userService.updateAddress(userId, index, updatedAddress);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/addresses/{index}")
    public ResponseEntity<Void> deleteAddress(Authentication authentication, @PathVariable int index) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        userService.deleteAddress(userId, index);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/addresses")
    public ResponseEntity<List<Address>> getAllAddresses(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        List<Address> addresses = userService.getAllAddresses(userId);
        return ResponseEntity.ok(addresses);
    }

    @GetMapping("/lastUsedAddress")
    public ResponseEntity<Address> getLastUsedAddress(Authentication authentication) {
        Long userId = Long.parseLong(authentication.getPrincipal().toString());
        Address lastUsedAddress = userService.getLastUsedAddress(userId);
        return ResponseEntity.ok(lastUsedAddress);
    }
}

