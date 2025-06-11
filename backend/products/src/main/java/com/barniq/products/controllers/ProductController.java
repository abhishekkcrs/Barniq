package com.barniq.products.controllers;

import com.barniq.products.DTO.ProductMin;
import com.barniq.products.DTO.ProductRequest;
import com.barniq.products.DTO.ProductResponse;
import com.barniq.products.entities.Product;
import com.barniq.products.entities.UnverifiedProduct;
import com.barniq.products.service.ProductService;
import com.barniq.products.service.UnverifiedProductService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/products")
public class ProductController {

    private final UnverifiedProductService unverifiedProductService;
    private final ProductService productService;

    public ProductController(UnverifiedProductService unverifiedProductService, ProductService productService) {
        this.unverifiedProductService = unverifiedProductService;
        this.productService = productService;
    }

    @PostMapping
    public ResponseEntity<ProductResponse> createProduct(@RequestBody ProductRequest request) {
        UnverifiedProduct product = unverifiedProductService.createProduct(request);
        return ResponseEntity.ok(new ProductResponse(product));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ProductResponse> getProduct(@PathVariable Long id) {
        Product product = productService.getSingleProduct(id);
        return ResponseEntity.ok(new ProductResponse(product));
    }

    @PutMapping("/{id}")
    public ResponseEntity<ProductResponse> updateProduct(@PathVariable Long id,
                                                         @RequestBody ProductRequest request) {
        UnverifiedProduct updated = unverifiedProductService.updateProduct(id, request);
        return ResponseEntity.ok(new ProductResponse(updated));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        unverifiedProductService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/getproducts")
    public ResponseEntity<List<ProductMin>> getProducts(@RequestBody Map<Long,Long> productIds){
        return ResponseEntity.ok(productService.getSeveralProducts(productIds));
    }

//    @GetMapping
//    public List<ProductResponse> getAllProducts() {
//        return productService.getAllProducts()
//                .stream()
//                .map(ProductResponse::new)
//                .toList();
//    }
}
