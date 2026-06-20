package com.techmart.ejb.service;

import com.techmart.core.entity.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class UserService {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public void save(User user){
        em.persist(user);
    }
}
