package com.techmart.api.service;

import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.dto.UserDTO;

public interface OrderService {
    String processPaymentSuccess(ShoppingCartDTO cart, UserDTO userDto, String stripeSessionId, Long addressId);
}
