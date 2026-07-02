package com.techmart.servlet;

import com.techmart.api.service.CartService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/cart-add")
public class CartAddServlet extends HttpServlet {

    @EJB
    private CartService cartService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String guestToken = (String) session.getAttribute("guestToken");
        if (guestToken == null) {
            guestToken = UUID.randomUUID().toString();
            session.setAttribute("guestToken", guestToken);
        }

        try {
            Long productId = Long.parseLong(req.getParameter("productId"));
            Integer quantity = Integer.parseInt(req.getParameter("quantity"));

            com.techmart.core.dto.UserDTO user = (com.techmart.core.dto.UserDTO) session.getAttribute("user");
            Long userId = (user != null) ? user.getId() : null;

            cartService.addItemToCart(guestToken, userId, productId, quantity);

            session.setAttribute("cartMessage", "Item successfully locked into your shopping cart!");
            resp.sendRedirect("product-view?id=" + productId);

        } catch (Exception e) {
            session.setAttribute("cartMessage", "Error processing transaction: " + e.getMessage());
//            resp.sendRedirect("product.jsp");
            resp.sendRedirect(req.getContextPath() + "/products");
        }
    }
}