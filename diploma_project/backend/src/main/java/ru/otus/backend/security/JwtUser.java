package ru.otus.backend.security;

import lombok.Builder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import ru.otus.backend.model.customer.Customer;

import java.util.Collection;
import java.util.stream.Collectors;

public class JwtUser implements UserDetails {
    private final String userName;
    private final String password;
    private final Collection<GrantedAuthority> authorities;

    public JwtUser(Customer customer) {
        this.userName = customer.getLogin();
        this.password = customer.getPassword();
        System.out.println(customer.getRoles());
        this.authorities = customer.getRoles().stream()
                .map(role -> new SimpleGrantedAuthority(role.getName()))
                .collect(Collectors.toList());
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {
        return userName;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}
