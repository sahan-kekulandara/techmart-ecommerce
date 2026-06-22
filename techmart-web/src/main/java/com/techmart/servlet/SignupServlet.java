package com.techmart.servlet;

import com.techmart.api.service.EmailService;
import com.techmart.api.service.UserService;
import com.techmart.core.dto.UserDTO;
import com.techmart.core.entity.User;
import com.techmart.ejb.service.UserServiceBean;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        UserDTO user = new UserDTO();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password);

        try {
            userService.register(user);
            resp.sendRedirect(
                    "verifyUser.jsp?email="
                            + URLEncoder.encode(
                            user.getEmail(),
                            StandardCharsets.UTF_8));
        } catch (RuntimeException e) {
            req.setAttribute("error", e.getMessage());
            req.setAttribute("firstName", user.getFirstName());
            req.setAttribute("lastName", user.getLastName());
            req.setAttribute("email", user.getEmail());

            req.getRequestDispatcher("/signUp.jsp")
                    .forward(req, resp);
        }
    }
}
