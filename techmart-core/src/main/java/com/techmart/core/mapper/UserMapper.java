package com.techmart.core.mapper;

import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;

@ApplicationScoped
public class UserMapper {

    @Inject
    private UserStatusMapper userStatusMapper;

    @Inject
    private UserTypeMapper userTypeMapper;

    public UserDTO toDTO(User entity) {
        if (entity == null) {
            return null;
        }

        UserDTO dto = new UserDTO();
        dto.setId(entity.getId());
        dto.setFirstName(entity.getFirstName());
        dto.setLastName(entity.getLastName());
        dto.setEmail(entity.getEmail());
        dto.setPassword(entity.getPassword());
        dto.setCreatedAt(entity.getCreatedAt());

        if (entity.getUserStatus() != null) {
            dto.setUserStatus(userStatusMapper.toDTO(entity.getUserStatus()));
        }

        if (entity.getUserType() != null) {
            dto.setUserType(userTypeMapper.toDTO(entity.getUserType()));
        }

        return dto;
    }

    public User toEntity(UserDTO dto) {
        if (dto == null) {
            return null;
        }

        User entity = new User();
        entity.setId(dto.getId());
        entity.setFirstName(dto.getFirstName());
        entity.setLastName(dto.getLastName());
        entity.setEmail(dto.getEmail());
        entity.setPassword(dto.getPassword());
        entity.setCreatedAt(dto.getCreatedAt());

        if (dto.getUserStatus() != null) {
            entity.setUserStatus(userStatusMapper.toEntity(dto.getUserStatus()));
        }

        if (dto.getUserType() != null) {
            entity.setUserType(userTypeMapper.toEntity(dto.getUserType()));
        }

        return entity;
    }
}