package ru.otus.backend.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.otus.backend.dto.customer.product.ResponseProductCategoriesDto;
import ru.otus.backend.service.ProductCategoryService;
import ru.otus.backend.utils.ProductUtils;

import java.util.stream.Collectors;

@Slf4j
@RestController
@RequestMapping("${rest.base-path}/category")
public class ProductCategoryController extends AbstractRestController {
    private final ProductCategoryService productCategoryService;

    public ProductCategoryController(ProductCategoryService productCategoryService) {
        this.productCategoryService = productCategoryService;
    }

    @GetMapping
    public ResponseEntity<ResponseProductCategoriesDto> getProductCategories() {
        return ResponseEntity.ok(new ResponseProductCategoriesDto(productCategoryService.getCategories().stream()
                .map(ProductUtils::toProductCategoryDto)
                .collect(Collectors.toList())));
    }
}
