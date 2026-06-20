package com.techmart.servlet;

import com.techmart.core.entity.User;
import com.techmart.core.entity.UserStatus;
import com.techmart.ejb.service.UserService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;

@WebServlet("/test")
public class Test extends HttpServlet {

    @EJB
    private UserService userService;

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = new User();
        user.setFirstName("Sahan");
        user.setLastName("Kekulandara");
        user.setEmail("sahan@gmail.com");
        user.setPassword("1234567");
        user.setCreatedAt(Timestamp.from(Instant.now()));

        UserStatus userStatus = new UserStatus();
        userStatus.setId(1L);
        userStatus.setStatus("active");

        user.setUserStatus(userStatus);

        userService.save(user);
        resp.getWriter().write("Success");
    }
}
