package com.controller;

import com.model.Disaster;
import com.model.User;
import com.service.DisasterService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/user/disasters")
public class DisasterController {

    @Autowired
    private DisasterService disasterService;
    
    @Autowired
    private UserService userService;

    @GetMapping
    public String showReportForm(Model model) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        // Get user ID from username
        User user = userService.findByUsername(auth.getName());
        System.out.println("Current user ID: " + user.getId());

        model.addAttribute("disasters", disasterService.findDisastersByUserId(String.valueOf(user.getId())));
        model.addAttribute("content", "/WEB-INF/views/user/disasters/submit-report.jsp");
        model.addAttribute("pageTitle", "Submit Disaster Report");
        
        return "layouts/base";
    }

    @PostMapping("/submit")
    @ResponseBody
    public String submitReport(String location, String description, String severity, 
                             Double latitude, Double longitude) {
        try {
            System.out.println("Received report submission");
            
            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            User user = userService.findByUsername(auth.getName());
            System.out.println("Submitting for user ID: " + user.getId());

            Disaster disaster = new Disaster();
            disaster.setLocation(location);
            disaster.setDescription(description);
            disaster.setSeverity(severity);
            disaster.setLatitude(latitude);
            disaster.setLongitude(longitude);
            disaster.setReportedBy(String.valueOf(user.getId())); // Convert ID to string
            disaster.setReportedTime(LocalDateTime.now());
            disaster.setVerified(false);
            disaster.setStatus("PENDING");

            boolean success = disasterService.addDisaster(disaster);
            System.out.println("Submission result: " + success);
            
            return success ? "success" : "error";
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error: " + e.getMessage());
            return "error";
        }
    }
}