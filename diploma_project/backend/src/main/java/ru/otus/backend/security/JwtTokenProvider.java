package ru.otus.backend.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.customer.Role;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

@Component
public class JwtTokenProvider {
    @Value("${security.jwt.secretKey}")
    private String tokenSecretKey;

    @Value("${security.jwt.expire}")
    private long tokenExpire;

    public static final String TOKEN_PREFIX = "Bearer ";

    private final JwtUserDetailsService jwtUserDetailsService;

    public JwtTokenProvider(JwtUserDetailsService jwtUserDetailsService) {
        this.jwtUserDetailsService = jwtUserDetailsService;
    }

    public String createToken(Customer customer) {
        Claims claims = Jwts.claims().setSubject(String.valueOf(customer.getId()));
        claims.put("customerLogin", customer.getLogin());
        claims.put("customerRoles", customer.getRoles().stream().map(Role::getName).collect(Collectors.toList()));
        Date now = new Date();
        Date expiration = new Date(now.getTime() + tokenExpire);
        return Jwts.builder()
                .setClaims(claims)
                .setIssuedAt(now)
                .setExpiration(expiration)
                .signWith(SignatureAlgorithm.HS256, tokenSecretKey)
                .compact();
    }

    public Authentication getAuthentication(String token) {
        UserDetails userDetails = jwtUserDetailsService.loadCustomerByLogin(getUserName(token));
        return new UsernamePasswordAuthenticationToken(userDetails, "", userDetails.getAuthorities());
    }

    public String getUserName(String token) {
        return Jwts.parser()
                .setSigningKey(tokenSecretKey)
                .parseClaimsJws(token)
                .getBody()
                .get("customerLogin", String.class);
    }

    public Optional<String> resolveToken(HttpServletRequest request) {
        String authorization = request.getHeader("Authorization");
        if (Objects.nonNull(authorization) && authorization.startsWith(TOKEN_PREFIX)) {
            return Optional.of(authorization.substring(TOKEN_PREFIX.length()));
        }
        return Optional.empty();
    }
}
