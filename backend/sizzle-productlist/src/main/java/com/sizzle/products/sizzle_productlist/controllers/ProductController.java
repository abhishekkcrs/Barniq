package com.sizzle.products.sizzle_productlist.controllers;

import com.sizzle.products.sizzle_productlist.dto.ProductMin;
import com.sizzle.products.sizzle_productlist.entity.Product;
import com.sizzle.products.sizzle_productlist.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/apis")
public class ProductController {

    @Autowired
    ProductService productService;

    @GetMapping("/allproducts")
    public Iterable<Product> findProducts(){
        return productService.getAllProducts();
    }

    @PostMapping("/save")
    public void save(@RequestBody final Product product){
         productService.saveProduct(product);
    }

    @GetMapping("/product/{name}")
    public List<Product> searchProduct(@PathVariable String name){
        return productService.searchProductsByName(name);
    }

    @GetMapping("/search/product/{name}")
    public List<ProductMin> searchFuzzyProduct(@PathVariable String name){
        return productService.fuzzySearchProductsByName(name);
    }
}

