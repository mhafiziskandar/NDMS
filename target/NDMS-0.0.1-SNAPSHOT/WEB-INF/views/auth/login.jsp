<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
 <meta charset="utf-8">
 <meta name="viewport" content="width=device-width, initial-scale=1">
 <title>NDMS | Log in</title>

 <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/dist/css/adminlte.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/fontawesome-free/css/all.min.css">
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
</head>
<body class="hold-transition login-page">
<div class="login-box">
 <div class="login-logo">
   <a href="#"><b>NDMS</b></a>
 </div>
 <div class="card">
   <div class="card-body login-card-body">
     <p class="login-box-msg">Sign in to start your session</p>

     <form action="${pageContext.request.contextPath}/login" method="post">
       <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
       
       <div class="input-group mb-3">
         <input type="text" name="username" class="form-control" placeholder="Username">
         <div class="input-group-append">
           <div class="input-group-text">
             <span class="fas fa-envelope"></span>
           </div>
         </div>
       </div>
       <div class="input-group mb-3">
         <input type="password" name="password" class="form-control" placeholder="Password">
         <div class="input-group-append">
           <div class="input-group-text">
             <span class="fas fa-lock"></span>
           </div>
         </div>
       </div>
       <div class="row">
         <div class="col-8">
           <div class="icheck-primary">
             <input type="checkbox" id="remember" name="remember-me">
             <label for="remember">Remember Me</label>
           </div>
         </div>
         <div class="col-4">
           <button type="submit" class="btn btn-primary btn-block">Sign In</button>
         </div>
       </div>
     </form>

     <c:if test="${param.error != null}">
       <div class="alert alert-danger mt-3">Invalid username or password.</div>
     </c:if>
   </div>
 </div>
</div>

<script src="${pageContext.request.contextPath}/resources/plugins/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/dist/js/adminlte.min.js"></script>
</body>
</html>