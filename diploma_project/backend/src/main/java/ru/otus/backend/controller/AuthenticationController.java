package ru.otus.backend.controller;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.otus.backend.dto.customer.LoginRequestCustomerDto;
import ru.otus.backend.dto.customer.LoginResponseCustomerDto;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.security.JwtTokenProvider;
import ru.otus.backend.service.customer.CustomerService;

@Slf4j
@AllArgsConstructor
@RestController
@RequestMapping("${rest.base-path}/auth")
public class AuthenticationController extends AbstractRestController {
    private final JwtTokenProvider jwtTokenProvider;
    private final CustomerService customerService;

    @PostMapping(value = "/login")
    public ResponseEntity<LoginResponseCustomerDto> login(@RequestBody LoginRequestCustomerDto requestDto) {
        String login = requestDto.getCustomerLogin();
        String password = requestDto.getCustomerPassword();
        Customer customer = customerService.findByUserLoginAndPassword(login, password)
                .orElseThrow(
                        () -> new RuntimeException("No such user with login: " + login));
        String accessToken = jwtTokenProvider.createToken(customer);
        return ResponseEntity.ok()
                .body(new LoginResponseCustomerDto(accessToken));
    }
}
