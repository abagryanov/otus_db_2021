package ru.otus.backend.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import ru.otus.backend.dto.customer.product.RequestProductsDto;
import ru.otus.backend.dto.customer.product.ResponseProductsDto;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.security.AnonymousUser;
import ru.otus.backend.service.customer.CustomerService;
import ru.otus.backend.service.product.ProductService;
import ru.otus.backend.service.product.discount.DiscountService;
import ru.otus.backend.service.product.margin.MarginService;
import ru.otus.backend.utils.ProductUtils;

import java.util.stream.Collectors;

@Slf4j
@RestController
@AllArgsConstructor
@RequestMapping("${rest.base-path}/product")
public class ProductController extends AbstractRestController {
    private final ProductService productService;
    private final CustomerService customerService;
    private final DiscountService discountService;
    private final MarginService marginService;

    @PostMapping
    public ResponseEntity<ResponseProductsDto> getProducts(Authentication authentication,
                                                           @RequestBody RequestProductsDto requestProductsDto) {
        UserDetails userDetails = (authentication == null) ? new AnonymousUser() :
                (UserDetails) authentication.getPrincipal();
        Customer customer = customerService.findByUserLogin(userDetails.getUsername()).orElse(new Customer());
        return ResponseEntity.ok(new ResponseProductsDto(productService.getProducts(requestProductsDto).stream()
                .map(product -> ProductUtils.toProductDto(product, customer, discountService, marginService))
        .collect(Collectors.toSet())));
    }
}
