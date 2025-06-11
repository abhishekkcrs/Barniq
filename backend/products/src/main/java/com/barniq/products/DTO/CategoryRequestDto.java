package com.barniq.products.DTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.UUID;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CategoryRequestDto {
    private String name;
    private String slug;
    private Long parentId; // Optional
}