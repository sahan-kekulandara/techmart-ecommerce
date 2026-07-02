<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<nav class="navbar navbar-expand-lg bg-white border-bottom py-3 sticky-top">
    <div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

        <!-- Secure Context Brand Alignment -->
        <a class="navbar-brand d-flex align-items-center gap-2 fw-extrabold text-dark fs-4 tracking-tight" href="${pageContext.request.contextPath}/admin/dashboard">
            <img src="${pageContext.request.contextPath}/icon.png" alt="TechMart" style="height: 32px; width: auto; object-fit: contain;"/>
            <span>Tech<span class="text-primary">Mart</span></span>
        </a>

        <button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse" data-bs-target="#tmNavbarWorkspace" aria-controls="tmNavbarWorkspace" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>

        <div class="collapse navbar-collapse" id="tmNavbarWorkspace">
            <!-- Center Menu Routing Matrix mapped to Controller Servlets -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 mt-3 mt-lg-0 gap-1 gap-lg-3 ps-lg-4">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold text-dark" href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="bi bi-grid-1x2-fill me-1 text-primary"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="${pageContext.request.contextPath}/admin/products">
                        <i class="bi bi-laptop me-1"></i> Tech Catalog
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="${pageContext.request.contextPath}/admin/orders">
                        <i class="bi bi-cart3 me-1"></i> Order Streams
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium d-flex align-items-center gap-1" href="${pageContext.request.contextPath}/admin/users">
                        <i class="bi bi-people me-1"></i> User Base
                    </a>
                </li>
            </ul>

            <hr class="d-lg-none my-3 text-muted">
            <div class="navbar-nav align-items-lg-center gap-3">

                <a href="${pageContext.request.contextPath}/admin/settings" class="nav-link p-2 text-secondary d-none d-lg-inline-block">
                    <i class="bi bi-gear fs-5"></i>
                </a>

                <!-- Dynamic User Session Identity Context -->
                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 p-0 text-dark fw-semibold" href="#" id="profileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 36px; height: 36px; font-size: 0.9rem;">
                            <c:out value="${fn:substring(sessionScope.user.name, 0, 2)}" default="AD"/>
                        </div>
                        <span class="d-inline-block text-truncate" style="max-width: 110px;">
                            <c:out value="${sessionScope.user.name}" default="Admin User"/>
                        </span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-light rounded-3 mt-2" aria-labelledby="profileDropdown">
                        <li>
                            <div class="dropdown-header text-dark fw-bold pb-1">Platform Manager</div>
                            <div class="dropdown-header text-muted small pt-0 text-break">
                                <c:out value="${sessionScope.user.email}" default="admin@techmart.com"/>
                            </div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="${pageContext.request.contextPath}/admin/profile"><i class="bi bi-person"></i> Account Profile</a></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="${pageContext.request.contextPath}/admin/settings"><i class="bi bi-sliders"></i> Store Rules</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-danger small fw-semibold" href="${pageContext.request.contextPath}/logout"><i class="bi bi-box-arrow-right"></i> Sign Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>