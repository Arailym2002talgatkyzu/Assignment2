package com.example.filters;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "NotFoundFilter")
public class NotFoundFilter implements Filter {
    private static final List<String> allUrls = List.of(
            "/", "/login.jsp", "/register.jsp", "/permission-denied.jsp", "/userpage.jsp", "/PostForm.jsp", "/notFound.jsp",
            "/LoginServlet", "/AddFriendServlet", "/SearchUserServlet", "/CommentServlet", "/PostServlet", "/index.jsp"
    );

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletResponse resp = (HttpServletResponse) response;
        String path = ((HttpServletRequest) request).getRequestURI().replace("/JavaAssignment2_war","");
        if (!allUrls.contains(path)) {
            request.setAttribute("uri", path);
            request.getRequestDispatcher("notFound.jsp").forward(request, response);
        } else {
            chain.doFilter(request, response);
        }
    }
}
