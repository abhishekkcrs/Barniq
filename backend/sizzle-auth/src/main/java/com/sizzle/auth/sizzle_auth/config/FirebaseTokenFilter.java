package com.sizzle.auth.sizzle_auth.config;

import com.google.firebase.auth.FirebaseAuth;
import com.google.firebase.auth.FirebaseAuthException;
import com.google.firebase.auth.FirebaseToken;
import com.sizzle.auth.sizzle_auth.repo.RoleRepository;
import com.sizzle.auth.sizzle_auth.service.JwtService;
import com.sizzle.auth.sizzle_auth.service.UserService;
import com.sizzle.auth.sizzle_auth.DTO.UserEntity;
import io.jsonwebtoken.Jwt;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.java.Log;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import lombok.extern.slf4j.Slf4j;


import java.io.IOException;
import java.util.List;
import java.util.Objects;
import java.util.Set;
import java.util.concurrent.ThreadLocalRandom;

@Component
public class FirebaseTokenFilter extends OncePerRequestFilter {

    private static final Logger logger = LoggerFactory.getLogger(FirebaseTokenFilter.class);

    @Autowired
    UserService userService;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    JwtService jwtService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {

        String header = request.getHeader("Authorization");
        System.out.println("Remember to have same IP addr");

        if (header == null || !header.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            return;
        }
        logger.info("Checking Security");



        String token = header.replace("Bearer ", "");

        try {
            FirebaseToken firebaseToken = FirebaseAuth.getInstance().verifyIdToken(token);
            String uid = firebaseToken.getUid(); // Always present
            String email = firebaseToken.getEmail(); // May be null
            String name = firebaseToken.getName();
            String photoUrl = firebaseToken.getPicture();
            Object phoneNumberObj = firebaseToken.getClaims().get("phone_number");
            String phoneNumber = phoneNumberObj != null ? phoneNumberObj.toString() : null;
            String principal;
            logger.info("Phone No: " + phoneNumber);
            Long userId = userService.isValidUser(email,phoneNumber);
            if(userId != -1){
                principal = userId.toString();
            }
            else{
                Long randomUid = ThreadLocalRandom.current().nextLong(1, Long.MAX_VALUE);
                UserEntity newUser = new UserEntity();
                newUser.setUserId(randomUid);
                newUser.setEmail(email);
                newUser.setPhoneNumber(phoneNumber);
                newUser.setPhotoUrl(photoUrl);
                newUser.setName(name);
                newUser.setRoles(Set.of(Objects.requireNonNull(roleRepository.findByRoleName("ROLE_USER").orElse(null))));
                principal = randomUid.toString();
                List<String> roles = List.of("ROLE_USER");
                String newToken = "Bearer " + jwtService.generateToken(principal, roles);
                userService.saveUser(newUser,newToken);
            }



            // Set Spring Security Authentication
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(principal, null, List.of());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            logger.info("Authenticated user with email: {}", email);


        } catch (FirebaseAuthException e) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            logger.error("Firebase verification failed: {}", e.getMessage());
            return;
        }

        filterChain.doFilter(request, response);
    }
}

