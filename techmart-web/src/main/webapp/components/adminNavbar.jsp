<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 6/22/2026
  Time: 10:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav class="navbar navbar-expand-lg bg-white border-bottom py-3 sticky-top">
    <!-- Matches the exact responsive layout padding used on your signup, login, and dashboard screens -->
    <div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

        <!-- Brand Logo/Identity Alignment -->
        <a class="navbar-brand d-flex align-items-center gap-2 fw-extrabold text-dark fs-4 tracking-tight" href="index.jsp">
            <img src="icon.png" alt="TechMart" style="height: 32px; width: auto; object-fit: contain;"/>
            <span>Tech<span class="text-primary">Mart</span></span>
        </a>

        <!-- Mobile Toggler Control Button -->
        <button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse" data-bs-target="#tmNavbarWorkspace" aria-controls="tmNavbarWorkspace" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>

        <!-- Navbar Dropdowns & Core Menu Routing Matrix -->
        <div class="collapse navbar-collapse" id="tmNavbarWorkspace">

            <!-- Center/Left Primary Links Group -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 mt-3 mt-lg-0 gap-1 gap-lg-3 ps-lg-4">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold text-dark" aria-current="page" href="index.jsp">
                        <i class="bi bi-grid-1x2-fill me-1 text-primary"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="catalog.jsp">
                        <i class="bi bi-laptop me-1"></i> Tech Catalog
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="orders.jsp">
                        <i class="bi bi-cart3 me-1"></i> Order Streams
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium d-flex align-items-center gap-1" href="users.jsp">
                        <i class="bi bi-people me-1"></i> User Base
                        <!-- Clean dynamic operational alert indicator -->
                        <span class="badge rounded-pill bg-danger bg-opacity-10 text-danger small px-2 py-1" style="font-size: 0.7rem;">7</span>
                    </a>
                </li>
            </ul>

            <!-- Right Profile & Security Quick Access Matrix -->
            <hr class="d-lg-none my-3 text-muted">
            <div class="navbar-nav align-items-lg-center gap-3">

                <!-- Quick Settings Indicator -->
                <a href="settings.jsp" class="nav-link p-2 text-secondary d-none d-lg-inline-block">
                    <i class="bi bi-gear fs-5"></i>
                </a>

                <!-- User Session Context Trigger Menu -->
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 p-0 text-dark fw-semibold" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 36px; height: 36px; font-size: 0.9rem;">
                            AD
                        </div>
                        <span class="d-inline-block text-truncate" style="max-width: 110px;">Admin User</span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-light rounded-3 mt-2" aria-labelledby="profileDropdown">
                        <li>
                            <div class="dropdown-header text-dark fw-bold pb-1">Platform Manager</div>
                            <div class="dropdown-header text-muted small pt-0 text-break">admin@techmart.com</div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="profile.jsp"><i class="bi bi-person"></i> Account Profile</a></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="settings.jsp"><i class="bi bi-sliders"></i> Store Rules</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <!-- Submits clean invalidation route inside your web infrastructure container context -->
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-danger small fw-semibold" href="logout"><i class="bi bi-box-arrow-right"></i> Sign Out</a></li>
                    </ul>
                </div>

            </div>

        </div>
    </div>
</nav>