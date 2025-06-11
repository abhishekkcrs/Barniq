package com.sizzle.user.sizzle_order.config;

import com.sizzle.user.sizzle_order.service.JwtService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.List;

@Component
public class JwtFilterChain extends OncePerRequestFilter {

    @Autowired
    JwtService jwtService;

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response,
                                    FilterChain filterChain) throws ServletException, IOException {
        Enumeration<String> headerNames = request.getHeaderNames();
        if (headerNames != null) {
            while (headerNames.hasMoreElements()) {
                String headerName = headerNames.nextElement();
                String headerValue = request.getHeader(headerName);
                System.out.println(headerName + " = " + headerValue);
            }
        }


        String header = request.getHeader("JWT-X-Header");


        if (header == null || !header.startsWith("Bearer ")) {
            filterChain.doFilter(request, response);
            logger.info("Header received is NULL");
            return;
        }
        logger.info("Checking JWT Security in UserField");

        String token = header.replace("Bearer ", "");

        if(jwtService.validateToken(token)) {

            String userId = jwtService.getUsernameFromToken(token);

            // Set Spring Security Authentication
            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userId, null, List.of());
            SecurityContextHolder.getContext().setAuthentication(authentication);
            logger.info("JWT Verified");
        } else{
            logger.error("JWT verification failed");
            return;
        }
        filterChain.doFilter(request, response);
    }
}
