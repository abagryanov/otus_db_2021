package ru.otus.backend.repository.product.discount;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.product.discount.ProductDiscount;

@Repository
public interface ProductDiscountRepository extends JpaRepository<ProductDiscount, Integer> {
}
