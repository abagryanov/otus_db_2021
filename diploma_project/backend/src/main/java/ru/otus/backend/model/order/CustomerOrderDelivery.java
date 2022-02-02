package ru.otus.backend.model.order;

import lombok.*;
import ru.otus.backend.model.company.DeliveryType;
import ru.otus.backend.model.company.PickupDeliveryLocation;
import ru.otus.backend.model.customer.CustomerDeliveryLocation;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "customer_order_delivery", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CustomerOrderDelivery {
    @Id
    @Column(name = "customer_order_delivery_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "delivery_date")
    private LocalDate deliveryDate;

    @Column(name = "delivery_info")
    private String deliveryInfo;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "delivery_type_id")
    private DeliveryType deliveryType;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "pickup_delivery_location_id")
    private PickupDeliveryLocation pickupDeliveryLocation;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customer_delivery_location_id")
    private CustomerDeliveryLocation customerDeliveryLocation;
}
