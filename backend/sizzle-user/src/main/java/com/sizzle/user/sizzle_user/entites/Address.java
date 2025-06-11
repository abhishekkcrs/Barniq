package com.sizzle.user.sizzle_user.entites;
import lombok.Data;

@Data
public class Address {
    private String name;
    private Long number;
    private String hno;
    private String street;
    private String city;
    private String state;
    private String zip;
}