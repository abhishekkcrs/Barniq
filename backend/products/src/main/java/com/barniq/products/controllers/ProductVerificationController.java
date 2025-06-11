package com.barniq.products.controllers;

import com.barniq.products.service.ProductVerificationService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/api/admin/products")
public class ProductVerificationController {

    private final ProductVerificationService verificationService;

    public ProductVerificationController(ProductVerificationService verificationService) {
        this.verificationService = verificationService;
    }

    /**
     * Endpoint for admin to verify a product.
     * @param unverifiedProductId UUID of the product to verify.
     * @return HTTP 200 if successful, or 404 if not found.
     */
    @PostMapping("/verify/{id}")
    public ResponseEntity<String> verifyProduct(@PathVariable("id") Long unverifiedProductId) {
        try {
            verificationService.verifyProduct(unverifiedProductId);
            return ResponseEntity.ok("Product verified successfully");
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }
}
