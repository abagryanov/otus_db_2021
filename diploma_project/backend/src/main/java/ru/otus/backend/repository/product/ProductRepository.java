package ru.otus.backend.repository.product;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.product.Product;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {
}
