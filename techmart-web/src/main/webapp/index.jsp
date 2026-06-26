<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.techmart.core.dto.CategoryDTO" %>
<%@ page import="com.techmart.core.dto.ProductDTO" %>

<%
    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("newProducts");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Premium Electronics Store</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="images/logo/icon.png" rel="icon">

    <style>
        body {
            background-color: var(--tm-bg-workspace, #f8f9fa);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .hero-banner {
            background: linear-gradient(135deg, #0d6efd 0%, #0a4baf 100%);
            border-radius: var(--tm-radius, 12px);
            position: relative;
            overflow: hidden;
        }

        .hero-banner::after {
            content: '';
            position: absolute;
            right: -10%;
            bottom: -30%;
            width: 400px;
            height: 400px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 50%;
        }

        .category-showcase-card {
            background-color: #ffffff;
            border: 1px solid rgba(0, 0, 0, 0.06);
            border-radius: var(--tm-radius, 12px);
            transition: all 0.2s ease-in-out;
            text-decoration: none !important;
        }

        .category-showcase-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.04);
            border-color: #0d6efd;
        }

        .product-card {
            border-radius: var(--tm-radius, 12px);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            border: 1px solid rgba(0, 0, 0, 0.05) !important;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 0.75rem 1.5rem rgba(0, 0, 0, 0.05) !important;
        }

        .product-img-wrapper {
            background-color: #f8f9fa;
            border-radius: 0.75rem;
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .group-hover:hover i {
            transform: translateX(5px);
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp"/>

<main class="container-fluid px-3 px-sm-5 px-lg-5 px-xxl-5 py-5 flex-grow-1">

    <div class="hero-banner text-white p-4 p-sm-5 mb-5 shadow-sm">
        <div class="row align-items-center g-4">
            <div class="col-12 col-md-7 text-center text-md-start">
                    <span class="badge bg-white bg-opacity-20 text-white mb-2 px-3 py-2 fw-semibold text-uppercase tracking-wider"
                          style="font-size: 0.75rem;">
                        ⚡ New Seasonal Hardware Release
                    </span>
                <h1 class="display-5 fw-extrabold tracking-tight mb-2">Next-Gen Workspaces</h1>
                <p class="lead opacity-90 mb-4">Upgrade your deployment architecture with precision computers, retail
                    high-tier monitors, and pro accessories.</p>
                <a href="#new-arrivals" class="btn btn-white text-primary bg-white fw-bold px-4 py-2.5 shadow-sm">
                    Browse New Arrivals
                </a>
            </div>
        </div>
    </div>

    <div class="mb-5">
        <h4 class="fw-bold text-dark mb-3">Shop by Category</h4>
        <div class="row g-3">
            <% if (categories != null) { %>
            <% for (CategoryDTO category : categories) { %>
            <div class="col-6 col-sm-4 col-md-3 col-xl-2">
                <a href="products?categoryId=<%= category.getId() %>"
                   class="category-showcase-card d-flex flex-column align-items-center p-4 text-center h-100">
                    <i class="bi bi-grid text-primary mb-2" style="font-size:2.2rem;"></i>
                    <span class="small fw-bold text-dark">
                    <%= category.getCategory() %>
                </span>
                </a>
            </div>
            <% } %>
            <% } else { %>
            <div class="col-12 text-muted">No categories available. Please load via home page.</div>
            <% } %>
        </div>
    </div>

    <hr class="my-5 opacity-5">

    <div id="new-arrivals" class="mb-4">
        <div class="d-flex align-items-center justify-content-between mb-3">
            <h4 class="fw-bold text-dark m-0">New Products</h4>
            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-2.5 py-1.5 rounded-pill small fw-medium">Fresh Stock</span>
        </div>

        <div class="row g-4">
            <% if (products != null) { %>
            <% for (ProductDTO p : products) { %>
            <div class="col-12 col-sm-6 col-md-4 col-xl-3">
                <div class="card product-card bg-white h-100 p-3 border-0 shadow-sm">
                    <div class="product-img-wrapper position-relative">
                        <i class="bi bi-laptop text-secondary opacity-25" style="font-size: 4rem;"></i>
                        <span class="badge bg-danger position-absolute top-0 start-0 m-2 px-2.5 py-1.5 rounded-2 small fw-bold">New Release</span>
                    </div>
                    <div class="card-body px-1 pt-3 pb-0 d-flex flex-column">
                        <span class="text-muted small fw-medium text-uppercase font-monospace"><%=p.getSubcategory().getSubcategory()%></span>
                        <h6 class="fw-bold text-dark mt-1 mb-2 text-truncate"><%=p.getTitle()%></h6>
                        <p class="text-muted small mb-3"><%=p.getDescription()%></p>
                        <div class="d-flex align-items-center justify-content-between mt-auto pt-2">
                            <span class="fs-5 fw-extrabold text-dark">$ <%=p.getPrice()%></span>
                            <button class="btn btn-primary btn-sm rounded-3 px-3 py-2 d-flex align-items-center gap-1">
                                <i class="bi bi-cart-plus"></i> Add
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <% } %>
            <% } else { %>
            <div class="col-12 text-muted">No product available. Please load via home page.</div>
            <% } %>
        </div>
    </div>

    <div class="row mt-5">
        <div class="col-12 text-end">
            <a href="products"
               class="text-decoration-none fw-bold text-primary d-inline-flex align-items-center gap-1 group-hover"
               style="font-size: 0.95rem; transition: color 0.2s ease;">
                <span>Explore Entire Catalog</span>
                <i class="bi bi-arrow-right fs-5 transition-transform" style="transition: transform 0.2s ease;"></i>
            </a>
        </div>
    </div>

</main>

<jsp:include page="components/footer.jsp"/>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>