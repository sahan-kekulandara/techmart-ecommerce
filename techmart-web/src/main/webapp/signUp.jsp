<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String error = (String) request.getAttribute("error");
    String firstName = (String) request.getAttribute("firstName");
    String lastName = (String) request.getAttribute("lastName");
    String email = (String) request.getAttribute("email");

    if (firstName == null) firstName = "";
    if (lastName == null) lastName = "";
    if (email == null) email = "";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Create Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="images/logo/icon.png" rel="icon">

    <style>
        body {
            min-height: 100vh;
            display: flex;
            align-items: center;
            background-color: var(--tm-bg-workspace);
        }

        .signup-container {
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
                <h1 class="display-5 fw-extrabold text-dark tracking-tight">Turn Procurement Into Strategy</h1>
                <p class="lead text-secondary">Experience the real-time enterprise e-commerce platform built to unify
                    suppliers, manage distributed inventories, and streamline corporate tech distribution.</p>
            </div>

            <div class="d-flex flex-column gap-4 d-none d-lg-flex mt-5">
                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-lightning-charge-fill fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Real-Time Inventory Management</h6>
                        <p class="text-muted small m-0">Synchronize supply channels instantly using transaction-safe
                            atomic tracking mechanisms.</p>
                    </div>
                </div>

                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-shield-check-fill fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Enterprise-Grade Architecture</h6>
                        <p class="text-muted small m-0">Built upon component-driven distributed enterprise systems with
                            strict transactional guarantees.</p>
                    </div>
                </div>

                <div class="d-flex gap-3 align-items-start">
                    <div class="feature-icon-box flex-shrink-0">
                        <i class="bi bi-graph-up-arrow fs-5"></i>
                    </div>
                    <div>
                        <h6 class="fw-bold text-dark mb-1">Predictive Resource Scalability</h6>
                        <p class="text-muted small m-0">Scale seamlessly with robust asynchronous pipelines handling
                            burst message ordering loads.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-md-9 col-lg-6 col-xl-5 ps-lg-5 ps-xl-5">
            <div class="card tm-card signup-container shadow-sm">
                <div class="row g-0">
                    <div class="col-12 p-4 p-sm-5 bg-white">

                        <div class="mb-4">
                            <h3 class="fw-bold text-dark m-0">Get Started</h3>
                            <p class="text-muted small mt-1">
                                Already have an account?
                                <a href="login.jsp" class="text-decoration-none fw-semibold">
                                    Sign In instead
                                </a>
                            </p>
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

                        <form action="signup" method="POST" class="needs-validation" novalidate>
                            <div class="row g-3">
                                <div class="col-sm-6">
                                    <label for="firstName" class="form-label">First Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text"
                                               class="form-control"
                                               id="firstName"
                                               name="firstName"
                                               placeholder="John"
                                               required
                                               maxlength="45"
                                               value="<%= firstName %>">
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <label for="lastName" class="form-label">Last Name</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                                        <input type="text"
                                               class="form-control"
                                               id="lastName"
                                               name="lastName"
                                               placeholder="Doe"
                                               required
                                               maxlength="45"
                                               value="<%= lastName %>">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label for="email" class="form-label">Email Address</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                        <input type="email"
                                               class="form-control"
                                               id="email"
                                               name="email"
                                               placeholder="name@company.com"
                                               required
                                               maxlength="100"
                                               value="<%= email %>">
                                    </div>
                                </div>

                                <div class="col-12">
                                    <label for="password" class="form-label">Password</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password"
                                               placeholder="••••••••" required maxlength="20">
                                    </div>
                                    <div class="form-text text-muted small mt-1">Must be 8-20 characters long.</div>
                                </div>

                                <input type="hidden" name="userStatusId" value="1">

                                <div class="col-12 mt-2">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                        <label class="form-check-label text-muted small" for="termsCheck">
                                            I agree to the TechMart enterprise user platform agreements.
                                        </label>
                                    </div>
                                </div>

                                <div class="col-12 mt-4">
                                    <button class="btn btn-primary w-100 py-2.5" type="submit">
                                        Register New Account
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