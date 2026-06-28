<%@ page import="com.techmart.core.dto.CategoryDTO" %>
<%@ page import="com.techmart.core.dto.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Arrays" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");

    String currentSearch = (request.getAttribute("currentSearch") != null) ? (String) request.getAttribute("currentSearch") : "";
    String currentSort = (request.getAttribute("currentSort") != null) ? (String) request.getAttribute("currentSort") : "latest";
    String currentStockStatus = (request.getAttribute("currentStockStatus") != null) ? (String) request.getAttribute("currentStockStatus") : "all";

    String[] currentCategoryIds = (request.getAttribute("currentCategoryIds") != null) ? (String[]) request.getAttribute("currentCategoryIds") : new String[0];
    List<String> selectedCatList = Arrays.asList(currentCategoryIds);

    int activePage = (request.getAttribute("activePage") != null) ? (Integer) request.getAttribute("activePage") : 1;
    int totalPages = (request.getAttribute("totalPages") != null) ? (Integer) request.getAttribute("totalPages") : 1;
    long totalProducts = (request.getAttribute("totalProducts") != null) ? (Long) request.getAttribute("totalProducts") : 0L;
    int startElement = (request.getAttribute("startElement") != null) ? (Integer) request.getAttribute("startElement") : 0;
    int endElement = (request.getAttribute("endElement") != null) ? (Integer) request.getAttribute("endElement") : 0;

    String queryString = request.getQueryString();
    if (queryString == null) {
        queryString = "";
    }

    queryString = queryString.replaceAll("&?page=\\d+", "");
%>
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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            bg-color: #f8f9fa;
        }

        .filter-sidebar {
            border-radius: 16px;
            border: 1px solid #eef0f2;
        }

        .product-catalog-card {
            border-radius: 16px;
            border: 1px solid #eef0f2;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .product-catalog-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 20px rgba(0, 0, 0, 0.05) !important;
        }

        .catalog-img-wrapper {
            height: 180px;
            bg-color: #f8f9fa;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        .text-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="components/navbar.jsp"/>

<main class="container-fluid px-3 px-md-5 py-5 flex-grow-1">

    <div class="mb-5">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-2">
                <li class="breadcrumb-item"><a href="home.jsp"
                                               class="text-decoration-none text-muted fw-medium">Home</a></li>
                <li class="breadcrumb-item active text-dark fw-semibold" aria-current="page">Search Catalog</li>
            </ol>
        </nav>
        <h2 class="fw-extrabold tracking-tight m-0 text-dark" style="font-weight: 800;">
            Showing results for <span
                class="text-primary">"<%= !currentSearch.isEmpty() ? currentSearch : "All Items" %>"</span>
        </h2>
        <p class="text-muted m-0 mt-1">Found <%= totalProducts %> premium hardware items matching your parameters.</p>
    </div>

    <div class="row g-4">

        <div class="col-12 col-lg-3">
            <div class="filter-sidebar p-4 shadow-sm bg-white">
                <div class="d-flex align-items-center justify-content-between mb-4 pb-3 border-bottom">
                    <h5 class="fw-bold text-dark m-0 d-flex align-items-center gap-2" style="font-size: 1.1rem;">
                        <i class="bi bi-sliders2 text-primary"></i> Filter Options
                    </h5>
                    <a href="products" class="text-decoration-none small text-muted hover:text-primary fw-medium">Clear
                        All</a>
                </div>

                <form id="catalogFilterForm" action="products" method="GET">

                    <input type="hidden" name="search" value="<%= currentSearch %>">

                    <input type="hidden" id="hiddenSortOrder" name="sort" value="<%= currentSort %>">

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Product
                            Categories</label>
                        <div class="d-flex flex-column gap-2 mt-2">
                            <% if (categories != null) { %>
                            <% for (CategoryDTO category : categories) {
                                String catIdStr = String.valueOf(category.getId());
                                boolean isChecked = selectedCatList.contains(catIdStr);
                            %>
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="category"
                                       value="<%=category.getId()%>" id="cat_<%=category.getId()%>"
                                    <%= isChecked ? "checked" : "" %>>
                                <label class="form-check-label small text-secondary fw-medium"
                                       for="cat_<%=category.getId()%>">
                                    <%=category.getCategory()%>
                                </label>
                            </div>
                            <% } %>
                            <% } %>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Price
                            Range ($)</label>
                        <div class="row g-2 mt-1">
                            <div class="col-6">
                                <input type="number" name="min_price"
                                       class="form-control bg-light border-0 py-2.5 text-center small rounded-3"
                                       placeholder="Min"
                                       value="<%= (request.getAttribute("currentMinPrice") != null) ? request.getAttribute("currentMinPrice") : "" %>">
                            </div>
                            <div class="col-6">
                                <input type="number" name="max_price"
                                       class="form-control bg-light border-0 py-2.5 text-center small rounded-3"
                                       placeholder="Max"
                                       value="<%= (request.getAttribute("currentMaxPrice") != null) ? request.getAttribute("currentMaxPrice") : "" %>">
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold text-dark small text-uppercase tracking-wider opacity-75">Availability</label>
                        <div class="d-flex flex-column gap-2 mt-2">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="stockStatus" id="stockAll"
                                       value="all"
                                    <%= "all".equals(currentStockStatus) ? "checked" : "" %>>
                                <label class="form-check-label small text-secondary fw-medium" for="stockAll">All
                                    Catalog Items</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="stockStatus" id="stockIn"
                                       value="in_stock"
                                    <%= "in_stock".equals(currentStockStatus) ? "checked" : "" %>>
                                <label class="form-check-label small text-secondary fw-medium" for="stockIn">Exclude Out
                                    of Stock</label>
                            </div>
                        </div>
                    </div>

                    <button type="submit"
                            class="btn btn-primary w-100 py-2.5 fw-semibold mt-3 rounded-3 shadow-sm border-0">
                        Apply Search Filters
                    </button>
                </form>
            </div>
        </div>

        <div class="col-12 col-lg-9">

            <div class="d-flex flex-wrap justify-content-between align-items-center mb-4 gap-3 bg-white p-3 rounded-4 border">
                <div class="small text-muted fw-medium">
                    Showing <span class="text-dark fw-bold"><%= startElement %> - <%= endElement %></span> of <span
                        class="text-dark fw-bold"><%= totalProducts %></span> elements
                </div>

                <div class="d-flex align-items-center gap-3">
                    <label class="small text-muted text-nowrap m-0 fw-medium" for="sortOrder">Sort By:</label>
                    <select id="sortOrder"
                            class="form-select form-select-sm border-0 bg-light py-2 px-3 rounded-3 text-dark fw-semibold"
                            style="width: 180px; font-size:0.85rem;" onchange="submitSortingForm(this.value)">
                        <option value="latest" <%= "latest".equals(currentSort) ? "selected" : "" %>>Newest Releases
                        </option>
                        <option value="price_low" <%= "price_low".equals(currentSort) ? "selected" : "" %>>Price: Low to
                            High
                        </option>
                        <option value="price_high" <%= "price_high".equals(currentSort) ? "selected" : "" %>>Price: High
                            to Low
                        </option>
                    </select>
                </div>
            </div>

            <div class="row g-4 mb-5">
                <% if (products != null && !products.isEmpty()) { %>
                <% for (ProductDTO product : products) { %>
                <div class="col-12 col-sm-6 col-md-4">
                    <div class="card product-catalog-card h-100 p-2 shadow-sm">
                        <div class="catalog-img-wrapper position-relative text-center d-flex align-items-center justify-content-center bg-light rounded-3 overflow-hidden"
                             style="height: 200px;">
                            <%
                                String imgUrl = "product-image?path=products/placeholder.jpg";
                                if (product.getImages() != null && !product.getImages().isEmpty()) {
                                    String imagePath = product.getImages().stream()
                                            .filter(img -> Boolean.TRUE.equals(img.getIsPrimary()))
                                            .map(com.techmart.core.dto.ProductImageDTO::getImagePath)
                                            .findFirst()
                                            .orElse(product.getImages().get(0).getImagePath());

                                    imgUrl = "product-image?path=" + imagePath;
                                }
                            %>

                            <img src="<%= imgUrl %>"
                                 class="img-fluid h-100 w-100 object-fit-contain p-2"
                                 alt="<%= product.getTitle() %>"
                                 onerror="this.src='product-image?path=products/placeholder.jpg';">

                            <span class="badge position-absolute top-3 start-3 shadow-sm <%= (product.getQty() > 0) ? "bg-success" : "bg-danger" %>">
        <%= (product.getQty() > 0) ? "In Stock" : "Out of Stock" %>
    </span>
                        </div>
                        <div class="card-body px-2 pt-3 pb-2 d-flex flex-column">
                                <span class="text-muted small fw-bold text-uppercase font-monospace tracking-wider"
                                      style="font-size:0.7rem;">
                                    <%= (product.getSubcategory() != null) ? product.getSubcategory().getSubcategory() : "Hardware" %>
                                </span>
                            <h6 class="fw-bold text-dark mt-1 mb-1 text-truncate" style="font-size: 1.05rem;">
                                <%= product.getTitle() %>
                            </h6>
                            <p class="text-muted small mb-3 text-clamp-2">
                                <%= product.getDescription() %>
                            </p>
                            <div class="d-flex align-items-center justify-content-between mt-auto pt-2 border-top border-light">
                                    <span class="fs-5 fw-bold text-dark" style="font-weight: 800 !important;">
                                        $<%= String.format("%.2f", product.getPrice()) %>
                                    </span>
                                <button class="btn btn-primary btn-sm rounded-3 px-3 py-2 d-flex align-items-center gap-1" <%= (product.getQty() <= 0) ? "disabled" : "" %>>
                                    <i class="bi bi-cart-plus"></i> Add
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <div class="col-12 text-center py-5">
                    <i class="bi bi-search text-muted" style="font-size: 3rem;"></i>
                    <h4 class="mt-3 fw-bold text-secondary">No Products Found</h4>
                    <p class="text-muted">We couldn't find anything matching your search parameters. Try another
                        item!</p>
                </div>
                <% } %>
            </div>

            <% if (totalPages > 1) { %>
            <nav aria-label="Catalog Page Vector Navigation" class="d-flex justify-content-center">
                <ul class="pagination pagination-md p-0 m-0">
                    <li class="page-item <%= (activePage == 1) ? "disabled" : "" %>">
                        <a class="page-link d-flex align-items-center px-3 py-2"
                           href="<%= (activePage == 1) ? "#" : "?" + queryString + "&page=" + (activePage - 1) %>">
                            <i class="bi bi-chevron-left me-1"></i> Prev
                        </a>
                    </li>

                    <% for (int i = 1; i <= totalPages; i++) { %>
                    <li class="page-item <%= (activePage == i) ? "active" : "" %>">
                        <a class="page-link px-3 py-2" href="?<%= queryString %>&page=<%= i %>"><%= i %>
                        </a>
                    </li>
                    <% } %>

                    <li class="page-item <%= (activePage == totalPages) ? "disabled" : "" %>">
                        <a class="page-link d-flex align-items-center px-3 py-2"
                           href="<%= (activePage == totalPages) ? "#" : "?" + queryString + "&page=" + (activePage + 1) %>">
                            Next <i class="bi bi-chevron-right ms-1"></i>
                        </a>
                    </li>
                </ul>
            </nav>
            <% } %>

        </div>
    </div>
</main>

<jsp:include page="components/footer.jsp"/>

<script>
    // Feeds dropdown values inside the form and submits natively to preserve state metrics together
    function submitSortingForm(sortValue) {
        document.getElementById('hiddenSortOrder').value = sortValue;
        document.getElementById('catalogFilterForm').submit();
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>