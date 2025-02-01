<nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
        </li>
    </ul>

    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown">
            <a class="nav-link" data-toggle="dropdown" href="#">
                <i class="far fa-user"></i>
            </a>
            <div class="dropdown-menu dropdown-menu-right">
                <a href="#" class="dropdown-item">Profile</a>
                <div class="dropdown-divider"></div>
                <a href="javascript:void(0)" class="dropdown-item" onclick="document.getElementById('logout-form').submit();">Logout</a>
				<form id="logout-form" action="${pageContext.request.contextPath}/logout" method="post" style="display: none;">
				    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
            </div>
        </li>
    </ul>
</nav>