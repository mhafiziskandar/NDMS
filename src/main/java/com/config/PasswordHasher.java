package com.config;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

public class PasswordHasher {
    public static void main(String[] args) {
        PasswordEncoder encoder = new BCryptPasswordEncoder();
        String rawPassword = "password";
        String hashedPassword = encoder.encode(rawPassword);
        System.out.println("The hashed password for \"" + rawPassword + "\" is:");
        System.out.println(hashedPassword);
    }
}