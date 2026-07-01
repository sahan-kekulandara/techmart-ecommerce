package com.techmart.api.service;

import com.techmart.core.dto.OrderDTO;
import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.dto.UserDTO;

import java.util.List;

public interface OrderService {
    String processPaymentSuccess(ShoppingCartDTO cart, UserDTO userDto, String stripeSessionId, Long addressId);
    List<OrderDTO> getCustomerOrderHistory(Long userId);
}
