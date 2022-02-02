package ru.otus.backend.model.customer;

import lombok.*;
import ru.otus.backend.model.company.LocationInfo;

import javax.persistence.*;

@Entity
@Table(name = "customer_delivery_location", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CustomerDeliveryLocation {
    @Id
    @Column(name = "customer_delivery_location_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "location_info_id")
    private LocationInfo locationInfo;
}
