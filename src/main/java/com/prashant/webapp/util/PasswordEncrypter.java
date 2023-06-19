package com.prashant.webapp.util;
import org.mindrot.jbcrypt.BCrypt;

public class PasswordEncrypter {
    public static String hashPassword(String password) {
        // Generate a random salt
        String salt = BCrypt.gensalt(10);

        // Hash the password with the salt
        String hashedPassword = BCrypt.hashpw(password, salt);

        return hashedPassword;
    }

    public static boolean verifyPassword(String password, String hashedPassword) {
        // Verify the password against the hashed password
        boolean isValid = BCrypt.checkpw(password, hashedPassword);

        return isValid;
    }
}
