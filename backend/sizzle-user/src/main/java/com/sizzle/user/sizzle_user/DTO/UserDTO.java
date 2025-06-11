package com.sizzle.user.sizzle_user.DTO;

import com.sizzle.user.sizzle_user.entites.Address;
import java.util.List;
import java.util.Set;

import lombok.Data;

@Data
public class UserDTO {
    private String name;
    private String email;
    private String phoneNo;
    private String photoUrl;
    private List<Address> address;
    private Address lastUsedAddress;
    private Set<Long> roleIds;
}
