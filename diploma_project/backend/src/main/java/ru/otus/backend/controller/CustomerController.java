package ru.otus.backend.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.otus.backend.dto.customer.RequestCreateCustomerDto;
import ru.otus.backend.dto.customer.CustomerDto;
import ru.otus.backend.service.customer.CustomerService;

@Slf4j
@RestController
@RequestMapping("${rest.base-path}/customer")
public class CustomerController extends AbstractRestController {
    private final CustomerService customerService;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @PostMapping("/registration")
    public ResponseEntity<CustomerDto> createCustomer(@RequestBody RequestCreateCustomerDto requestCreateCustomerDto) {
        return ResponseEntity.ok(new CustomerDto(customerService.createCustomer(requestCreateCustomerDto)));
    }
}
