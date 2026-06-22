package com.techmart.ejb.repository;

import com.techmart.core.entity.UserStatus;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class UserStatusRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public UserStatus findStatusById(Long id) {
        return em.find(UserStatus.class, id);
    }
}
