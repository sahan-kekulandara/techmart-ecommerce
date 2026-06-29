package com.techmart.core.dto;

import com.techmart.core.enums.CartStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ShoppingCartDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private Long userId;
    private String guestToken;
    private CartStatus status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private List<CartItemDTO> items;
    private Double totalCartPrice;
}