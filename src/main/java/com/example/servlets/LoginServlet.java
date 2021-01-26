package com.example.servlets;

import com.example.classes.Database;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        UserController userController = new UserController();
        response.setContentType("text/html");
        HttpSession session = request.getSession(true);
        if (request.getParameter("action") != null) {
            //Login
            if (request.getParameter("action").equals("login")) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                try {
                    int id = Database.getInstance().doLogin(name,password);
                    if (id > 0) {
                        response.getWriter().write("True");
                        session.setAttribute("name",name);
                        session.setAttribute("user_id",id);
                        session.setMaxInactiveInterval(15*60);
                    } else {
                        response.getWriter().write("False");
                    }
                } catch (SQLException throwable) {
                    throwable.printStackTrace();
                }
            }
            if (request.getParameter("action").equals("register")) {
                String name = request.getParameter("name");
                String password = request.getParameter("password");
                try {
                    int id = Database.getInstance().doLogin(name, password);
                    if (id > 0) {
                        response.getWriter().write("False");
                    } else {
                        if (Database.getInstance().doRegister(name,password) > 0) {
                            response.getWriter().write("True");
                            session.setAttribute("name",name);
                            session.setAttribute("user_id",id);
                        } else {
                            response.getWriter().write("False");
                        }
                    }
                } catch (SQLException throwable) {
                    throwable.printStackTrace();
                }
            }
            //Logout
            if (request.getParameter("action").equals("logout")) {
                session.invalidate();
                response.getWriter().write("True");
            }
        }
    }
}
