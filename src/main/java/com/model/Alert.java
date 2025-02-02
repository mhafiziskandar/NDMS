package com.model;

import javax.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "alerts")
public class Alert {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    private String location;
    private String description;
    private String severity;
    
    @Column(name = "reported_time")
    private LocalDateTime reportedTime;
    
    private boolean verified;
    private String status;  // PENDING, VERIFIED, RESOLVED
    private double latitude;
    private double longitude;
    
    @Column(name = "reported_by")
    private Long reportedBy;
    
    public Alert() {
        this.reportedTime = LocalDateTime.now();
        this.verified = false;
        this.status = "PENDING";
    }
    
    // Update the getter and setter for reportedBy
    public Long getReportedBy() { return reportedBy; }
    public void setReportedBy(Long reportedBy) { this.reportedBy = reportedBy; }
    
    // Rest of getters and setters remain the same
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }
    
    public LocalDateTime getReportedTime() { return reportedTime; }
    public void setReportedTime(LocalDateTime reportedTime) { this.reportedTime = reportedTime; }
    
    public String getFormattedReportedTime() {
        if (this.reportedTime == null) return "";
        return this.reportedTime.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
    }
    
    public boolean isVerified() { return verified; }
    public void setVerified(boolean verified) { this.verified = verified; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public double getLatitude() { return latitude; }
    public void setLatitude(double latitude) { this.latitude = latitude; }
    
    public double getLongitude() { return longitude; }
    public void setLongitude(double longitude) { this.longitude = longitude; }
    
    @Transient  // This field won't be persisted to the database
    private String reporterUsername;
    
    // Add getters and setters for the new field
    public String getReporterUsername() {
        return reporterUsername;
    }
    
    public void setReporterUsername(String reporterUsername) {
        this.reporterUsername = reporterUsername;
    }
}