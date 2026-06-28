<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - User Settings Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

        .profile-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 16px;
        }

        .nav-pills .nav-link {
            color: #64748b;
            font-weight: 600;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.2s ease;
        }

        .nav-pills .nav-link.active, .nav-pills .nav-link:hover {
            background-color: #eff6ff;
            color: #2563eb;
        }

        .avatar-placeholder {
            width: 90px;
            height: 90px;
            background-color: #eff6ff;
            color: #2563eb;
            font-size: 2rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            border: 3px solid #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .order-history-item {
            border-left: 4px solid #cbd5e1;
            transition: border-color 0.2s ease;
        }

        .order-history-item:hover {
            border-left-color: #2563eb;
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp"/>

<main class="container my-5 flex-grow-1">

    <c:if test="${not empty sessionScope.profileSuccessMessage}">
        <div class="alert alert-success border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-check-circle-fill"></i>
            <div><c:out value="${sessionScope.profileSuccessMessage}"/></div>
        </div>
        <% session.removeAttribute("profileSuccessMessage"); %>
    </c:if>

    <c:if test="${not empty sessionScope.profileErrorMessage}">
        <div class="alert alert-danger border-0 shadow-sm rounded-3 mb-4 d-flex align-items-center gap-2" role="alert">
            <i class="bi bi-exclamation-triangle-fill"></i>
            <div><c:out value="${sessionScope.profileErrorMessage}"/></div>
        </div>
        <% session.removeAttribute("profileErrorMessage"); %>
    </c:if>

    <div class="row g-4">

        <aside class="col-lg-4 col-xl-3">
            <div class="profile-card p-4 shadow-sm text-center mb-4">
                <div class="d-flex justify-content-center mb-3">
                    <div class="avatar-placeholder">
                        <c:out value="${fn:substring(user.firstName, 0, 1)}${fn:substring(user.lastName, 0, 1)}"
                               default="JD"/>
                    </div>
                </div>
                <h5 class="fw-bold mb-1"><c:out value="${user.firstName} ${user.lastName}" default="John Doe"/></h5>
                <p class="text-muted small mb-3"><c:out value="${user.email}" default="john.doe@company.com"/></p>
                <span class="badge bg-light text-primary border border-primary-subtle rounded-pill px-3 py-1.5 fw-semibold small">
                    Verified Customer
                </span>
            </div>

            <!-- Tab Switcher Navigation Controllers -->
            <div class="profile-card p-3 shadow-sm">
                <div class="nav flex-column nav-pills gap-1" id="v-pills-tab" role="tablist"
                     aria-orientation="vertical">
                    <button class="nav-link active d-flex align-items-center gap-2 text-start" id="v-pills-profile-tab"
                            data-bs-toggle="pill" data-bs-target="#v-pills-profile" type="button" role="tab"
                            aria-controls="v-pills-profile" aria-selected="true">
                        <i class="bi bi-person-circle fs-5"></i> Personal Info
                    </button>
                    <button class="nav-link d-flex align-items-center gap-2 text-start" id="v-pills-orders-tab"
                            data-bs-toggle="pill" data-bs-target="#v-pills-orders" type="button" role="tab"
                            aria-controls="v-pills-orders" aria-selected="false">
                        <i class="bi bi-bag-check fs-5"></i> Order History
                    </button>
                    <button class="nav-link d-flex align-items-center gap-2 text-start" id="v-pills-security-tab"
                            data-bs-toggle="pill" data-bs-target="#v-pills-security" type="button" role="tab"
                            aria-controls="v-pills-security" aria-selected="false">
                        <i class="bi bi-shield-lock fs-5"></i> Security Settings
                    </button>
                </div>
            </div>
        </aside>

        <!-- RIGHT PANEL: INTERACTIVE CONTENT WORKING VIEWPORT -->
        <div class="col-lg-8 col-xl-9">
            <div class="tab-content" id="v-pills-tabContent">

                <!-- TAB 1: PERSONAL INFORMATION PROFILE FORM -->
                <div class="tab-pane fade show active" id="v-pills-profile" role="tabpanel"
                     aria-labelledby="v-pills-profile-tab">
                    <div class="profile-card p-4 p-md-5 shadow-sm bg-white">
                        <h4 class="fw-bold mb-1">Account Particulars</h4>
                        <p class="text-muted small mb-4">Manage your communication endpoints and digital profile
                            metadata records.</p>

                        <form action="profile-update" method="POST">
                            <input type="hidden" name="action" value="updateInfo">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold text-muted">First Name</label>
                                    <input type="text" name="firstName"
                                           class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                           value="<c:out value='${user.firstName}' default='John'/>" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label small fw-bold text-muted">Last Name</label>
                                    <input type="text" name="lastName"
                                           class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                           value="<c:out value='${user.lastName}' default='Doe'/>" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label small fw-bold text-muted">Email Address</label>
                                    <input type="email"
                                           class="form-control py-2.5 rounded-3 border-light bg-light text-muted fw-medium"
                                           value="<c:out value='${user.email}' default='john.doe@company.com'/>"
                                           disabled>
                                    <div class="form-text text-muted" style="font-size: 0.75rem;">To shift registered
                                        routing emails, please open an administrative support inquiry ticket.
                                    </div>
                                </div>
                                <div class="border-top pt-4">
                                    <h6 class="fw-bold text-primary mb-3">Primary Logistics Address</h6>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">Address Line 1</label>
                                            <input type="text" name="addressLine1"
                                                   class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                                   value="<c:out value='${userAddress.addressLine1}'/>"
                                                   placeholder="Street address, P.O. box, company name" required
                                                   maxlength="150">
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label small fw-bold text-muted">Address Line 2
                                                (Optional)</label>
                                            <input type="text" name="addressLine2"
                                                   class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                                   value="<c:out value='${userAddress.addressLine2}'/>"
                                                   placeholder="Apartment, suite, unit, building, floor"
                                                   maxlength="150">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold text-muted">City</label>
                                            <input type="text" name="city"
                                                   class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                                   value="<c:out value='${userAddress.city}'/>"
                                                   placeholder="e.g. New York" required maxlength="50">
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label small fw-bold text-muted">Postal Code</label>
                                            <input type="text" name="postalCode"
                                                   class="form-control py-2.5 rounded-3 border-light bg-light text-dark fw-medium"
                                                   value="<c:out value='${userAddress.postalCode}'/>"
                                                   placeholder="e.g. 10001" required maxlength="20">
                                        </div>

                                        <div class="col-12 mt-3">
                                            <div class="d-flex gap-3 flex-wrap">
                                            <span class="badge bg-success-subtle text-success border border-success-subtle px-2.5 py-1.5 rounded-2 small d-flex align-items-center gap-1">
                                                <i class="bi bi-truck"></i> Default Shipping Destination
                                            </span>
                                                <c:if test="${userAddress.isBilling}">
                                                <span class="badge bg-info-subtle text-info border border-info-subtle px-2.5 py-1.5 rounded-2 small d-flex align-items-center gap-1">
                                                    <i class="bi bi-credit-card"></i> Default Billing Location
                                                </span>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="submit"
                                    class="btn btn-primary px-4 py-2.5 fw-semibold rounded-3 mt-4 border-0 shadow-sm">
                                Save Profile Changes
                            </button>
                        </form>
                    </div>
                </div>

                <!-- TAB 2: ORDER RECENT TRANSACTIONS TRACKER -->
                <div class="tab-pane fade" id="v-pills-orders" role="tabpanel" aria-labelledby="v-pills-orders-tab">
                    <div class="profile-card p-4 shadow-sm bg-white">
                        <h4 class="fw-bold mb-1">Order History</h4>
                        <p class="text-muted small mb-4">View and track your tech hardware acquisitions.</p>

                        <div class="d-flex flex-column gap-3">
                            <c:choose>
                                <c:when test="${empty orders}">
                                    <!-- Empty Order Placeholder Screen -->
                                    <div class="text-center py-5">
                                        <i class="bi bi-cart-x text-muted display-4 d-block mb-3"></i>
                                        <h5 class="fw-bold text-secondary">No Orders Found</h5>
                                        <p class="text-muted small m-0">You haven't checked out any marketplace
                                            shipments yet.</p>
                                        <a href="products.jsp"
                                           class="btn btn-primary btn-sm rounded-2 mt-3 fw-semibold px-3">Browse
                                            Catalog</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="order" items="${orders}">
                                        <div class="bg-light rounded-3 p-3 order-history-item d-flex flex-wrap justify-content-between align-items-center gap-3">
                                            <div>
                                                <div class="d-flex align-items-center gap-2 mb-1">
                                                    <span class="fw-bold text-dark">Order #<c:out
                                                            value="${order.id}"/></span>
                                                    <span class="badge bg-white text-success border border-success-subtle rounded-pill font-medium small px-2">Shipped</span>
                                                </div>
                                                <div class="small text-muted">
                                                    Placed on: <span class="text-dark fw-medium"><c:out
                                                        value="${order.date}"/></span> • Items: <span
                                                        class="text-dark fw-medium"><c:out
                                                        value="${order.totalItems}"/></span>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-center gap-3">
                                                <h5 class="fw-extrabold text-dark m-0">$<c:out
                                                        value="${order.totalPrice}"/></h5>
                                                <a href="order-invoice?id=${order.id}"
                                                   class="btn btn-white bg-white border border-secondary-subtle btn-sm rounded-2 fw-semibold px-3">Details</a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- TAB 3: SECURITY AUTHENTICATION FORMS -->
                <div class="tab-pane fade" id="v-pills-security" role="tabpanel" aria-labelledby="v-pills-security-tab">
                    <div class="profile-card p-4 p-md-5 shadow-sm bg-white">
                        <h4 class="fw-bold mb-1">Security Parameters</h4>
                        <p class="text-muted small mb-4">Modify your platform encryption credential tokens
                            regularly.</p>

                        <form action="profile-update" method="POST">
                            <input type="hidden" name="action" value="updatePassword">
                            <div class="d-flex flex-column gap-3">
                                <div>
                                    <label class="form-label small fw-bold text-muted">Current Password</label>
                                    <input type="password" name="oldPassword"
                                           class="form-control py-2.5 rounded-3 border-light bg-light" required>
                                </div>
                                <div>
                                    <label class="form-label small fw-bold text-muted">New Secure Password</label>
                                    <input type="password" name="newPassword"
                                           class="form-control py-2.5 rounded-3 border-light bg-light" required>
                                </div>
                                <div>
                                    <label class="form-label small fw-bold text-muted">Confirm New Password</label>
                                    <input type="password" name="confirmPassword"
                                           class="form-control py-2.5 rounded-3 border-light bg-light" required>
                                </div>
                            </div>
                            <button type="submit"
                                    class="btn btn-outline-danger px-4 py-2.5 fw-semibold rounded-3 mt-4 shadow-sm">
                                Update Authentication Token
                            </button>
                        </form>
                    </div>
                </div>

            </div>
        </div>

    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>