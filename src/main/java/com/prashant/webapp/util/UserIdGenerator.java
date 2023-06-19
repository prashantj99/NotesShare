package com.prashant.webapp.util;
import java.util.UUID;

public class UserIdGenerator {
    public static String generateUserId() {
        UUID uuid = UUID.randomUUID();
        return uuid.toString();
    }

    public static void main(String[] args) {
        String userId = generateUserId();
        System.out.println("Generated User ID: " + userId);
    }
}
