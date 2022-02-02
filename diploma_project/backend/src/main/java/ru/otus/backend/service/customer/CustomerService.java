package ru.otus.backend.service.customer;

import ru.otus.backend.dto.customer.RequestCreateCustomerDto;
import ru.otus.backend.model.customer.Customer;

import java.util.Optional;

public interface CustomerService {
    Customer createCustomer(RequestCreateCustomerDto requestCreateCustomerDto);
    Optional<Customer> findByUserLogin(String login);
    Optional<Customer> findByUserLoginAndPassword(String login, String password);
}
