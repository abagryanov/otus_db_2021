package ru.otus.backend.repository.customer;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.customer.Customer;

@Repository
public interface CustomerRepository extends JpaRepository<Customer, Integer> {

}
