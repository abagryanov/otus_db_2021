package ru.otus.backend.service.product.discount;

import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.product.Product;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

public interface DiscountService {
    BigDecimal getMaxCategoryCustomerDiscount(Product product, Customer customer);
    BigDecimal getMaxCategoryDiscount(Product product);
    BigDecimal getMaxProductCustomerDiscount(Product product, Customer customer);
    BigDecimal getMaxProductDiscount(Product product);

    default BigDecimal getDiscount(Customer customer, Product product) {
        return Collections.max(List.of(
                getMaxCategoryCustomerDiscount(product, customer),
                getMaxCategoryDiscount(product),
                getMaxProductCustomerDiscount(product, customer),
                getMaxProductDiscount(product)
                ));
    }
}
