package com.techmart.core.mapper;

import com.techmart.core.dto.UserTypeDTO;
import com.techmart.core.entity.UserType;
import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class UserTypeMapper {

    public UserTypeDTO toDTO(UserType entity) {
        if (entity == null) {
            return null;
        }

        UserTypeDTO dto = new UserTypeDTO();
        dto.setId(entity.getId());
        dto.setType(entity.getType());

        return dto;
    }

    public UserType toEntity(UserTypeDTO dto) {
        if (dto == null) {
            return null;
        }

        UserType entity = new UserType();
        entity.setId(dto.getId());
        entity.setType(dto.getType());

        return entity;
    }
}