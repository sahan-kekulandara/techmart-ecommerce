package com.techmart.servlet;

import com.google.gson.Gson;
import com.techmart.api.service.ProductService;
import com.techmart.core.dto.ProductDTO;
import com.techmart.core.dto.ProductSuggestionDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/product-suggestions")
public class ProductSuggestionServlet extends HttpServlet {

    @EJB
    private ProductService productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String keyword = req.getParameter("q");

        if(keyword == null || keyword.isBlank()){
            return;
        }

        List<ProductSuggestionDTO> products = productService.findSuggestions(keyword);

        Gson gson = new Gson();
        resp.setContentType("application/json");
        resp.getWriter().write(gson.toJson(products));
    }
}