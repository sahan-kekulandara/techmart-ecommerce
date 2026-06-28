<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Shopping Cart</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght=400;500;600;700;800&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .cart-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
        }

        .cart-item-img {
            width: 80px;
            height: 80px;
            object-fit: contain;
            background-color: #f8fafc;
            border-radius: 12px;
            padding: 6px;
            border: 1px solid #e2e8f0;
        }

        .qty-adjust-group {
            max-width: 110px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            overflow: hidden;
        }

        .qty-adjust-btn {
            background-color: #f1f5f9;
            border: 0;
            width: 32px;
            font-size: 0.9rem;
            font-weight: bold;
            transition: background 0.2s;
        }

        .qty-adjust-btn:hover {
            background-color: #e2e8f0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
            color: #64748b;
        }
    </style>
</head>
<body class="bg-light">

<jsp:include page="components/navbar.jsp"/>

<main class="container my-5 flex-grow-1">

    <h3 class="fw-extrabold tracking-tight mb-4" style="font-weight: 800;">Your Shopping Cart</h3>

    <c:if test="${not empty sessionScope.cartMessage}">
        <div class="alert alert-info border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-info-circle-fill"></i>
            <div><c:out value="${sessionScope.cartMessage}"/></div>
        </div>
        <% session.removeAttribute("cartMessage"); %>
    </c:if>

    <div class="row g-4">
        <c:choose>
            <c:when test="${empty cartItems || fn:length(cartItems) == 0}">
                <!-- EMPTY CART FALLBACK STATE -->
                <div class="col-12 text-center py-5 cart-card shadow-sm bg-white">
                    <i class="bi bi-cart-x display-3 text-muted d-block mb-3"></i>
                    <h4 class="fw-bold text-secondary">Your Cart is Empty</h4>
                    <p class="text-muted small mb-4">Looks like you haven't added any high-performance gear yet.</p>
                    <a href="products.jsp" class="btn btn-primary fw-semibold px-4 py-2 rounded-3 shadow-sm border-0">
                        Explore Catalog
                    </a>
                </div>
            </c:when>
            <c:otherwise>

                <div class="col-lg-8">
                    <div class="cart-card p-4 shadow-sm bg-white d-flex flex-column gap-4">

                        <c:forEach var="item" items="${cartItems}">
                            <div class="d-flex flex-column flex-sm-row align-items-sm-center justify-content-between gap-3 pb-4 border-bottom border-light last-border-0">

                                <!-- Product Details Context -->
                                <div class="d-flex align-items-center gap-3 flex-grow-1">
                                    <img src="uploads/products/${item.productImage}" class="cart-item-img"
                                         alt="${item.productTitle}">
                                    <div style="max-width: 280px;">
                                        <h6 class="fw-bold text-dark text-truncate mb-1"><c:out
                                                value="${item.productTitle}"/></h6>
                                        <span class="text-muted small">Unit Price: <strong>$<c:out
                                                value="${item.price}"/></strong></span>
                                    </div>
                                </div>

                                <div class="d-flex align-items-center justify-content-between justify-content-sm-end gap-4 w-100-mobile">

                                    <form action="cart-update" method="POST" class="m-0">
                                        <input type="hidden" name="cartItemId" value="${item.id}">
                                        <div class="input-group qty-adjust-group">
                                            <button class="qty-adjust-btn" type="submit" name="action"
                                                    value="decrease" ${item.quantity <= 1 ? 'disabled' : ''}>-
                                            </button>
                                            <input type="text"
                                                   class="form-control text-center bg-transparent border-0 small p-0 fw-bold"
                                                   value="${item.quantity}" style="max-width: 45px;" readonly>
                                            <button class="qty-adjust-btn" type="submit" name="action" value="increase">
                                                +
                                            </button>
                                        </div>
                                    </form>

                                    <!-- Row Total Cost -->
                                    <div class="text-end" style="min-width: 90px;">
                                        <h6 class="fw-bold text-dark m-0">$<c:out
                                                value="${item.price * item.quantity}"/></h6>
                                    </div>

                                    <!-- Delete Item Button Pipeline -->
                                    <form action="cart-remove" method="POST" class="m-0">
                                        <input type="hidden" name="cartItemId" value="${item.id}">
                                        <button type="submit" class="btn btn-link text-danger p-1 fs-5 line-height-1"
                                                title="Remove Item">
                                            <i class="bi bi-trash3-fill"></i>
                                        </button>
                                    </form>

                                </div>
                            </div>
                        </c:forEach>

                        <div class="d-flex justify-content-between align-items-center pt-2">
                            <a href="products.jsp"
                               class="btn btn-link text-decoration-none text-primary fw-semibold p-0 small">
                                <i class="bi bi-arrow-left"></i> Continue Shopping
                            </a>
                        </div>
                    </div>
                </div>

                <!-- RIGHT COLUMN: FINANCIAL BREAKDOWN SUMMARIZATION PANEL -->
                <div class="col-lg-4">
                    <div class="cart-card p-4 shadow-sm bg-white position-sticky" style="top: 24px;">
                        <h5 class="fw-bold mb-4 text-dark">Order Summary</h5>

                        <div class="summary-row">
                            <span>Subtotal Items</span>
                            <span class="text-dark fw-medium">$<c:out value="${cartSubtotal}"/></span>
                        </div>
                        <div class="summary-row">
                            <span>Estimated Shipping</span>
                            <span class="text-success fw-medium">FREE</span>
                        </div>
                        <div class="summary-row pb-3 mb-3 border-bottom border-light">
                            <span>Local Value Tax (VAT)</span>
                            <span class="text-dark fw-medium">$0.00</span>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <span class="fw-bold text-dark">Total Value Due</span>
                            <h4 class="fw-extrabold text-primary m-0" style="font-weight: 800;">$<c:out
                                    value="${cartSubtotal}"/></h4>
                        </div>

                        <!-- Secure Checkout Action Pipeline -->
                        <a href="checkout"
                           class="btn btn-primary w-100 py-2.5 fw-bold rounded-3 shadow-sm border-0 d-flex align-items-center justify-content-center gap-2">
                            <i class="bi bi-shield-lock-fill"></i> Proceed to Checkout
                        </a>

                        <div class="text-center mt-3">
                            <span class="text-muted font-monospace tracking-wide opacity-75" style="font-size: 0.7rem;">
                                <i class="bi bi-lock-fill"></i> SECURE SSL HARDWARE GATEWAY
                            </span>
                        </div>
                    </div>
                </div>

            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>