package com.prashant.webapp.util;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.*;

import java.io.*;
import java.util.Properties;

public class GEmailSender {

//    String path = "mail_properties.properties";

    public static  boolean sendEmail(String path, String to, String from, String subject, String text) {
        boolean flag = false;
        // Load the email properties from the properties file
        Properties props = new Properties();
        try {
            FileInputStream fis = new FileInputStream(path);
            props.load(fis);
            fis.close();
        } catch (IOException e) {
            System.out.println("Error loading email properties: " + e.getMessage());
            return false;
        }
        final String username=props.getProperty("useremail");
        final String password=props.getProperty("userpassword");
        //session
        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        System.out.println("valid"+session);
        try {

            Message message = new MimeMessage(session);
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setFrom(new InternetAddress(from));
            message.setSubject(subject);
            message.setText(text);
            Transport.send(message);
            System.out.print("to "+to);
            System.out.print("to "+from);
            flag = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return flag;
    }

}
