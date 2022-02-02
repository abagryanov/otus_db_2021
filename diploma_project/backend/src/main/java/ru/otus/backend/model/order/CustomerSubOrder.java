package ru.otus.backend.model.order;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "customer_sub_order", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CustomerSubOrder {
    @Id
    @Column(name = "customer_sub_order_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "amount")
    private BigDecimal amount;

    @Column(name = "discount")
    private BigDecimal discount;

    @Column(name = "price")
    private BigDecimal price;
}
