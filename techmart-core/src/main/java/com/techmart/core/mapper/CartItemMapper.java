package com.techmart.core.mapper;

import com.techmart.core.dto.CartItemDTO;
import com.techmart.core.entity.CartItem;
import com.techmart.core.entity.ProductImage;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class CartItemMapper {

    public CartItemDTO toDTO(CartItem entity) {
        if (entity == null) {
            return null;
        }

        String targetPath = "products/placeholder.jpg"; // Default fallback
        if (entity.getProduct() != null && entity.getProduct().getImages() != null) {
            for (ProductImage img : entity.getProduct().getImages()) {
                if (img != null) {
                    if (img.getIsPrimary() || "products/placeholder.jpg".equals(targetPath)) {
                        targetPath = img.getImagePath();
                    }
                }
            }
        }

        return CartItemDTO.builder()
                .id(entity.getId())
                .productId(entity.getProduct() != null ? entity.getProduct().getId() : null)
                .productTitle(entity.getProduct() != null ? entity.getProduct().getTitle() : "Unknown Hardware Asset")
                .productPrice(entity.getProduct() != null ? entity.getProduct().getPrice() : 0.0)
                .productImagePath(targetPath)
                .quantity(entity.getQuantity())
                .addedAt(entity.getAddedAt())
                .build();
    }
}