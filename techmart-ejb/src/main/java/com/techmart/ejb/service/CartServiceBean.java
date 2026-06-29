package com.techmart.ejb.service;

import com.techmart.api.service.CartService;
import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.entity.CartItem;
import com.techmart.core.entity.Product;
import com.techmart.core.entity.ShoppingCart;
import com.techmart.core.enums.CartStatus;
import com.techmart.core.mapper.ShoppingCartMapper;
import com.techmart.ejb.repository.CartItemRepository;
import com.techmart.ejb.repository.CartRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.ArrayList;
import java.util.List;

@Stateless
public class CartServiceBean implements CartService {

    @PersistenceContext
    private EntityManager em;

    @Inject
    private CartRepository cartRepository;

    @Inject
    private CartItemRepository cartItemRepository;

    @Inject
    private ShoppingCartMapper cartMapper;

    @Override
    public void addItemToCart(String guestToken, Long userId, Long productId, Integer quantity) {
        Product product = em.find(Product.class, productId);
        if (product == null || product.getQty() < quantity) {
            throw new IllegalArgumentException("Requested hardware stock is unavailable.");
        }

        ShoppingCart cart = cartRepository.findActiveCart(guestToken, userId);

        if (cart == null) {
            cart = new ShoppingCart();
            cart.setStatus(CartStatus.ACTIVE);
            cart.setGuestToken(guestToken);
        }

        CartItem existingItem = null;
        for (CartItem item : cart.getItems()) {
            if (item.getProduct().getId().equals(productId)) {
                existingItem = item;
                break;
            }
        }

        if (existingItem != null) {
            existingItem.setQuantity(existingItem.getQuantity() + quantity);
        } else {
            CartItem newItem = new CartItem();
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            cart.addItem(newItem);
        }
        cartRepository.save(cart);
    }

    @Override
    public ShoppingCartDTO getActiveCart(String guestToken, Long userId) {
        ShoppingCart cart = cartRepository.findActiveCart(guestToken, userId);

        if (cart == null) {
            return ShoppingCartDTO.builder()
                    .items(new ArrayList<>())
                    .totalCartPrice(0.0)
                    .build();
        }

        return cartMapper.toDTO(cart);
    }

    @Override
    public void updateItemQuantity(Long cartItemId, String actionIndicator) {
        CartItem item = cartItemRepository.findItemById(cartItemId);
        if (item == null) {
            throw new IllegalArgumentException("Cart line item could not be found.");
        }

        int currentQty = item.getQuantity();

        if ("increase".equalsIgnoreCase(actionIndicator)) {
            if (currentQty >= item.getProduct().getQty()) {
                throw new IllegalStateException("Cannot exceed maximum available warehouse stock.");
            }
            item.setQuantity(currentQty + 1);

        } else if ("decrease".equalsIgnoreCase(actionIndicator)) {
            if (currentQty > 1) {
                item.setQuantity(currentQty - 1);
            }
        }

        item.getShoppingCart().setUpdatedAt(java.time.LocalDateTime.now());
        cartRepository.save(item.getShoppingCart());
    }

    @Override
    public void removeItemFromCart(Long cartItemId) {
        CartItem item = em.find(CartItem.class, cartItemId);

        if (item != null) {
            ShoppingCart cart = item.getShoppingCart();

            if (cart != null) {
                cart.getItems().remove(item);
                cart.setUpdatedAt(java.time.LocalDateTime.now());
            }

            em.remove(item);
            if (cart != null) {
                em.merge(cart);
            }
        }
    }


    @Override
    public void mergeCart(String guestToken, Long userId) {
        if (guestToken == null || userId == null) return;

        ShoppingCart guestCart = cartRepository.findActiveCart(guestToken, null);
        if (guestCart == null || guestCart.getItems().isEmpty()) {
            return;
        }

        ShoppingCart userCart = cartRepository.findActiveCart(null, userId);
        if (userCart == null) {
            userCart = new ShoppingCart();
            userCart.setStatus(CartStatus.ACTIVE);
            userCart.setUser(em.find(com.techmart.core.entity.User.class, userId));
            em.persist(userCart);
        }

        List<CartItem> guestItems = new ArrayList<>(guestCart.getItems());

        for (CartItem guestItem : guestItems) {
            Product product = guestItem.getProduct();

            CartItem existingUserItem = null;
            for (CartItem userItem : userCart.getItems()) {
                if (userItem.getProduct().getId().equals(product.getId())) {
                    existingUserItem = userItem;
                    break;
                }
            }

            if (existingUserItem != null) {
                int combinedQty = existingUserItem.getQuantity() + guestItem.getQuantity();
                existingUserItem.setQuantity(Math.min(combinedQty, product.getQty()));

                guestCart.removeItem(guestItem);
                em.remove(guestItem);
            } else {
                guestCart.removeItem(guestItem);
                userCart.addItem(guestItem);
            }
        }

        guestCart.setStatus(CartStatus.MERGED);
        guestCart.setUpdatedAt(java.time.LocalDateTime.now());
        userCart.setUpdatedAt(java.time.LocalDateTime.now());

        em.merge(guestCart);
        em.merge(userCart);
    }
}