package com.techmart.servlet;

import com.techmart.api.service.CartService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart-update")
public class CartUpdateServlet extends HttpServlet {

    @EJB
    private CartService cartService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long cartItemId = Long.parseLong(req.getParameter("cartItemId"));
            String action = req.getParameter("action"); // "increase" or "decrease"

            cartService.updateItemQuantity(cartItemId, action);

        } catch (Exception e) {
            req.getSession().setAttribute("cartMessage", "Quantity check warning: " + e.getMessage());
        }
        resp.sendRedirect("cart");
    }
}