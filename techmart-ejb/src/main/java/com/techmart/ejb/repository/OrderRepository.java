package com.techmart.ejb.repository;

import com.techmart.core.entity.Order;
import com.techmart.core.entity.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.List;

@Stateless
public class OrderRepository {
    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public void save(Order order) {
        em.persist(order);
    }

    public List<Order> findOrdersByUserId(Long userId) {
        try {
            TypedQuery<Order> query = em.createQuery("SELECT DISTINCT o FROM Order o LEFT JOIN FETCH o.items WHERE o.user.id = :userId ORDER BY o.createdAt DESC", Order.class);
            query.setParameter("userId", userId);
            return query.getResultList();
        } catch (NullPointerException e) {
            return null;
        }
    }
}
