package ru.otus.backend.dto.customer.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductCategoryDto {
    private int id;
    private String name;
    private String description;
}
