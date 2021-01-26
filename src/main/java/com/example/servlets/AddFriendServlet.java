package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "AddFriendServlet", value = "/AddFriendServlet")
public class AddFriendServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int user_id = (Integer) session.getAttribute("user_id");
        int friend_id = Integer.parseInt(request.getParameter("friend_id"));
        try {
            if (request.getParameter("action").equals("send")) {
                if (Database.getInstance().doAddFriend(user_id,friend_id) > 0) response.getWriter().write("True");
                return;
            }
            if (request.getParameter("action").equals("accept")){
                if (Database.getInstance().doAcceptFriend(friend_id, user_id) > 0) response.getWriter().write("True");
            }
        } catch (SQLException throwable) {
            throwable.printStackTrace();
        }
    }
}
