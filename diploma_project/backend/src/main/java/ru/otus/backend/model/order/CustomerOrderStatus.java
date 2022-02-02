package ru.otus.backend.model.order;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "customer_order_status", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CustomerOrderStatus {
    @Id
    @Column(name = "customer_order_status_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "description")
    private String description;
}
