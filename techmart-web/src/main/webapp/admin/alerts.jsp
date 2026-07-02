<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Stock Surveillance Hub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .alert-card-danger {
            border-left: 4px solid #ef4444 !important;
        }
        .alert-card-warning {
            border-left: 4px solid #f59e0b !important;
        }
        .surveillance-metric {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
        }
    </style>
</head>
<body>

<jsp:include page="components/adminNavbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

    <div class="row align-items-center justify-content-between mb-5 g-3">
        <div class="col-12 col-md-auto">
            <h1 class="display-6 fw-extrabold text-dark tracking-tight mb-1">Stock Surveillance</h1>
            <p class="text-secondary m-0">Automated monitoring of inventory pipelines triggering immediate replenishment boundaries.</p>
        </div>
        <div class="col-12 col-md-auto">
            <button class="btn btn-dark fw-semibold px-3 py-2.5 d-flex align-items-center gap-2 rounded-3 shadow-sm"
                    data-bs-toggle="modal" data-bs-target="#thresholdSettingsModal">
                <i class="bi bi-sliders2-vertical"></i> Adjust Threshold Bounds
            </button>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-12 col-md-4">
            <div class="card surveillance-metric text-white border-0 shadow-sm p-4 rounded-4">
                <span class="text-slate-400 small fw-bold text-uppercase tracking-wider opacity-75">Active Breaches</span>
                <h2 class="display-5 fw-extrabold my-2 text-warning">2 SKUs</h2>
                <p class="small text-muted mb-0 d-flex align-items-center gap-2">
                    <span class="status-dot bg-danger" style="width:8px; height:8px; border-radius:50%;"></span> Items running out of stock.
                </p>
            </div>
        </div>
        <div class="col-12 col-md-8">
            <div class="card border-0 bg-white p-4 rounded-4 shadow-sm h-100 d-flex justify-content-center">
                <div class="row text-center g-3">
                    <div class="col-4 border-end">
                        <div class="text-muted small fw-medium mb-1">Global Buffer Limit</div>
                        <h4 class="fw-bold text-dark m-0">5 Units</h4>
                    </div>
                    <div class="col-4 border-end">
                        <div class="text-muted small fw-medium mb-1">Procurement Pipeline</div>
                        <h4 class="fw-bold text-primary m-0">3 Pending</h4>
                    </div>
                    <div class="col-4">
                        <div class="text-muted small fw-medium mb-1">Auto-Restock Email</div>
                        <h4 class="fw-bold text-success m-0">Enabled</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-4">Critical Replenishment Queue</h4>

    <div class="d-flex flex-column gap-3 mb-5">

        <div class="card border-0 bg-white shadow-sm p-4 rounded-4 alert-card-danger">
            <div class="row align-items-center g-3">
                <div class="col-12 col-lg-6">
                    <div class="d-flex gap-3 align-items-center">
                        <div class="p-3 bg-danger bg-opacity-10 text-danger rounded-3">
                            <i class="bi bi-exclamation-triangle-fill fs-4"></i>
                        </div>
                        <div>
                            <div class="d-flex align-items-center gap-2">
                                <h5 class="fw-bold text-dark m-0">iPhone 15 Pro Max</h5>
                                <span class="badge bg-danger text-white rounded-1 font-monospace small">CRITICAL CRUNCH</span>
                            </div>
                            <p class="text-muted font-monospace small mb-0 mt-1">SKU: TM-IP15PM | Warehouse Location: Zone-A3</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 text-lg-center">
                    <div class="text-muted small">Current Level / Safety Bound</div>
                    <div class="h5 fw-extrabold text-danger mt-1">1 Unit left <span class="text-muted fw-normal fs-6">/ 5 units</span></div>
                </div>
                <div class="col-6 col-lg-3 text-end">
                    <form action="${pageContext.request.contextPath}/admin/surveillance/restock" method="POST" class="d-inline">
                        <input type="hidden" name="sku" value="TM-IP15PM">
                        <button type="submit" class="btn btn-outline-danger fw-semibold btn-md px-3 py-2 rounded-3 shadow-none">
                            <i class="bi bi-mailbox2"></i> Trigger Supplier PO
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <div class="card border-0 bg-white shadow-sm p-4 rounded-4 alert-card-warning">
            <div class="row align-items-center g-3">
                <div class="col-12 col-lg-6">
                    <div class="d-flex gap-3 align-items-center">
                        <div class="p-3 bg-warning bg-opacity-10 text-warning rounded-3">
                            <i class="bi bi-shield-alert fs-4"></i>
                        </div>
                        <div>
                            <div class="d-flex align-items-center gap-2">
                                <h5 class="fw-bold text-dark m-0">Sony WH-1000XM5</h5>
                                <span class="badge bg-warning text-dark rounded-1 font-monospace small">LOW STOCK BUFFER</span>
                            </div>
                            <p class="text-muted font-monospace small mb-0 mt-1">SKU: TM-SNYXM5 | Warehouse Location: Zone-B1</p>
                        </div>
                    </div>
                </div>
                <div class="col-6 col-lg-3 text-lg-center">
                    <div class="text-muted small">Current Level / Safety Bound</div>
                    <div class="h5 fw-extrabold text-warning mt-1">3 Units left <span class="text-muted fw-normal fs-6">/ 5 units</span></div>
                </div>
                <div class="col-6 col-lg-3 text-end">
                    <form action="${pageContext.request.contextPath}/admin/surveillance/restock" method="POST" class="d-inline">
                        <input type="hidden" name="sku" value="TM-SNYXM5">
                        <button type="submit" class="btn btn-outline-warning fw-semibold btn-md px-3 py-2 rounded-3 shadow-none">
                            <i class="bi bi-mailbox2"></i> Trigger Supplier PO
                        </button>
                    </form>
                </div>
            </div>
        </div>

    </div>
</main>

<div class="modal fade" id="thresholdSettingsModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="modalSettingsTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow rounded-4">
            <div class="modal-header border-bottom px-4 py-3">
                <h5 class="modal-title fw-extrabold text-dark" id="modalSettingsTitle">Surveillance Configurations</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/surveillance/config" method="POST">
                <div class="modal-body p-4">
                    <div class="mb-4">
                        <label class="form-label text-secondary small fw-bold text-uppercase mb-2">Global Minimum Safety Buffer</label>
                        <div class="input-group">
                            <input type="number" name="globalLimit" class="form-control rounded-3 py-2 shadow-none" value="5" required>
                            <span class="input-group-text bg-light text-muted">Units</span>
                        </div>
                        <small class="text-muted d-block mt-2">When items hit or drop below this quantity parameter, automated alert system tags flag visibility.</small>
                    </div>
                    <div class="form-check form-switch py-1">
                        <input class="form-check-input shadow-none" type="checkbox" role="switch" id="autoEmailCheck" name="autoNotify" checked>
                        <label class="form-check-label fw-semibold text-dark ms-2" for="autoEmailCheck">Automated Supplier Email Pings</label>
                    </div>
                </div>
                <div class="modal-footer border-top px-4 py-3 bg-light rounded-bottom-4">
                    <button type="button" class="btn btn-white border text-dark bg-white fw-semibold px-3 py-2" data-bs-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary fw-semibold px-4 py-2">Apply Global Bounds</button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="components/adminFooter.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>