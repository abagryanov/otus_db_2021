package ru.otus.backend.repository.product.discount;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.product.discount.ProductCustomerDiscount;

@Repository
public interface ProductCustomerDiscountRepository extends JpaRepository<ProductCustomerDiscount, Integer> {
}
