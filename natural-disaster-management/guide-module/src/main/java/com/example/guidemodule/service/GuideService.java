package com.example.guidemodule.service;

import com.example.guidemodule.model.Guide;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class GuideService {
    private List<Guide> guides = new ArrayList<>();

    public List<Guide> getAllGuides() {
        return guides;
    }

    public Guide getGuideById(Long id) {
        return guides.stream().filter(guide -> guide.getId().equals(id)).findFirst().orElse(null);
    }

    public void saveGuide(Guide guide) {
        guide.setId((long) (guides.size() + 1));
        guides.add(guide);
    }

    public void deleteGuide(Long id) {
        guides.removeIf(guide -> guide.getId().equals(id));
    }
}
