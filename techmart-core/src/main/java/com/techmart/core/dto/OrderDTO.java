package com.techmart.core.dto;

import com.techmart.core.enums.OrderStatus;
import lombok.*;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderDTO {

    private String id;
    private Long userId;
    private double totalAmount;
    private OrderStatus status;
    private String stripeSessionId;
    private Long shippingAddressId;
    private LocalDateTime createdAt;
    private List<OrderItemDTO> items;
}