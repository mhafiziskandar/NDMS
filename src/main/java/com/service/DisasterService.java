package com.service;

import com.model.Disaster;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class DisasterService {
    
    @Autowired
    private DataSource dataSource;
    
    public List<Disaster> findDisastersByUserId(String userId) {
        String sql = "SELECT * FROM alerts WHERE reported_by = ? ORDER BY reported_time DESC";
        List<Disaster> disasters = new ArrayList<>();
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                disasters.add(mapResultSetToDisaster(rs));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return disasters;
    }
    
    public boolean addDisaster(Disaster disaster) {
        String sql = "INSERT INTO alerts (location, description, severity, verified, status, " +
                    "latitude, longitude, reported_by, reported_time) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, disaster.getLocation());
            stmt.setString(2, disaster.getDescription());
            stmt.setString(3, disaster.getSeverity());
            stmt.setBoolean(4, false);
            stmt.setString(5, "PENDING");
            stmt.setDouble(6, disaster.getLatitude() != null ? disaster.getLatitude() : 0.0);
            stmt.setDouble(7, disaster.getLongitude() != null ? disaster.getLongitude() : 0.0);
            stmt.setInt(8, Integer.parseInt(disaster.getReportedBy())); // Convert string ID to integer
            stmt.setTimestamp(9, Timestamp.valueOf(disaster.getReportedTime()));
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Disaster getDisasterById(Long id) {
        String sql = "SELECT * FROM alerts WHERE id = ?";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setLong(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToDisaster(rs);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateDisaster(Disaster disaster) {
        String sql = "UPDATE alerts SET location = ?, description = ?, severity = ?, " +
                    "verified = ?, status = ?, latitude = ?, longitude = ?, " +
                    "reported_by = ?, reported_time = ? WHERE id = ?";
                    
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, disaster.getLocation());
            stmt.setString(2, disaster.getDescription());
            stmt.setString(3, disaster.getSeverity());
            stmt.setBoolean(4, disaster.isVerified());
            stmt.setString(5, disaster.getStatus());
            stmt.setDouble(6, disaster.getLatitude() != null ? disaster.getLatitude() : 0.0);
            stmt.setDouble(7, disaster.getLongitude() != null ? disaster.getLongitude() : 0.0);
            stmt.setString(8, disaster.getReportedBy());
            stmt.setTimestamp(9, Timestamp.valueOf(disaster.getReportedTime()));
            stmt.setLong(10, disaster.getId());
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteDisaster(Long id) {
        String sql = "DELETE FROM alerts WHERE id = ?";
        
        try (Connection conn = dataSource.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setLong(1, id);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Disaster mapResultSetToDisaster(ResultSet rs) throws SQLException {
        Disaster disaster = new Disaster();
        disaster.setId(rs.getLong("id"));
        disaster.setLocation(rs.getString("location"));
        disaster.setDescription(rs.getString("description"));
        disaster.setSeverity(rs.getString("severity"));
        disaster.setVerified(rs.getBoolean("verified"));
        disaster.setStatus(rs.getString("status"));
        disaster.setLatitude(rs.getDouble("latitude"));
        disaster.setLongitude(rs.getDouble("longitude"));
        disaster.setReportedBy(rs.getString("reported_by"));
        disaster.setReportedTime(rs.getTimestamp("reported_time").toLocalDateTime());
        return disaster;
    }
}