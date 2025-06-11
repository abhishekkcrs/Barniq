package com.sizzle.user.sizzle_order.DTO;
import lombok.*;

import java.util.Map;
import java.util.UUID;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItemResponse {
    private Long productId;
    private Long vendorId;
    private int quantity;
    private String name;
    private String imageUrl;
    private double price;
    private double discount;
    private Map<String, Object> attributes;
    private Map<String, Object> variant;
    // <-- add this
}