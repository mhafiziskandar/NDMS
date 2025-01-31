<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Content Wrapper -->
<div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1>Submit Disaster Report</h1>
                </div>
            </div>
        </div>
    </section>

    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <!-- Form for submitting a report -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">Report a Disaster</h3>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/disaster/report" method="post">
                        <div class="form-group">
                            <label for="location">Location:</label>
                            <input type="text" class="form-control" id="location" name="location" required>
                        </div>
                        <div class="form-group">
                            <label for="severity">Severity:</label>
                            <select class="form-control" id="severity" name="severity" required>
                                <option value="HIGH">High</option>
                                <option value="MEDIUM">Medium</option>
                                <option value="LOW">Low</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea class="form-control" id="description" name="description" rows="5" required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Submit Report</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</div>
