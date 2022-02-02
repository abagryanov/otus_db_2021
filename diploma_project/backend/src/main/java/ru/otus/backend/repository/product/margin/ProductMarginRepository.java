package ru.otus.backend.repository.product.margin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.product.margin.ProductMargin;

@Repository
public interface ProductMarginRepository extends JpaRepository<ProductMargin, Integer> {
}
