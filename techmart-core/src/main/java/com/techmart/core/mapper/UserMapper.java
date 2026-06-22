package com.techmart.core.mapper;

import com.techmart.core.dto.UserDTO;
import com.techmart.core.dto.UserStatusDTO;
import com.techmart.core.entity.User;

public class UserMapper {

    private UserMapper() {
    }

    public static UserDTO toDTO(User user) {

        if (user == null) {
            return null;
        }

        UserDTO dto = new UserDTO();

        dto.setId(user.getId());
        dto.setFirstName(user.getFirstName());
        dto.setLastName(user.getLastName());
        dto.setEmail(user.getEmail());
        dto.setPassword(user.getPassword());
        dto.setCreatedAt(user.getCreatedAt());

        UserStatusDTO statusDTO = UserStatusMapper.toDTO(user.getUserStatus());
        dto.setUserStatus(statusDTO);

        return dto;
    }
}