<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Verify Account</title>
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
        .verify-container {
            border-radius: var(--tm-radius);
            overflow: hidden;
        }
        .magic-icon-box {
            width: 70px;
            height: 70px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(13, 110, 253, 0.06);
            color: #0d6efd; /* Bootstrap Primary color */
            border-radius: 50%;
            margin: 0 auto;
        }
        /* Subtle continuous pulse animation to look interactive */
        .pulse-animation {
            animation: pulse 2.5s infinite ease-in-out;
        }
        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.06); opacity: 0.9; }
            100% { transform: scale(1); opacity: 1; }
        }
    </style>
</head>
<body class="py-5">

<div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

    <div class="row gx-4 gx-lg-5 gx-xxl-5安全 gy-5 align-items-center justify-content-center">

        <div class="col-12 col-lg-5 col-xl-5 pe-lg-4 pe-xl-5 text-center text-lg-start d-none d-lg-block">
            <div class="mb-4">
                <img src="images/logo/icon.png" alt="TechMart Brand Icon" class="mb-3" style="height: 60px; width: auto; object-fit: contain;"/>
                <h1 class="display-5 fw-extrabold text-dark tracking-tight">Securing Your Tech Procurement</h1>
                <p class="lead text-secondary">To protect your online catalog interactions and transaction pipelines, we have generated a seamless authentication route straight to your inbox.</p>
            </div>

            <div class="mt-5 p-4 bg-white border border-light rounded-4 shadow-sm" style="background: rgba(255,255,255,0.6) !important;">
                <h6 class="fw-bold text-dark d-flex align-items-center gap-2 mb-2">
                    <i class="bi bi-shield-lock-fill text-primary"></i> Admin Verification Protocols
                </h6>
                <p class="text-muted small m-0">The TechMart admin panel uses passwordless Magic Links to ensure account initialization requests are authenticated securely before store access is granted.</p>
            </div>
        </div>

        <div class="col-12 col-md-9 col-lg-6 col-xl-4 ps-lg-4 ps-xl-5">
            <div class="card tm-card verify-container shadow-sm">
                <div class="row g-0">
                    <div class="col-12 p-4 p-sm-5 bg-white text-center">

                        <div class="mb-4">
                            <div class="magic-icon-box pulse-animation mb-3">
                                <i class="bi bi-magic fs-2"></i>
                            </div>
                            <h3 class="fw-bold text-dark m-0">Check Your Email</h3>
                            <p class="text-muted small mt-2">We just sent a secure access passport directly to your account.</p>
                        </div>


                        <c:if test="${not empty registeredEmail}">
                            <div class="my-4 p-3 rounded-3 bg-light border border-light">
                                <p class="text-muted small m-0">We transmitted a secure sign-in token to:</p>
                                <h6 class="fw-bold text-dark mt-1 mb-0 text-break">${registeredEmail}</h6>
                            </div>
                        </c:if>

                        <p class="text-muted small px-md-3">
                            Click the unique link inside the email to immediately instantiate your dashboard profile. You don't even need to type a password!
                        </p>

                        <div class="mt-4 pt-2 d-grid gap-2">
                            <a href="https://mail.google.com" target="_blank" class="btn btn-primary py-2.5 d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-envelope-paper-fill"></i> Open Mail Inbox
                            </a>

                            <form action="resendLink" method="POST" class="mt-2">
                                <input type="hidden" name="email" value="${param.email}">
                                <p class="text-muted small mb-1">Didn't receive the authentication message?</p>
                                <button type="submit" class="btn btn-link text-decoration-none fw-semibold small p-0 text-primary">
                                    Resend Magic Link
                                </button>
                            </form>
                        </div>

                        <div class="border-top mt-4 pt-3">
                            <a href="login.jsp" class="text-muted small text-decoration-none d-flex align-items-center justify-content-center gap-2">
                                <i class="bi bi-arrow-left"></i> Back to Platform Sign In
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
