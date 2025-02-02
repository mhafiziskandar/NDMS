package com.service;

import com.model.Alert;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Transactional
public interface AlertService {
    void save(Alert alert);
    Alert findById(Long id);
    List<Alert> findPendingAlerts();
    List<Alert> findVerifiedAlerts();
    List<Alert> findResolvedAlerts();
    void verifyAlert(Long id);
    void resolveAlert(Long id);
    List<Alert> findAllAlerts();
}