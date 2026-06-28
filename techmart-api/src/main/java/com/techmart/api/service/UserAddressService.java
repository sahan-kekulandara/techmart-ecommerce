package com.techmart.api.service;

import com.techmart.core.dto.UserAddressDTO;

public interface UserAddressService {
    UserAddressDTO findAddressByUserId(Long id);
    void saveOrUpdateProfileAddress(UserAddressDTO dto);
}
