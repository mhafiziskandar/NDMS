package com.controller;

import com.service.AlertService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/alerts")
public class AlertController {

    @Autowired
    private AlertService alertService;

    @GetMapping
    public String showAlertDashboard(Model model) {
        // Set data for the alerts page
        model.addAttribute("pendingAlerts", alertService.findPendingAlerts());
        model.addAttribute("verifiedAlerts", alertService.findVerifiedAlerts());
        
        // Set attributes for the base template
        model.addAttribute("content", "/WEB-INF/views/admin/alerts/alerts-dashboard.jsp");
        model.addAttribute("pageTitle", "Alerts Dashboard");

        // Return the base layout
        return "layouts/base";
    }

    @PostMapping("/verify/{id}")
    @ResponseBody
    public String verifyAlert(@PathVariable Long id) {
        try {
            alertService.verifyAlert(id);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    @PostMapping("/resolve/{id}")
    @ResponseBody
    public String resolveAlert(@PathVariable Long id) {
        try {
            alertService.resolveAlert(id);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    @GetMapping("/data")
    @ResponseBody
    public Object getAlertData() {
        return alertService.findVerifiedAlerts();
    }
}