package com.techmart.ejb.repository;

import com.techmart.core.entity.Order;
import com.techmart.core.entity.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class OrderRepository {
    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public void save(Order order) {
        em.persist(order);
    }
}
