package com.techmart.servlet;

import com.techmart.api.service.CartService;
import com.techmart.core.dto.ShoppingCartDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/cart")
public class CartViewServlet extends HttpServlet {

    @EJB
    private CartService cartService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String guestToken = (String) session.getAttribute("guestToken");
        if (guestToken == null) {
            guestToken = UUID.randomUUID().toString();
            session.setAttribute("guestToken", guestToken);
        }

        com.techmart.core.dto.UserDTO user = (com.techmart.core.dto.UserDTO) session.getAttribute("user");
        Long userId = (user != null) ? user.getId() : null;

        ShoppingCartDTO shoppingCart = cartService.getActiveCart(guestToken, userId);

        req.setAttribute("shoppingCart", shoppingCart);
        req.getRequestDispatcher("/cartView.jsp").forward(req, resp);
    }
}