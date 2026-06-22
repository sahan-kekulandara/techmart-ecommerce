package com.techmart.api.service;

public interface EmailService {
    void sendVerificationEmail(String email, String verificationLink);
}

