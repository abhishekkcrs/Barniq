package com.barniq.products.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductMin {
    private String name;
    private String imageUrl;
    private double price;
    private double discount;
    private Map<String, Object> attributes;
    private Map<String, Object> variant;

}
