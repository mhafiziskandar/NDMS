<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Content Wrapper -->
<div class="content-wrapper">
	<!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <!-- <h1>Blank Page</h1> -->
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <!-- <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Blank Page</li> -->
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
    <!-- Main content -->
    <section class="content">
        <div class="container-fluid">
            <!-- Alert Summary Cards -->
            <div class="row">
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-warning">
                        <div class="inner">
                            <h3>${pendingAlerts.size()}</h3>
                            <p>Pending Alerts</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-clock"></i>
                        </div>
                    </div>
                </div>
                <div class="col-lg-3 col-6">
                    <div class="small-box bg-info">
                        <div class="inner">
                            <h3>${verifiedAlerts.size()}</h3>
                            <p>Active Alerts</p>
                        </div>
                        <div class="icon">
                            <i class="fas fa-exclamation-triangle"></i>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Disaster Map Card -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-map-marker-alt mr-1"></i>
                        Active Disasters Map
                    </h3>
                </div>
                <div class="card-body">
                    <div id="map" style="height: 400px;"></div>
                </div>
            </div>

            <!-- Pending Reports Card -->
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title">
                        <i class="fas fa-clock mr-1"></i>
                        Pending Reports
                    </h3>
                </div>
                <div class="card-body">
                    <table id="pendingTable" class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Location</th>
                                <th>Description</th>
                                <th>Severity</th>
                                <th>Reported Time</th>
                                <th>Reported By</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
						    <c:forEach items="${pendingAlerts}" var="alert">
						        <tr>
						            <td>${alert.location}</td>
						            <td>${alert.description}</td>
						            <td>
						                <span class="badge badge-${alert.severity == 'HIGH' ? 'danger' : 
						                    alert.severity == 'MEDIUM' ? 'warning' : 'info'}">
						                    ${alert.severity}
						                </span>
						            </td>
						            <td>
						                <fmt:formatDate value="${alert.reportedTime}" pattern="dd/MM/yyyy HH:mm"/>
						            </td>
						            <td>${alert.reportedBy}</td>
						            <td>
						                <!-- Verify Button -->
						                <button class="btn btn-success btn-sm verify-btn" 
						                        data-id="${alert.id}">
						                    <i class="fas fa-check"></i> Verify
						                </button>
						                <!-- Mark as Resolved Button -->
						                <form action="${pageContext.request.contextPath}/disaster/status" method="post" style="display: inline;">
						                    <input type="hidden" name="id" value="${alert.id}">
						                    <button type="submit" class="btn btn-secondary btn-sm">
						                        <i class="fas fa-times"></i> Mark as Resolved
						                    </button>
						                </form>
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

<!-- Required scripts -->
<script src="https://unpkg.com/leaflet@1.7.1/dist/leaflet.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>

<script>
$(document).ready(function() {
    // Initialize DataTable
    $('#pendingTable').DataTable({
        "paging": true,
        "lengthChange": false,
        "searching": true,
        "ordering": true,
        "info": true,
        "autoWidth": false,
        "responsive": true
    });

    // Initialize map
    var map = L.map('map').setView([4.2105, 101.9758], 6);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
        attribution: '© OpenStreetMap contributors'
    }).addTo(map);

    // Add markers for verified alerts
    <c:forEach items="${verifiedAlerts}" var="alert">
        L.marker([${alert.latitude}, ${alert.longitude}])
         .bindPopup(
            '<b>${alert.location}</b><br>' +
            '${alert.description}<br>' +
            'Severity: ${alert.severity}<br>' +
            'Status: ${alert.status}'
         )
         .addTo(map);
    </c:forEach>

    // Handle verify button click
	$('.verify-btn').click(function() {
	    var button = $(this);
	    var alertId = button.data('id');
	    
	    $.post('/admin/alerts/verify/' + alertId, function(response) {
	        if (response === 'success') {
	            toastr.success('Alert verified successfully');
	            setTimeout(function() {
	                location.reload();
	            }, 1500);
	        } else {
	            toastr.error('Error verifying alert');
	        }
	    });
	});
    
    // Initialize Toast
    var Toast = Swal.mixin({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000
    });
});
</script>