package com.sizzle.products.sizzle_productlist.entity;

import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.elasticsearch.annotations.Document;

import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Document(indexName = "grocery")
public class Product {
    @Id
    private Long id;

    private String name;

    private String description;

    private List<String> imageUrls;

    private Integer categoryId;

    private String category;

    private Integer ratings_count;

    private String brand;

    private Integer price;

    private float ratings;

    private Boolean availability;

    private Date dateAdded;

    private Float discountPercentage;

    private List<String> reviews;

    private String videoUrl;
}
