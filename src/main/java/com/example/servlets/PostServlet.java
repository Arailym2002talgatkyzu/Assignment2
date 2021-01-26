package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "PostServlet", value = "/PostServlet")
public class PostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int user_id = (Integer) session.getAttribute("user_id");
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String access = request.getParameter("access");
        boolean commenting = false;
        if (request.getParameter("commenting").equals("true")) commenting = true;
        try {
            if (Database.getInstance().doPost(user_id, title, content, access, commenting) == 0) response.sendRedirect("index.jsp");
            else response.sendRedirect("PostForm.jsp");
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
    }
}
