package ru.otus.backend.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.service.customer.CustomerService;

import java.util.Optional;

@Service
public class JwtUserDetailsService {
    private final CustomerService customerService;

    public JwtUserDetailsService(CustomerService customerService) {
        this.customerService = customerService;
    }

    public UserDetails loadCustomerByLogin(String login) {
        Optional<Customer> customerOptional = customerService.findByUserLogin(login);
        if (customerOptional.isEmpty()) {
            throw new UsernameNotFoundException("No such customer with login: " + login);
        }
        return new JwtUser(customerOptional.get());
    }
}
