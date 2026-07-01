package com.techmart.core.mapper;

import com.techmart.core.dto.OrderDTO;
import com.techmart.core.dto.OrderItemDTO;
import com.techmart.core.entity.Order;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@ApplicationScoped
public class OrderMapper {

    @Inject
    private OrderItemMapper orderItemMapper; // Injected exactly like your SubcategoryMapper

    public OrderDTO toDTO(Order entity) {
        if (entity == null) {
            return null;
        }

        OrderDTO dto = new OrderDTO();
        dto.setId(entity.getId());
        dto.setTotalAmount(entity.getTotalAmount()); // Direct double assignment
        dto.setStatus(entity.getStatus());
        dto.setStripeSessionId(entity.getStripeSessionId());
        dto.setCreatedAt(entity.getCreatedAt());

        if (entity.getUser() != null) {
            dto.setUserId(entity.getUser().getId());
        }

        if (entity.getShippingAddress() != null) {
            dto.setShippingAddressId(entity.getShippingAddress().getId());
        }

        // Clean collection mapping using the injected OrderItemMapper
        if (entity.getItems() != null && !entity.getItems().isEmpty()) {
            List<OrderItemDTO> itemDTOs = entity.getItems().stream()
                    .map(item -> {
                        OrderItemDTO itemDto = orderItemMapper.toDTO(item);
                        if (itemDto != null) {
                            itemDto.setOrder(dto); // Link back to parent DTO matching your architectural pattern
                        }
                        return itemDto;
                    })
                    .collect(Collectors.toList());

            dto.setItems(itemDTOs);
        }

        return dto;
    }

    public Order toEntity(OrderDTO dto) {
        if (dto == null) {
            return null;
        }

        Order entity = new Order();
        entity.setId(dto.getId());
        entity.setTotalAmount(dto.getTotalAmount()); // Direct double assignment
        entity.setStatus(dto.getStatus());
        entity.setStripeSessionId(dto.getStripeSessionId());
        entity.setCreatedAt(dto.getCreatedAt());

        return entity;
    }
}