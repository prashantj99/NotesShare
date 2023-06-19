package com.prashant.webapp.util;
import java.util.Random;

public class OTPGenerator {

    private static final int OTP_LENGTH = 6;

    public static String generateOTP() {
        // Defining the characters allowed in the OTP
        String allowedChars = "0123456789";

        Random random = new Random();
        StringBuilder otp = new StringBuilder();

        // Generate random digits for the OTP
        for (int i = 0; i < OTP_LENGTH; i++) {
            int index = random.nextInt(allowedChars.length());
            otp.append(allowedChars.charAt(index));
        }

        return otp.toString();
    }

//    public static void main(String[] args) {
//        String otp = generateOTP();
//        System.out.println("Generated OTP: " + otp);
//    }
}
