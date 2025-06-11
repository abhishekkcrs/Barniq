package com.barniq.products.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "categories")
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)  // <-- Add ID generation
    private Long id;

    @Column(nullable = false, unique = true) // Unique to avoid duplicate category names
    private String name;

    @ManyToOne(fetch = FetchType.LAZY)  // Lazy loading to avoid unnecessary data fetch
    @JoinColumn(name = "parent_id")
    private Category parent;  // Allows for nested categories (self-referencing)

    @Column(nullable = false, unique = true)
    private String slug;  // For SEO-friendly URLs, unique and non-null

}
