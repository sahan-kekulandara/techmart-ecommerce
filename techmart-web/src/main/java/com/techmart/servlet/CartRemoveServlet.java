package com.techmart.servlet;

import com.techmart.api.service.CartService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cart-remove")
public class CartRemoveServlet extends HttpServlet {

    @EJB
    private CartService cartService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            Long cartItemId = Long.parseLong(req.getParameter("cartItemId"));

            cartService.removeItemFromCart(cartItemId);
            req.getSession().setAttribute("cartMessage", "Item removed from your cart.");

        } catch (Exception e) {
            req.getSession().setAttribute("cartMessage", "Error processing removal: " + e.getMessage());
        }
        resp.sendRedirect("cart");
    }
}