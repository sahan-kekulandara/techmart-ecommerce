package com.techmart.core.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CartItemDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long productId;
    private String productTitle;
    private Double productPrice;
    private String productImagePath;
    private Integer quantity;
    private LocalDateTime addedAt;

    public Double getSubTotal() {
        return (productPrice != null && quantity != null) ? productPrice * quantity : 0.0;
    }
}