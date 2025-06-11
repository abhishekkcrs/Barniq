//package com.sizzle.auth.sizzle_auth.config;
//
//import com.google.firebase.auth.FirebaseAuth;
//import com.google.firebase.auth.FirebaseAuthException;
//import com.google.firebase.auth.FirebaseToken;
//import com.sizzle.auth.sizzle_auth.service.JwtService;
//import jakarta.servlet.FilterChain;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.stereotype.Component;
//import org.springframework.web.filter.OncePerRequestFilter;
//
//import java.io.IOException;
//import java.util.List;
//
//@Component
//public class JwtAuthenticationFilter extends OncePerRequestFilter {
//
//    @Autowired
//    JwtService jwtService;
//
//    @Override
//    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
//                                    FilterChain filterChain) throws ServletException, IOException {
//        String header = request.getHeader("JWT-X-Header");
//
//        if (header == null || !header.startsWith("Bearer ")) {
//            filterChain.doFilter(request, response);
//            return;
//        }
//        logger.info("Checking JWT Security");
//
//        String token = header.replace("Bearer ", "");
//
//        if(jwtService.isValid(token)) {
//
//            // Set Spring Security Authentication
//            UsernamePasswordAuthenticationToken authentication =
//                    new UsernamePasswordAuthenticationToken("jwt", null, List.of());
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//            logger.info("JWT Verified");
//
//
//        } else{
//            logger.error("JWT verification failed: {}");
//            return;
//        }
//        filterChain.doFilter(request, response);
//    }
//}
