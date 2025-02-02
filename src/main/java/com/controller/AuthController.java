package com.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Controller
public class AuthController {

    @GetMapping("/login")
    public String login() {
        return "auth/login";
    }
    
    @PostMapping("/login")
    public String loginSubmit(Authentication authentication) {
        // Check if user has ADMIN role
        if (authentication != null && authentication.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/NDMS/views/admin/alerts/alerts-dashboard.jsp";
        }
        return "redirect:/login?error";
    }
    
    @GetMapping("/login-success")
    public String loginSuccess(Authentication authentication) {
        if (authentication != null && authentication.getAuthorities().stream()
                .anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            return "redirect:/NDMS/views/admin/alerts/alerts-dashboard.jsp";
        }
        return "redirect:/NDMS/views/user/disasters/submit-report.jsp";  // Default redirect for non-admin users
    }
}