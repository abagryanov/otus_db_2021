package ru.otus.backend.model.company;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "delivery_type", schema = "company")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class DeliveryType {
    @Id
    @Column(name = "delivery_type_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;
}
