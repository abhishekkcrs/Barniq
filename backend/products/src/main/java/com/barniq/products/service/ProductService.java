package com.barniq.products.service;

import com.barniq.products.DTO.ProductMin;
import com.barniq.products.entities.Product;
import com.barniq.products.entities.ProductVariant;
import com.barniq.products.repo.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class ProductService {

    @Autowired
    ProductRepository productRepository;

    public Product getSingleProduct(Long id){
        return productRepository.findById(id).orElse(null);
    }

    public List<ProductMin> getSeveralProducts(Map<Long, Long> productVariantMap) {
        Set<Long> productIds = productVariantMap.keySet();
        List<Product> products = productRepository.findAllByIdIn(productIds);

        return products.stream()
                .map(product -> {
                    Long variantId = productVariantMap.get(product.getId());
                    if (variantId == null) return null;

                    ProductVariant variant = product.getVariants().stream()
                            .filter(v -> v.getId().equals(variantId))
                            .findFirst()
                            .orElse(null);
                    if (variant == null) return null;

                    // 🖼️ Image fallback logic
                    String imageUrl = null;
                    if (variant.getImages() != null && !variant.getImages().isEmpty()) {
                        imageUrl = variant.getImages().get(0).getImageUrl();
                    } else if (product.getImageUrls() != null && !product.getImageUrls().isEmpty()) {
                        imageUrl = product.getImageUrls().get(0).getImageUrl();
                    }

                    return new ProductMin(
                            product.getName(),
                            imageUrl,
                            variant.getPrice(),
                            product.getDiscountPercentage(),
                            product.getAttributes(),
                            variant.getAttributes()
                    );
                })
                .filter(Objects::nonNull)
                .toList();
    }


}
