package ru.otus.backend.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestOrderDeliveryDto {
    private String deliveryType;
    private int deliveryId;
}
