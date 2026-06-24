package com.techmart.ejb.repository;

import com.techmart.core.entity.Category;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

@Stateless
public class CategoryRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public List<Category> findAll() {
        return em.createQuery(
                "SELECT c FROM Category c ORDER BY c.category",
                Category.class
        ).getResultList();
    }
}