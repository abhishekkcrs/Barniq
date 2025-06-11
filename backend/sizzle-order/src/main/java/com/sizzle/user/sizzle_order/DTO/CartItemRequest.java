package com.sizzle.user.sizzle_order.DTO;

import lombok.*;

import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class CartItemRequest {
    private Long productId;
    private Long vendorId;
    private int quantity;
}