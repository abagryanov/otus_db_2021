package ru.otus.backend.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestSubOrderDto {
    private int productId;
    private double amount;
}
