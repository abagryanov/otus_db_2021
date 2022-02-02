package ru.otus.backend.service.product;

import org.springframework.stereotype.Service;
import ru.otus.backend.dto.customer.product.RequestProductsDto;
import ru.otus.backend.model.product.Product;
import ru.otus.backend.model.product.ProductCategory;
import ru.otus.backend.repository.product.ProductRepository;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;

    public ProductServiceImpl(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public Set<Product> getProducts(RequestProductsDto requestProductsDto) {
        Set<Integer> requestedCategories = requestProductsDto.getProductCategories();
        List<Product> result = productRepository.findAll();
        return (requestedCategories == null || requestedCategories.isEmpty()) ?
                new HashSet<>(result) :
                result.stream()
                        .filter(product -> {
                            Set<Integer> _productCategories = product.getProductCategories().stream()
                                    .map(ProductCategory::getId)
                                    .filter(requestedCategories::contains)
                                    .collect(Collectors.toSet());
                            return !(_productCategories.isEmpty());
                        }).collect(Collectors.toSet());
    }
}
