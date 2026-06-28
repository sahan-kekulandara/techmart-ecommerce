package com.techmart.ejb.repository;

import com.techmart.core.dto.ProductFilterDTO;
import com.techmart.core.entity.Product;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.List;

@Stateless
public class ProductRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public List<Product> findLatestProducts(int limit) {
        return em.createQuery(
                        "SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.images i " +
                                "ORDER BY p.createdAt DESC", Product.class)
                .setMaxResults(limit)
                .getResultList();
    }

    public List<Product> search(ProductFilterDTO filter) {
        StringBuilder jpql = new StringBuilder(
                "SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.images i WHERE 1=1 "
        );

        if (filter.getSearch() != null && !filter.getSearch().trim().isEmpty()) {
            jpql.append("AND LOWER(p.title) LIKE :keyword ");
        }
        if (filter.getCategoryIds() != null && !filter.getCategoryIds().isEmpty()) {
            jpql.append("AND p.subcategory.category.id IN :categoryIds ");
        }
        if (filter.getMinPrice() != null) {
            jpql.append("AND p.price >= :minPrice ");
        }
        if (filter.getMaxPrice() != null) {
            jpql.append("AND p.price <= :maxPrice ");
        }
        if (Boolean.TRUE.equals(filter.getStockOnly())) {
            jpql.append("AND p.qty > 0 ");
        }

        if ("price_low".equals(filter.getSort())) {
            jpql.append("ORDER BY p.price ASC");
        } else if ("price_high".equals(filter.getSort())) {
            jpql.append("ORDER BY p.price DESC");
        } else {
            jpql.append("ORDER BY p.createdAt DESC");
        }

        TypedQuery<Product> query = em.createQuery(jpql.toString(), Product.class);

        if (filter.getSearch() != null && !filter.getSearch().trim().isEmpty()) {
            query.setParameter("keyword", "%" + filter.getSearch().trim().toLowerCase() + "%");
        }
        if (filter.getCategoryIds() != null && !filter.getCategoryIds().isEmpty()) {
            query.setParameter("categoryIds", filter.getCategoryIds());
        }
        if (filter.getMinPrice() != null) {
            query.setParameter("minPrice", filter.getMinPrice());
        }
        if (filter.getMaxPrice() != null) {
            query.setParameter("maxPrice", filter.getMaxPrice());
        }

        int page = filter.getPage() > 0 ? filter.getPage() : 1;
        int size = filter.getSize() > 0 ? filter.getSize() : 9;
        query.setFirstResult((page - 1) * size);
        query.setMaxResults(size);

        return query.getResultList();
    }

    public long countSearch(ProductFilterDTO filter) {
        StringBuilder jpql = new StringBuilder("SELECT COUNT(p) FROM Product p WHERE 1=1 ");

        if (filter.getSearch() != null && !filter.getSearch().trim().isEmpty()) {
            jpql.append("AND LOWER(p.title) LIKE :keyword ");
        }
        if (filter.getCategoryIds() != null && !filter.getCategoryIds().isEmpty()) {
            jpql.append("AND p.subcategory.category.id IN :categoryIds ");
        }
        if (filter.getMinPrice() != null) {
            jpql.append("AND p.price >= :minPrice ");
        }
        if (filter.getMaxPrice() != null) {
            jpql.append("AND p.price <= :maxPrice ");
        }

        TypedQuery<Long> query = em.createQuery(jpql.toString(), Long.class);

        if (filter.getSearch() != null && !filter.getSearch().trim().isEmpty()) {
            query.setParameter("keyword", "%" + filter.getSearch().trim().toLowerCase() + "%");
        }
        if (filter.getCategoryIds() != null && !filter.getCategoryIds().isEmpty()) {
            query.setParameter("categoryIds", filter.getCategoryIds());
        }
        if (filter.getMinPrice() != null) {
            query.setParameter("minPrice", filter.getMinPrice());
        }
        if (filter.getMaxPrice() != null) {
            query.setParameter("maxPrice", filter.getMaxPrice());
        }

        return query.getSingleResult();
    }

    public List<Product> findAll() {
        return em.createQuery("SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.images", Product.class)
                .getResultList();
    }

    public List<Product> searchSuggestions(String keyword) {
        if (keyword == null || keyword.isBlank()) {
            return List.of();
        }

        String searchParam = keyword.trim().toLowerCase() + "%";
        return em.createQuery(
                        "SELECT DISTINCT p FROM Product p LEFT JOIN FETCH p.images i " +
                                "WHERE LOWER(p.title) LIKE :keyword ORDER BY p.title", Product.class)
                .setParameter("keyword", searchParam)
                .setMaxResults(8)
                .getResultList();
    }
}