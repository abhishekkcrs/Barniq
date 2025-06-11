package com.barniq.products.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "unverified_product_images")
public class UnverifiedProductImage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // Add ID generation
    private Long id;

    @Column(nullable = false)
    private String imageUrl;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "unverified_product_id", nullable = false)
    private UnverifiedProduct unverifiedProduct;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "variant_id", nullable = true)
    private UnverifiedProductVariant variant;
}
