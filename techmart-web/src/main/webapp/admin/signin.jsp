<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Admin Workspace Sign In</title>
    <!-- Core UI Design System Alignments -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            min-height: 100vh;
        }
        .auth-card {
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
        }
        .brand-logo {
            height: 40px;
            width: auto;
            object-fit: contain;
        }
    </style>
</head>
<body class="d-flex align-items-center justify-content-center py-5">

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-sm-10 col-md-8 col-lg-5 col-xl-4">

            <!-- TechMart Brand Identifier Header -->
            <div class="text-center mb-4">
                <div class="d-inline-flex align-items-center gap-2 fw-extrabold text-dark fs-2 tracking-tight mb-2">
                    <img src="${pageContext.request.contextPath}/icon.png" alt="TechMart" class="brand-logo"/>
                    <span>Tech<span class="text-primary">Mart</span></span>
                </div>
                <p class="text-secondary small">Operations Center Identity Gateway</p>
            </div>

            <!-- Main Authorization Form Wrapper -->
            <div class="card auth-card shadow-sm bg-white p-4 p-sm-5">
                <div class="mb-4">
                    <h4 class="fw-extrabold text-dark m-0">Sign In</h4>
                    <p class="text-muted small m-0 mt-1">Provide platform manager administrative credentials.</p>
                </div>

                <!-- DYNAMIC CONTEXT EXCEPTION ALERT HANDLER -->
                <!-- This intercepts errors passed from your backend authentication servlet block -->
                <c:if test="${not empty requestScope.errorMessage}">
                    <div class="alert alert-danger d-flex align-items-center gap-2 border-0 small py-2.5 rounded-3 mb-4" role="alert">
                        <i class="bi bi-exclamation-octagon-fill"></i>
                        <div><c:out value="${requestScope.errorMessage}"/></div>
                    </div>
                </c:if>

                <!-- Authentication Security Processing Target Route -->
                <form action="${pageContext.request.contextPath}/login" method="POST">

                    <!-- Hidden flag telling your backend servlet to process this login as an Admin check -->
                    <input type="hidden" name="loginType" value="ADMIN_WORKSPACE">

                    <div class="mb-3">
                        <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider">Manager Email</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="email" name="email" class="form-control bg-light border-start-0 py-2 shadow-none small"
                                   placeholder="admin@techmart.com" required autocomplete="email">
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider m-0">Security Password</label>
                            <a href="#" class="text-decoration-none small text-muted fw-medium">Recovery</a>
                        </div>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-shield-lock"></i></span>
                            <input type="password" name="password" class="form-control bg-light border-start-0 py-2 shadow-none small"
                                   placeholder="••••••••" required autocomplete="current-password">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2.5 fw-semibold rounded-3 shadow-sm d-flex align-items-center justify-content-center gap-2">
                        <span>Access Management Platform</span> <i class="bi bi-arrow-right"></i>
                    </button>
                </form>
            </div>

            <!-- Footer Return Navigation Map Links -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-secondary small fw-medium d-inline-flex align-items-center gap-1">
                    <i class="bi bi-arrow-left"></i> Return to Storefront Marketplace
                </a>
            </div>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>