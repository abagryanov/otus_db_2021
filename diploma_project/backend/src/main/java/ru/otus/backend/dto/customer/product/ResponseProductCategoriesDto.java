package ru.otus.backend.dto.customer.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResponseProductCategoriesDto {
    private List<ProductCategoryDto> productCategories;
}
