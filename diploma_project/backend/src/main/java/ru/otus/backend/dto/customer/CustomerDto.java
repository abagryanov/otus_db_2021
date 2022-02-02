package ru.otus.backend.dto.customer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import ru.otus.backend.model.customer.Customer;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CustomerDto {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;

    public CustomerDto(Customer customer) {
        this.id = customer.getId();
        this.firstName = customer.getFirstName();
        this.lastName = customer.getLastName();
        this.email = customer.getEmail();
        this.phone = customer.getPhone();
    }
}
