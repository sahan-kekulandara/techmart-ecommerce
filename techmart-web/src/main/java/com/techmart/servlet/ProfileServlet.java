package com.techmart.servlet;

import com.techmart.api.service.OrderService;
import com.techmart.api.service.UserAddressService;
import com.techmart.api.service.UserService; // Assuming your user management EJB
import com.techmart.core.dto.OrderDTO;
import com.techmart.core.dto.UserAddressDTO;
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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @EJB
    private UserAddressService userAddressService;

    @EJB
    private OrderService orderService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        UserAddressDTO userAddress = userAddressService.findAddressByUserId(loggedInUser.getId());

        if (userAddress == null) {
            userAddress = new UserAddressDTO();
        }

        List<OrderDTO> customerOrderHistory = orderService.getCustomerOrderHistory(loggedInUser.getId());


        req.setAttribute("userAddress", userAddress);
        req.setAttribute("user", loggedInUser);
        req.setAttribute("orders",customerOrderHistory);

        req.getRequestDispatcher("/profile.jsp").forward(req, resp);
    }
}