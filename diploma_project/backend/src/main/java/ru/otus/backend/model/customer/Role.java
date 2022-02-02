package ru.otus.backend.model.customer;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "role", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Role {
    @Id
    @Column(name = "role_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;
}
