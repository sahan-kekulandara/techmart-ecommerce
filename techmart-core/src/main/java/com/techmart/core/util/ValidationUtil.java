package com.techmart.core.util;

public final class ValidationUtil {

    public static boolean isValidEmail(String email) {
        if (email == null || email.isBlank()) {
            return false;
        }

        return email.matches(
                "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    }

    public static boolean isValidPassword(String password) {
        if (password == null) {
            return false;
        }
        return password.matches(
                "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,20}$");
    }
}
