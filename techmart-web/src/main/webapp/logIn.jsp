<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 6/22/2026
  Time: 1:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String error = (String) request.getAttribute("error");
    String email = (String) request.getAttribute("email");

    if (email == null) email = "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Sign In</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="style.css" rel="stylesheet">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            background-color: var(--tm-bg-workspace);
        }

        .login-container {
            border-radius: var(--tm-radius);
            overflow: hidden;
        }

        .feature-icon-box {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(13, 110, 253, 0.1);
            color: var(--tm-primary);
            border-radius: 0.5rem;
        }
    </style>
</head>
<body class="py-5">

<div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

    <div class="row gx-4 gx-lg-5 gx-xxl-5 gy-5 align-items-center justify-content-center">

        <div class="col-12 col-lg-5 col-xl-5 pe-lg-4 pe-xl-5">
            <div class="mb-4 text-center text-lg-start">
                <img src="images/logo/icon.png" alt="TechMart Brand Icon" class="mb-3"
                     style="height: 60px; width: auto; object-fit: contain;"/>
                <h1 class="display-5 fw-extrabold text-dark tracking-tight">Your Tech Hub, Managed & Delivered</h1>
                <p class="lead text-secondary">Log in to TechMart to explore the premium technology marketplace. Gain
                    real-time access to user shopping tracks, accessory lines, or manage central operations
                    instantly.</p>
            </div>

            <div class="d-flex flex-column gap-4 d-none d-lg-flex mt-5">
                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-laptop fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Premium Electronics Catalog</h6>
                        <p class="text-muted small m-0">Browse through thousands of high-end devices, retail computers,
                            and specialized modern tech accessories.</p>
                    </div>
                </div>

                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-sliders fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Centralized Admin Authority</h6>
                        <p class="text-muted small m-0">Administrators maintain complete programmatic authority over
                            catalog rows, order approval matrices, and store rules.</p>
                    </div>
                </div>

                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-cart-check-fill fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Frictionless Checkout Management</h6>
                        <p class="text-muted small m-0">Process transactional states securely with automated dispatch
                            notifications and order histories.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-9 col-lg-6 col-xl-4 ps-lg-4 ps-xl-5">
            <div class="card tm-card login-container shadow-sm">
                <div class="row g-0">
                    <div class="col-12 p-4 p-sm-5 bg-white">
                        <div class="mb-4">
                            <h3 class="fw-bold text-dark m-0">Welcome Back</h3>
                            <p class="text-muted small mt-1">New to our platform? <a href="signUp.jsp"
                                                                                     class="text-decoration-none fw-semibold">Create
                                an Account</a></p>
                        </div>

                        <% if (error != null) { %>
                        <div class="alert alert-danger alert-dismissible fade show mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i>
                            <%= error %>

                            <button type="button"
                                    class="btn-close"
                                    data-bs-dismiss="alert"></button>
                        </div>
                        <% } %>

                        <form action="login" method="POST" class="needs-validation" novalidate>
                            <div class="row g-3">

                                <div class="col-12">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email"
                                               placeholder="name@company.com" required maxlength="100"
                                               value="<%= email%>">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label for="password" class="form-label m-0">Password</label>
                                        <a href="#" class="text-decoration-none small text-muted">Forgot Password?</a>
                                    </div>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password"
                                               placeholder="••••••••" required maxlength="20">
                                    </div>
                                </div>

                                <div class="col-12 mt-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="rememberMe"
                                               name="rememberMe">
                                        <label class="form-check-label text-muted small" for="rememberMe">
                                            Keep me logged into this device
                                        </label>
                                    </div>
                                </div>

                                <div class="col-12 mt-4">
                                    <button class="btn btn-primary w-100 py-2.5" type="submit">
                                        Sign In to Store
                                    </button>
                                </div>

                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>