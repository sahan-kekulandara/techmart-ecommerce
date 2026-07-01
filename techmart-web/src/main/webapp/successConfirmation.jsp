<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Order Confirmed</title>
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
        .success-card {
            background: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 1rem;
        }
        .icon-circle {
            width: 72px;
            height: 72px;
            background-color: #dcfce7;
            color: #15803d;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }
        .order-reference {
            background-color: #f1f5f9;
            border: 1px dashed #cbd5e1;
            border-radius: 0.5rem;
        }
    </style>
</head>
<body>

<jsp:include page="components/footer.jsp"/>

<main class="container my-auto py-5">
    <div class="row justify-content-center">
        <div class="col-md-7 col-lg-6 text-center">

            <div class="success-card shadow-sm p-5">
                <div class="icon-circle shadow-sm">
                    <i class="bi bi-check-circle-fill fs-1"></i>
                </div>

                <h1 class="fw-bold tracking-tight mb-2">Payment Successful!</h1>
                <p class="text-muted mb-4">Thank you for your purchase. Your hardware provisioning transaction has cleared securely via Stripe, and your order is now processing.</p>

                <div class="order-reference p-3 mb-4">
                    <span class="text-xs text-uppercase fw-semibold tracking-wider text-muted d-block mb-1">Order Tracking Reference</span>
                    <strong class="font-monospace text-dark fs-5">
                        <c:choose>
                            <c:when test="${not empty orderId}">
                                <c:out value="${orderId}"/>
                            </c:when>
                            <c:otherwise>
                                TM-PENDING-ACQUISITION
                            </c:otherwise>
                        </c:choose>
                    </strong>
                </div>

                <p class="text-sm text-muted mb-4">
                    A confirmation log has been written to your profile record. You can use the tracking reference above to check updates on your hardware logistics status.
                </p>

                <div class="d-flex flex-column flex-sm-row gap-2 justify-content-center mt-2">
                    <a href="order-history" class="btn btn-primary px-4 py-2.5 fw-semibold rounded-3 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-receipt"></i> View Order History
                    </a>
                    <a href="products" class="btn btn-outline-secondary px-4 py-2.5 fw-semibold rounded-3 d-inline-flex align-items-center justify-content-center gap-2">
                        <i class="bi bi-bag"></i> Continue Shopping
                    </a>
                </div>
            </div>

            <div class="mt-4 opacity-75">
                <span class="text-muted font-monospace" style="font-size: 0.7rem;">
                    <i class="bi bi-shield-fill-check text-success"></i> COMPLIANT FULFILLMENT PIPELINE ACQUIRED
                </span>
            </div>

        </div>
    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>