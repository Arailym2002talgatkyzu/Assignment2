package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdatePostServlet", value = "/UpdatePostServlet")
public class UpdatePostServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String access = request.getParameter("access");
        boolean commenting = false;
        if (request.getParameter("commenting").equals("true")) commenting = true;
        int post_id = Integer.parseInt((String) request.getParameter("post_id"));
        try {
            if (Database.getInstance().doUpdatePost(post_id,access,commenting) == 1) response.sendRedirect("userpage.jsp");
            else response.sendRedirect("PostForm.jsp");
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
    }
}
