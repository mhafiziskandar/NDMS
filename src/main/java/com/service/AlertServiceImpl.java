package com.service;

import com.model.Alert;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
@Transactional
public class AlertServiceImpl implements AlertService {

    @Autowired
    private SessionFactory sessionFactory;
    
    private String getUsernameById(Long userId) {
        if (userId == null) return "Unknown";
        
        try {
            return sessionFactory.getCurrentSession()
                .createQuery("SELECT u.username FROM User u WHERE u.id = :userId", String.class)
                .setParameter("userId", userId)
                .uniqueResult();
        } catch (Exception e) {
            return "Unknown";
        }
    }

    @Override
    @Transactional
    public void save(Alert alert) {
        sessionFactory.getCurrentSession().saveOrUpdate(alert);
    }

    @Override
    @Transactional(readOnly = true)
    public Alert findById(Long id) {
        return sessionFactory.getCurrentSession().get(Alert.class, id);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Alert> findVerifiedAlerts() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM Alert WHERE verified = true AND status = 'VERIFIED'", Alert.class)
                .getResultList();
    }
    
    @Override
    @Transactional(readOnly = true)
    public List<Alert> findResolvedAlerts() {
        return sessionFactory.getCurrentSession()
            .createQuery("FROM Alert WHERE status = 'RESOLVED'", Alert.class)
            .getResultList();
    }

    @Override
    @Transactional
    public void verifyAlert(Long id) {
        Alert alert = findById(id);
        if (alert != null) {
            alert.setVerified(true);
            alert.setStatus("VERIFIED");
            sessionFactory.getCurrentSession().update(alert);
            sessionFactory.getCurrentSession().flush();
        }
    }

    @Override
    @Transactional
    public void resolveAlert(Long id) {
        Alert alert = findById(id);
        if (alert != null) {
            alert.setStatus("RESOLVED");
            sessionFactory.getCurrentSession().update(alert);
            sessionFactory.getCurrentSession().flush();
        }
    }

    @Override
    @Transactional(readOnly = true)
    public List<Alert> findAllAlerts() {
        List<Alert> alerts = sessionFactory.getCurrentSession()
            .createQuery("FROM Alert ORDER BY reportedTime DESC", Alert.class)
            .getResultList();
            
        for (Alert alert : alerts) {
            alert.setReporterUsername(getUsernameById(alert.getReportedBy()));
        }
        
        return alerts;
    }
    
    @Override
    @Transactional(readOnly = true)
    public List<Alert> findPendingAlerts() {
    	List<Alert> alerts = sessionFactory.getCurrentSession()
    			.createQuery("FROM Alert WHERE verified = false AND status = 'PENDING'", Alert.class)
                .getResultList();
                
            for (Alert alert : alerts) {
                alert.setReporterUsername(getUsernameById(alert.getReportedBy()));
            }
            
            return alerts;
    }
}