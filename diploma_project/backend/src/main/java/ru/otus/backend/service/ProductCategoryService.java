package ru.otus.backend.service;

import ru.otus.backend.model.product.ProductCategory;

import java.util.List;

public interface ProductCategoryService {
    List<ProductCategory> getCategories();
}
