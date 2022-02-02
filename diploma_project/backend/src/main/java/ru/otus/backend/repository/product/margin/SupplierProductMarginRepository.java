package ru.otus.backend.repository.product.margin;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import ru.otus.backend.model.product.margin.SupplierProductMargin;

@Repository
public interface SupplierProductMarginRepository extends JpaRepository<SupplierProductMargin, Integer> {
}
