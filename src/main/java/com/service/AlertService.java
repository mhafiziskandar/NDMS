package com.service;

import com.model.Alert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class AlertService {
    
    @Autowired
    private JdbcTemplate jdbcTemplate;
    
    public void save(Alert alert) {
        if (alert.getId() == null) {
            jdbcTemplate.update(
                "INSERT INTO alerts (location, description, severity, reported_time, verified, status, latitude, longitude, reported_by) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
                alert.getLocation(), alert.getDescription(), alert.getSeverity(), alert.getReportedTime(), alert.isVerified(),
                alert.getStatus(), alert.getLatitude(), alert.getLongitude(), alert.getReportedBy()
            );
        } else {
            jdbcTemplate.update(
                "UPDATE alerts SET location=?, description=?, severity=?, reported_time=?, verified=?, status=?, latitude=?, longitude=?, reported_by=? WHERE id=?",
                alert.getLocation(), alert.getDescription(), alert.getSeverity(), alert.getReportedTime(), alert.isVerified(),
                alert.getStatus(), alert.getLatitude(), alert.getLongitude(), alert.getReportedBy(), alert.getId()
            );
        }
    }

    public Alert findById(Long id) {
        return jdbcTemplate.queryForObject(
            "SELECT * FROM alerts WHERE id = ?",
            new Object[]{id},
            new AlertRowMapper()
        );
    }
    
    public List<Alert> findPendingAlerts() {
        return jdbcTemplate.query(
            "SELECT * FROM alerts WHERE verified = false AND status = 'PENDING'",
            new AlertRowMapper()
        );
    }
    
    public List<Alert> findVerifiedAlerts() {
        return jdbcTemplate.query(
            "SELECT * FROM alerts WHERE verified = true AND status = 'VERIFIED'",
            new AlertRowMapper()
        );
    }
    
    public void verifyAlert(Long id) {
        jdbcTemplate.update(
            "UPDATE alerts SET verified = true, status = 'VERIFIED' WHERE id = ?",
            id
        );
    }
    
    public void resolveAlert(Long id) {
        jdbcTemplate.update(
            "UPDATE alerts SET status = 'RESOLVED' WHERE id = ?",
            id
        );
    }
}