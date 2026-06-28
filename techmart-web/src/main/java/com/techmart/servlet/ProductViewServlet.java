package com.techmart.servlet;

import com.techmart.api.service.ProductService;
import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductImageDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;

@WebServlet("/product-view")
public class ProductViewServlet extends HttpServlet {

    @EJB
    private ProductService productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idParam = req.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            resp.sendRedirect("products.jsp");
            return;
        }

        try {
            Long productId = Long.parseLong(idParam);
            ProductDTO product = productService.getProductById(productId);
            if (product == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested technical hardware asset could not be located.");
                return;
            }

            if (product.getImages() == null || product.getImages().isEmpty()) {
                product.setImages(new ArrayList<>());
                ProductImageDTO placeholderImage = ProductImageDTO.builder()
                        .imagePath("products/placeholder.jpg")
                        .isPrimary(true)
                        .build();
                product.getImages().add(placeholderImage);
            }

            req.setAttribute("product", product);
            req.getRequestDispatcher("/productView.jsp").forward(req, resp);

        } catch (NumberFormatException e) {
            resp.sendRedirect("products.jsp");
        }
    }
}