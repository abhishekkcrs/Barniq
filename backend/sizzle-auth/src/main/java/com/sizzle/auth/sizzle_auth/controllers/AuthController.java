package com.sizzle.auth.sizzle_auth.controllers;

import com.sizzle.auth.sizzle_auth.service.JwtService;
import com.sizzle.auth.sizzle_auth.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/auth")
public class AuthController {

    private final JwtService jwtService;

    @Autowired
    public AuthController(JwtService jwtService) {
        this.jwtService = jwtService;
    }

    @Autowired
    UserService userService;

    @PostMapping("/firebase")
    public ResponseEntity<Map<String, String>> authenticateWithFirebase(Authentication authentication) {
        System.out.println("Inside the JWT Generator");
        String userId= authentication.getPrincipal().toString();
        Long longUserId = Long.parseLong(userId);
        List<String> roles = userService.getRolesByUserId(longUserId); // Example method to get roles as List<String>
        String jwt = jwtService.generateToken(userId, roles);

        log.info("JWT issued: " + jwt);
        for(String role:roles)
            System.out.print(role + " ");
        return ResponseEntity.ok(Map.of("token", jwt, "userId", userId));
    }

    @PostMapping("/verify")
    public ResponseEntity<?> verifyToken(HttpServletRequest request) {
        String header = request.getHeader("JWT-X-Header");
        log.info("Validating User with JWT-X-Header");

        if (header == null || !header.startsWith("Bearer ")) {
            log.info("Invalid Header");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Missing or invalid Authorization header");
        }

        String token = header.replace("Bearer ", "");

        if (!jwtService.isValid(token)) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid token");
        }
        return ResponseEntity.ok().build();
    }

    @GetMapping("/verify")
    String test(){
        return "Testing Success";
    }


}

