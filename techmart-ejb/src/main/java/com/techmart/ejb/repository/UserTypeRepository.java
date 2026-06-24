package com.techmart.ejb.repository;

import com.techmart.core.entity.UserStatus;
import com.techmart.core.entity.UserType;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class UserTypeRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public UserType findTypeById(Long id) {
        return em.find(UserType.class, id);
    }
}
