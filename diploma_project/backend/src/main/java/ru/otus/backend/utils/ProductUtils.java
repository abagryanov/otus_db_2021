package ru.otus.backend.utils;

import ru.otus.backend.dto.customer.product.ProductCategoryDto;
import ru.otus.backend.dto.customer.product.ProductDto;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.product.Product;
import ru.otus.backend.model.product.ProductCategory;
import ru.otus.backend.model.product.ProductPrice;
import ru.otus.backend.service.product.discount.DiscountService;
import ru.otus.backend.service.product.margin.MarginService;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Comparator;
import java.util.stream.Collectors;

public class ProductUtils {
    public static ProductCategoryDto toProductCategoryDto(ProductCategory productCategory) {
        return new ProductCategoryDto(productCategory.getId(), productCategory.getName(), productCategory.getDescription());
    }

    public static BigDecimal getProductPrice(Product product) {
        LocalDate now = LocalDate.now();
        return product.getProductPrices().stream()
                .filter(price ->
                        (price.getStartDate().isBefore(now) || price.getStartDate().isEqual(now)) &&
                                (price.getFinishDate() == null || price.getFinishDate().isAfter(now)))
                .max(Comparator.comparing(ProductPrice::getPrice))
                .orElse(ProductPrice.builder().price(new BigDecimal(0)).build())
                .getPrice();
    }

    public static ProductDto toProductDto(Product product,
                                          Customer customer,
                                          DiscountService discountService,
                                          MarginService marginService) {
        return new ProductDto(
                product.getId(),
                product.getName(),
                product.getDescription(),
                product.getProductSaleType().getShortName(),
                product.getProductCategories().stream()
                        .map(ProductUtils::toProductCategoryDto).collect(Collectors.toSet()),
                CommonUtils.parseDouble(ProductUtils.getProductPrice(product)),
                discountService.getDiscount(customer, product).doubleValue(),
                marginService.getMargin(product).doubleValue());
    }
}
