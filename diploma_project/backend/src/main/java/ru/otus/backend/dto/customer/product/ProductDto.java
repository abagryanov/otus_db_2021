package ru.otus.backend.dto.customer.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductDto {
    private int id;
    private String name;
    private String description;
    private String productSaleType;
    private Set<ProductCategoryDto> productCategories;
    private double productPrice;
    private double productDiscount;
    private double productMargin;
}
