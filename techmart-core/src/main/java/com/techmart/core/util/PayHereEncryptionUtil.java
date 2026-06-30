package com.techmart.core.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

public class PayHereEncryptionUtil {

    public static String generateCheckoutHash(String merchantId, String orderId, double amount, String currency, String merchantSecret) {
        try {
            DecimalFormat df = new DecimalFormat("0.00", new DecimalFormatSymbols(Locale.US));
            String formattedAmount = df.format(amount);

            String hashedSecret = md5Upper(merchantSecret);

            String payload = merchantId + orderId + formattedAmount + currency + hashedSecret;

            return md5Upper(payload);

        } catch (Exception e) {
            throw new RuntimeException("Failed to generate PayHere security hash chain", e);
        }
    }

    private static String md5Upper(String input) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] digest = md.digest(input.getBytes());
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(String.format("%02X", b)); // Hexadecimal uppercase format
        }
        return sb.toString();
    }
}