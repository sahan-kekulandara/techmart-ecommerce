package com.techmart.core.mapper;

import com.techmart.core.dto.OrderItemDTO;
import com.techmart.core.entity.OrderItem;
import com.techmart.core.entity.ProductImage;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class OrderItemMapper {

    public OrderItemDTO toDTO(OrderItem entity) {
        if (entity == null) {
            return null;
        }

        OrderItemDTO dto = new OrderItemDTO();
        dto.setId(entity.getId());
        dto.setQuantity(entity.getQuantity());
        dto.setPriceAtPurchase(entity.getPriceAtPurchase());
        dto.setProductName(entity.getProduct().getTitle());

        if (entity.getProduct() != null) {
            dto.setProductId(entity.getProduct().getId());
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

        dto.setImagePath(targetPath);

        return dto;
    }

    public OrderItem toEntity(OrderItemDTO dto) {
        if (dto == null) {
            return null;
        }

        OrderItem entity = new OrderItem();
        entity.setId(dto.getId());
        entity.setQuantity(dto.getQuantity());
        entity.setPriceAtPurchase(dto.getPriceAtPurchase()); // Direct double assignment

        return entity;
    }
}