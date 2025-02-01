package com.service;

import com.model.Alert;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class AlertServiceImpl {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public void save(Alert alert) {
        getSession().saveOrUpdate(alert);
    }

    public Alert findById(Long id) {
        return getSession().get(Alert.class, id);
    }

    @Transactional(readOnly = true)
    public List<Alert> findPendingAlerts() {
        return getSession()
                .createQuery("FROM Alert WHERE verified = false AND status = 'PENDING'", Alert.class)
                .getResultList();
    }

    @Transactional(readOnly = true)
    public List<Alert> findVerifiedAlerts() {
        return getSession()
                .createQuery("FROM Alert WHERE verified = true AND status = 'VERIFIED'", Alert.class)
                .getResultList();
    }

    @Transactional
    public void verifyAlert(Long id) {
        Alert alert = findById(id);
        if (alert != null) {
            alert.setVerified(true);
            alert.setStatus("VERIFIED");
            save(alert);
        }
    }

    @Transactional
    public void resolveAlert(Long id) {
        Alert alert = findById(id);
        if (alert != null) {
            alert.setStatus("RESOLVED");
            save(alert);
        }
    }
}