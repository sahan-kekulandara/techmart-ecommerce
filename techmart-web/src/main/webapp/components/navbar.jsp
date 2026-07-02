<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<nav class="navbar navbar-expand-lg bg-white border-bottom py-3 sticky-top">
    <div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

        <a class="navbar-brand d-flex align-items-center gap-2 fw-extrabold text-dark fs-4 tracking-tight"
           href="home.jsp">
            <img src="/images/logo/icon.png" alt="TechMart" style="height: 32px; width: auto; object-fit: contain;"/>
            <span>Tech<span class="text-primary">Mart</span></span>
        </a>

        <button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse"
                data-bs-target="#tmStorefrontNavbar" aria-controls="tmStorefrontNavbar" aria-expanded="false"
                aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>

        <div class="collapse navbar-collapse" id="tmStorefrontNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 mt-3 mt-lg-0 gap-1 gap-lg-3 ps-lg-4">
                <li class="nav-item">
                    <a class="nav-link active fw-semibold text-dark" aria-current="page" href="home.jsp">
                        <i class="bi bi-house-door-fill me-1 text-primary"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="products">Shop Catalog</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="orders">My Purchases</a>
                </li>
            </ul>

            <hr class="d-lg-none my-3 text-muted">

            <div class="navbar-nav align-items-lg-center gap-3">

                <form action="products" method="GET" class="position-relative me-lg-2 d-none d-sm-block">
                    <input type="search" name="search" id="searchBox"
                           class="form-control form-control-sm bg-light border-0 rounded-pill px-3 py-2 text-dark small"
                           placeholder="Search tech hardware..." style="width: 210px; font-size: 0.85rem;">
                    <i class="bi bi-search position-absolute end-0 top-50 translate-middle-y me-3 text-secondary small"></i>
                    <div id="searchResults"
                         class="list-group position-absolute w-100 shadow"
                         style="z-index:1000; display:none;">
                    </div>
                </form>

                <a href="cart"
                   class="btn btn-light bg-light border-0 rounded-pill px-3 py-2 position-relative d-flex align-items-center gap-2 text-dark fw-semibold"
                   style="font-size: 0.85rem;">
                    <i class="bi bi-cart3 text-primary fs-6"></i>
                    <span class="d-none d-lg-inline">Cart</span>
                </a>

                <c:choose>
                    <%-- Scenario A: User is Logged In --%>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 p-0 text-dark fw-semibold"
                               href="#" id="customerProfileDropdown" role="button" data-bs-toggle="dropdown"
                               aria-expanded="false">
                                <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold"
                                     style="width: 36px; height: 36px; font-size: 0.9rem;">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user.firstName and not empty sessionScope.user.lastName}">
                                            <c:out value="${fn:substring(sessionScope.user.firstName, 0, 1)}${fn:substring(sessionScope.user.lastName, 0, 1)}" />
                                        </c:when>
                                        <c:otherwise>
                                            JD
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <span class="d-inline-block text-truncate" style="max-width: 110px;">
                                    <c:out value="${sessionScope.user.firstName} ${sessionScope.user.lastName}" />
                                </span>
                            </a>

                            <ul class="dropdown-menu dropdown-menu-end shadow-sm border-light rounded-3 mt-2"
                                aria-labelledby="customerProfileDropdown">
                                <li>
                                    <div class="dropdown-header text-dark fw-bold pb-1">Verified Member</div>
                                    <div class="dropdown-header text-muted small pt-0 text-break">
                                        <c:out value="${sessionScope.user.email}" />
                                    </div>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="profile.jsp">
                                        <i class="bi bi-person"></i> My Profile
                                    </a>
                                </li>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item py-2 d-flex align-items-center gap-2 text-danger small fw-semibold" href="logout">
                                        <i class="bi bi-box-arrow-right"></i> Log Out
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:when>

                    <%-- Scenario B: Guest User --%>
                    <c:otherwise>
                        <a href="logIn.jsp" class="btn btn-link text-secondary text-decoration-none fw-semibold small px-2">
                            Sign In
                        </a>
                        <a href="signUp.jsp" class="btn btn-primary rounded-pill fw-semibold small px-3 py-2 shadow-sm" style="font-size: 0.85rem;">
                            Get Started
                        </a>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>
</nav>

<script src="js/live-search.js"></script>