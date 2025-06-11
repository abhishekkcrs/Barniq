package com.sizzle.products.sizzle_productlist.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class ProductMin {
    final Long id;
    final String name;
    final String imageUrl;
    final float rating;
    final int price;
    final int ratingsCount;
    final float discountPercentage;

    public ProductMin(Long id,String name, String imageUrl,float rating, int price, int ratingsCount, float discountPercentage){
        this.id = id;
        this.name=name;
        this.imageUrl=imageUrl;
        this.rating=rating;
        this.price=price;
        this.ratingsCount=ratingsCount;
        this.discountPercentage=discountPercentage;
    }
}
