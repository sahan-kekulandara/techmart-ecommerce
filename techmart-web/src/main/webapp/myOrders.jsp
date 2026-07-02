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

<jsp:include page="components/navbar.jsp"/>

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

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>