package com.techmart.servlet;

import com.techmart.api.service.UserAddressService;
import com.techmart.api.service.UserService;
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

@WebServlet("/profile-update")
public class ProfileUpdateServlet extends HttpServlet {

    @EJB
    private UserAddressService userAddressService;

    @EJB
    private UserService userService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        UserDTO loggedInUser = (UserDTO) session.getAttribute("user");

        if (loggedInUser == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String action = req.getParameter("action");

        if ("updateInfo".equals(action)) {
            String address1 = req.getParameter("addressLine1");
            String address2 = req.getParameter("addressLine2");
            String cityVal = req.getParameter("city");
            String zipCode = req.getParameter("postalCode");

            UserAddressDTO addressData = UserAddressDTO.builder()
                    .user(loggedInUser)
                    .addressLine1(address1)
                    .addressLine2(address2)
                    .city(cityVal)
                    .postalCode(zipCode)
                    .isShipping(true)
                    .isBilling(false)
                    .build();

            userAddressService.saveOrUpdateProfileAddress(addressData);

            session.setAttribute("profileSuccessMessage", "Address details saved successfully!");
            resp.sendRedirect("profile");

        } else if ("updatePassword".equals(action)) {
            String oldPass = req.getParameter("oldPassword");
            String newPass = req.getParameter("newPassword");
            String confirmPass = req.getParameter("confirmPassword");

            boolean isUpdated = userService.updatePassword(loggedInUser.getId(), oldPass, newPass, confirmPass);

            if (isUpdated) {
                session.setAttribute("profileSuccessMessage", "Security authentication credentials modified successfully.");
            } else {
                session.setAttribute("profileErrorMessage", "Password change rejected. Verify entries match correctly.");
            }

            resp.sendRedirect("profile");
        }

    }
}