package com.techmart.ejb.repository;

import com.techmart.core.entity.CartItem;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;


@Stateless
public class CartItemRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public CartItem findItemById(Long cartItemId) {
        return em.find(CartItem.class, cartItemId);
    }
}
