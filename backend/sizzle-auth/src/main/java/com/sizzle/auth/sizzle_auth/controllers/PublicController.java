package com.sizzle.auth.sizzle_auth.controllers;


import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth/public")
public class PublicController {

    @GetMapping("/test")
    String testingFile(){
        return "Test success";
    }

}
