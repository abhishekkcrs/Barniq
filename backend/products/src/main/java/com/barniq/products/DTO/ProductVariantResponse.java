package com.barniq.products.DTO;


import com.barniq.products.entities.UnverifiedProductImage;
import lombok.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductVariantResponse {
    private Long id;
    private int price;
    private int quantity;
    private String sku;
    private Map<String, Object> attributes;
    private List<String> imageUrls;

    // Constructor from UnverifiedProductVariant entity
    public ProductVariantResponse(com.barniq.products.entities.UnverifiedProductVariant variant) {
        this.id = variant.getId();
        this.price = variant.getPrice();
        this.quantity = variant.getQuantity();
        this.attributes = variant.getAttributes();
        this.imageUrls = variant.getImages() != null ? variant.getImages().stream()
                .map(UnverifiedProductImage::getImageUrl)
                .toList() : List.of();
    }
    public ProductVariantResponse(com.barniq.products.entities.ProductVariant variant) {
        this.id = variant.getId();
        this.price = variant.getPrice();
        this.quantity = variant.getQuantity();
        this.sku = variant.getSku();
        this.attributes = variant.getAttributes();
        this.imageUrls = variant.getImages() != null ? variant.getImages().stream()
                .map(img -> img.getImageUrl())
                .toList() : List.of();
    }
}
