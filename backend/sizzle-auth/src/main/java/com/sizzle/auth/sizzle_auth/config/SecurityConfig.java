package com.sizzle.auth.sizzle_auth.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private final FirebaseTokenFilter firebaseTokenFilter;
//    private final JwtAuthenticationFilter jwtAuthenticationFilter;

    public SecurityConfig(FirebaseTokenFilter firebaseTokenFilter) {
        this.firebaseTokenFilter = firebaseTokenFilter;
//        this.jwtAuthenticationFilter = jwtAuthenticationFilter;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        System.out.println("IN the security Filter chain");
        http
                .csrf(AbstractHttpConfigurer::disable)
                .authorizeHttpRequests(auth -> auth
                        .requestMatchers("/auth/firebase", "/auth/public/**").authenticated()
                        .requestMatchers("/auth/verify", "/api/**").permitAll()
                )
                .addFilterBefore(firebaseTokenFilter, UsernamePasswordAuthenticationFilter.class);
        return http.build();
    }
}
