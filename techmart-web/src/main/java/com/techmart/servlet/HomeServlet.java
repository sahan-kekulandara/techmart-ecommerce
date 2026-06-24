package com.techmart.servlet;

import com.techmart.api.service.CategoryService;
import com.techmart.api.service.ProductService;
import com.techmart.core.dto.CategoryDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @EJB
    private CategoryService categoryService;

    @EJB
    private ProductService productService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("categories", categoryService.findAll());
        req.setAttribute("newProducts", productService.findLatestProducts(4));
        req.getRequestDispatcher("/index.jsp").forward(req, resp);
    }
}