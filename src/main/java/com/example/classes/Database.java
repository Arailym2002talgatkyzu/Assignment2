package com.example.classes;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Database {
    private static final Database instance = new Database();

    public static Database getInstance() {
        return instance;
    }

    private Database() {
    }

    private static Connection getConnection() {
        Context initialContext;
        Connection connection = null;
        try {
            initialContext = new InitialContext();
            Context envCtx = (Context) initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource) envCtx.lookup("jdbc/SocialNet");
            connection = ds.getConnection();
        } catch (SQLException | NamingException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public int doPost(int user_id, String title, String content, String access, boolean commenting) throws SQLException {
        String sql = "insert into posts (user_id, title, content, access, commenting) values(?,?,?,?,?)";
        PreparedStatement statement = getConnection().prepareStatement(sql);
        statement.setInt(1,user_id);
        statement.setString(2,title);
        statement.setString(3,content);
        statement.setString(4,access);
        statement.setBoolean(5,commenting);
        return statement.executeUpdate();
    }

    public List<String> doGet() throws SQLException {
        String sql = "select title from posts";
        Statement statement = getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        List<String> posts = new ArrayList<>();
        while (resultSet.next()) {
            posts.add(resultSet.getString("title"));
        }
        return posts;
    }

    public int doUpdatePost(int post_id, String access, boolean commenting) throws SQLException {
        String sql = "update posts set access='" + access + "', commenting=" + commenting + " where id=" + post_id;
        Statement statement = getConnection().createStatement();
        return statement.executeUpdate(sql);
    }

    public int doComment(int user_id, int post_id, String comment) throws SQLException {
        String sql = "insert into comments (user_id, post_id, comment) values(?,?,?)";
        PreparedStatement statement = getConnection().prepareStatement(sql);
        statement.setInt(1,user_id);
        statement.setInt(2,post_id);
        statement.setString(3,comment);
        return statement.executeUpdate();
    }

    public int doLogin(String name, String password) throws SQLException {
        String sql = "select id from users where username='" + name + "' and password='" + password + "'";
        Statement statement = getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        while (resultSet.next()) {
            return resultSet.getInt("id");
        }

        return 0;
    }

    public List<Integer> doSearchUser(String name, int id) throws SQLException {
        String sql = "select id from users where username like '%" + name + "%' and id!="+id;
        Statement statement = getConnection().createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        List<Integer> ids = new ArrayList<>();
        while (resultSet.next()) {
            ids.add(resultSet.getInt("id"));
        }
        return ids;
    }

    public int doRegister(String username, String password) throws SQLException {
        String sql = "insert into users (username, password) values(?,?)";
        PreparedStatement statement = getConnection().prepareStatement(sql);
        statement.setString(1,username);
        statement.setString(2,password);
        return statement.executeUpdate();
    }

    public int doAddFriend(int user_id, int friend_id) throws SQLException {
        String sql = "insert into friends (user_id, friend_id, status) values(?,?,?)";
        PreparedStatement statement = getConnection().prepareStatement(sql);
        statement.setInt(1,user_id);
        statement.setInt(2,friend_id);
        statement.setInt(3,0);
        return statement.executeUpdate();
    }

    public int doAcceptFriend(int user_id, int friend_id) throws SQLException {
        String sql = "update friends set status=? where user_id=? and friend_id=?";
        PreparedStatement statement = getConnection().prepareStatement(sql);
        statement.setInt(1, 1);
        statement.setInt(2,user_id);
        statement.setInt(3,friend_id);
        return statement.executeUpdate();
    }
}