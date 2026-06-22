package com.techmart.servlet;

import com.techmart.api.service.UserService;
import com.techmart.core.dto.UserDTO;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest req,HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            UserDTO user = userService.login(email, password);
            HttpSession session = req.getSession();
            session.setAttribute("user", user);
            resp.sendRedirect("index.jsp");
        } catch (RuntimeException e) {
            req.setAttribute( "error", e.getMessage());
            req.setAttribute("email",email);
            req.getRequestDispatcher( "/logIn.jsp").forward(req, resp);
        }
    }
}
