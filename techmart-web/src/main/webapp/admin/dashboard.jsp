<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Operations Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Context-safe path to local style layout sheet -->
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet">

    <style>
        body {
            background-color: #f1f5f9; /* Fixed missing custom property variable */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .stat-card {
            border-radius: 12px; /* Fixed missing custom property variable */
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .stat-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.08) !important;
        }
        .status-dot {
            width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }
        .table-responsive {
            scrollbar-width: thin;
        }
    </style>
</head>
<body>

<!-- Dynamic Context Component Include -->
<jsp:include page="components/adminNavbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

    <!-- Welcome banner row -->
    <div class="row align-items-center justify-content-between mb-5 g-3">
        <div class="col-12 col-md-auto">
            <h1 class="display-6 fw-extrabold text-dark tracking-tight mb-1">Operations Overview</h1>
            <p class="text-secondary m-0">Real-time status updates across procurement channels and inventory pipelines.</p>
        </div>
        <div class="col-12 col-md-auto">
            <div class="d-flex gap-2">
                <button class="btn btn-white border shadow-sm text-dark bg-white fw-semibold px-3 py-2 d-flex align-items-center gap-2">
                    <i class="bi bi-download"></i> Export Logs
                </button>
                <a href="${pageContext.request.contextPath}/admin/products?action=new" class="btn btn-primary fw-semibold px-3 py-2 d-flex align-items-center gap-2">
                    <i class="bi bi-plus-lg"></i> Add New Product
                </a>
            </div>
        </div>
    </div>

    <!-- HIGH-LEVEL KPI METRICS ROW -->
    <div class="row g-4 mb-5">
        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card stat-card shadow-sm p-4 bg-white border-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase tracking-wider">Gross Volume</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1">$142,380.50</h3>
                        <span class="text-success small fw-medium d-flex align-items-center gap-1">
                            <i class="bi bi-arrow-up-right"></i> +12.4% <span class="text-muted fw-normal font-monospace" style="font-size: 0.75rem;">mo/mo</span>
                        </span>
                    </div>
                    <div class="p-3 bg-primary bg-opacity-10 text-primary rounded-4">
                        <i class="bi bi-currency-dollar fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card stat-card shadow-sm p-4 bg-white border-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase tracking-wider">Active Orders</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1">48 Units</h3>
                        <span class="text-warning small fw-medium d-flex align-items-center gap-1">
                            <i class="bi bi-clock-history"></i> 12 Pending logistics
                        </span>
                    </div>
                    <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-4">
                        <i class="bi bi-cart-fill fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card stat-card shadow-sm p-4 bg-white border-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase tracking-wider">Catalog SKUs</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1">1,245 SKUs</h3>
                        <span class="text-muted small d-flex align-items-center gap-1">
                            <span class="status-dot bg-danger"></span> 4 Items out of stock
                        </span>
                    </div>
                    <div class="p-3 bg-info bg-opacity-10 text-info rounded-4">
                        <i class="bi bi-laptop fs-3"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-12 col-sm-6 col-xl-3">
            <div class="card stat-card shadow-sm p-4 bg-white border-0">
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase tracking-wider">Verification Queue</span>
                        <h3 class="fw-bold text-dark mt-2 mb-1">7 Accounts</h3>
                        <span class="text-primary small fw-semibold d-flex align-items-center gap-1">
                            <i class="bi bi-shield-check"></i> Internal registrations
                        </span>
                    </div>
                    <div class="p-3 bg-success bg-opacity-10 text-success rounded-4">
                        <i class="bi bi-people-fill fs-3"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- DATA AND TRANSACTION SPLIT PANELS -->
    <div class="row g-5">
        <!-- Left Panel: Recent Orders -->
        <div class="col-12 col-xl-8">
            <div class="card shadow-sm border-0 bg-white rounded-4 p-4">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h4 class="fw-bold text-dark m-0">Recent Order Streams</h4>
                        <p class="text-muted small m-0">Live transactions occurring within your enterprise app context.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-link text-decoration-none fw-semibold small p-0 text-primary">View All</a>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light text-secondary border-0 small text-uppercase">
                        <tr>
                            <th class="border-0 ps-3 py-3">Order ID</th>
                            <th class="border-0 py-3">Client</th>
                            <th class="border-0 py-3">Hardware Items</th>
                            <th class="border-0 py-3">Total Cost</th>
                            <th class="border-0 py-3">Status</th>
                            <th class="border-0 pe-3 py-3 text-end">Action</th>
                        </tr>
                        </thead>
                        <tbody class="text-dark small">
                        <tr>
                            <td class="ps-3 fw-bold font-monospace text-primary">#TM-9204</td>
                            <td>
                                <div class="fw-semibold">Alice Vance</div>
                                <div class="text-muted text-truncate" style="max-width: 130px; font-size: 0.75rem;">alice@vance.inc</div>
                            </td>
                            <td>MacBook Pro M3 (x2)</td>
                            <td class="fw-semibold">$3,998.00</td>
                            <td><span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2 py-1 fw-semibold">Dispatched</span></td>
                            <td class="pe-3 text-end"><a href="#" class="btn btn-light btn-sm px-2 py-1"><i class="bi bi-eye-fill"></i></a></td>
                        </tr>
                        <tr>
                            <td class="ps-3 fw-bold font-monospace text-primary">#TM-9203</td>
                            <td>
                                <div class="fw-semibold">Marcus Vance</div>
                                <div class="text-muted text-truncate" style="max-width: 130px; font-size: 0.75rem;">m.vance@tech.co</div>
                            </td>
                            <td>Logitech MX Master (x5)</td>
                            <td class="fw-semibold">$499.95</td>
                            <td><span class="badge bg-warning bg-opacity-10 text-warning rounded-pill px-2 py-1 fw-semibold">Processing</span></td>
                            <td class="pe-3 text-end"><a href="#" class="btn btn-light btn-sm px-2 py-1"><i class="bi bi-eye-fill"></i></a></td>
                        </tr>
                        <tr>
                            <td class="ps-3 fw-bold font-monospace text-primary">#TM-9202</td>
                            <td>
                                <div class="fw-semibold">David K.</div>
                                <div class="text-muted text-truncate" style="max-width: 130px; font-size: 0.75rem;">david@cloudlabs.io</div>
                            </td>
                            <td>Dell UltraSharp 32" (x1)</td>
                            <td class="fw-semibold">$849.00</td>
                            <td><span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-2 py-1 fw-semibold">Cancelled</span></td>
                            <td class="pe-3 text-end"><a href="#" class="btn btn-light btn-sm px-2 py-1"><i class="bi bi-eye-fill"></i></a></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Right Panel: Low Stock Alerts -->
        <div class="col-12 col-xl-4">
            <div class="card shadow-sm border-0 bg-white rounded-4 p-4">
                <div class="mb-4">
                    <h4 class="fw-bold text-dark m-0">Critical Stock Alerts</h4>
                    <p class="text-muted small m-0">Items running below automated fallback safety bounds.</p>
                </div>

                <div class="d-flex flex-column gap-3">
                    <div class="p-3 rounded-3 border bg-light d-flex align-items-center justify-content-between">
                        <div class="d-flex gap-3 align-items-center min-w-0">
                            <div class="p-2 bg-danger bg-opacity-10 text-danger rounded-2 flex-shrink-0">
                                <i class="bi bi-exclamation-triangle-fill fs-5"></i>
                            </div>
                            <div class="min-w-0">
                                <h6 class="fw-bold text-dark mb-0 text-truncate" style="font-size: 0.9rem;">iPhone 15 Pro Max</h6>
                                <p class="text-muted small mb-0 font-monospace" style="font-size: 0.75rem;">SKU: TM-IP15PM</p>
                            </div>
                        </div>
                        <div class="text-end flex-shrink-0 ps-2">
                            <span class="badge bg-danger text-white rounded-1 fw-bold">1 Left</span>
                        </div>
                    </div>

                    <div class="p-3 rounded-3 border bg-light d-flex align-items-center justify-content-between">
                        <div class="d-flex gap-3 align-items-center min-w-0">
                            <div class="p-2 bg-warning bg-opacity-10 text-warning rounded-2 flex-shrink-0">
                                <i class="bi bi-shield-alert fs-5"></i>
                            </div>
                            <div class="min-w-0">
                                <h6 class="fw-bold text-dark mb-0 text-truncate" style="font-size: 0.9rem;">Sony WH-1000XM5</h6>
                                <p class="text-muted small mb-0 font-monospace" style="font-size: 0.75rem;">SKU: TM-SNYXM5</p>
                            </div>
                        </div>
                        <div class="text-end flex-shrink-0 ps-2">
                            <span class="badge bg-warning text-dark rounded-1 fw-bold">3 Left</span>
                        </div>
                    </div>
                </div>

                <div class="mt-4 pt-2">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline-primary btn-sm w-100 py-2 fw-semibold">
                        Open Stock Management Console
                    </a>
                </div>
            </div>
        </div>
    </div>
</main>

<jsp:include page="components/adminFooter.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>