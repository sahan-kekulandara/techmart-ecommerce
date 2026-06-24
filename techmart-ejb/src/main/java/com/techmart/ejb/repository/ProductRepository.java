package com.techmart.ejb.repository;

import com.techmart.core.entity.Product;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class ProductRepository {
    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public List<Product> findLatestProducts(int limit) {

        return em.createQuery(
                        "SELECT p FROM Product p ORDER BY p.createdAt DESC",
                        Product.class)
                .setMaxResults(limit)
                .getResultList();
    }
}
