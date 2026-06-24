package com.techmart.core.mapper;

import com.techmart.core.dto.ProductDTO;
import com.techmart.core.entity.Product;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class ProductMapper {

    @Inject
    private SubcategoryMapper subcategoryMapper;

    @Inject
    private ProductStatusMapper productStatusMapper;

    public ProductDTO toDTO(Product entity) {
        if (entity == null) {
            return null;
        }

        ProductDTO dto = new ProductDTO();
        dto.setId(entity.getId());
        dto.setTitle(entity.getTitle());
        dto.setDescription(entity.getDescription());
        dto.setPrice(entity.getPrice());
        dto.setQty(entity.getQty());
        dto.setCreatedAt(entity.getCreatedAt());

        if (entity.getSubcategory() != null) {
            dto.setSubcategory(subcategoryMapper.toDTO(entity.getSubcategory()));
        }

        if (entity.getProductStatus() != null) {
            dto.setProductStatus(productStatusMapper.toDTO(entity.getProductStatus()));
        }

        return dto;
    }

    public Product toEntity(ProductDTO dto) {
        if (dto == null) {
            return null;
        }

        Product entity = new Product();
        entity.setId(dto.getId());
        entity.setTitle(dto.getTitle());
        entity.setDescription(dto.getDescription());
        entity.setPrice(dto.getPrice());
        entity.setQty(dto.getQty());
        entity.setCreatedAt(dto.getCreatedAt());

        if (dto.getSubcategory() != null) {
            entity.setSubcategory(subcategoryMapper.toEntity(dto.getSubcategory()));
        }

        if (dto.getProductStatus() != null) {
            entity.setProductStatus(productStatusMapper.toEntity(dto.getProductStatus()));
        }

        return entity;
    }
}