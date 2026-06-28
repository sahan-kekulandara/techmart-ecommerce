package com.techmart.api.service;

import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.User;

public interface UserService {
    void register(UserDTO user);
    void userVerify(String token);
    UserDTO login(String email,String password);
    public boolean updatePassword(Long userId, String oldPassword, String newPassword, String confirmPassword);
}
