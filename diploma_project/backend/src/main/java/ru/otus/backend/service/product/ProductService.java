package ru.otus.backend.service.product;

import org.springframework.stereotype.Repository;
import ru.otus.backend.dto.customer.product.RequestProductsDto;
import ru.otus.backend.model.product.Product;

import java.util.Set;

@Repository
public interface ProductService {
    Set<Product> getProducts(RequestProductsDto requestProductsDto);
}
