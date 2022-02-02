package ru.otus.backend.service;

import org.springframework.stereotype.Service;
import ru.otus.backend.dto.customer.product.ProductCategoryDto;
import ru.otus.backend.model.product.ProductCategory;
import ru.otus.backend.repository.product.ProductCategoryRepository;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {
    private ProductCategoryRepository productCategoryRepository;

    public ProductCategoryServiceImpl(ProductCategoryRepository productCategoryRepository) {
        this.productCategoryRepository = productCategoryRepository;
    }

    @Override
    public List<ProductCategory> getCategories() {
        return productCategoryRepository.findAll();
    }
}
