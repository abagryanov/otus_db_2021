package ru.otus.backend.dto.order;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RequestCreateOrderDto {
    private RequestOrderDeliveryDto deliveryInfo;
    private Set<RequestSubOrderDto> subOrders;
}
