package com.techmart.ejb.repository;

import com.techmart.core.entity.UserAddress;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.NoResultException;

import java.util.List;

@Stateless
public class UserAddressRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public UserAddress findLatestByUserId(Long userId) {
        try {
            return em.createQuery(
                            "SELECT a FROM UserAddress a WHERE a.user.id = :userId ORDER BY a.id DESC", UserAddress.class)
                    .setParameter("userId", userId)
                    .setMaxResults(1)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public void save(UserAddress address) {
        em.persist(address);
    }

    public void update(UserAddress address) {
        em.merge(address);
    }

    public List<UserAddress> findAddressesByUserId(Long userId) {
        return em.createQuery(
                        "SELECT a FROM UserAddress a WHERE a.user.id = :userId",
                        com.techmart.core.entity.UserAddress.class)
                .setParameter("userId", userId)
                .getResultList();
    }
}