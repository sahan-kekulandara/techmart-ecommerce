package com.techmart.api.service;

import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.User;

public interface UserService {
    public void register(UserDTO user);
    public void userVerify(String token);
}
