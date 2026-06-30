package com.techmart.ejb.service;

import com.techmart.api.service.UserAddressService;
import com.techmart.core.dto.UserAddressDTO;
import com.techmart.core.entity.UserAddress;
import com.techmart.core.mapper.UserAddressMapper;
import com.techmart.ejb.repository.UserAddressRepository;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;

import java.util.List;
import java.util.stream.Collectors;

@Stateless
public class UserAddressServiceBean implements UserAddressService {

    @EJB
    private UserAddressRepository repository;

    @Inject
    private UserAddressMapper mapper;

    @Override
    public UserAddressDTO findAddressByUserId(Long id) {
        UserAddress entity = repository.findLatestByUserId(id);
        return (entity != null) ? mapper.toDTO(entity) : null;
    }

    @Override
    public void saveOrUpdateProfileAddress(UserAddressDTO dto) {
        UserAddress existingAddress = repository.findLatestByUserId(dto.getUser().getId());

        if (existingAddress != null) {
            existingAddress.setAddressLine1(dto.getAddressLine1());
            existingAddress.setAddressLine2(dto.getAddressLine2());
            existingAddress.setCity(dto.getCity());
            existingAddress.setPostalCode(dto.getPostalCode());
            repository.update(existingAddress);

        } else {
            UserAddress newEntity = mapper.toEntity(dto);
            com.techmart.core.entity.User userEntity = new com.techmart.core.entity.User();
            userEntity.setId(dto.getUser().getId());
            newEntity.setUser(userEntity);

            repository.save(newEntity);
        }
    }

    @Override
    public List<UserAddressDTO> getUserAddresses(Long userId) {
        return repository.findAddressesByUserId(userId).stream()
                .map(mapper::toDTO)
                .collect(Collectors.toList());
    }
}