package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "SearchUserServlet", value = "/SearchUserServlet")
public class SearchUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("name");
        HttpSession session = request.getSession();
        try {
            List<Integer> ids = Database.getInstance().doSearchUser(username, (Integer) session.getAttribute("user_id"));
            session.setAttribute("ids", ids);
            response.getWriter().write("True");
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
    }
}
