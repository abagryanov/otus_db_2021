package ru.otus.backend.model.product.margin;

import lombok.*;
import ru.otus.backend.model.product.Product;

import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "supplier_product_margin", schema = "supplier")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class SupplierProductMargin {
    @Id
    @Column(name = "supplier_product_margin_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "margin")
    private BigDecimal margin;

    @OneToOne
    @JoinColumn(name = "supplier_product_id", referencedColumnName = "product_id")
    private Product product;
}
