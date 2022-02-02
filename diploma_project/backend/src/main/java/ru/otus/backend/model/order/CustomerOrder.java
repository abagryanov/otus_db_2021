package ru.otus.backend.model.order;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "customer_order", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CustomerOrder {
    @Id
    @Column(name = "customer_order_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "created_timestamp")
    private LocalDateTime createdTimestamp;

    @Column(name = "payed_timestamp")
    private LocalDateTime payedTimestamp;

    @Column(name = "total_price")
    private BigDecimal totalPrice;

    @Column(name = "total_discount")
    private BigDecimal totalDiscount;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customer_order_status_id")
    private CustomerOrderStatus customerOrderStatus;

    @OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customer_order_id")
    private CustomerOrderDelivery customerOrderDelivery;
}
