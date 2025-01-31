<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>NDMS | ${pageTitle}</title>
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/adminlte.min.css">
</head>
<body class="hold-transition sidebar-mini">
    <div class="wrapper">
        <jsp:include page="/WEB-INF/views/layouts/header.jsp" />
        <jsp:include page="/WEB-INF/views/layouts/sidebar.jsp" />
        <jsp:include page="${content}" />
        <jsp:include page="/WEB-INF/views/layouts/footer.jsp" />
    </div>

    <script src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/dist/js/adminlte.min.js"></script>
</body>
</html>