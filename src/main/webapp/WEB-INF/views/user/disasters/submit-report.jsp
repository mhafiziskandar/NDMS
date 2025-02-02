<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Content Wrapper -->
<div class="content-wrapper">
    <!-- Content Header -->
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
            <!-- Submit Form Card -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-exclamation-triangle mr-1"></i>
                        Report Details
                    </h3>
                </div>
                <div class="card-body">
                    <form id="disasterForm">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="location">Location:</label>
                                    <input type="text" class="form-control" id="location" name="location" required 
                                           placeholder="e.g., Kuala Lumpur, Bukit Bintang">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="severity">Severity:</label>
                                    <select class="form-control" id="severity" name="severity" required>
                                        <option value="HIGH">High</option>
                                        <option value="MEDIUM">Medium</option>
                                        <option value="LOW">Low</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="latitude">Latitude:</label>
                                    <input type="number" step="any" class="form-control" id="latitude" name="latitude" required 
                                           placeholder="e.g., 3.1478">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="longitude">Longitude:</label>
                                    <input type="number" step="any" class="form-control" id="longitude" name="longitude" required 
                                           placeholder="e.g., 101.7137">
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description:</label>
                            <textarea class="form-control" id="description" name="description" rows="3" required
                                      placeholder="Describe the disaster situation in detail"></textarea>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-paper-plane"></i> Submit Report
                        </button>
                    </form>
                </div>
            </div>

            <!-- Recent Reports Table -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-list mr-1"></i>
                        My Recent Reports
                    </h3>
                </div>
                <div class="card-body">
                    <table id="reportsTable" class="table table-bordered table-striped">
		                <thead>
		                    <tr>
		                        <th>Location</th>
		                        <th>Coordinates</th>
		                        <th>Description</th>
		                        <th>Severity</th>
		                        <th>Status</th>
		                    </tr>
		                </thead>
		                <tbody>
		                    <c:forEach items="${disasters}" var="disaster">
		                        <tr>
		                            <td>${disaster.location}</td>
		                            <td>${disaster.latitude}, ${disaster.longitude}</td>
		                            <td>${disaster.description}</td>
		                            <td>
		                                <span class="badge badge-${disaster.severity == 'HIGH' ? 'danger' : 
		                                    disaster.severity == 'MEDIUM' ? 'warning' : 'info'}">
		                                    ${disaster.severity}
		                                </span>
		                            </td>
		                            <td>
		                                <span class="badge badge-${disaster.status == 'PENDING' ? 'warning' : 
		                                    disaster.status == 'VERIFIED' ? 'success' : 'secondary'}">
		                                    ${disaster.status}
		                                </span>
		                            </td>
		                        </tr>
		                    </c:forEach>
		                </tbody>
		            </table>
                </div>
            </div>
        </div>
    </section>
</div>

<script type="text/javascript">
// Wait for document and all scripts to load
window.addEventListener('load', function() {
    console.log('Window loaded');
    
    if (typeof jQuery !== 'undefined') {
        console.log('jQuery is loaded');
        
        // Initialize DataTable
        if ($.fn.DataTable) {
            console.log('DataTables is loaded');
            $('#reportsTable').DataTable({
                "paging": true,
                "lengthChange": false,
                "searching": true,
                "ordering": true,
                "info": true,
                "autoWidth": false,
                "responsive": true,
                "order": [[5, "desc"]]
            });
        }

        // Configure Toastr
        if (typeof toastr !== 'undefined') {
            console.log('Toastr is loaded');
            toastr.options = {
                "closeButton": true,
                "progressBar": true,
                "positionClass": "toast-top-right",
                "timeOut": "3000"
            };
        }

     // Simplified code sending form data:
        $('#disasterForm').on('submit', function(e) {
            e.preventDefault();
            console.log('Form submitted');

            var submitBtn = $(this).find('button[type="submit"]');
            var originalBtnText = submitBtn.html();
            submitBtn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Submitting...');

            $.ajax({
                url: '${pageContext.request.contextPath}/user/disasters/submit',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    console.log('Response:', response);
                    if (response === 'success') {
                        toastr.success('Report submitted successfully');
                        $('#disasterForm')[0].reset();
                        setTimeout(function() {
                            location.reload();
                        }, 1500);
                    } else {
                        toastr.error('Error: ' + response);
                        submitBtn.prop('disabled', false).html(originalBtnText);
                    }
                },
                error: function(xhr, status, error) {
                    console.error('AJAX Error:', {
                        status: status,
                        error: error,
                        response: xhr.responseText
                    });
                    toastr.error('Submission failed: ' + error);
                    submitBtn.prop('disabled', false).html(originalBtnText);
                }
            });
        });
    } else {
        console.error('jQuery is not loaded!');
    }
});
</script>