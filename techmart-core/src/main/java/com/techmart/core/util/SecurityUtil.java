package com.techmart.core.util;

import java.security.SecureRandom;
import java.util.UUID;

public final class SecurityUtil {

    public static String generateVerificationToken() {
        return UUID.randomUUID().toString();
    }
}