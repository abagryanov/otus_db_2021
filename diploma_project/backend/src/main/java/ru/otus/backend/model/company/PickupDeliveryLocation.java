package ru.otus.backend.model.company;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "pickup_delivery_location", schema = "company")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class PickupDeliveryLocation {
    @Id
    @Column(name = "pickup_delivery_location_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "location_info_id")
    private LocationInfo locationInfo;
}
