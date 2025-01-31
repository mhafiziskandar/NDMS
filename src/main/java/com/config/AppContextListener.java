package com.config;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import org.springframework.web.context.ContextLoaderListener;

public class AppContextListener extends ContextLoaderListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent event) {
        System.out.println("AppContextListener initialized.");
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        System.out.println("AppContextListener destroyed.");
    }
}
