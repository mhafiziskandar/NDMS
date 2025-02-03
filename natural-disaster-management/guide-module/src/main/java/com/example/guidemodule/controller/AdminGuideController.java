package com.example.guidemodule.controller;

import com.example.guidemodule.model.Guide;
import com.example.guidemodule.service.GuideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/guides")
public class AdminGuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping
    public String manageGuides(Model model) {
        model.addAttribute("guides", guideService.getAllGuides());
        return "admin/manage-guides";
    }

    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("guide", new Guide());
        return "admin/create-guide";
    }

    @PostMapping
    public String createGuide(@ModelAttribute Guide guide) {
        guideService.saveGuide(guide);
        return "redirect:/admin/guides";
    }

    @GetMapping("/{id}/delete")
    public String deleteGuide(@PathVariable Long id) {
        guideService.deleteGuide(id);
        return "redirect:/admin/guides";
    }
}
