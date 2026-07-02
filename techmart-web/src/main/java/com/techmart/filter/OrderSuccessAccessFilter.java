package com.techmart.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/orderSuccess.jsp")
public class OrderSuccessAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        Object orderId = httpRequest.getAttribute("orderId");

        if (orderId == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/products");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}
}