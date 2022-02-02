package ru.otus.backend.service.product.margin;

import ru.otus.backend.model.product.Product;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.List;

public interface MarginService {
    BigDecimal getProductMargin(Product product);
    BigDecimal getSupplierProductMargin(Product product);

    default BigDecimal getMargin(Product product) {
        return Collections.max(List.of(getProductMargin(product), getSupplierProductMargin(product)));
    }
}
