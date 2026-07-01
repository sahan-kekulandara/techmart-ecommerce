package com.techmart.ejb.repository;

import com.techmart.core.entity.ShoppingCart;
import com.techmart.core.enums.CartStatus;
import jakarta.ejb.Stateless;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import java.util.List;

@Stateless
public class CartRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public ShoppingCart findActiveCart(String guestToken, Long userId) {
        String jpql = "SELECT c FROM ShoppingCart c WHERE c.status = :status ";
        if (userId != null) {
            jpql += "AND c.user.id = :userId";
        } else {
            jpql += "AND c.guestToken = :guestToken";
        }

        TypedQuery<ShoppingCart> query = em.createQuery(jpql, ShoppingCart.class)
                .setParameter("status", CartStatus.ACTIVE);

        if (userId != null) {
            query.setParameter("userId", userId);
        } else {
            query.setParameter("guestToken", guestToken);
        }

        List<ShoppingCart> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    public void save(ShoppingCart cart) {
        if (cart.getId() == null) {
            em.persist(cart);
        } else {
            em.merge(cart);
        }
    }

    public void clearCartItems(Long cartId) {
        em.createQuery("DELETE FROM CartItem ci WHERE ci.shoppingCart.id = :cartId")
                .setParameter("cartId", cartId)
                .executeUpdate();
    }
}