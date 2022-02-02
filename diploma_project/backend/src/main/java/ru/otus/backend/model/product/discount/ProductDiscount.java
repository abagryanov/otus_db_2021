package ru.otus.backend.model.product.discount;

import lombok.*;
import ru.otus.backend.model.product.Product;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "product_discount", schema = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ProductDiscount {
    @Id
    @Column(name = "product_discount_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "start_date")
    private LocalDate startDate;

    @Column(name = "finish_date")
    private LocalDate finishDate;

    @Column(name = "discount")
    private BigDecimal discount;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "supplier_product_id", referencedColumnName = "product_id")
    private Product product;
}
