<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Inventory & Catalog Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2=family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/style.css" rel="stylesheet">

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: #f1f5f9;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .product-card {
            border-radius: 12px;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .product-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1.5rem rgba(0, 0, 0, 0.05) !important;
        }
        .thumbnail-box {
            width: 48px;
            height: 48px;
            background-color: #f8fafc;
            border: 1px solid #e2e8f0;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .table-responsive {
            scrollbar-width: thin;
        }
    </style>
</head>
<body>

<jsp:include page="components/adminNavbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

    <div class="row align-items-center justify-content-between mb-5 g-3">
        <div class="col-12 col-md-auto">
            <h1 class="display-6 fw-extrabold text-dark tracking-tight mb-1">Inventory Management</h1>
            <p class="text-secondary m-0">Create new SKUs, update real-time warehousing stock numbers, and manage store catalog listings.</p>
        </div>
        <div class="col-12 col-md-auto">
            <button class="btn btn-primary fw-semibold px-4 py-2.5 d-flex align-items-center gap-2 shadow-sm rounded-3"
                    data-bs-toggle="modal" data-bs-target="#productFormModal" onclick="prepareCreateForm()">
                <i class="bi bi-plus-lg fs-5"></i> Add New Product SKU
            </button>
        </div>
    </div>

    <div class="card shadow-sm border-0 bg-white rounded-4 p-4">
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
            <div>
                <h4 class="fw-bold text-dark m-0">Active Hardware Catalog</h4>
                <p class="text-muted small m-0">Showing available items synchronized across database repository entities.</p>
            </div>

            <div style="max-width: 320px;" class="w-100">
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-search"></i></span>
                    <input type="text" class="form-control bg-light border-start-0 small shadow-none" placeholder="Search SKU or name...">
                </div>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light text-secondary border-0 small text-uppercase">
                <tr>
                    <th class="border-0 ps-3 py-3" style="width: 80px;">Item</th>
                    <th class="border-0 py-3">Product Specifications</th>
                    <th class="border-0 py-3">SKU Identifier</th>
                    <th class="border-0 py-3">Price Unit</th>
                    <th class="border-0 py-3">Stock Available</th>
                    <th class="border-0 py-3">Catalog Visibility Status</th>
                    <th class="border-0 pe-3 py-3 text-end" style="width: 120px;">Actions</th>
                </tr>
                </thead>
                <tbody class="text-dark small">
                <tr>
                    <td class="ps-3">
                        <div class="thumbnail-box">
                            <i class="bi bi-laptop text-primary fs-4"></i>
                        </div>
                    </td>
                    <td>
                        <div class="fw-bold text-dark">MacBook Pro M3 Max</div>
                        <div class="text-muted text-truncate" style="max-width: 280px; font-size: 0.75rem;">14-inch, 16GB Unified Memory, 512GB SSD Storage</div>
                    </td>
                    <td class="font-monospace fw-semibold text-secondary">TM-MBP14M3</td>
                    <td class="fw-bold">$1,999.00</td>
                    <td>
                        <span class="fw-bold text-dark">45 Units</span>
                    </td>
                    <td>
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2.5 py-1.5 fw-semibold">Active Storefront</span>
                    </td>
                    <td class="pe-3 text-end">
                        <div class="d-inline-flex gap-1">
                            <button class="btn btn-light btn-sm p-2" title="Edit Item" data-bs-toggle="modal" data-bs-target="#productFormModal" onclick="prepareEditForm('1', 'MacBook Pro M3 Max', 'TM-MBP14M3', '1999.00', '45', '14-inch, 16GB RAM, 512GB SSD')">
                                <i class="bi bi-pencil-square text-secondary"></i>
                            </button>
                            <button class="btn btn-light btn-sm p-2" title="Archive / Delete Product"><i class="bi bi-trash3-fill text-danger"></i></button>
                        </div>
                    </td>
                </tr>

                <tr>
                    <td class="ps-3">
                        <div class="thumbnail-box">
                            <i class="bi bi-phone text-primary fs-4"></i>
                        </div>
                    </td>
                    <td>
                        <div class="fw-bold text-dark">iPhone 15 Pro Max</div>
                        <div class="text-muted text-truncate" style="max-width: 280px; font-size: 0.75rem;">Natural Titanium, 256GB Storage Allocation</div>
                    </td>
                    <td class="font-monospace fw-semibold text-secondary">TM-IP15PM</td>
                    <td class="fw-bold">$1,199.00</td>
                    <td>
                        <span class="badge bg-danger text-white rounded-1 fw-bold">1 Unit Left</span>
                    </td>
                    <td>
                        <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-2.5 py-1.5 fw-semibold">Active Storefront</span>
                    </td>
                    <td class="pe-3 text-end">
                        <div class="d-inline-flex gap-1">
                            <button class="btn btn-light btn-sm p-2" data-bs-toggle="modal" data-bs-target="#productFormModal" onclick="prepareEditForm('2', 'iPhone 15 Pro Max', 'TM-IP15PM', '1199.00', '1', 'Natural Titanium, 256GB')"><i class="bi bi-pencil-square text-secondary"></i></button>
                            <button class="btn btn-light btn-sm p-2"><i class="bi bi-trash3-fill text-danger"></i></button>
                        </div>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</main>

<div class="modal fade" id="productFormModal" data-bs-backdrop="static" tabindex="-1" aria-labelledby="formTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content border-0 shadow rounded-4">

            <div class="modal-header border-bottom px-4 py-3">
                <h5 class="modal-title fw-extrabold text-dark" id="formTitle">Add New Catalog SKU</h5>
                <button type="button" class="btn-close shadow-none" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <form action="${pageContext.request.contextPath}/admin/products" method="POST">
                <div class="modal-body p-4">

                    <input type="hidden" id="productActionId" name="action" value="create">
                    <input type="hidden" id="formProductId" name="productId" value="">

                    <div class="row g-3">
                        <div class="col-12 col-md-8">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Product Title Name</label>
                            <input type="text" id="formTitleInput" name="name" class="form-control rounded-3 py-2 shadow-none" placeholder="e.g., Sony WH-1000XM5" required>
                        </div>
                        <div class="col-12 col-md-4">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Unique SKU Code</label>
                            <input type="text" id="formSkuInput" name="sku" class="form-control rounded-3 py-2 font-monospace shadow-none" placeholder="TM-SNYXM5" required>
                        </div>

                        <div class="col-12 col-md-6">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Base Price (USD)</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white">$</span>
                                <input type="number" id="formPriceInput" name="price" step="0.01" class="form-control rounded-end-3 py-2 shadow-none" placeholder="0.00" required>
                            </div>
                        </div>
                        <div class="col-12 col-md-6">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Initial Stock Warehoused</label>
                            <input type="number" id="formStockInput" name="stock" class="form-control rounded-3 py-2 shadow-none" placeholder="0" required>
                        </div>

                        <div class="col-12">
                            <label class="form-label text-secondary small fw-bold text-uppercase">Technical Specifications / Description</label>
                            <textarea id="formDescInput" name="description" rows="3" class="form-control rounded-3 shadow-none" placeholder="Describe key functional system details..."></textarea>
                        </div>
                    </div>

                </div>
                <div class="modal-footer border-top px-4 py-3 bg-light rounded-bottom-4">
                    <button type="button" class="btn btn-white border text-dark bg-white fw-semibold px-3 py-2" data-bs-toggle="modal">Cancel</button>
                    <button type="submit" id="submitFormButton" class="btn btn-primary fw-semibold px-4 py-2">Save Product SKU</button>
                </div>
            </form>

        </div>
    </div>
</div>

<jsp:include page="components/adminFooter.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function prepareCreateForm() {
        document.getElementById('formTitle').innerText = "Add New Catalog SKU";
        document.getElementById('productActionId').value = "create";
        document.getElementById('formProductId').value = "";
        document.getElementById('submitFormButton').innerText = "Save Product SKU";

        // Reset old text inside input fields
        document.getElementById('formTitleInput').value = "";
        document.getElementById('formSkuInput').value = "";
        document.getElementById('formPriceInput').value = "";
        document.getElementById('formStockInput').value = "";
        document.getElementById('formDescInput').value = "";
    }

    function prepareEditForm(id, name, sku, price, stock, desc) {
        document.getElementById('formTitle').innerText = "Modify Product Specifications";
        document.getElementById('productActionId').value = "update";
        document.getElementById('formProductId').value = id;
        document.getElementById('submitFormButton').innerText = "Apply Updates";

        // Populate inputs with current database state data variables
        document.getElementById('formTitleInput').value = name;
        document.getElementById('formSkuInput').value = sku;
        document.getElementById('formPriceInput').value = price;
        document.getElementById('formStockInput').value = stock;
        document.getElementById('formDescInput').value = desc;
    }
</script>
</body>
</html>