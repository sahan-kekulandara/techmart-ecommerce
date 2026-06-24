<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - Advanced Search Catalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link href="style.css" rel="stylesheet">

    <style>
        /* Modern CSS Design Tokens */
        :root {
            --tm-primary: #2563eb;
            --tm-primary-hover: #1d4ed8;
            --tm-primary-light: #eff6ff;
            --tm-bg-workspace: #f8fafc;
            --tm-card-bg: #ffffff;
            --tm-text-main: #0f172a;
            --tm-text-muted: #64748b;
            --tm-border: #e2e8f0;
            --tm-radius-lg: 16px;
            --tm-radius-md: 12px;
            --tm-radius-sm: 8px;
            --font-jakarta: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            font-family: var(--font-jakarta);
            background-color: var(--tm-bg-workspace);
            color: var(--tm-text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Sidebar Glassmorphism Styles */
        .filter-sidebar {
            background-color: var(--tm-card-bg);
            border-radius: var(--tm-radius-lg);
            border: 1px solid var(--tm-border);
        }

        .form-check-input:checked {
            background-color: var(--tm-primary);
            border-color: var(--tm-primary);
        }

        /* Modernized Elegant Product Grid Cards */
        .product-catalog-card {
            background-color: var(--tm-card-bg);
            border-radius: var(--tm-radius-lg);
            border: 1px solid var(--tm-border) !important;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            overflow: hidden;
        }

        .product-catalog-card:hover {
            transform: translateY(-6px);
            border-color: #cbd5e1 !important;
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.05), 0 8px 10px -6px rgba(0, 0, 0, 0.05) !important;
        }

        /* Perfect Image Wrapping Scale */
        .catalog-img-wrapper {
            background: linear-gradient(145deg, #f8fafc, #f1f5f9);
            border-radius: var(--tm-radius-md);
            height: 200px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            margin: 4px;
            transition: background 0.3s ease;
        }

        .product-catalog-card:hover .catalog-img-wrapper {
            background: linear-gradient(145deg, #f1f5f9, #e2e8f0);
        }

        /* Badge Formatting overrides */
        .badge-status {
            font-weight: 600;
            font-size: 0.75rem;
            letter-spacing: 0.025em;
            padding: 6px 12px;
            border-radius: var(--tm-radius-sm);
        }

        /* Pagination Accent Overrides */
        .pagination {
            gap: 6px;
        }
        .page-item .page-link {
            border: 1px solid var(--tm-border);
            border-radius: var(--tm-radius-sm) !important;
            color: var(--tm-text-main);
            font-weight: 600;
            font-size: 0.9rem;
            transition: all 0.2s ease;
        }
        .page-item.active .page-link {
            background-color: var(--tm-primary);
            border-color: var(--tm-primary);
            color: white;
        }
        .page-item:not(.active) .page-link:hover {
            background-color: var(--tm-primary-light);
            color: var(--tm-primary);
            border-color: rgba(37, 99, 235, 0.3);
        }

        /* Custom line clamp utility */
        .text-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            height: 40px;
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp" />

<main class="container-fluid px-3 px-md-5 py-5 flex-grow-1">

    <div class="mb-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-muted fw-medium">Home</a></li>
                <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Search Catalog</li>
            </ol>
        </nav>
        <h2 class="fw-extrabold tracking-tight m-0 text-dark" style="font-weight: 800;">Showing results for <span class="text-primary">"Laptops"</span></h2>
        <p class="text-muted m-0 mt-1">Found 24 premium hardware items matching your parameters.</p>
    </div>

    <div class="row g-4">

        <div class="col-12 col-lg-3">
            <div class="filter-sidebar p-4 shadow-sm bg-white">
                <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                    <h5 class="fw-bold text-dark m-0 d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                        <i class="bi bi-sliders2 text-primary"></i> Filter Options
                    </h5>
                    <a href="products.jsp" class="text-decoration-none small text-muted hover:text-primary fw-medium">Clear All</a>
                </div>

                <form action="products" method="GET">

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Product Categories</label>
                        <div class="d-flex flex-column gap-2.5 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="cat1" checked>
                                <label class="form-check-label small text-secondary fw-medium" for="cat1">Laptops & Computers</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="cat2">
                                <label class="form-check-label small text-secondary fw-medium" for="cat2">Displays & Monitors</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="cat3">
                                <label class="form-check-label small text-secondary fw-medium" for="cat3">Audio Equipment</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="cat4">
                                <label class="form-check-label small text-secondary fw-medium" for="cat4">Peripherals & Add-ons</label>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Manufacturer / Brand</label>
                        <select name="brand" class="form-select form-select-md mt-2 bg-light border-0 py-2.5 px-3 rounded-3 small fw-medium">
                            <option value="all">All Available Brands</option>
                            <option value="apple">Apple Inc.</option>
                            <option value="dell">Dell</option>
                            <option value="sony">Sony Electronics</option>
                            <option value="logitech">Logitech G</option>
                        </select>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Price Range ($)</label>
                        <div class="row g-2 mt-1">
                            <div class="col-6">
                                <input type="number" name="min_price" class="form-control bg-light border-0 py-2.5 text-center small rounded-3" placeholder="Min">
                            </div>
                            <div class="col-6">
                                <input type="number" name="max_price" class="form-control bg-light border-0 py-2.5 text-center small rounded-3" placeholder="Max">
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Availability</label>
                        <div class="d-flex flex-column gap-2.5 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="stockStatus" id="stockAll" checked>
                                <label class="form-check-label small text-secondary fw-medium" for="stockAll">All Catalog Items</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="stockStatus" id="stockIn">
                                <label class="form-check-label small text-secondary fw-medium" for="stockIn">Exclude Out of Stock</label>
                            </div>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 py-2.5 fw-semibold mt-3 rounded-3 shadow-sm border-0">
                        Apply Search Filters
                    </button>
                </form>
            </div>
        </div>

        <div class="col-12 col-lg-9">

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3 bg-white p-3 rounded-4 border">
                <div class="small text-muted fw-medium">
                    Showing <span class="text-dark fw-bold">1 - 3</span> of <span class="text-dark fw-bold">24</span> elements
                </div>

                <div class="d-flex align-items-center gap-3">
                    <label class="small text-muted text-nowrap m-0 fw-medium" for="sortOrder">Sort By:</label>
                    <select id="sortOrder" name="sort" class="form-select form-select-sm border-0 bg-light py-2 px-3 rounded-3 text-dark fw-semibold" style="width: 180px; font-size:0.85rem;">
                        <option value="latest">Newest Releases</option>
                        <option value="price_low">Price: Low to High</option>
                        <option value="price_high">Price: High to Low</option>
                        <option value="popular">Most Popular</option>
                    </select>
                </div>
            </div>

            <div class="row g-4 mb-5">

                <div class="col-12 col-sm-6 col-md-4">
                    <div class="card product-catalog-card h-100 p-2 shadow-sm">
                        <div class="catalog-img-wrapper">
                            <i class="bi bi-laptop text-primary opacity-50" style="font-size: 3.5rem;"></i>
                            <span class="badge badge-status bg-success position-absolute top-3 start-3 shadow-sm">In Stock</span>
                        </div>
                        <div class="card-body px-2 pt-3 pb-2 d-flex flex-column">
                            <span class="text-muted small fw-bold text-uppercase font-monospace tracking-wider" style="font-size:0.7rem;">Apple</span>
                            <h6 class="fw-bold text-dark mt-1 mb-1 text-truncate" style="font-size: 1.05rem;">MacBook Pro 16" M3 Max</h6>
                            <p class="text-muted small mb-3 text-clamp-2">16-core CPU, 40-core GPU, 48GB unified memory powerhouse layout.</p>
                            <div class="d-flex align-items-center justify-content-between mt-auto pt-2 border-top border-light">
                                <span class="fs-5 fw-bold text-dark" style="font-weight: 800 !important;">$3,499.00</span>
                                <button class="btn btn-primary btn-sm rounded-3 px-3 py-2 d-flex align-items-center gap-1">
                                    <i class="bi bi-cart-plus"></i> Add
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-md-4">
                    <div class="card product-catalog-card h-100 p-2 shadow-sm">
                        <div class="catalog-img-wrapper">
                            <i class="bi bi-laptop text-primary opacity-50" style="font-size: 3.5rem;"></i>
                            <span class="badge badge-status bg-success position-absolute top-3 start-3 shadow-sm">In Stock</span>
                        </div>
                        <div class="card-body px-2 pt-3 pb-2 d-flex flex-column">
                            <span class="text-muted small fw-bold text-uppercase font-monospace tracking-wider" style="font-size:0.7rem;">Dell</span>
                            <h6 class="fw-bold text-dark mt-1 mb-1 text-truncate" style="font-size: 1.05rem;">XPS 15 Creator Edition</h6>
                            <p class="text-muted small mb-3 text-clamp-2">Intel Core i9, 32GB DDR5 RAM, 1TB NVMe SSD storage system.</p>
                            <div class="d-flex align-items-center justify-content-between mt-auto pt-2 border-top border-light">
                                <span class="fs-5 fw-bold text-dark" style="font-weight: 800 !important;">$2,199.00</span>
                                <button class="btn btn-primary btn-sm rounded-3 px-3 py-1.5 d-flex align-items-center gap-1.5 fw-semibold border-0">
                                    <i class="bi bi-cart-plus-fill"></i> Add
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12 col-sm-6 col-md-4">
                    <div class="card product-catalog-card h-100 p-2 shadow-sm opacity-90">
                        <div class="catalog-img-wrapper">
                            <i class="bi bi-laptop text-secondary opacity-25" style="font-size: 3.5rem;"></i>
                            <span class="badge badge-status bg-secondary position-absolute top-3 start-3 shadow-sm">Out of Stock</span>
                        </div>
                        <div class="card-body px-2 pt-3 pb-2 d-flex flex-column">
                            <span class="text-muted small fw-bold text-uppercase font-monospace tracking-wider" style="font-size:0.7rem;">Apple</span>
                            <h6 class="fw-bold text-muted mt-1 mb-1 text-truncate" style="font-size: 1.05rem;">MacBook Air 13" M2</h6>
                            <p class="text-muted small mb-3 text-clamp-2">Ultra-thin framework, 8GB unified memory, 256GB lightning fast flash array.</p>
                            <div class="d-flex align-items-center justify-content-between mt-auto pt-2 border-top border-light">
                                <span class="fs-5 fw-bold text-muted" style="font-weight: 700 !important;">$1,099.00</span>
                                <button class="btn btn-light text-muted btn-sm rounded-3 px-3 py-1.5 fw-semibold" disabled>
                                    Sold Out
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <nav aria-label="Catalog Page Vector Navigation" class="d-flex justify-content-center">
                <ul class="pagination pagination-md p-0 m-0">
                    <li class="page-item disabled">
                        <a class="page-link d-flex align-items-center px-3 py-2" href="#" tabindex="-1" aria-disabled="true">
                            <i class="bi bi-chevron-left me-1"></i> Prev
                        </a>
                    </li>
                    <li class="page-item active" aria-current="page"><a class="page-link px-3 py-2" href="#">1</a></li>
                    <li class="page-item"><a class="page-link px-3 py-2" href="#">2</a></li>
                    <li class="page-item"><a class="page-link px-3 py-2" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link d-flex align-items-center px-3 py-2" href="#">
                            Next <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </li>
                </ul>
            </nav>

        </div>

    </div>

</main>

<jsp:include page="components/footer.jsp" />

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
