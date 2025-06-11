package com.barniq.products.DTO;


import lombok.*;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariantRequest {
    private int price;
    private int quantity;
    private String sku;

    private Map<String, Object> attributes;  // e.g., {"color": "red", "size": "M"}
    private List<String> imageUrls;          // Optional variant-level images
}
