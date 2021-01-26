package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "CommentServlet", value = "/CommentServlet")
public class CommentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int user_id = (Integer) session.getAttribute("user_id");
        int post_id = Integer.parseInt((String) request.getParameter("post_id"));
        String comment = request.getParameter("comment");
        try {
            if (Database.getInstance().doComment(user_id, post_id, comment) == 0) response.sendRedirect("index.jsp");
            else response.sendRedirect("/");
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
    }
}
