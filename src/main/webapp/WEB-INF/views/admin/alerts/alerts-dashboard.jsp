<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
	#map {
	    height: 400px !important;
	    width: 100% !important;
	    border: 1px solid #ddd;
	    margin-bottom: 20px;
	    position: relative !important;
	    z-index: 0;
	}
	
	.leaflet-container {
	    z-index: 1 !important;
	}
	
	.leaflet-popup {
	    z-index: 1000 !important;
	}
	
	.map-popup {
	    padding: 10px;
	    min-width: 200px;
	}
	
	.map-popup h6 {
	    margin-bottom: 8px;
	    font-weight: bold;
	}
	
	.map-popup p {
	    margin-bottom: 5px;
	}
	
	.leaflet-marker-icon {
	    z-index: 1000 !important;
	}
	
	.modal-header {
	    color: white;
	}
	
	.modal-header .close {
	    color: white;
	    opacity: 0.8;
	}
	
	.modal-header .close:hover {
	    opacity: 1;
	}
	
	.btn .fas.fa-spinner {
	    margin-right: 5px;
	}
</style>

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
			    <div class="col-lg-3 col-6">
			        <div class="small-box bg-success">
			            <div class="inner">
			                <h3>${resolvedAlerts.size()}</h3>
			                <p>Resolved Alerts</p>
			            </div>
			            <div class="icon">
			                <i class="fas fa-check-circle"></i>
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
						            <td>${alert.formattedReportedTime}</td>
						            <td>${alert.reporterUsername}</td>
						            <td>
						                <!-- Verify Button -->
						                <button class="btn btn-success btn-sm verify-btn" data-id="${alert.id}">
						                    <i class="fas fa-check"></i> Verify
						                </button>
						                
						                <!-- Mark as Resolved Button -->
					                    <button class="btn btn-secondary btn-sm resolve-btn" data-id="${alert.id}">
					                        <i class="fas fa-times"></i> Resolve
					                    </button>
						            </td>
						        </tr>
						    </c:forEach>
						</tbody>
					</table>
                </div>
            </div>
            
            <!-- All Alerts -->
			<div class="card">
			    <div class="card-header">
			        <h3 class="card-title">
			            <i class="fas fa-list mr-1"></i>
			            All Alerts
			        </h3>
			    </div>
			    <div class="card-body">
			        <table id="allAlertsTable" class="table table-bordered table-striped">
			            <thead>
			                <tr>
			                    <th>Location</th>
			                    <th>Description</th>
			                    <th>Severity</th>
			                    <th>Status</th>
			                    <th>Reported Time</th>
			                    <th>Reported By</th>
			                    <th>Actions</th>
			                </tr>
			            </thead>
			            <tbody>
			                <c:forEach items="${allAlerts}" var="alert">
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
			                            <span class="badge badge-${alert.status == 'PENDING' ? 'warning' : 
			                                alert.status == 'VERIFIED' ? 'success' : 'secondary'}">
			                                ${alert.status}
			                            </span>
			                        </td>
			                        <td>${alert.formattedReportedTime}</td>
			                        <td>${alert.reporterUsername}</td>
			                        <td>
			                            <c:if test="${alert.status == 'PENDING'}">
			                                <button class="btn btn-success btn-sm verify-btn" 
			                                        data-id="${alert.id}">
			                                    <i class="fas fa-check"></i> Verify
			                                </button>
			                            </c:if>
			                            <c:if test="${alert.status != 'RESOLVED'}">
			                                <button class="btn btn-secondary btn-sm resolve-btn" 
			                                        data-id="${alert.id}">
			                                    <i class="fas fa-times"></i> Resolve
			                                </button>
			                            </c:if>
			                            <button class="btn btn-info btn-sm locate-btn" 
										        data-id="${alert.id}"
										        data-lat="${alert.latitude}" 
										        data-lng="${alert.longitude}">
										    <i class="fas fa-map-marker-alt"></i> Locate
										</button>
			                        </td>
			                    </tr>
			                </c:forEach>
			            </tbody>
			        </table>
			    </div>
			</div>
			
			<!-- Verify Modal -->
			<div class="modal fade" id="verifyModal" tabindex="-1" role="dialog">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header bg-info">
			                <h5 class="modal-title">Verify Alert</h5>
			                <button type="button" class="close" data-dismiss="modal">
			                    <span>&times;</span>
			                </button>
			            </div>
			            <div class="modal-body">
			                <p>Are you sure you want to verify this alert?</p>
			                <p class="text-muted">This action will mark the alert as verified in the system.</p>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
			                <button type="button" class="btn btn-info" id="confirmVerify">
			                    <i class="fas fa-check"></i> Verify
			                </button>
			            </div>
			        </div>
			    </div>
			</div>
			
			<!-- Resolve Modal -->
			<div class="modal fade" id="resolveModal" tabindex="-1" role="dialog">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header bg-secondary">
			                <h5 class="modal-title">Resolve Alert</h5>
			                <button type="button" class="close" data-dismiss="modal">
			                    <span>&times;</span>
			                </button>
			            </div>
			            <div class="modal-body">
			                <p>Are you sure you want to resolve this alert?</p>
			                <p class="text-muted">This will mark the alert as resolved and remove it from active alerts.</p>
			            </div>
			            <div class="modal-footer">
			                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
			                <button type="button" class="btn btn-primary" id="confirmResolve">
			                    <i class="fas fa-check"></i> Resolve
			                </button>
			            </div>
			        </div>
			    </div>
			</div>
        </div>
    </section>
</div>

<script>
	document.addEventListener('DOMContentLoaded', function() {
		$(document).ready(function() {
		    // Debug logging
		    console.log("Initializing dashboard...");
		
		    // Initialize DataTables
		    $('#pendingTable, #allAlertsTable').DataTable({
		        "paging": true,
		        "lengthChange": false,
		        "searching": true,
		        "ordering": true,
		        "info": true,
		        "autoWidth": false,
		        "responsive": true,
		        "pageLength": 10
		    });
		
		 	// Initialize map
		    var map = L.map('map', {
		        center: [4.2105, 101.9758],
		        zoom: 6,
		        minZoom: 5,
		        maxZoom: 18
		    });
		
		    // Add tile layer and ensure it loads
		    var tileLayer = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
		        attribution: '© OpenStreetMap contributors',
		        maxZoom: 19
		    }).addTo(map);
		
		    // Debug log when tile layer loads
		    tileLayer.on('load', function() {
		        console.log("Map tiles loaded successfully");
		    });
		
		 	// Store markers with alert IDs as keys
		    var markers = {};
		
		    // Add markers for all alerts
		    <c:forEach items="${allAlerts}" var="alert">
		        try {
		            var lat = ${alert.latitude};
		            var lng = ${alert.longitude};
		            
		            console.log("Adding marker:", {
		                id: ${alert.id},
		                lat: lat,
		                lng: lng,
		                location: "${alert.location}"
		            });
		
		            if (!isNaN(lat) && !isNaN(lng)) {
		                var marker = L.marker([lat, lng]);
		                
		                var popupContent = `
		                    <div class="map-popup">
		                        <h6 class="font-weight-bold mb-2">${alert.location}</h6>
		                        <p class="mb-2">${alert.description}</p>
		                        <div class="mb-2">
		                            <strong>Status:</strong> 
		                            <span class="badge badge-${alert.status == 'PENDING' ? 'warning' : 
		                                alert.status == 'VERIFIED' ? 'success' : 'secondary'}">
		                                ${alert.status}
		                            </span>
		                        </div>
		                        <div class="mb-2">
		                            <strong>Severity:</strong> 
		                            <span class="badge badge-${alert.severity == 'HIGH' ? 'danger' : 
		                                alert.severity == 'MEDIUM' ? 'warning' : 'info'}">
		                                ${alert.severity}
		                            </span>
		                        </div>
		                        <div class="mt-2">
		                            <strong>Reported:</strong><br/>
		                            ${alert.formattedReportedTime}
		                        </div>
		                    </div>
		                `;
		                
		                marker.bindPopup(popupContent);
		                marker.addTo(map);
		                markers[${alert.id}] = marker;
		            } else {
		                console.error("Invalid coordinates for alert ID ${alert.id}:", { lat, lng });
		            }
		        } catch (e) {
		            console.error("Error adding marker for alert ID ${alert.id}:", e);
		        }
		    </c:forEach>
		
		    // After all markers are added, fit bounds if there are any markers
		    setTimeout(function() {
		        map.invalidateSize();
		        
		        var markerArray = Object.values(markers);
		        if (markerArray.length > 0) {
		            var group = L.featureGroup(markerArray);
		            map.fitBounds(group.getBounds().pad(0.1));
		        }
		        
		        console.log("Total markers added:", markerArray.length);
		    }, 500);
		
		    // Handle locate button click
		    $('.locate-btn').click(function() {
		        var btn = $(this);
		        var lat = parseFloat(btn.data('lat'));
		        var lng = parseFloat(btn.data('lng'));
		        var alertId = btn.data('id');
		        
		        console.log("Locate clicked:", { lat, lng, alertId });
		
		        if (isNaN(lat) || isNaN(lng)) {
		            toastr.error('Invalid coordinates for this location');
		            return;
		        }
		
		        // Zoom to location
		        map.setView([lat, lng], 15, {
		            animate: true,
		            duration: 1
		        });
		
		        // Find and open the marker's popup
		        if (markers[alertId]) {
		            markers[alertId].openPopup();
		        }
		    });
		    
		    var selectedAlertId = null;
		    
		    $(document).on('click', '.verify-btn', function(e) {
		        e.preventDefault();
		        selectedAlertId = $(this).data('id');
		        $('#verifyModal').modal('show');
		    });
			
			// Handle verify confirmation
			$('#confirmVerify').click(function() {
			    if (!selectedAlertId) return;
			    
			    var btn = $(this);
			    btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Verifying...');
			    
			    $.ajax({
			        url: '${pageContext.request.contextPath}/admin/alerts/verify/' + selectedAlertId,
			        method: 'POST',
			        success: function(response) {
			            if (response === 'success') {
			                $('#verifyModal').modal('hide');
			                toastr.success('Alert verified successfully');
			                setTimeout(function() {
			                    location.reload();
			                }, 1000);
			            } else {
			                toastr.error('Error verifying alert');
			                btn.prop('disabled', false).html('<i class="fas fa-check"></i> Verify');
			            }
			        },
			        error: function(xhr, status, error) {
			            console.error("Verify error:", error);
			            toastr.error('Failed to verify alert: ' + error);
			            btn.prop('disabled', false).html('<i class="fas fa-check"></i> Verify');
			        }
			    });
			});
			
			// Handle resolve button click
			$(document).on('click', '.resolve-btn', function(e) {
		        e.preventDefault();
		        selectedAlertId = $(this).data('id');
		        $('#resolveModal').modal('show');
		    });
			
			// Handle resolve confirmation
			$('#confirmResolve').click(function() {
			    if (!selectedAlertId) return;
			    
			    var btn = $(this);
			    btn.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Resolving...');
			    
			    $.ajax({
			        url: '${pageContext.request.contextPath}/admin/alerts/resolve/' + selectedAlertId,
			        method: 'POST',
			        success: function(response) {
			            if (response === 'success') {
			                $('#resolveModal').modal('hide');
			                toastr.success('Alert resolved successfully');
			                setTimeout(function() {
			                    location.reload();
			                }, 1000);
			            } else {
			                toastr.error('Error resolving alert');
			                btn.prop('disabled', false).html('<i class="fas fa-check"></i> Resolve');
			            }
			        },
			        error: function(xhr, status, error) {
			            console.error("Resolve error:", error);
			            toastr.error('Failed to resolve alert: ' + error);
			            btn.prop('disabled', false).html('<i class="fas fa-check"></i> Resolve');
			        }
			    });
			});
	
			 // Reset selected alert ID when modals are closed
			 $('#verifyModal, #resolveModal').on('hidden.bs.modal', function() {
			     selectedAlertId = null;
			     $(this).find('button').prop('disabled', false).html(function() {
			         return $(this).data('original-html') || $(this).html();
			     });
			 });
		
		    // Configure Toastr notifications
		    toastr.options = {
		        "closeButton": true,
		        "progressBar": true,
		        "positionClass": "toast-top-right",
		        "timeOut": "3000"
		    };
		
		    // Handle map resize on tab/modal changes
		    setTimeout(function() {
		        map.invalidateSize();
		    }, 100);
		
		    // Add map click debugging
		    map.on('click', function(e) {
		        console.log("Map clicked at:", e.latlng);
		    });
		
		    // Log when initialization is complete
		    console.log("Dashboard initialization complete");
		});
	});
</script>