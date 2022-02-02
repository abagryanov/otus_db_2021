package ru.otus.backend.model.product;

import lombok.*;
import ru.otus.backend.model.product.margin.ProductMargin;

import javax.persistence.*;
import java.util.Set;

@Entity
@Table(name = "product", schema = "product")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Product {
    @Id
    @Column(name = "product_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @EqualsAndHashCode.Include
    private int id;

    @Column(name = "name")
    private String name;

    @Column(name = "article")
    private String article;

    @Column(name = "description")
    private String description;

    @ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name = "product_sale_type_id")
    private ProductSaleType productSaleType;

    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinTable(
            name = "product_category",
            schema = "product",
            joinColumns = @JoinColumn(name = "product_id", referencedColumnName = "product_id"),
            inverseJoinColumns = @JoinColumn(name = "category_id", referencedColumnName = "category_id")
    )
    private Set<ProductCategory> productCategories;

    @OneToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "supplier_product_price_id")
    private Set<ProductPrice> productPrices;
}
