package ru.otus.backend.dto.customer.product;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestProductsDto {
    private Set<Integer> productCategories;
}
