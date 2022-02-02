package ru.otus.backend.service.product.margin;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import ru.otus.backend.model.product.Product;
import ru.otus.backend.model.product.margin.ProductMargin;
import ru.otus.backend.model.product.margin.SupplierProductMargin;
import ru.otus.backend.repository.product.margin.ProductMarginRepository;
import ru.otus.backend.repository.product.margin.SupplierProductMarginRepository;

import java.math.BigDecimal;

@Service
public class MarginServiceImpl implements MarginService {
    private final ProductMarginRepository productMarginRepository;
    private final SupplierProductMarginRepository supplierProductMarginRepository;

    public MarginServiceImpl(ProductMarginRepository productMarginRepository,
                             SupplierProductMarginRepository supplierProductMarginRepository) {
        this.productMarginRepository = productMarginRepository;
        this.supplierProductMarginRepository = supplierProductMarginRepository;
    }

    @Override
    public BigDecimal getProductMargin(Product product) {
        return productMarginRepository.findOne(
                Example.of(ProductMargin.builder().product(product).build(),
                        ExampleMatcher.matching().withIgnorePaths("id", "margin")))
                .orElse(ProductMargin.builder().margin(new BigDecimal(0)).build()).getMargin();
    }

    @Override
    public BigDecimal getSupplierProductMargin(Product product) {
        return supplierProductMarginRepository.findOne(
                Example.of(SupplierProductMargin.builder().product(product).build(),
                        ExampleMatcher.matching().withIgnorePaths("id", "margin")))
                .orElse(SupplierProductMargin.builder().margin(new BigDecimal(0)).build()).getMargin();
    }
}
