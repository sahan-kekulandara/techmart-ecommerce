package com.techmart.ejb.repository;

import com.techmart.core.entity.User;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;

@Stateless
public class UserRepository {

    @PersistenceContext(unitName = "TechMartPU")
    private EntityManager em;

    public void save(User user) {
        em.persist(user);
    }

    public boolean existsByEmail(String email) {

        Long count = em.createQuery(
                        "SELECT COUNT(u) FROM User u WHERE u.email=:email",
                        Long.class)
                .setParameter("email", email)
                .getSingleResult();

        return count > 0;
    }

    public User findByToken(String token) {

        try {
            return em.createQuery(
                            "SELECT u FROM User u " +
                                    "WHERE u.verificationToken = :token AND u.userStatus.status = :status",
                            User.class)
                    .setParameter("token", token).setParameter("status","unverified")
                    .getSingleResult();

        } catch (NoResultException e) {
            return null;
        }
    }

    public User update(User user) {
        return em.merge(user);
    }

    public User findById(Long id) {
        return em.find(User.class, id);
    }

    public void delete(User user) {
        em.remove(em.contains(user) ? user : em.merge(user));
    }
}