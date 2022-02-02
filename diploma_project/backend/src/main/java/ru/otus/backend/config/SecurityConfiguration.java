package ru.otus.backend.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;

import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import ru.otus.backend.security.JwtTokenFilter;
import ru.otus.backend.security.JwtTokenProvider;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    @Value("${rest.base-path}")
    private String restApiBasePath;
    private final JwtTokenProvider jwtTokenProvider;
    private final ObjectMapper objectMapper;

    public SecurityConfiguration(JwtTokenProvider jwtTokenProvider, ObjectMapper objectMapper) {
        this.jwtTokenProvider = jwtTokenProvider;
        this.objectMapper = objectMapper;
    }


    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .httpBasic().disable()
                .csrf().disable()
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                .anonymous()
                .and()
                .authorizeRequests()
                .antMatchers(HttpMethod.POST, restApiBasePath + "/customer/registration").permitAll()
                .antMatchers(HttpMethod.POST, restApiBasePath + "/auth/**").permitAll()
                .antMatchers(HttpMethod.POST, restApiBasePath + "/product").permitAll()
                .antMatchers(HttpMethod.GET, restApiBasePath + "/**").permitAll()
                .antMatchers("/**").permitAll()
                .anyRequest().authenticated()
                .and()
                .addFilterBefore(new JwtTokenFilter(jwtTokenProvider, objectMapper, restApiBasePath),
                        UsernamePasswordAuthenticationFilter.class);
    }
}
