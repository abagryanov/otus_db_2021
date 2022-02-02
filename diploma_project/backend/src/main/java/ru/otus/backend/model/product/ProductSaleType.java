package ru.otus.backend.model.product;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "product_sale_type", schema = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductSaleType {
    @Id
    @Column(name = "product_sale_type_id")
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "short_name")
    private String shortName;
}
