package com.techmart.core.mapper;

import com.techmart.core.dto.SubcategoryDTO;
import com.techmart.core.entity.Subcategory;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class SubcategoryMapper {

    @Inject
    private CategoryMapper categoryMapper;

    public SubcategoryDTO toDTO(Subcategory entity) {
        if (entity == null) {
            return null;
        }

        SubcategoryDTO dto = new SubcategoryDTO();
        dto.setId(entity.getId());
        dto.setSubcategory(entity.getSubcategory());

        if (entity.getCategory() != null) {
            dto.setCategory(categoryMapper.toDTO(entity.getCategory()));
        }

        return dto;
    }

    public Subcategory toEntity(SubcategoryDTO dto) {
        if (dto == null) {
            return null;
        }

        Subcategory entity = new Subcategory();
        entity.setId(dto.getId());
        entity.setSubcategory(dto.getSubcategory());

        if (dto.getCategory() != null) {
            entity.setCategory(categoryMapper.toEntity(dto.getCategory()));
        }

        return entity;
    }
}