<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Secure Checkout</title>
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
        .checkout-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
        }
        .address-radio-box {
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .address-radio-box:hover {
            border-color: #cbd5e1;
        }
        .form-check-input:checked + .address-radio-box {
            border-color: #2563eb;
            background-color: #eff6ff;
        }
        .summary-item-thumb {
            width: 50px;
            height: 50px;
            object-fit: contain;
            background-color: #f8fafc;
            border-radius: 8px;
            padding: 4px;
            border: 1px solid #e2e8f0;
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp"/>

<main class="container my-5 flex-grow-1">
    <h3 class="fw-extrabold tracking-tight mb-4" style="font-weight: 800;">Secure Checkout</h3>

    <div class="row g-4">
        <div class="col-lg-7">
            <div class="checkout-card p-4 shadow-sm bg-white mb-4">
                <h5 class="fw-bold mb-3 text-dark"><i class="bi bi-geo-alt-fill text-primary"></i> Shipping Destination</h5>
                <p class="text-muted small mb-4">Select your delivery logistics endpoint or add a new deployment address record.</p>

                <form id="checkoutForm" action="order-initialize" method="POST">
                    <div class="d-flex flex-column gap-3 mb-4">
                        <c:choose>
                            <c:when test="${empty userAddresses}">
                                <div class="alert alert-warning border-0 rounded-3 small" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill"></i> No saved delivery coordinates found. Please update your profile settings or add a destination address.
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="addr" items="${userAddresses}" varStatus="status">
                                    <label class="position-relative m-0 w-100">
                                            <%-- Mapped custom style selection trigger logic --%>
                                        <input type="radio" name="selectedAddressId" value="${addr.id}" class="form-check-input position-absolute top-50 start-0 translate-middle-y ms-3" ${status.first ? 'checked' : ''}>
                                        <div class="address-radio-box ps-5">
                                            <div class="d-flex justify-content-between align-items-start">
                                                <div>
                                                    <span class="fw-bold d-block text-dark small mb-1">
                                                        Address Option #${status.count}
                                                        <c:if var="isFirst" test="${status.first}"><span class="badge bg-primary-subtle text-primary ms-2 rounded-pill" style="font-size: 0.65rem;">PRIMARY</span></c:if>
                                                    </span>
                                                    <span class="text-secondary small d-block"><c:out value="${addr.addressLine1}"/></span>
                                                    <c:if test="${not empty addr.addressLine2}">
                                                        <span class="text-secondary small d-block"><c:out value="${addr.addressLine2}"/></span>
                                                    </c:if>
                                                    <span class="text-dark fw-medium small"><c:out value="${addr.city}"/>, <c:out value="${addr.postalCode}"/></span>
                                                </div>
                                            </div>
                                        </div>
                                    </label>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h5 class="fw-bold mb-3 pt-3 border-top border-light text-dark"><i class="bi bi-credit-card-2-front-fill text-primary"></i> Payment Settlement Gateway</h5>
                    <div class="p-3 bg-light rounded-3 border d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3">
                            <i class="bi bi-shield-check text-success fs-3"></i>
                            <div>
                                <h6 class="fw-bold m-0 text-dark">PayHere Gateway Transaction</h6>
                                <p class="text-muted small m-0">Secure instant routing via local & global card networks.</p>
                            </div>
                        </div>
                        <img src="https://www.payhere.lk/downloads/images/payhere_short_banner.png" alt="PayHere Verified" style="height: 32px;">
                    </div>
                </form>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="checkout-card p-4 shadow-sm bg-white position-sticky" style="top: 24px;">
                <h5 class="fw-bold mb-4 text-dark">Review Your Order</h5>

                <div class="d-flex flex-column gap-3 mb-4 max-height-300 overflow-auto pr-1">
                    <%-- Fixed collection to match shoppingCart.items --%>
                    <c:forEach var="item" items="${shoppingCart.items}">
                        <div class="d-flex align-items-center justify-content-between gap-3 pb-2 border-bottom border-light">
                            <div class="d-flex align-items-center gap-3">
                                    <%-- Refactored to pass through your direct application dynamic image proxy gateway --%>
                                <img src="product-image?path=${item.productImagePath}" class="summary-item-thumb" alt="${item.productTitle}">
                                <div style="max-width: 180px;">
                                    <h6 class="fw-bold text-dark text-truncate small m-0"><c:out value="${item.productTitle}"/></h6>
                                    <span class="text-muted small">Qty: <strong><c:out value="${item.quantity}"/></strong></span>
                                </div>
                            </div>
                                <%-- Utilizes precalculated CartItemDTO line subtotals --%>
                            <span class="fw-bold text-dark small">$<c:out value="${item.subTotal}"/></span>
                        </div>
                    </c:forEach>
                </div>

                <div class="d-flex justify-content-between mb-2 text-muted small">
                    <span>Subtotal Items</span>
                    <%-- Mapped directly to totalCartPrice variable wrapper --%>
                    <span class="text-dark fw-medium">$<c:out value="${shoppingCart.totalCartPrice}"/></span>
                </div>
                <div class="d-flex justify-content-between mb-2 text-muted small">
                    <span>Logistics Delivery/Freight</span>
                    <span class="text-success fw-medium">FREE</span>
                </div>
                <div class="d-flex justify-content-between pb-3 mb-3 border-bottom border-light text-muted small">
                    <span>Local Value Added Tax (VAT)</span>
                    <span class="text-dark fw-medium">$0.00</span>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <span class="fw-bold text-dark">Total Due</span>
                    <h4 class="fw-extrabold text-primary m-0" style="font-weight: 800;">$<c:out value="${shoppingCart.totalCartPrice}"/></h4>
                </div>

                <form id="payhereRedirectForm" method="post" action="https://sandbox.payhere.lk/pay/checkout">
                    <input type="hidden" name="merchant_id" value="${payhereMerchantId}">
                    <input type="hidden" name="return_url" value="${baseURL}/payment-success">
                    <input type="hidden" name="cancel_url" value="${baseURL}/payment-cancelled">
                    <input type="hidden" name="notify_url" value="${baseURL}/api/v1/payments/ipn">

                    <input type="hidden" name="order_id" value="${generatedOrderId}">
                    <input type="hidden" name="items" value="TechMart High-Performance Hardware Unit Build Suite">
                    <input type="hidden" name="currency" value="USD">
                    <input type="hidden" name="amount" value="${shoppingCart.totalCartPrice}">

                    <%-- Handles UserDTO properties securely --%>
                    <input type="hidden" name="first_name" value="${user.firstName}">
                    <input type="hidden" name="last_name" value="${user.lastName}">
                    <input type="hidden" name="email" value="${user.email}">
                    <input type="hidden" name="phone" value="0771234567">
                    <input type="hidden" name="address" value="${userAddresses[0].addressLine1}">
                    <input type="hidden" name="city" value="${userAddresses[0].city}">
                    <input type="hidden" name="country" value="Sri Lanka">

                    <button type="button" onclick="submitCheckoutPipeline()" class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm border-0 d-flex align-items-center justify-content-center gap-2" ${empty userAddresses ? 'disabled' : ''}>
                        <i class="bi bi-credit-card-fill fs-5"></i> Execute Secure Settlement
                    </button>
                </form>

                <div class="text-center mt-3">
                    <span class="text-muted font-monospace tracking-wide opacity-75" style="font-size: 0.65rem;">
                        <i class="bi bi-shield-lock-fill"></i> COMPLIANT PAYHERE DIRECT GATEWAY PASSTHROUGH
                    </span>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script>
    function submitCheckoutPipeline() {
        const selectedAddress = document.querySelector('input[name="selectedAddressId"]:checked');
        if (!selectedAddress) {
            alert("Operational Fault: Please select a valid shipping delivery coordinate!");
            return;
        }

        document.getElementById('payhereRedirectForm').submit();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>