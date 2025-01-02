package com.service;

import com.model.Alert;
import org.springframework.jdbc.core.RowMapper;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AlertRowMapper implements RowMapper<Alert> {
    @Override
    public Alert mapRow(ResultSet rs, int rowNum) throws SQLException {
        Alert alert = new Alert();
        alert.setId(rs.getLong("id"));
        alert.setLocation(rs.getString("location"));
        alert.setDescription(rs.getString("description"));
        alert.setSeverity(rs.getString("severity"));
        alert.setReportedTime(rs.getTimestamp("reported_time").toLocalDateTime());
        alert.setVerified(rs.getBoolean("verified"));
        alert.setStatus(rs.getString("status"));
        alert.setLatitude(rs.getDouble("latitude"));
        alert.setLongitude(rs.getDouble("longitude"));
        alert.setReportedBy(rs.getString("reported_by"));
        return alert;
    }
}