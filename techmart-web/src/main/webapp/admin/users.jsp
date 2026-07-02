<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - User Base & Identity Control</title>
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
        .user-initials-avatar {
            width: 40px;
            height: 40px;
            font-size: 0.85rem;
        }
        .table-responsive { scrollbar-width: thin; }
    </style>
</head>
<body>

<jsp:include page="components/adminNavbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

    <div class="row align-items-center justify-content-between mb-5 g-3">
        <div class="col-12 col-md-auto">
            <h1 class="display-6 fw-extrabold text-dark tracking-tight mb-1">User Base Auditing</h1>
            <p class="text-secondary m-0">Manage security clearances, audit customer profile registrations, and restrict fraudulent client accounts.</p>
        </div>
        <div class="col-12 col-md-auto">
            <div class="d-flex gap-2">
                <button class="btn btn-white border shadow-sm text-dark bg-white fw-semibold px-3 py-2 d-flex align-items-center gap-2 rounded-3">
                    <i class="bi bi-shield-lock-fill text-primary"></i> View Security Log History
                </button>
            </div>
        </div>
    </div>

    <div class="card shadow-sm border-0 bg-white rounded-4 p-4">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
            <div>
                <h4 class="fw-bold text-dark m-0">Registered Profiles Directory</h4>
                <p class="text-muted small m-0">Synchronized list of identity profiles managed across data security boundaries.</p>
            </div>

            <div style="max-width: 300px;" class="w-100">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-filter"></i></span>
                    <input type="text" class="form-control bg-light border-start-0 small shadow-none" placeholder="Filter by email or name...">
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light text-secondary border-0 small text-uppercase">
                <tr>
                    <th class="border-0 ps-3 py-3">User Profile</th>
                    <th class="border-0 py-3">Account Email</th>
                    <th class="border-0 py-3">Assigned Role</th>
                    <th class="border-0 py-3">Security Access State</th>
                    <th class="border-0 pe-3 py-3 text-end" style="width: 160px;">Identity Settings</th>
                </tr>
                </thead>
                <tbody class="text-dark small">
                <tr>
                    <td class="ps-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-circle bg-primary bg-opacity-10 text-primary d-flex align-items-center justify-content-center fw-bold user-initials-avatar">
                                AV
                            </div>
                            <div>
                                <div class="fw-bold text-dark">Alice Vance</div>
                                <div class="text-muted extra-small" style="font-size: 0.72rem;">ID: 10402</div>
                            </div>
                        </div>
                    </td>
                    <td class="font-monospace text-secondary">alice@vance.inc</td>
                    <td>
                        <span class="badge bg-secondary bg-opacity-10 text-dark font-monospace fw-semibold rounded-2 px-2 py-1">CUSTOMER</span>
                    </td>
                    <td>
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2.5 py-1 fw-semibold">Active Clear</span>
                    </td>
                    <td class="pe-3 text-end">
                        <button class="btn btn-light btn-sm border px-2.5 py-1.5 fw-semibold text-secondary rounded-2"
                                data-bs-toggle="modal" data-bs-target="#userConfigModal"
                                onclick="populateUserModal('10402', 'Alice Vance', 'alice@vance.inc', 'CUSTOMER', 'ACTIVE')">
                            <i class="bi bi-shield-gear"></i> Configure
                        </button>
                    </td>
                </tr>

                <tr>
                    <td class="ps-3">
                        <div class="d-flex align-items-center gap-3">
                            <div class="rounded-circle bg-danger bg-opacity-10 text-danger d-flex align-items-center justify-content-center fw-bold user-initials-avatar">
                                DK
                            </div>
                            <div>
                                <div class="fw-bold text-dark">David K.</div>
                                <div class="text-muted extra-small" style="font-size: 0.72rem;">ID: 10398</div>
                            </div>
                        </div>
                    </td>
                    <td class="font-monospace text-secondary">david@cloudlabs.io</td>
                    <td>
                        <span class="badge bg-secondary bg-opacity-10 text-dark font-monospace fw-semibold rounded-2 px-2 py-1">CUSTOMER</span>
                    </td>
                    <td>
                        <span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-2.5 py-1 fw-semibold">Suspended</span>
                    </td>
                    <td class="pe-3 text-end">
                        <button class="btn btn-light btn-sm border px-2.5 py-1.5 fw-semibold text-secondary rounded-2"
                                data-bs-toggle="modal" data-bs-target="#userConfigModal"
                                onclick="populateUserModal('10398', 'David K.', 'david@cloudlabs.io', 'CUSTOMER', 'SUSPENDED')">
                            <i class="bi bi-shield-gear"></i> Configure
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</main>

<div class="modal fade" id="userConfigModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="userModalTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-md">
        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header border-bottom px-4 py-3">
                <h5 class="modal-title fw-extrabold text-dark" id="userModalTitle">Modify User Clearances</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="${pageContext.request.contextPath}/admin/users/update" method="POST">
                <div class="modal-body p-4">

                    <input type="hidden" id="modalUserIdInput" name="userId" value="">

                    <div class="mb-4">
                        <label class="form-label text-secondary small fw-bold text-uppercase mb-1">Target Account Profile</label>
                        <div class="p-3 bg-light border rounded-3">
                            <div class="fw-bold text-dark animate-profile" id="modalUserNameDisplay">---</div>
                            <div class="text-muted font-monospace small" id="modalUserEmailDisplay">---</div>
                        </div>
                    </div>

                    <div class="row g-3">
                        <div class="col-6">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Platform Role Policy</label>
                            <select id="modalRoleSelect" name="role" class="form-select rounded-3 py-2 shadow-none mt-1 fw-semibold">
                                <option value="CUSTOMER">Customer Account</option>
                                <option value="ADMIN">Platform Administrator</option>
                            </select>
                        </div>

                        <div class="col-6">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Security Status Flag</label>
                            <select id="modalStatusSelect" name="status" class="form-select rounded-3 py-2 shadow-none mt-1 fw-semibold">
                                <option value="ACTIVE">Active Clear</option>
                                <option value="SUSPENDED">Suspended / Blocked</option>
                            </select>
                        </div>
                    </div>

                </div>
                <div class="modal-footer border-top px-4 py-3 bg-light rounded-bottom-4">
                    <button type="button" class="btn btn-white border text-dark bg-white fw-semibold px-3 py-2" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary fw-semibold px-4 py-2">Apply Security Policy</button>
                </div>
            </form>

        </div>
    </div>
</div>

<jsp:include page="components/adminFooter.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function populateUserModal(id, name, email, role, status) {
        document.getElementById('modalUserIdInput').value = id;
        document.getElementById('modalUserNameDisplay').innerText = name + " (ID: " + id + ")";
        document.getElementById('modalUserEmailDisplay').innerText = email;

        // Match selection inputs with entity model details
        document.getElementById('modalRoleSelect').value = role;
        document.getElementById('modalStatusSelect').value = status;
    }
</script>
</body>
</html>