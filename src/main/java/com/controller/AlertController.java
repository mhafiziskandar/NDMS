package com.controller;

import com.model.Alert;
import com.service.AlertService;
import java.util.List;
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
        List<Alert> allAlerts = alertService.findAllAlerts();
        List<Alert> pendingAlerts = alertService.findPendingAlerts();
        List<Alert> verifiedAlerts = alertService.findVerifiedAlerts();
        List<Alert> resolvedAlerts = alertService.findResolvedAlerts();

        model.addAttribute("allAlerts", allAlerts);
        model.addAttribute("pendingAlerts", pendingAlerts);
        model.addAttribute("verifiedAlerts", verifiedAlerts);
        model.addAttribute("resolvedAlerts", resolvedAlerts);
        model.addAttribute("content", "/WEB-INF/views/admin/alerts/alerts-dashboard.jsp");
        model.addAttribute("pageTitle", "Alerts Dashboard");
        return "layouts/base";
    }

    @PostMapping("/verify/{id}")
    @ResponseBody
    public String verifyAlert(@PathVariable Long id) {
        System.out.println("Verifying alert with ID: " + id);
        alertService.verifyAlert(id);
        return "success";
    }

    @PostMapping("/resolve/{id}")
    @ResponseBody
    public String resolveAlert(@PathVariable Long id) {
        System.out.println("Resolving alert with ID: " + id);
        alertService.resolveAlert(id);
        return "success";
    }

    @GetMapping("/data")
    @ResponseBody
    public Object getAlertData() {
        return alertService.findVerifiedAlerts();
    }

    @GetMapping("/all")
    @ResponseBody
    public List<Alert> getAllAlerts() {
        return alertService.findAllAlerts();
    }
}