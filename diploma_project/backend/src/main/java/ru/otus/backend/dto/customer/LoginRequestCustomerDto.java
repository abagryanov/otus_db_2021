package ru.otus.backend.dto.customer;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginRequestCustomerDto {
    private String customerLogin;
    private String customerPassword;
}
