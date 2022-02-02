package ru.otus.backend.dto.customer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestCreateCustomerDto {
    private String customerFirstName;
    private String customerLastName;
    private String customerLogin;
    private String customerPassword;
    private String email;
    private String phone;
    private Set<String> roles;
}
