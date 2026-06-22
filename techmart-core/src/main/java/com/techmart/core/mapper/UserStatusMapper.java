package com.techmart.core.mapper;

import com.techmart.core.dto.UserStatusDTO;
import com.techmart.core.entity.UserStatus;

public class UserStatusMapper {
    public static UserStatusDTO toDTO(UserStatus status) {

        if (status == null) {
            return null;
        }

        UserStatusDTO dto = new UserStatusDTO();

        dto.setId(status.getId());
        dto.setStatus(status.getStatus());

        return dto;
    }
}
