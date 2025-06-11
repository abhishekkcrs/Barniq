package com.barniq.products.entities;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

import java.util.List;
import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "unverified_product_variants")
public class UnverifiedProductVariant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // Add auto-generated ID
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "unverified_product_id", nullable = false)
    private UnverifiedProduct unverifiedProduct;

    private int price;

    private int quantity;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(columnDefinition = "jsonb")
    private Map<String, Object> attributes;

    @OneToMany(mappedBy = "variant", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.LAZY)
    private List<UnverifiedProductImage> images;
}
