package com.sizzle.auth.sizzle_auth.service;


import com.sizzle.auth.sizzle_auth.DTO.UserEntity;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

@FeignClient(
        name = "sizzle-user",
        url  = "${user.service.url}"        // ← pick this up from properties or environment
)
public interface UserFeignInterface {

    @PostMapping("/users")  // Mapping to the POST request for adding a user
    UserEntity addUser(@RequestBody UserEntity userEntity, @RequestHeader("JWT-X-Header") String token);

}
