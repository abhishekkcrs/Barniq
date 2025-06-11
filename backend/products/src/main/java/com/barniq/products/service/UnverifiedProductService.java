package com.barniq.products.service;

import com.barniq.products.DTO.ProductRequest;
import com.barniq.products.entities.*;
import com.barniq.products.repo.CategoryRepository;
import com.barniq.products.repo.ProductRepository;
import com.barniq.products.repo.UnverifiedProductRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import javax.swing.text.html.Option;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;


@Service
public class UnverifiedProductService {
    private final UnverifiedProductRepository unverifiedProductRepo;
    private final CategoryRepository categoryRepo;
    private final ProductRepository verifiedProductRepo;

    public UnverifiedProductService(UnverifiedProductRepository unverifiedProductRepo,
                                    CategoryRepository categoryRepo,
                                    ProductRepository verifiedProductRepo) {
        this.unverifiedProductRepo = unverifiedProductRepo;
        this.categoryRepo = categoryRepo;
        this.verifiedProductRepo=verifiedProductRepo;
    }

    public UnverifiedProduct createProduct(ProductRequest req) {
        Category category = categoryRepo.findById(req.getCategoryId())
                .orElseThrow(() -> new RuntimeException("Category not found"));

        UnverifiedProduct product = new UnverifiedProduct();
        product.setName(req.getName());
        product.setDescription(req.getDescription());
        product.setCategory(category);
        product.setRatingsCount(req.getRatingsCount());
        product.setBrand(req.getBrand());
        product.setAttributes(req.getAttributes());
        product.setPrice(req.getPrice());
        product.setRatings(req.getRatings());
        product.setQuantity(req.getQuantity());
        product.setDateAdded(LocalDateTime.now());
        product.setDiscountPercentage(req.getDiscountPercentage());
        product.setVideoUrl(req.getVideoUrl());

        // Handle images
        List<UnverifiedProductImage> images = req.getImageUrls().stream().map(url -> {
            UnverifiedProductImage img = new UnverifiedProductImage();
//            img.setId(UUID.randomUUID());
            img.setImageUrl(url);
            img.setUnverifiedProduct(product);
            return img;
        }).toList();
        product.setImageUrls(images);

        // Handle variants
        List<UnverifiedProductVariant> variants = req.getVariants().stream().map(variantDto -> {
            UnverifiedProductVariant variant = new UnverifiedProductVariant();
            variant.setQuantity(variantDto.getQuantity());
            variant.setPrice(variantDto.getPrice());
            variant.setAttributes(variantDto.getAttributes()); // dynamic fields
            variant.setUnverifiedProduct(product);
            return variant;
        }).toList();
        product.setVariants(variants);
        return unverifiedProductRepo.save(product);
    }

    public UnverifiedProduct getProduct(Long id) {
        return unverifiedProductRepo.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    @Transactional
    public UnverifiedProduct updateProduct(Long id, ProductRequest req) {
        Optional<UnverifiedProduct> optionalUnverified = unverifiedProductRepo.findById(id);

        if (optionalUnverified.isPresent()) {
            // Update the existing unverified product
            UnverifiedProduct product = optionalUnverified.get();

            Category category = categoryRepo.findById(req.getCategoryId())
                    .orElseThrow(() -> new RuntimeException("Category not found"));

            product.setName(req.getName());
            product.setDescription(req.getDescription());
            product.setCategory(category);
            product.setRatingsCount(req.getRatingsCount());
            product.setBrand(req.getBrand());
            product.setPrice(req.getPrice());
            product.setRatings(req.getRatings());
            product.setAttributes(req.getAttributes());
            product.setQuantity(req.getQuantity());
            product.setDiscountPercentage(req.getDiscountPercentage());
            product.setVideoUrl(req.getVideoUrl());

            // Update images
            product.getImageUrls().clear();
            List<UnverifiedProductImage> images = req.getImageUrls().stream().map(url -> {
                UnverifiedProductImage img = new UnverifiedProductImage();
                img.setImageUrl(url);
                img.setUnverifiedProduct(product);
                return img;
            }).collect(Collectors.toList());
            product.getImageUrls().addAll(images);

            // Update variants
            product.getVariants().clear();
            List<UnverifiedProductVariant> variants = req.getVariants().stream().map(variantDto -> {
                UnverifiedProductVariant variant = new UnverifiedProductVariant();
                variant.setQuantity(variantDto.getQuantity());
                variant.setPrice(variantDto.getPrice());
                variant.setAttributes(variantDto.getAttributes());
                variant.setUnverifiedProduct(product);
                return variant;
            }).collect(Collectors.toList());
            product.getVariants().addAll(variants);

            return unverifiedProductRepo.save(product);

        } else {
            // Product is verified, so we create a new unverified entry
            Product verifiedProduct = verifiedProductRepo.findById(id)
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            Category category = categoryRepo.findById(req.getCategoryId())
                    .orElseThrow(() -> new RuntimeException("Category not found"));

            UnverifiedProduct product = new UnverifiedProduct();
            product.setName(req.getName());
            product.setSourceProductId(verifiedProduct.getId());
            product.setDescription(req.getDescription());
            product.setCategory(category);
            product.setRatingsCount(req.getRatingsCount());
            product.setBrand(req.getBrand());
            product.setPrice(req.getPrice());
            product.setRatings(req.getRatings());
            product.setAttributes(req.getAttributes());
            product.setQuantity(req.getQuantity());
            product.setDiscountPercentage(req.getDiscountPercentage());
            product.setVideoUrl(req.getVideoUrl());
            product.setDateAdded(LocalDateTime.now());

            // Add images
            List<UnverifiedProductImage> images = req.getImageUrls().stream().map(url -> {
                UnverifiedProductImage img = new UnverifiedProductImage();
                img.setImageUrl(url);
                img.setUnverifiedProduct(product);
                return img;
            }).collect(Collectors.toList());
            product.setImageUrls(images);

            // Add variants
            List<UnverifiedProductVariant> variants = req.getVariants().stream().map(variantDto -> {
                UnverifiedProductVariant variant = new UnverifiedProductVariant();
                variant.setQuantity(variantDto.getQuantity());
                variant.setPrice(variantDto.getPrice());
                variant.setAttributes(variantDto.getAttributes());
                variant.setUnverifiedProduct(product);
                return variant;
            }).collect(Collectors.toList());
            product.setVariants(variants);

            return unverifiedProductRepo.save(product);
        }
    }


    public void deleteProduct(Long id) {
        if (!unverifiedProductRepo.existsById(id)) {
            throw new RuntimeException("Product not found");
        }
        unverifiedProductRepo.deleteById(id);
    }
}
