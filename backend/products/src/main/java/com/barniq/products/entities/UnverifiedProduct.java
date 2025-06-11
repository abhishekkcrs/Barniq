package com.barniq.products.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "unverified_products")
public class UnverifiedProduct {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // <-- Add ID generation
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(length = 5000)  // Optional: set description length limit
    private String description;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "category_id", nullable = false)
    private Category category;

    private int ratingsCount;

    private String brand;

    private int price;

    private double ratings;

    private int quantity;

    private LocalDateTime dateAdded;

    private double discountPercentage;

    private String videoUrl;

    @Column(name = "source_product_id")
    private Long sourceProductId;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, Object> attributes;

    @OneToMany(mappedBy = "unverifiedProduct", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UnverifiedProductImage> imageUrls;

    @OneToMany(mappedBy = "unverifiedProduct", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<UnverifiedProductVariant> variants;
}
