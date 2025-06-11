package com.sizzle.user.sizzle_user.service;


import com.sizzle.user.sizzle_user.DTO.UserDTO;
import com.sizzle.user.sizzle_user.entites.Address;
import com.sizzle.user.sizzle_user.entites.RoleEntity;
import com.sizzle.user.sizzle_user.entites.UserEntity;
import com.sizzle.user.sizzle_user.repository.RoleRepository;
import com.sizzle.user.sizzle_user.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashSet;
import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RoleRepository roleRepository;

    private UserDTO convertToDTO(UserEntity user) {
        UserDTO dto = new UserDTO();
        dto.setName(user.getName());
        dto.setEmail(user.getEmail());
        dto.setPhoneNo(user.getPhoneNumber());
        dto.setPhotoUrl(user.getPhotoUrl());
        dto.setAddress(user.getAddress());
        dto.setLastUsedAddress(user.getLastUsedAddress());
//        Set<RoleEntity> roles = new HashSet<>(roleRepository.findAllById(dto.getRoleIds()));
//        user.setRoles(roles);
        return dto;
    }


    // Add a new user
    @Transactional
    public UserDTO addUser(UserEntity userEntity) {
        userEntity.setLastUsedAddress(null);
        UserEntity savedUser = userRepository.save(userEntity);
        return convertToDTO(savedUser);
    }

    // Get a user by ID
    public UserDTO getUserById(Long userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        return convertToDTO(user);
    }

    // Update user details
    @Transactional
    public UserDTO updateUser(Long userId, UserEntity updatedUserEntity) {
        UserEntity existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        existingUser.setEmail(updatedUserEntity.getEmail());
        existingUser.setPasswordHash(updatedUserEntity.getPasswordHash());
        existingUser.setName(updatedUserEntity.getName());
        existingUser.setPhoneNumber(updatedUserEntity.getPhoneNumber());

        return convertToDTO(userRepository.save(existingUser));
    }

    // Delete user
    @Transactional
    public void deleteUser(Long userId) {
        UserEntity existingUser = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));
        userRepository.delete(existingUser);
    }

    // Add a new address to the user's address list
    @Transactional
    public void addAddress(Long userId, Address newAddress) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Add the new address to the user's address list
        user.getAddress().add(newAddress);

        // Set the new address as the last used one
        user.setLastUsedAddress(newAddress);

        userRepository.save(user);
    }

    // Update an existing address
    @Transactional
    public void updateAddress(Long userId, int addressIndex, Address updatedAddress) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Ensure the address exists in the list
        if (addressIndex < 0 || addressIndex >= user.getAddress().size()) {
            throw new IllegalArgumentException("Invalid address index");
        }

        // Replace the address at the given index
        user.getAddress().set(addressIndex, updatedAddress);

        // If the updated address is the one the user last used, update it accordingly
        if (user.getLastUsedAddress().equals(user.getAddress().get(addressIndex))) {
            user.setLastUsedAddress(updatedAddress);
        }

        userRepository.save(user);
    }

    // Delete an address and handle lastUsedAddress
    @Transactional
    public void deleteAddress(Long userId, int addressIndex) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        // Ensure the address exists in the list
        if (addressIndex < 0 || addressIndex >= user.getAddress().size()) {
            throw new IllegalArgumentException("Invalid address index");
        }

        // Get the address being deleted
        Address addressToDelete = user.getAddress().get(addressIndex);

        // If the deleted address is the last used address, update it
        if (addressToDelete.equals(user.getLastUsedAddress())) {
            if (user.getAddress().size() > 1) {
                // If there are more addresses, set the first one (or another logic) as lastUsedAddress
                user.setLastUsedAddress(user.getAddress().get(0));  // Example: set the first address as the last used one
            } else {
                // If it's the only address, set lastUsedAddress to null
                user.setLastUsedAddress(null);
            }
        }

        // Remove the address
        user.getAddress().remove(addressIndex);

        userRepository.save(user);
    }

    // Get all addresses for a user
    public List<Address> getAllAddresses(Long userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        return user.getAddress();
    }

    // Get the last used address for a user
    public Address getLastUsedAddress(Long userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found"));

        return user.getLastUsedAddress();
    }

    // Find user by email
    public Optional<UserEntity> getUserByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    public Optional<UserEntity> getUserbyId(Long userId){
        return userRepository.findByUserId(userId);
    }

}
