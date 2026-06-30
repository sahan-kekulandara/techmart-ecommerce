package com.techmart.api.service;

import com.techmart.core.dto.UserAddressDTO;
import com.techmart.core.entity.UserAddress;

import java.util.List;

public interface UserAddressService {
    UserAddressDTO findAddressByUserId(Long id);
    void saveOrUpdateProfileAddress(UserAddressDTO dto);
    List<UserAddressDTO> getUserAddresses(Long userId);
}
