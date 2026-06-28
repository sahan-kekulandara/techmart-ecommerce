<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TechMart - <c:out value="${product.title}" default="Product Detail View"/></title>
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
        .view-wrapper-card {
            background-color: #ffffff;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
        }
        .gallery-carousel {
            background: linear-gradient(145deg, #f8fafc, #f1f5f9);
            border-radius: 16px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
        }
        .carousel-item img {
            height: 420px;
            object-fit: contain;
            width: 100%;
            padding: 2rem;
        }
        .thumb-gallery-btn {
            width: 70px;
            height: 70px;
            object-fit: contain;
            background: #ffffff;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            cursor: pointer;
            padding: 4px;
            transition: all 0.2s ease;
        }
        .thumb-gallery-btn.active, .thumb-gallery-btn:hover {
            border-color: #2563eb;
            transform: scale(1.05);
        }
        .qty-input-group {
            max-width: 130px;
            border: 1px solid #cbd5e1;
            border-radius: 10px;
            overflow: hidden;
        }
        .qty-btn {
            background-color: #f1f5f9;
            border: 0;
            width: 38px;
            transition: background 0.2s;
        }
        .qty-btn:hover {
            background-color: #e2e8f0;
        }
        .spec-table th {
            width: 30%;
            color: #64748b;
            font-weight: 600;
        }
    </style>
</head>
<body>

<jsp:include page="components/navbar.jsp"/>

<main class="container my-5 flex-grow-1">

    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-muted fw-medium">Home</a></li>
            <li class="breadcrumb-item"><a href="products.jsp" class="text-decoration-none text-muted fw-medium">Catalog</a></li>
            <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page"><c:out value="${product.title}" default="Item View"/></li>
        </ol>
    </nav>

    <div class="view-wrapper-card p-4 p-lg-5 shadow-sm">
        <div class="row g-5">

            <div class="col-12 col-lg-6">
                <div id="productImagesCarousel" class="carousel slide gallery-carousel" data-bs-ride="false">

                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="uploads/products/${product.image}" class="d-block" alt="Primary View">
                        </div>

                        <c:forEach var="subImg" items="${productImages}" varStatus="status">
                            <div class="carousel-item">
                                <img src="uploads/products/${subImg.imagePath}" class="d-block" alt="Gallery View ${status.count}">
                            </div>
                        </c:forEach>
                    </div>

                    <button class="carousel-control-prev" type="button" data-bs-target="#productImagesCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon bg-dark rounded-circle p-2.5" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#productImagesCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon bg-dark rounded-circle p-2.5" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>

                <div class="d-flex gap-2 justify-content-center mt-3 flex-wrap">
                    <img src="uploads/products/${product.image}" class="thumb-gallery-btn active" data-bs-target="#productImagesCarousel" data-bs-slide-to="0" alt="Thumb 0">
                    <c:forEach var="subImg" items="${productImages}" varStatus="status">
                        <img src="uploads/products/${subImg.imagePath}" class="thumb-gallery-btn" data-bs-target="#productImagesCarousel" data-bs-slide-to="${status.count}" alt="Thumb ${status.count}">
                    </c:forEach>
                </div>
            </div>

            <div class="col-12 col-lg-6 d-flex flex-column">

                <span class="badge bg-light text-primary border border-primary-subtle rounded-pill mb-2 align-self-start font-monospace tracking-wider small px-3 py-1.5 fw-bold">
                    <c:out value="${product.subcategoryName}" default="Hardware Components"/>
                </span>

                <h1 class="fw-extrabold text-dark tracking-tight mb-2" style="font-weight: 800;"><c:out value="${product.title}" default="Premium Hardware Unit"/></h1>
                <p class="text-muted small mb-3">Model Identification Identifier Code: <span class="text-dark fw-bold">TM-HW-<c:out value="${product.id}"/></span></p>

                <div class="d-flex align-items-center gap-2 mb-4">
                    <c:choose>
                        <c:when var="inStock" test="${product.qty > 0}">
                            <span class="badge bg-success-subtle text-success rounded-pill px-2.5 py-1 small fw-semibold d-flex align-items-center gap-1">
                                <i class="bi bi-patch-check-fill"></i> In Stock Ready to Deploy
                            </span>
                            <span class="text-muted small fw-medium">(<c:out value="${product.qty}"/> units remaining)</span>
                        </c:when>
                        <c:otherwise>
                            <span class="badge bg-danger-subtle text-danger rounded-pill px-2.5 py-1 small fw-semibold d-flex align-items-center gap-1">
                                <i class="bi bi-exclamation-triangle-fill"></i> Out of stock
                            </span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <div class="bg-light p-4 rounded-4 mb-4 border border-light">
                    <span class="text-muted small d-block mb-1 fw-semibold">Retail Price</span>
                    <h2 class="fw-black text-primary m-0" style="font-weight: 900; font-size: 2.25rem;">$<c:out value="${product.price}"/></h2>
                </div>

                <h6 class="fw-bold text-dark mb-2">Item Overview</h6>
                <p class="text-secondary small mb-4 lh-base"><c:out value="${product.description}" default="No hardware design specifications documentation details loaded inside database configuration scope file."/></p>

                <form action="cart-add" method="POST" class="mt-auto pt-3 border-top border-light">
                    <input type="hidden" name="productId" value="${product.id}">

                    <div class="d-flex flex-wrap align-items-center gap-3 mb-4">
                        <div class="d-flex flex-column gap-1.5">
                            <label class="small fw-bold text-muted">Purchase Qty</label>

                            <div class="input-group qty-input-group">
                                <button class="qty-btn" type="button" onclick="adjustValue(-1)" ${!inStock ? 'disabled' : ''}>-</button>
                                <input type="number" id="qtyInput" name="quantity" class="form-control text-center bg-transparent border-0 small p-0 fw-bold" value="1" min="1" max="${product.qty}" readonly>
                                <button class="qty-btn" type="button" onclick="adjustValue(1)" ${!inStock ? 'disabled' : ''}>+</button>
                            </div>
                        </div>
                    </div>

                    <div class="row g-2">
                        <div class="col-sm-8">
                            <button type="submit" class="btn btn-primary w-100 py-3 fw-bold rounded-3 shadow-sm border-0 d-flex align-items-center justify-content-center gap-2" ${!inStock ? 'disabled' : ''}>
                                <i class="bi bi-cart-plus-fill fs-5"></i> Secure to Shopping Cart
                            </button>
                        </div>
                        <div class="col-sm-4">
                            <a href="products.jsp" class="btn btn-light border-secondary-subtle text-secondary w-100 py-3 fw-semibold rounded-3">
                                Back to Shop
                            </a>
                        </div>
                    </div>
                </form>

            </div>
        </div>

        <div class="row mt-5 pt-4 border-top border-light">
            <div class="col-12">
                <h5 class="fw-bold text-dark mb-3">Hardware Data Sheet Specifications</h5>
                <div class="table-responsive">
                    <table class="table table-striped spec-table small border m-0 rounded-3 overflow-hidden">
                        <tbody>
                        <tr>
                            <th class="bg-light ps-3">Category Matrix</th>
                            <td><c:out value="${product.categoryName}" default="Premium Hardware"/></td>
                        </tr>
                        <tr>
                            <th class="bg-light ps-3">Sub-assignment</th>
                            <td><c:out value="${product.subcategoryName}" default="Not Defined"/></td>
                        </tr>
                        <tr>
                            <th class="bg-light ps-3">Platform Status</th>
                            <td>Active Retail Ledger Element</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script>
    function adjustValue(change) {
        const qtyField = document.getElementById('qtyInput');
        let currentVal = parseInt(qtyField.value);
        let maxLimit = parseInt(qtyField.getAttribute('max')) || 100;

        let targetVal = currentVal + change;
        if(targetVal >= 1 && targetVal <= maxLimit) {
            qtyField.value = targetVal;
        }
    }

    document.addEventListener('DOMContentLoaded', function () {
        const carouselEl = document.getElementById('productImagesCarousel');
        const customThumbnails = document.querySelectorAll('.thumb-gallery-btn');

        carouselEl.addEventListener('slide.bs.carousel', function (e) {
            customThumbnails.forEach(thumb => thumb.classList.remove('active'));
            if(customThumbnails[e.to]) {
                customThumbnails[e.to].classList.add('active');
            }
        });
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>