package com.techmart.core.mapper;

import com.techmart.core.dto.ProductStatusDTO;
import com.techmart.core.entity.Product;
import com.techmart.core.entity.ProductStatus;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class ProductStatusMapper {

    public ProductStatusDTO toDTO(ProductStatus entity) {
        if (entity == null) {
            return null;
        }

        ProductStatusDTO dto = new ProductStatusDTO();
        dto.setId(entity.getId());
        dto.setStatus(entity.getStatus());

        return dto;
    }

    public ProductStatus toEntity(ProductStatusDTO dto) {
        if (dto == null) {
            return null;
        }

        ProductStatus entity = new ProductStatus();
        entity.setId(dto.getId());
        entity.setStatus(dto.getStatus());

        return entity;
    }
}