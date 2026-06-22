package com.techmart.servlet;

import com.techmart.api.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/verify")
public class UserVerifyServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String token = req.getParameter("token");

        try {
            userService.userVerify(token);
            resp.sendRedirect("login.jsp");

        } catch (RuntimeException e) {
//            req.setAttribute("error", e.getMessage());
            resp.getWriter().write(e.getMessage());
//            req.getRequestDispatcher("/verifyError.jsp").forward(req, resp);
        }
    }
}
