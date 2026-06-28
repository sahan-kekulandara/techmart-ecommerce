package com.techmart.servlet;

import com.techmart.api.service.CategoryService;
import com.techmart.api.service.ProductService;
import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductFilterDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/products")
public class ProductServlet extends HttpServlet {

    @EJB
    private CategoryService categoryService;

    @EJB
    private ProductService productService;

    private static final int DEFAULT_PAGE_SIZE = 9;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ProductFilterDTO filter = new ProductFilterDTO();

        filter.setSearch(req.getParameter("search"));
        filter.setSort(req.getParameter("sort"));

        String[] categoryParams = req.getParameterValues("category");
        if (categoryParams != null && categoryParams.length > 0) {
            List<Long> categoryIds = Arrays.stream(categoryParams)
                    .filter(id -> id != null && !id.trim().isEmpty())
                    .map(Long::parseLong)
                    .collect(Collectors.toList());
            filter.setCategoryIds(categoryIds);
        }

        String minPriceParam = req.getParameter("min_price");
        if (minPriceParam != null && !minPriceParam.trim().isEmpty()) {
            filter.setMinPrice(new BigDecimal(minPriceParam));
        }

        String maxPriceParam = req.getParameter("max_price");
        if (maxPriceParam != null && !maxPriceParam.trim().isEmpty()) {
            filter.setMaxPrice(new BigDecimal(maxPriceParam));
        }

        String stockStatus = req.getParameter("stockStatus");
        if ("in_stock".equals(stockStatus)) {
            filter.setStockOnly(true);
        }

        int activePage = 1;
        String pageParam = req.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                activePage = Integer.parseInt(pageParam);
                if (activePage < 1) activePage = 1;
            } catch (NumberFormatException e) {
                activePage = 1;
            }
        }

        filter.setPage(activePage);
        filter.setSize(DEFAULT_PAGE_SIZE);

        List<ProductDTO> products = productService.search(filter);
        long totalProducts = productService.countSearch(filter);
        int pageSize = filter.getSize();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;

        int startElement = (activePage - 1) * pageSize + 1;
        int endElement = Math.min(activePage * pageSize, (int) totalProducts);
        if (totalProducts == 0) startElement = 0;

        req.setAttribute("products", products);
        req.setAttribute("totalProducts", totalProducts);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("activePage", activePage);
        req.setAttribute("startElement", startElement);
        req.setAttribute("endElement", endElement);

        req.setAttribute("currentSearch", filter.getSearch());
        req.setAttribute("currentSort", filter.getSort());
        req.setAttribute("currentMinPrice", filter.getMinPrice());
        req.setAttribute("currentCategoryIds", categoryParams);
        req.setAttribute("currentMaxPrice", filter.getMaxPrice());
        req.setAttribute("currentStockStatus", stockStatus);
        req.setAttribute("categories", categoryService.findAll());

        req.getRequestDispatcher("/product.jsp").forward(req, resp);
    }
}