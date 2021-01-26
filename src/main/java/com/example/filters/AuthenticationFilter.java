package com.example.filters;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebFilter(filterName = "AuthenticationFilter")
public class AuthenticationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpSession session = ((HttpServletRequest) request).getSession(false);
        HttpServletResponse resp = (HttpServletResponse) response;
        if (session == null || session.getAttribute("user_id") == null) {
            resp.sendRedirect("permission-denied.jsp");
        } else {
            chain.doFilter(request, response);
        }
    }
}
