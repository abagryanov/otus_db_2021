package ru.otus.backend.service.customer;

import org.springframework.data.domain.Example;
import org.springframework.data.domain.ExampleMatcher;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ru.otus.backend.dto.customer.RequestCreateCustomerDto;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.customer.Role;
import ru.otus.backend.repository.customer.CustomerRepository;
import ru.otus.backend.repository.customer.RoleRepository;
import ru.otus.backend.utils.CustomerUtils;

import java.util.Objects;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

@Service
public class CustomerServiceImpl implements CustomerService {
    private final CustomerRepository customerRepository;
    private final RoleRepository roleRepository;
    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    public CustomerServiceImpl(CustomerRepository customerRepository,
                               RoleRepository roleRepository,
                               BCryptPasswordEncoder bCryptPasswordEncoder) {
        this.customerRepository = customerRepository;
        this.roleRepository = roleRepository;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }

    @Override
    public Customer createCustomer(RequestCreateCustomerDto requestCreateCustomerDto) {
        return customerRepository.save(toCustomer(requestCreateCustomerDto));
    }

    @Override
    public Optional<Customer> findByUserLogin(String login) {
        return customerRepository.findOne(Example.of(Customer.builder().login(login).build(),
                ExampleMatcher.matching().withIgnorePaths("id", "firstName", "lastName", "password", "email", "phone")));
    }

    @Override
    public Optional<Customer> findByUserLoginAndPassword(String login, String password) {
        Optional<Customer> customerOptional = findByUserLogin(login);
        return customerOptional.isEmpty() ? Optional.empty() :
                bCryptPasswordEncoder.matches(password, customerOptional.get().getPassword()) ?
                        customerOptional : Optional.empty();
    }

    private Customer toCustomer(RequestCreateCustomerDto requestCreateCustomerDto) {
        Set<String> roles = requestCreateCustomerDto.getRoles();
        roles = (roles == null || roles.isEmpty()) ? CustomerUtils.getDefaultCustomerRoles() : roles;
        return new Customer(
                requestCreateCustomerDto.getCustomerFirstName(),
                requestCreateCustomerDto.getCustomerLastName(),
                requestCreateCustomerDto.getCustomerLogin(),
                bCryptPasswordEncoder.encode(requestCreateCustomerDto.getCustomerPassword()),
                requestCreateCustomerDto.getEmail(),
                requestCreateCustomerDto.getPhone(),
                roles.stream()
                        .map(roleName -> roleRepository.getRoleByName(roleName).orElse(new Role()))
                        .filter(role -> Objects.nonNull(role.getName()))
                        .collect(Collectors.toSet())
        );
    }
}
