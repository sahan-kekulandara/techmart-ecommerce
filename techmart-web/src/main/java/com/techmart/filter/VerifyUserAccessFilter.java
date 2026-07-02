package com.techmart.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/verifyUser.jsp")
public class VerifyUserAccessFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        Object registeredEmail = httpRequest.getAttribute("registeredEmail");

        if (registeredEmail == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/signUp.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {}
}