package com.example.server;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatServer {
    private Map<String, UserThread> userThreadMap = new HashMap<>();
    private List<Post> posts = new ArrayList<>();
    private int port;

    public ChatServer(int port) {
        this.port = port;
    }

    public int getPort() {
        return port;
    }

    public Map<String, UserThread> getUserThreadMap() {
        return userThreadMap;
    }

    public UserThread getUserThread(String name) {
        return userThreadMap.get(name);
    }

    public void addUserThread(String name, UserThread userThread) {
        userThreadMap.put(name, userThread);
        broadcast("User " + name + " added", name);
        System.out.println("User " + name + " added");
    }

    public void addPost(String title, String content, String username) {
        posts.add(new Post(title, content, username));
    }

    public Boolean containsUser(String name) {
        return userThreadMap.containsKey(name);
    }

    public void exec() throws IOException {
        ServerSocket serverSocket = new ServerSocket(this.port);
        System.out.println("Waiting for clients");

        while (true) {
            Socket socket = serverSocket.accept();
            UserThread userThread = new UserThread(socket, this);
            userThread.start();
//            System.out.println(userThread.getClientName()+" connected successfully");
        }
    }

    public void broadcast(String message) {
        for (UserThread aUser : userThreadMap.values()) {
            aUser.sendMessage(message);
        }
    }

    void broadcast(String message, String from) {

        for (Map.Entry<String, UserThread> entry : getUserThreadMap().entrySet()) {
            if (entry.getKey() == null || !entry.getKey().equals(from)) {
                entry.getValue().sendMessage("[" + from + "] to all:" + message);
            }
        }
    }

    public void sendMessage(String msg, String from, String to) {
        getUserThread(to).sendMessage("[" + from + "]:" + msg);
    }

    public List<Post> getPosts() {
        return posts;
    }
}
