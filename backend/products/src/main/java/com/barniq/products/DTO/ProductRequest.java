package com.barniq.products.DTO;
import lombok.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductRequest {
    private String name;
    private String description;
    private Long categoryId;
    private int ratingsCount;
    private String brand;
    private int price;
    private double ratings;
    private int quantity;
    private double discountPercentage;
    private String videoUrl;

    private List<String> imageUrls;     // Product-level images
    private List<String> reviews;       // You can adapt this to a Review DTO if needed
    private Map<String, Object> attributes; // Dynamic product-level attributes

    private List<ProductVariantRequest> variants; // Variant support
}