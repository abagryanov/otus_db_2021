package ru.otus.backend.service.product.discount;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.stereotype.Service;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.product.Product;
import ru.otus.backend.model.product.discount.CategoryCustomerDiscount;
import ru.otus.backend.model.product.discount.CategoryDiscount;
import ru.otus.backend.model.product.discount.ProductCustomerDiscount;
import ru.otus.backend.model.product.discount.ProductDiscount;
import ru.otus.backend.repository.product.discount.CategoryCustomerDiscountRepository;
import ru.otus.backend.repository.product.discount.CategoryDiscountRepository;
import ru.otus.backend.repository.product.discount.ProductCustomerDiscountRepository;
import ru.otus.backend.repository.product.discount.ProductDiscountRepository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Collections;
import java.util.Comparator;
import java.util.stream.Collectors;

@Service
public class DiscountServiceImpl implements DiscountService {
    private final CategoryCustomerDiscountRepository categoryCustomerDiscountRepository;
    private final CategoryDiscountRepository categoryDiscountRepository;
    private final ProductCustomerDiscountRepository productCustomerDiscountRepository;
    private final ProductDiscountRepository productDiscountRepository;

    public DiscountServiceImpl(CategoryCustomerDiscountRepository categoryCustomerDiscountRepository,
                               CategoryDiscountRepository categoryDiscountRepository,
                               ProductCustomerDiscountRepository productCustomerDiscountRepository,
                               ProductDiscountRepository productDiscountRepository) {
        this.categoryCustomerDiscountRepository = categoryCustomerDiscountRepository;
        this.categoryDiscountRepository = categoryDiscountRepository;
        this.productCustomerDiscountRepository = productCustomerDiscountRepository;
        this.productDiscountRepository = productDiscountRepository;
    }

    @Override
    public BigDecimal getMaxCategoryCustomerDiscount(Product product, Customer customer) {
        LocalDate now = LocalDate.now();
        return Collections.max(product.getProductCategories().stream()
                .map(category -> categoryCustomerDiscountRepository.findAll(Example.of(
                        CategoryCustomerDiscount.builder().productCategory(category).customer(customer).build(),
                        ExampleMatcher.matching().withIgnorePaths("id", "start_date", "finish_date", "discount"))
                        ).stream()
                                .filter(discount ->
                                        (discount.getStartDate().isBefore(now) || discount.getStartDate().isEqual(now)) &&
                                        (discount.getFinishDate() == null || discount.getFinishDate().isAfter(now)))
                                .max(Comparator.comparing(CategoryCustomerDiscount::getDiscount))
                                .orElse(CategoryCustomerDiscount.builder().discount(new BigDecimal(0)).build())
                ).map(CategoryCustomerDiscount::getDiscount)
                .collect(Collectors.toList()));
    }

    @Override
    public BigDecimal getMaxCategoryDiscount(Product product) {
        LocalDate now = LocalDate.now();
        return Collections.max(product.getProductCategories().stream()
                .map(category -> categoryDiscountRepository.findAll(Example.of(
                        CategoryDiscount.builder().productCategory(category).build(),
                        ExampleMatcher.matching().withIgnorePaths("id", "start_date", "finish_date", "discount"))
                        ).stream()
                                .filter(discount ->
                                        (discount.getStartDate().isBefore(now) || discount.getStartDate().isEqual(now)) &&
                                        (discount.getFinishDate() == null || discount.getFinishDate().isAfter(now)))
                                .max(Comparator.comparing(CategoryDiscount::getDiscount))
                                .orElse(CategoryDiscount.builder().discount(new BigDecimal(0)).build())
                ).map(CategoryDiscount::getDiscount)
                .collect(Collectors.toList()));
    }

    @Override
    public BigDecimal getMaxProductCustomerDiscount(Product product, Customer customer) {
        LocalDate now = LocalDate.now();
        ProductCustomerDiscount productCustomerDiscount = productCustomerDiscountRepository.findAll(Example.of(
                ProductCustomerDiscount.builder().product(product).customer(customer).build(),
                ExampleMatcher.matching().withIgnorePaths("id", "start_date", "finish_date", "discount"))
        ).stream()
                .filter(discount ->
                        (discount.getStartDate().isBefore(now) || discount.getStartDate().isEqual(now)) &&
                        (discount.getFinishDate() == null || discount.getFinishDate().isAfter(now)))
                .max(Comparator.comparing(ProductCustomerDiscount::getDiscount))
                .orElse(ProductCustomerDiscount.builder().discount(new BigDecimal(0)).build());
        return productCustomerDiscount.getDiscount();
    }

    @Override
    public BigDecimal getMaxProductDiscount(Product product) {
        LocalDate now = LocalDate.now();
        ProductDiscount productDiscount = productDiscountRepository.findAll(Example.of(
                ProductDiscount.builder().product(product).build(),
                ExampleMatcher.matching().withIgnorePaths("id", "start_date", "finish_date", "discount"))
        ).stream()
                .filter(discount ->
                        (discount.getStartDate().isBefore(now) || discount.getStartDate().isEqual(now)) &&
                        (discount.getFinishDate() == null || discount.getFinishDate().isAfter(now)))
                .max(Comparator.comparing(ProductDiscount::getDiscount))
                .orElse(ProductDiscount.builder().discount(new BigDecimal(0)).build());
        return productDiscount.getDiscount();
    }
}
