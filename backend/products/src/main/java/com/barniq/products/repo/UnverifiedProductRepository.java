package com.barniq.products.repo;

import com.barniq.products.entities.UnverifiedProduct;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.UUID;

public interface UnverifiedProductRepository extends JpaRepository<UnverifiedProduct, Long> {

}

