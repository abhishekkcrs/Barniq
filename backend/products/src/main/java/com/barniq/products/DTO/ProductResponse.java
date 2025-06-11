package com.barniq.products.DTO;

import com.barniq.products.entities.ProductImage;
import lombok.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductResponse {
    private Long id;
    private String name;
    private String description;
    private String category;
    private int ratingsCount;
    private String brand;
    private int price;
    private double ratings;
    private int quantity;
    private LocalDateTime dateAdded;
    private double discountPercentage;
    private String videoUrl;

    private List<String> imageUrls;
    private List<String> reviews; // keep or adapt as needed

    private Map<String, Object> attributes;

    private List<ProductVariantResponse> variants;

    // Convenience constructor for UnverifiedProduct mapping
    public ProductResponse(com.barniq.products.entities.UnverifiedProduct product) {
        this.id = product.getId();
        this.name = product.getName();
        this.description = product.getDescription();
        this.category = product.getCategory() != null ? product.getCategory().getName() : null;
        this.ratingsCount = product.getRatingsCount();
        this.brand = product.getBrand();
        this.price = product.getPrice();
        this.ratings = product.getRatings();
        this.quantity = product.getQuantity();  // Make sure your entity has this method/field
        this.dateAdded = product.getDateAdded();
        this.discountPercentage = product.getDiscountPercentage();
        this.videoUrl = product.getVideoUrl();
        this.imageUrls = product.getImageUrls().stream()
                .map(com.barniq.products.entities.UnverifiedProductImage::getImageUrl)
                .toList();
        this.attributes = product.getAttributes();

        if(product.getVariants() != null) {
            this.variants = product.getVariants().stream()
                    .map(ProductVariantResponse::new)
                    .toList();
        }
    }
    public ProductResponse(com.barniq.products.entities.Product product) {
        this.id = product.getId();
        this.name = product.getName();
        this.description = product.getDescription();
        this.category = product.getCategory() != null ? product.getCategory().getName() : null;
        this.ratingsCount = product.getRatingsCount();
        this.brand = product.getBrand();
        this.price = product.getPrice();
        this.ratings = product.getRatings();
        this.quantity = product.getQuantity();  // Make sure your entity has this method/field
        this.dateAdded = product.getDateAdded();
        this.discountPercentage = product.getDiscountPercentage();
        this.videoUrl = product.getVideoUrl();
        this.imageUrls = product.getImageUrls() == null
                ? List.of()
                : product.getImageUrls().stream()
                .map(ProductImage::getImageUrl)
                .toList();
        this.attributes = product.getAttributes();

        if(product.getVariants() != null) {
            this.variants = product.getVariants().stream()
                    .map(ProductVariantResponse::new)
                    .toList();
        }
    }
}
