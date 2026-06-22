package com.techmart.ejb.service;

import com.techmart.api.service.EmailService;
import com.techmart.api.service.UserService;
import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.User;
import com.techmart.core.entity.UserStatus;
import com.techmart.core.enums.UserStatusType;
import com.techmart.core.util.SecurityUtil;
import com.techmart.core.util.ValidationUtil;
import com.techmart.ejb.repository.UserRepository;
import com.techmart.ejb.repository.UserStatusRepository;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;

import java.sql.Timestamp;
import java.time.Instant;

@Stateless
public class UserServiceBean implements UserService {

    @EJB
    private UserRepository repository;

    @EJB
    private UserStatusRepository statusRepository;

    @EJB
    private EmailService emailService;

    @Override
    public void register(UserDTO userDTO) {

        if (userDTO.getFirstName() == null || userDTO.getFirstName().isBlank()) {
            throw new RuntimeException("Please enter your First Name");
        } else if (userDTO.getLastName() == null || userDTO.getLastName().isBlank()) {
            throw new RuntimeException("Please enter your Last Name");
        } else if (userDTO.getEmail() == null || userDTO.getEmail().isBlank()) {
            throw new RuntimeException("Please enter your Email");
        } else if (!ValidationUtil.isValidEmail(userDTO.getEmail())) {
            throw new RuntimeException("Invalid email.");
        } else if (repository.existsByEmail(userDTO.getEmail())) {
            throw new RuntimeException("Email already exists");
        } else if (userDTO.getPassword() == null || userDTO.getPassword().isBlank()) {
            throw new RuntimeException("Please enter your Password");
        } else if (!ValidationUtil.isValidPassword(userDTO.getPassword())) {
            throw new RuntimeException(
                    "Password must contain at least " +
                            "8 characters, one uppercase letter, " +
                            "one lowercase letter and one number.");
        } else {
            User user = new User();
            user.setFirstName(userDTO.getFirstName());
            user.setLastName(userDTO.getLastName());
            user.setEmail(userDTO.getEmail());
            user.setPassword(userDTO.getPassword());

            String token = SecurityUtil.generateVerificationToken();
            user.setVerificationToken(token);

            user.setCreatedAt(Timestamp.from(Instant.now()));

            UserStatus status = statusRepository.findStatusById(UserStatusType.UNVERIFIED.getId());
            user.setUserStatus(status);

            String link =
                    "http://localhost:8080/techmart/verify?token="
                            + token;

            emailService.sendVerificationEmail(user.getEmail(), link);
            repository.save(user);
        }
    }

    @Override
    public void userVerify(String token) {
        User user = repository.findByToken(token);

        if (user == null) {
            throw new RuntimeException(
                    "Invalid verification link.");
        }

        UserStatus status = statusRepository.findStatusById(UserStatusType.VERIFIED.getId());

        user.setUserStatus(status);
        user.setVerificationToken(null);
        repository.update(user);
    }

}