package com.barniq.products.service;

import com.barniq.products.entities.*;
import com.barniq.products.repo.ProductRepository;
import com.barniq.products.repo.UnverifiedProductRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class ProductVerificationService {

    private final ProductRepository productRepo;
    private final UnverifiedProductRepository unverifiedRepo;

    public ProductVerificationService(ProductRepository productRepo, UnverifiedProductRepository unverifiedRepo) {
        this.productRepo = productRepo;
        this.unverifiedRepo = unverifiedRepo;
    }



    @Transactional
    public void verifyProduct(Long unverifiedProductId) {
        UnverifiedProduct unverified = unverifiedRepo.findById(unverifiedProductId)
                .orElseThrow(() -> new IllegalArgumentException("Unverified product not found"));

        Optional<Product> maybeProduct = productRepo.findByIdWithImagesAndVariants(unverified.getSourceProductId());
        System.out.println("Found product: " + maybeProduct.isPresent());


        Product product = unverified.getSourceProductId() != null
                ? productRepo.findByIdWithImagesAndVariants(unverified.getSourceProductId())
                .orElseThrow(() -> new IllegalArgumentException("Source product not found"))
                : new Product();

        // === Step 1: Basic Fields Update ===
        updateBasicFields(unverified, product);

        // === Step 2: Save product to get ID if new ===
        product = productRepo.save(product);

        // === Step 3: Merge Base Images ===
        mergeBaseImages(unverified, product);

        // === Step 4: Merge Variants ===
        mergeVariants(unverified, product);

        // === Step 5: Save Final Product with Relationships ===
        productRepo.save(product);

        // === Step 6: Delete the Unverified Product Entry ===
        unverifiedRepo.deleteById(unverifiedProductId);
    }

    private void updateBasicFields(UnverifiedProduct unverified, Product product) {
        product.setName(unverified.getName());
        product.setDescription(unverified.getDescription());
        product.setCategory(unverified.getCategory());
        product.setRatingsCount(unverified.getRatingsCount());
        product.setBrand(unverified.getBrand());
        product.setAttributes(unverified.getAttributes());
        product.setPrice(unverified.getPrice());
        product.setRatings(unverified.getRatings());
        product.setQuantity(unverified.getQuantity());
        product.setDiscountPercentage(unverified.getDiscountPercentage());
        product.setVideoUrl(unverified.getVideoUrl());

        if (product.getDateAdded() == null) {
            product.setDateAdded(unverified.getDateAdded());
        }
        product.setSlug("temp-slug");
        product = productRepo.save(product);
        String slug = unverified.getName().toLowerCase().replaceAll("[^a-z0-9]+", "-" + product.getId());
        product.setSlug(slug);
    }

    private void mergeBaseImages(UnverifiedProduct unverified, Product product) {
        Set<String> existingImageUrls = product.getImageUrls().stream()
                .map(ProductImage::getImageUrl)
                .collect(Collectors.toSet());

        for (UnverifiedProductImage unImg : unverified.getImageUrls()) {
            if (existingImageUrls.add(unImg.getImageUrl())) {
                ProductImage image = new ProductImage();
                image.setImageUrl(unImg.getImageUrl());
                image.setProduct(product);
                product.getImageUrls().add(image);
            }
        }
    }

    private void mergeVariants(UnverifiedProduct unverified, Product product) {
        Set<String> existingSkus = product.getVariants().stream()
                .map(ProductVariant::getSku)
                .collect(Collectors.toSet());

        int skuCounter = product.getVariants().size() + 1;

        for (UnverifiedProductVariant unVar : unverified.getVariants()) {
            String attrPart = unVar.getAttributes().entrySet().stream()
                    .map(e -> e.getKey() + ":" + e.getValue())
                    .reduce((a, b) -> a + "-" + b)
                    .orElse("default");

            String sku = product.getName().toUpperCase().replaceAll("[^A-Z0-9]", "") + "-" +
                    String.format("%03d", skuCounter) + "-" + attrPart;

            if (existingSkus.add(sku)) {
                ProductVariant variant = new ProductVariant();
                variant.setSku(sku);
                variant.setQuantity(unVar.getQuantity());
                variant.setPrice(unVar.getPrice());
                variant.setAttributes(unVar.getAttributes());
                variant.setProduct(product);

                List<ProductImage> variantImages = unVar.getImages().stream().map(unImg -> {
                    ProductImage img = new ProductImage();
                    img.setImageUrl(unImg.getImageUrl());
                    img.setVariant(variant);
                    return img;
                }).collect(Collectors.toList());

                variant.setImages(variantImages);
                product.getVariants().add(variant);
                skuCounter++;
            }
        }
    }


}
