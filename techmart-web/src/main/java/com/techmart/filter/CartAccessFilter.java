package com.techmart.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Intercepts any direct requests to cart.jsp
@WebFilter("/cartView.jsp")
public class CartAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String cartServletPath = httpRequest.getContextPath() + "/cart";
        httpResponse.sendRedirect(cartServletPath);
    }

    @Override
    public void destroy() {}
}