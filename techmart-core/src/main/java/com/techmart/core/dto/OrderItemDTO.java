package com.techmart.core.dto;

import lombok.*;
import java.math.BigDecimal;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderItemDTO {

    private Long id;
    private Long productId;
    private int quantity;
    private double priceAtPurchase;
    private OrderDTO order;
}