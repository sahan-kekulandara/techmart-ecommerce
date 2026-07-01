<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Order History Ledger</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght=400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .order-master-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
            overflow: hidden;
        }
        .order-header-block {
            background-color: #f8fafc;
            border-bottom: 1px solid #e2e8f0;
        }
        .order-item-thumb {
            width: 65px;
            height: 65px;
            object-fit: contain;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 4px;
            border: 1px solid #e2e8f0;
        }
        .status-badge {
            font-weight: 600;
            font-size: 0.75rem;
            padding: 0.4rem 0.75rem;
            border-radius: 50px;
        }
        /* Custom dynamic CSS fix to strip border from final sub-item element array row */
        .last-border-0:last-child {
            border-bottom: 0 !important;
            padding-bottom: 0 !important;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg bg-white border-bottom py-3 sticky-top">
    <div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">

        <a class="navbar-brand d-flex align-items-center gap-2 fw-extrabold text-dark fs-4 tracking-tight" href="home">
            <img src="icon.png" alt="TechMart" style="height: 32px; width: auto; object-fit: contain;"/>
            <span>Tech<span class="text-primary">Mart</span></span>
        </a>

        <button class="navbar-toggler border-0 shadow-none p-0" type="button" data-bs-toggle="collapse" data-bs-target="#tmStorefrontNavbar" aria-controls="tmStorefrontNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>

        <div class="collapse navbar-collapse" id="tmStorefrontNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 mt-3 mt-lg-0 gap-1 gap-lg-3 ps-lg-4">
                <li class="nav-item">
                    <a class="nav-link fw-semibold text-dark" href="home">
                        <i class="bi bi-house-door-fill me-1 text-primary"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="products">Shop Catalog</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active fw-semibold text-primary" href="orders">My Purchases</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link text-secondary fw-medium" href="support">Help Desk</a>
                </li>
            </ul>

            <hr class="d-lg-none my-3 text-muted">
            <div class="navbar-nav align-items-lg-center gap-3">
                <form action="search" method="GET" class="position-relative me-lg-2 d-none d-sm-block">
                    <input type="search" name="query" class="form-control form-control-sm bg-light border-0 rounded-pill px-3 py-2 text-dark small" placeholder="Search tech hardware..." style="width: 210px; font-size: 0.85rem;">
                    <i class="bi bi-search position-absolute end-0 top-50 translate-middle-y me-3 text-secondary small"></i>
                </form>

                <a href="cart" class="btn btn-light bg-light border-0 rounded-pill px-3 py-2 position-relative d-flex align-items-center gap-2 text-dark fw-semibold" style="font-size: 0.85rem;">
                    <i class="bi bi-cart3 text-primary fs-6"></i>
                    <span class="d-none d-lg-inline">Cart</span>
                </a>

                <div class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center gap-2 p-0 text-dark fw-semibold" href="#" id="customerProfileDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold" style="width: 36px; height: 36px; font-size: 0.9rem;">
                            <c:out value="${fn:substring(sessionScope.user.firstName, 0, 2)}" default="U"/>
                        </div>
                        <span class="d-inline-block text-truncate" style="max-width: 110px;">
                                <c:out value="${sessionScope.user.firstName}" default="Guest User"/>
                            </span>
                    </a>

                    <ul class="dropdown-menu dropdown-menu-end shadow-sm border-light rounded-3 mt-2" aria-labelledby="customerProfileDropdown">
                        <li>
                            <div class="dropdown-header text-dark fw-bold pb-1">Verified Member</div>
                            <div class="dropdown-header text-muted small pt-0 text-break"><c:out value="${sessionScope.user.email}"/></div>
                        </li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="profile"><i class="bi bi-person"></i> My Profile</a></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="orders"><i class="bi bi-bag"></i> Order History</a></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-secondary small" href="settings"><i class="bi bi-gear"></i> Settings</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item py-2 d-flex align-items-center gap-2 text-danger small fw-semibold" href="logout"><i class="bi bi-box-arrow-right"></i> Log Out</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</nav>

<main class="container my-5 flex-grow-1">

    <div class="d-flex align-items-center justify-content-between mb-4">
        <div>
            <h3 class="fw-extrabold tracking-tight m-0" style="font-weight: 800;">Purchase History</h3>
            <p class="text-muted small m-0">Review and track deployment verification status pipelines for all past hardware acquisitions.</p>
        </div>
        <a href="products" class="btn btn-light btn-sm border fw-semibold rounded-3 px-3">
            <i class="bi bi-arrow-left"></i> Back to Storefront
        </a>
    </div>

    <c:choose>
        <c:when test="${empty customerOrders}">
            <div class="text-center py-5 order-master-card bg-white shadow-sm">
                <i class="bi bi-receipt-cutoff display-2 text-muted d-block mb-3"></i>
                <h4 class="fw-bold text-secondary">No Invoices Discovered</h4>
                <p class="text-muted small mb-4">You have not completed any transaction instances inside our retail ledger matrix yet.</p>
                <a href="products" class="btn btn-primary fw-semibold px-4 py-2 rounded-3 shadow-sm border-0">
                    Acquire Hardware Now
                </a>
            </div>
        </c:when>
        <c:otherwise>

            <div class="d-flex flex-column gap-4">
                <c:forEach var="order" items="${customerOrders}">
                    <div class="order-master-card shadow-sm bg-white">

                        <div class="order-header-block p-3 px-4 d-flex flex-wrap justify-content-between align-items-center gap-3">
                            <div class="d-flex gap-4 flex-wrap">
                                <div>
                                    <span class="text-muted d-block small font-monospace text-uppercase tracking-wider">Date Triggered</span>
                                    <span class="text-dark fw-semibold small"><c:out value="${order.createdAt}"/></span>
                                </div>
                                <div>
                                    <span class="text-muted d-block small font-monospace text-uppercase tracking-wider">Reference Ledger ID</span>
                                    <span class="text-dark fw-bold small">#<c:out value="${order.id}"/></span>
                                </div>
                                <div>
                                    <span class="text-muted d-block small font-monospace text-uppercase tracking-wider">Financial Subtotal</span>
                                    <span class="text-primary fw-extrabold small">$<c:out value="${order.totalAmount}"/></span>
                                </div>
                            </div>

                            <div>
                                <c:choose>
                                    <c:when test="${order.status == 'PAID' || order.status == 'DELIVERED'}">
                                        <span class="status-badge bg-success-subtle text-success border border-success-subtle"><i class="bi bi-check-circle-fill"></i> Dispatched & Handed Over</span>
                                    </c:when>
                                    <c:when test="${order.status == 'SHIPPED'}">
                                        <span class="status-badge bg-info-subtle text-info border border-info-subtle"><i class="bi bi-truck"></i> In Transit Logistics</span>
                                    </c:when>
                                    <c:when test="${order.status == 'PROCESSING'}">
                                        <span class="status-badge bg-warning-subtle text-warning border border-warning-subtle"><i class="bi bi-gear-fill"></i> Provisioning Components</span>
                                    </c:when>
                                    <c:when test="${order.status == 'UNPAID'}">
                                        <span class="status-badge bg-danger-subtle text-danger border border-danger-subtle"><i class="bi bi-x-circle-fill"></i> Payment Incomplete</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-badge bg-secondary-subtle text-secondary border border-secondary-subtle"><i class="bi bi-hourglass-split"></i> Processing Context</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="p-4 d-flex flex-column gap-3">
                            <c:forEach var="item" items="${order.items}">
                                <div class="d-flex align-items-center justify-content-between gap-3 pb-3 border-bottom border-light last-border-0">
                                    <div class="d-flex align-items-center gap-3">
                                        <img src="product-image?path=${item.imagePath}" class="order-item-thumb" alt="Product Thumbnail" onerror="this.src='https://placehold.co/65'">
                                        <div>
                                            <h6 class="fw-bold text-dark mb-1 small"><c:out value="${item.productName}"/></h6>
                                            <span class="text-muted small">Purchased Quantity Volume: <strong class="text-dark"><c:out value="${item.quantity}"/> unit(s)</strong></span>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <span class="text-muted d-block small">Historical Price Locked</span>
                                        <h6 class="fw-bold text-dark m-0">$<c:out value="${item.priceAtPurchase}"/></h6>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <div class="p-3 px-4 border-top border-light d-flex justify-content-between align-items-center bg-light-subtle">
                                <span class="text-muted font-monospace tracking-tight" style="font-size: 0.7rem;">
                                    <i class="bi bi-stripe text-primary"></i> STRIPE NODE REF: <c:out value="${order.stripeSessionId}" default="LOCAL_BYPASS_TOKEN"/>
                                </span>
                            <a href="order-invoice?id=${order.id}" class="btn btn-white bg-white border border-secondary-subtle btn-sm rounded-2 fw-semibold px-3 text-dark">
                                <i class="bi bi-printer"></i> Generate Invoice PDF
                            </a>
                        </div>

                    </div>
                </c:forEach>
            </div>

        </c:otherwise>
    </c:choose>
</main>

<footer class="bg-white border-top py-4 mt-auto">
    <div class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5">
        <div class="row align-items-center justify-content-between g-4">

            <div class="col-12 col-md-auto text-center text-md-start">
                <p class="text-muted small m-0">
                    &copy; 2026 <span class="fw-bold text-dark">TechMart</span> Marketplace. Premium hardware delivered securely.
                </p>
            </div>

            <div class="col-12 col-md-auto">
                <ul class="list-inline m-0 text-center text-md-end d-flex flex-wrap justify-content-center justify-content-md-end gap-3 small">
                    <li class="list-inline-item m-0">
                            <span class="text-muted d-flex align-items-center gap-1">
                                <i class="bi bi-shield-check text-success"></i> SSL Secured Transaction
                            </span>
                    </li>
                    <li class="list-inline-item m-0 d-none d-sm-inline text-muted">|</li>
                    <li class="list-inline-item m-0">
                        <a href="terms" class="text-decoration-none text-secondary">Terms of Service</a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a href="privacy" class="text-decoration-none text-secondary">Privacy Policy</a>
                    </li>
                    <li class="list-inline-item m-0">
                        <a href="returns" class="text-decoration-none text-secondary">Shipping & Returns</a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
</footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>