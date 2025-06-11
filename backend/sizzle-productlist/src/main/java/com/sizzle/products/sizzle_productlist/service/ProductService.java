package com.sizzle.products.sizzle_productlist.service;

import com.sizzle.products.sizzle_productlist.dto.ProductMin;
import com.sizzle.products.sizzle_productlist.entity.Product;
import com.sizzle.products.sizzle_productlist.repo.ProductRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

@Service
public class ProductService {

    @Autowired
    private ProductRepo productRepo;

    public Iterable<Product> getAllProducts(){
        return productRepo.findAll();
    }

    public boolean saveProduct(Product product){
        product.setId(1_000_000L + ThreadLocalRandom.current().nextLong(9_000_000_000L));
        productRepo.save(product);
        return true;
    }
    public boolean updateProduct(Product product, Long id){
        Product old = productRepo.findById(id).orElse(null);
        old.setPrice(product.getPrice());
        productRepo.save(old);
        return true;
    }
    public boolean deleteProduct(Long id){
        productRepo.deleteById(id);
        return true;
    }

    public List<Product> searchProductsByName(String name) {
        // Perform fuzzy search on product name
        return productRepo.findByNameLike(name);
    }

    public List<ProductMin> fuzzySearchProductsByName(String name) {
        // Perform fuzzy search on product name
        List<Product> product = productRepo.fuzzySearchByName(name);
        List<ProductMin> productMins = new ArrayList<>();
        for(Product p:product){
            ProductMin e = new ProductMin(p.getId(),p.getName(),p.getImageUrls().getFirst(),p.getRatings(),p.getPrice(),p.getRatings_count(),p.getDiscountPercentage());
            productMins.add(e);
        }
        return productMins;
    }

}
