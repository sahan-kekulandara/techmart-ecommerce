package com.techmart.servlet;

import com.techmart.api.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/verify")
public class UserVerifyServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        HttpSession session = req.getSession();

        String token = req.getParameter("token");

        if (token == null || token.isBlank()) {
            session.setAttribute("loginMessage", "Verification token is missing.");
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            userService.userVerify(token);

            session.setAttribute("loginMessage", "Your account has been successfully verified! Please log in.");
            resp.sendRedirect(req.getContextPath() + "/login");

        } catch (RuntimeException e) {
            session.setAttribute("loginMessage", "Verification failed: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/login");
        }
    }
}