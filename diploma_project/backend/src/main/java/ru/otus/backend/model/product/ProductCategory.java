package ru.otus.backend.model.product;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "category", schema = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ProductCategory {
    @Id
    @Column(name = "category_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;
}
