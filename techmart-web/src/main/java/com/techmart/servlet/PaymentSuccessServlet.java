package com.techmart.servlet;

import com.stripe.Stripe;
import com.stripe.model.checkout.Session;
import com.techmart.api.service.CartService;
import com.techmart.api.service.OrderService;
import com.techmart.core.dto.ShoppingCartDTO;
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

@WebServlet("/payment-success")
public class PaymentSuccessServlet extends HttpServlet {

    @EJB
    private CartService cartService;

    @EJB
    private OrderService orderService;

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
        String sessionId = req.getParameter("session_id");

        // Guard Condition: Reject if user identity context or stripe checkpoint data is invalid
        if (user == null || sessionId == null || sessionId.trim().isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }

        try {
            // 1. Fetch remote Checkout session parameters from Stripe API
            Session stripeSession = Session.retrieve(sessionId);

            // 2. Execute verification checks only on confirmed paid hooks
            if ("paid".equals(stripeSession.getPaymentStatus())) {
                String guestToken = (String) session.getAttribute("guestToken");
                ShoppingCartDTO cart = cartService.getActiveCart(guestToken, user.getId());
                Long addressId = (Long) session.getAttribute("selectedAddressId");

                // 3. Complete internal system validation checks
                if (cart != null && !cart.getItems().isEmpty() && addressId != null) {

                    // 4. Delegate transactional database writes down to business service layers
                    String trackingOrderId = orderService.processPaymentSuccess(cart, user, stripeSession.getId(), addressId);

                    // 5. Tear down validation states from active session memory
                    session.removeAttribute("selectedAddressId");

                    // 6. Direct client context variables safely to view templates
                    req.setAttribute("orderId", trackingOrderId);
                    req.getRequestDispatcher("/successConfirmation.jsp").forward(req, resp);
                    return;
                }
            }
        } catch (Exception e) {
            System.err.println("[FULFILLMENT CRASH] Order pipeline execution fault: " + e.getMessage());
            e.printStackTrace();
        }

        // Safe fallback redirection
        resp.sendRedirect("cart");
    }
}