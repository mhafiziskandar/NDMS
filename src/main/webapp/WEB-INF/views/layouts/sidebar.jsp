<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="#" class="brand-link">
        <span class="brand-text font-weight-light">NDMS</span>
    </a>

    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu">
                <!-- Dashboard - Available to all -->
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/dashboard" class="nav-link">
                        <i class="nav-icon fas fa-tachometer-alt"></i>
                        <p>Dashboard</p>
                    </a>
                </li>

                <!-- Emergency Preparedness - Available to all -->
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/disaster" class="nav-link">
                        <i class="nav-icon fas fa-exclamation-triangle"></i>
                        <p>Emergency Preparedness Module</p>
                    </a>
                </li>

                <!-- Disaster Reporting - Only for regular users -->
                <sec:authorize access="hasRole('ROLE_USER')">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/user/disasters" class="nav-link">
                            <i class="nav-icon fas fa-exclamation-triangle"></i>
                            <p>Disaster Reporting</p>
                        </a>
                    </li>
                </sec:authorize>

                <!-- Alerts and Disaster Status - Only for admins -->
                <sec:authorize access="hasRole('ROLE_ADMIN')">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/admin/alerts" class="nav-link">
                            <i class="nav-icon fas fa-exclamation-triangle"></i>
                            <p>Alerts and Disaster Status</p>
                        </a>
                    </li>
                </sec:authorize>
            </ul>
        </nav>
    </div>
</aside>