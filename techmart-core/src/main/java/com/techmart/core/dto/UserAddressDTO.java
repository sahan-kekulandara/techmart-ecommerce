package com.techmart.core.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserAddressDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long id;
    private UserDTO user;
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String postalCode;
    private String country;
    private Boolean isShipping;
    private Boolean isBilling;
}