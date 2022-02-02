package ru.otus.backend.model.customer;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "customer", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Customer {
    @Id
    @Column(name = "customer_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "first_name")
    private String firstName;

    @Column(name = "last_name")
    private String lastName;

    @Column(name = "login")
    private String login;

    @Column(name = "password")
    private String password;

    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "customer_role",
            schema = "customer",
            joinColumns = @JoinColumn(name = "customer_id", referencedColumnName = "customer_id"),
            inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "role_id")
    )
    private Set<Role> roles;

    public Customer(String firstName, String lastName, String login, String password, String email, String phone, Set<Role> roles) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.login = login;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.roles = roles;
    }
}
