package com.techmart.servlet;

import com.techmart.api.service.OrderService;
import com.techmart.core.dto.OrderDTO;
import com.techmart.core.entity.Order;
import com.techmart.core.dto.UserDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    @EJB
    private OrderService orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // Guard Condition: Unauthorized guests are sent to authentication prompt
        if (user == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            // Retrieve history tree bound to user context identity matching customerOrders variable in JSP
            List<OrderDTO> customerOrders = orderService.getCustomerOrderHistory(user.getId());
            req.setAttribute("customerOrders", customerOrders);

            // Forward safely down into your view presentation layer template
            req.getRequestDispatcher("/myOrders.jsp").forward(req, resp);

        } catch (Exception e) {
            System.err.println("[LEDGER VIEW FAULT] Failed to load customer transaction history: " + e.getMessage());
            resp.sendRedirect("home");
        }
    }
}