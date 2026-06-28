package com.techmart.core.mapper;

import com.techmart.core.dto.UserAddressDTO;
import com.techmart.core.entity.UserAddress;
import com.techmart.core.entity.User;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@ApplicationScoped
public class UserAddressMapper {


    @Inject
    private UserMapper userMapper;

    public UserAddressDTO toDTO(UserAddress entity) {
        if (entity == null) {
            return null;
        }

        return UserAddressDTO.builder()
                .id(entity.getId())
                .user(entity.getUser() != null ? userMapper.toDTO(entity.getUser()) : null)
                .addressLine1(entity.getAddressLine1())
                .addressLine2(entity.getAddressLine2())
                .city(entity.getCity())
                .postalCode(entity.getPostalCode())
                .isShipping(entity.getIsShipping())
                .isBilling(entity.getIsBilling())
                .build();
    }

    public UserAddress toEntity(UserAddressDTO dto) {
        if (dto == null) {
            return null;
        }

        UserAddress entity = new UserAddress();
        entity.setId(dto.getId());
        entity.setAddressLine1(dto.getAddressLine1());
        entity.setAddressLine2(dto.getAddressLine2());
        entity.setCity(dto.getCity());
        entity.setPostalCode(dto.getPostalCode());

        if (dto.getIsShipping() != null) entity.setIsShipping(dto.getIsShipping());
        if (dto.getIsBilling() != null) entity.setIsBilling(dto.getIsBilling());

        return entity;
    }
}