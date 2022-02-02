package ru.otus.backend.model.product.discount;

import lombok.*;
import ru.otus.backend.model.customer.Customer;
import ru.otus.backend.model.product.ProductCategory;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "category_customer_discount", schema = "customer")
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class CategoryCustomerDiscount {
    @Id
    @Column(name = "category_customer_discount_id")
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
    @JoinColumn(name = "category_id")
    private ProductCategory productCategory;

    @ManyToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @JoinColumn(name = "customer_id")
    private Customer customer;
}
