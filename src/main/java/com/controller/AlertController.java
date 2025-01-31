package com.controller;

import com.service.AlertServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/alerts")
public class AlertController {

    @Autowired
    private AlertServiceImpl alertService;

    @GetMapping
    public String showAlertDashboard(Model model) {
        model.addAttribute("pendingAlerts", alertService.findPendingAlerts());
        model.addAttribute("verifiedAlerts", alertService.findVerifiedAlerts());
        model.addAttribute("content", "/WEB-INF/views/admin/alerts/alerts-dashboard.jsp");
        model.addAttribute("pageTitle", "Alerts Dashboard");
        return "layouts/base";
    }

    @PostMapping("/verify/{id}")
    @ResponseBody
    public String verifyAlert(@PathVariable Long id) {
        alertService.verifyAlert(id);
        return "success";
    }

    @PostMapping("/resolve/{id}")
    @ResponseBody
    public String resolveAlert(@PathVariable Long id) {
        alertService.resolveAlert(id);
        return "success";
    }

    @GetMapping("/data")
    @ResponseBody
    public Object getAlertData() {
        return alertService.findVerifiedAlerts();
    }
}