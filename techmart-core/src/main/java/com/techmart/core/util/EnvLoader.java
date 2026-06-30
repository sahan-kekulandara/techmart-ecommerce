package com.techmart.core.util;

import io.github.cdimascio.dotenv.Dotenv;
import java.io.File;

public class EnvLoader {

    private static Dotenv dotenv;

    static {
        try {
            String absolutePath = "C:\\Users\\ADMIN\\OneDrive\\Desktop\\lectures\\BCD I\\TechMartModernization";
            File envFile = new File(absolutePath, ".env");

            if (envFile.exists()) {
                dotenv = Dotenv.configure()
                        .directory(envFile.getParent())
                        .filename(".env")
                        .load();
                System.out.println("TechMart Env loaded from direct local absolute path: " + envFile.getAbsolutePath());
            } else {
                System.err.println("TechMart Env Warning: .env file not found at the hardcoded path. Trying standard system fallback.");
                dotenv = Dotenv.configure().ignoreIfMissing().load();
            }
        } catch (Exception e) {
            System.err.println("TechMart Env Error during initialization: " + e.getMessage());
        }
    }

    public static String get(String key, String fallback) {
        if (dotenv != null) {
            String value = dotenv.get(key);
            if (value != null && !value.trim().isEmpty()) {
                return value;
            }
        }
        return fallback;
    }

    public static String get(String key) {
        return get(key, null);
    }
}