package ru.otus.backend.model.product;

import lombok.*;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "supplier_product_price", schema = "supplier")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductPrice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_product_price_id")
    private int id;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "finish_date")
    private LocalDate finishDate;

    @Column(name = "price")
    private BigDecimal price;
}
