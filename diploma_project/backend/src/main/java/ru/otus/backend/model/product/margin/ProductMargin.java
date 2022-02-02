package ru.otus.backend.model.product.margin;

import lombok.*;
import ru.otus.backend.model.product.Product;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "product_margin", schema = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class ProductMargin {
    @Id
    @Column(name = "product_margin_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "margin")
    private BigDecimal margin;

    @OneToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "product_id")
    private Product product;
}
