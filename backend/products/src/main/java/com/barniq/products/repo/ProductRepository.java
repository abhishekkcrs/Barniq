package com.barniq.products.repo;

import com.barniq.products.entities.Product;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

public interface ProductRepository extends JpaRepository<Product, Long> {

    @EntityGraph(attributePaths = {"variants", "variants.images"})
    List<Product> findAllByIdIn(Set<Long> ids);

    @Query("SELECT p FROM Product p LEFT JOIN FETCH p.imageUrls WHERE p.id = :id")
    Optional<Product> findByIdWithImages(@Param("id") Long id);

    // Optional: also fetch variants with images if needed:
    @Query("SELECT p FROM Product p " +
            "LEFT JOIN FETCH p.imageUrls " +
            "LEFT JOIN FETCH p.variants v " +
            "LEFT JOIN FETCH v.images " +
            "WHERE p.id = :id")
    Optional<Product> findByIdWithImagesAndVariants(@Param("id") Long id);


}

