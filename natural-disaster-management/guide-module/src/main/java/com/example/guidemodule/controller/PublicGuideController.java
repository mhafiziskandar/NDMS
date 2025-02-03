package com.example.guidemodule.controller;

import com.example.guidemodule.model.Guide;
import com.example.guidemodule.service.GuideService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/public/guides")
public class PublicGuideController {

    @Autowired
    private GuideService guideService;

    @GetMapping
    public String viewGuides(Model model) {
        model.addAttribute("guides", guideService.getAllGuides());
        return "public/view-guides";
    }

    @GetMapping("/{id}")
    public String viewGuideDetails(@PathVariable Long id, Model model) {
        Guide guide = guideService.getGuideById(id);
        model.addAttribute("guide", guide);
        return "public/guide-details";
    }
}
