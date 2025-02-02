package com.model;

import java.time.LocalDateTime;

public class Disaster {
    private Long id;
    private String location;
    private String description;
    private String severity;
    private boolean verified;
    private String status;
    private Double latitude;
    private Double longitude;
    private String reportedBy;
    private LocalDateTime reportedTime;

    // Default constructor
    public Disaster() {
        this.reportedTime = LocalDateTime.now();
        this.verified = false;
        this.status = "PENDING";
    }

    // Constructor with all fields
    public Disaster(Long id, String location, String description, String severity, 
                   boolean verified, String status, Double latitude, Double longitude, 
                   String reportedBy, LocalDateTime reportedTime) {
        this.id = id;
        this.location = location;
        this.description = description;
        this.severity = severity;
        this.verified = verified;
        this.status = status;
        this.latitude = latitude;
        this.longitude = longitude;
        this.reportedBy = reportedBy;
        this.reportedTime = reportedTime;
    }

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSeverity() {
        return severity;
    }

    public void setSeverity(String severity) {
        this.severity = severity;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public String getReportedBy() {
        return reportedBy;
    }

    public void setReportedBy(String reportedBy) {
        this.reportedBy = reportedBy;
    }

    public LocalDateTime getReportedTime() {
        return reportedTime;
    }

    public void setReportedTime(LocalDateTime reportedTime) {
        this.reportedTime = reportedTime;
    }
}