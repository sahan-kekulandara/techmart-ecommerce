package com.techmart.servlet;

import com.stripe.Stripe;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;
import com.techmart.api.service.CartService;
import com.techmart.api.service.UserAddressService;
import com.techmart.core.dto.ShoppingCartDTO;
import com.techmart.core.dto.UserAddressDTO;
import com.techmart.core.dto.UserDTO;
import com.techmart.core.util.EnvLoader;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutViewServlet extends HttpServlet {

    @EJB
    private CartService cartService;
    @EJB
    private UserAddressService userAddressService;

    @Override
    public void init() throws ServletException {
        String stripeKey = EnvLoader.get("STRIPE_SECRET_KEY");
        if (stripeKey != null) {
            Stripe.apiKey = stripeKey.trim();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            req.setAttribute("error", "Please sign in to complete secure checkout.");
            req.getRequestDispatcher("/logIn.jsp").forward(req, resp);
            return;
        }

        String guestToken = (String) session.getAttribute("guestToken");
        ShoppingCartDTO shoppingCart = cartService.getActiveCart(guestToken, user.getId());

        if (shoppingCart == null || shoppingCart.getItems().isEmpty()) {
            session.setAttribute("cartMessage", "Your cart is empty.");
            resp.sendRedirect("cart");
            return;
        }
        req.setAttribute("shoppingCart", shoppingCart);

        List<UserAddressDTO> userAddresses = userAddressService.getUserAddresses(user.getId());
        req.setAttribute("userAddresses", userAddresses);

        double deliveryFee = 0.0;
        if (!userAddresses.isEmpty()) {
            UserAddressDTO defaultAddr = userAddresses.get(0);
            if (defaultAddr.getCity() != null && "colombo".equalsIgnoreCase(defaultAddr.getCity().trim())) {
                deliveryFee = 0.0;
            } else {
                deliveryFee = 5.00;
            }
        }

        double cartSubtotal = shoppingCart.getTotalCartPrice();
        double finalGrandTotal = cartSubtotal + deliveryFee;

        req.setAttribute("deliveryFee", deliveryFee);
        req.setAttribute("finalGrandTotal", finalGrandTotal);

        req.getRequestDispatcher("/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();

        String addressParam = req.getParameter("selectedAddressId");
        if (addressParam == null || addressParam.trim().isEmpty()) {
            System.err.println("[CHECKOUT POST ERROR] Address selection parameter is missing!");
            resp.sendRedirect("checkout");
            return;
        }

        Long addressId = Long.parseLong(addressParam);
        session.setAttribute("selectedAddressId", addressId);
        System.out.println("[CHECKOUT POST LOG] Address ID successfully saved in session: " + addressId);
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            resp.sendRedirect("logIn.jsp");
            return;
        }

        String guestToken = (String) session.getAttribute("guestToken");
        ShoppingCartDTO shoppingCart = cartService.getActiveCart(guestToken, user.getId());

        // Recalculate total safely on backend
        List<UserAddressDTO> userAddresses = userAddressService.getUserAddresses(user.getId());
        double deliveryFee = 0.0;
        if (!userAddresses.isEmpty()) {
            UserAddressDTO defaultAddr = userAddresses.get(0);
            if (defaultAddr.getCity() != null && "colombo".equalsIgnoreCase(defaultAddr.getCity().trim())) {
                deliveryFee = 0.0;
            } else {
                deliveryFee = 5.00;
            }
        }
        double finalGrandTotal = shoppingCart.getTotalCartPrice() + deliveryFee;

        try {
            long amountInCents = Math.round(finalGrandTotal * 100);

            String scheme = req.getScheme();
            String serverName = req.getServerName();
            int serverPort = req.getServerPort();
            String contextPath = req.getContextPath();
            String baseURL = scheme + "://" + serverName + ":" + serverPort + contextPath;

            SessionCreateParams params = SessionCreateParams.builder()
                    .setMode(SessionCreateParams.Mode.PAYMENT)
                    .setCustomerEmail(user.getEmail())
                    .setSuccessUrl(baseURL + "/payment-success?session_id={CHECKOUT_SESSION_ID}")
                    .setCancelUrl(baseURL + "/checkout") // Redirects back to summary if they cancel
                    .addLineItem(
                            SessionCreateParams.LineItem.builder()
                                    .setQuantity(1L)
                                    .setPriceData(
                                            SessionCreateParams.LineItem.PriceData.builder()
                                                    .setCurrency("usd")
                                                    .setUnitAmount(amountInCents)
                                                    .setProductData(
                                                            SessionCreateParams.LineItem.PriceData.ProductData.builder()
                                                                    .setName("TechMart Order Total Settlement")
                                                                    .build()
                                                    )
                                                    .build()
                                    )
                                    .build()
                    )
                    .build();

            Session stripeSession = Session.create(params);

            resp.sendRedirect(stripeSession.getUrl());

        } catch (Exception e) {
            System.err.println("Stripe Exception: " + e.getMessage());
            resp.sendRedirect("cart");
        }
    }
}