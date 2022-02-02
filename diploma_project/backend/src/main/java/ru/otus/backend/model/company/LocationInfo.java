package ru.otus.backend.model.company;

import lombok.*;

import javax.persistence.*;

@Entity
@Table(name = "location_info", schema = "company")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class LocationInfo {
    @Id
    @Column(name = "location_info_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "city")
    private String city;

    @Column(name = "street")
    private String street;

    @Column(name = "building")
    private String building;

    @Column(name = "additional_info")
    private String additionalInfo;
}
