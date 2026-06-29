package com.techmart.api.service;

import com.techmart.core.dto.ShoppingCartDTO;
import jakarta.ejb.Remote;

@Remote
public interface CartService {
    public void addItemToCart(String guestToken, Long userId, Long productId, Integer quantity);
    ShoppingCartDTO getActiveCart(String guestToken, Long userId);

    void updateItemQuantity(Long cartItemId, String actionIndicator);

    void removeItemFromCart(Long cartItemId);

    void mergeCart(String guestToken, Long userId);
}
