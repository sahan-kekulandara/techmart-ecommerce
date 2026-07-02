<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>TechMart - Order Settlement & Streams</title>
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
    .order-badge-processing { background-color: rgba(245, 158, 11, 0.1); color: #d97706; }
    .order-badge-dispatched { background-color: rgba(16, 185, 129, 0.1); color: #059669; }
    .order-badge-cancelled { background-color: rgba(239, 68, 68, 0.1); color: #dc2626; }
    .table-responsive { scrollbar-width: thin; }
  </style>
</head>
<body>

<jsp:include page="components/adminNavbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

  <div class="row align-items-center justify-content-between mb-5 g-3">
    <div class="col-12 col-md-auto">
      <h1 class="display-6 fw-extrabold text-dark tracking-tight mb-1">Order Settlement Streams</h1>
      <p class="text-secondary m-0">Track real-time transactions clearing Stripe pass-through gateways and update delivery logistical flows.</p>
    </div>
    <div class="col-12 col-md-auto">
      <button class="btn btn-white border shadow-sm text-dark bg-white fw-semibold px-3 py-2 d-flex align-items-center gap-2 rounded-3">
        <i class="bi bi-filter-square"></i> Advanced Query Filters
      </button>
    </div>
  </div>

  <div class="card shadow-sm border-0 bg-white rounded-4 p-4">
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
      <div>
        <h4 class="fw-bold text-dark m-0">Live Purchase Pipeline</h4>
        <p class="text-muted small m-0">Audit client settlement states and control execution lifecycle boundaries.</p>
      </div>

      <div class="btn-group btn-group-sm p-1 bg-light rounded-3">
        <button type="button" class="btn btn-white shadow-sm border-0 small fw-semibold text-dark px-3 py-1.5 rounded-2">All Streams</button>
        <button type="button" class="btn text-secondary small fw-medium px-3">Processing</button>
        <button type="button" class="btn text-secondary small fw-medium px-3">Dispatched</button>
      </div>
    </div>

    <div class="table-responsive">
      <table class="table table-hover align-middle mb-0">
        <thead class="table-light text-secondary border-0 small text-uppercase">
        <tr>
          <th class="border-0 ps-3 py-3">Order ID</th>
          <th class="border-0 py-3">Client Identity</th>
          <th class="border-0 py-3">Stripe Reference</th>
          <th class="border-0 py-3">Total Value</th>
          <th class="border-0 py-3">Status</th>
          <th class="border-0 pe-3 py-3 text-end" style="width: 140px;">Operations</th>
        </tr>
        </thead>
        <tbody class="text-dark small">
        <tr>
          <td class="ps-3 font-monospace fw-bold text-primary">#TM-9203</td>
          <td>
            <div class="fw-bold text-dark">Marcus Vance</div>
            <div class="text-muted font-monospace" style="font-size: 0.72rem;">m.vance@tech.co</div>
          </td>
          <td class="font-monospace text-secondary text-truncate" style="max-width: 150px;">cs_live_a1B2c3D4...</td>
          <td class="fw-bold">$499.95</td>
          <td>
            <span class="badge order-badge-processing rounded-pill px-2.5 py-1.5 fw-semibold">Processing</span>
          </td>
          <td class="pe-3 text-end">
            <button class="btn btn-primary btn-sm px-3 py-1.5 fw-semibold rounded-2"
                    data-bs-toggle="modal" data-bs-target="#orderDetailsModal"
                    onclick="loadOrderDetails('#TM-9203', 'Marcus Vance', 'm.vance@tech.co', '$499.95', 'Processing', 'Logitech MX Master (x5)', '128 TechMart Blvd, Building 4B, Austin, TX 73301')">
              Manage
            </button>
          </td>
        </tr>

        <tr>
          <td class="ps-3 font-monospace fw-bold text-primary">#TM-9204</td>
          <td>
            <div class="fw-bold text-dark">Alice Vance</div>
            <div class="text-muted font-monospace" style="font-size: 0.72rem;">alice@vance.inc</div>
          </td>
          <td class="font-monospace text-secondary text-truncate" style="max-width: 150px;">cs_live_z9Y8x7W6...</td>
          <td class="fw-bold">$3,998.00</td>
          <td>
            <span class="badge order-badge-dispatched rounded-pill px-2.5 py-1.5 fw-semibold">Dispatched</span>
          </td>
          <td class="pe-3 text-end">
            <button class="btn btn-light btn-sm px-3 py-1.5 fw-medium text-secondary border rounded-2"
                    data-bs-toggle="modal" data-bs-target="#orderDetailsModal"
                    onclick="loadOrderDetails('#TM-9204', 'Alice Vance', 'alice@vance.inc', '$3,998.00', 'Dispatched', 'MacBook Pro M3 (x2)', '55 Market St, Floor 12, San Francisco, CA 94105')">
              View Logs
            </button>
          </td>
        </tr>
        </tbody>
      </table>
    </div>
  </div>
</main>

<div class="modal fade" id="orderDetailsModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-md">
    <div class="modal-content border-0 shadow rounded-4">

      <div class="modal-header border-bottom px-4 py-3">
        <h5 class="modal-title fw-extrabold text-dark" id="modalTitle">Pipeline Hub</h5>
        <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <form action="${pageContext.request.contextPath}/admin/orders" method="POST">
        <div class="modal-body p-4">
          <input type="hidden" id="modalOrderIdInput" name="orderId" value="">

          <div class="mb-4">
            <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider mb-1">Customer Profile & Contact</label>
            <div class="p-3 bg-light rounded-3 border">
              <div class="fw-bold text-dark" id="modalClientName">---</div>
              <div class="text-muted font-monospace small" id="modalClientEmail">---</div>
            </div>
          </div>

          <div class="mb-4">
            <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider mb-1">Line-item Manifest Details</label>
            <div class="p-3 bg-light rounded-3 border fw-semibold text-dark" id="modalItemsDescription">---</div>
          </div>

          <div class="mb-4">
            <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider mb-1">Verified Shipping Destination</label>
            <div class="p-3 bg-light rounded-3 border small text-secondary" id="modalShippingAddress">---</div>
          </div>

          <div class="row g-3">
            <div class="col-6">
              <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider">Gross Settlement</label>
              <div class="h4 fw-extrabold text-dark mt-1" id="modalTotalCost">---</div>
            </div>
            <div class="col-6">
              <label class="form-label text-secondary small fw-bold text-uppercase tracking-wider">Logistical State Transition</label>
              <select id="modalStatusSelect" name="status" class="form-select rounded-3 py-2 shadow-none mt-1 fw-semibold">
                <option value="Processing">Processing</option>
                <option value="Dispatched">Dispatched</option>
                <option value="Cancelled">Cancelled</option>
              </select>
            </div>
          </div>

        </div>
        <div class="modal-footer border-top px-4 py-3 bg-light rounded-bottom-4">
          <button type="button" class="btn btn-white border text-dark bg-white fw-semibold px-3 py-2 shadow-none" data-bs-dismiss="modal">Close</button>
          <button type="submit" class="btn btn-primary fw-semibold px-4 py-2">Commit Pipeline Transition</button>
        </div>
      </form>

    </div>
  </div>
</div>

<jsp:include page="components/adminFooter.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
  function loadOrderDetails(id, clientName, email, cost, status, items, address) {
    document.getElementById('modalTitle').innerText = "Manage Transaction Status " + id;
    document.getElementById('modalOrderIdInput').value = id;
    document.getElementById('modalClientName').innerText = clientName;
    document.getElementById('modalClientEmail').innerText = email;
    document.getElementById('modalTotalCost').innerText = cost;
    document.getElementById('modalItemsDescription').innerText = items;
    document.getElementById('modalShippingAddress').innerText = address;

    // Match the status selector string dynamically
    document.getElementById('modalStatusSelect').value = status;
  }
</script>
</body>
</html>