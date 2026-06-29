package com.techmart.core.mapper;

import com.techmart.core.dto.CartItemDTO;
import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.entity.ShoppingCart;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class ShoppingCartMapper {

    @Inject
    private CartItemMapper itemMapper;

    public ShoppingCartDTO toDTO(ShoppingCart entity) {
        if (entity == null) {
            return null;
        }

        List<CartItemDTO> itemDTOs = new ArrayList<>();
        if (entity.getItems() != null) {
            itemDTOs = entity.getItems().stream()
                    .filter(item -> item != null)
                    .map(itemMapper::toDTO)
                    .collect(Collectors.toList());
        }

        return ShoppingCartDTO.builder()
                .id(entity.getId())
                .userId(entity.getUser() != null ? entity.getUser().getId() : null)
                .guestToken(entity.getGuestToken())
                .status(entity.getStatus())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .items(itemDTOs)
                .totalCartPrice(entity.getTotalCartPrice()) // Calls entity helper method automatically
                .build();
    }
}