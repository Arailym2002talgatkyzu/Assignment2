package com.example.server;

import com.example.classes.Database;

import java.io.*;
import java.net.Socket;
import java.sql.SQLException;
import java.util.Date;
import java.util.Timer;
import java.util.TimerTask;

public class UserThread extends Thread {
    private Socket socket;
    private ChatServer chatServer;
    private PrintWriter writer;
    private BufferedReader reader;
    private String clientName;
    Timer timer = new Timer();

    public String getClientName() {
        return clientName;
    }

    UserThread(Socket socket, ChatServer chatServer) {
        this.socket = socket;
        this.chatServer = chatServer;
    }

    @Override
    public void run() {
        try {
            InputStream input = socket.getInputStream();
            reader = new BufferedReader(new InputStreamReader(input));

            OutputStream output = null;

            output = socket.getOutputStream();

            writer = new PrintWriter(output, true);
            writer.println("Please type unique username and password!");

            String data = reader.readLine();
            String username = data.split(" ")[0];
            String password = data.split(" ")[1];
            while (this.chatServer.containsUser(username)) {
                writer.println("This username is exists, please type another username ");
                username = reader.readLine();
            }
            this.clientName = username;
            chatServer.addUserThread(username, this);

            sendMessage("Users: ");
            for (String clientName : chatServer.getUserThreadMap().keySet()) {
                sendMessage(clientName);
            }

            String msg;
            do {
                timer.schedule( new TimerTask() {
                    public void run() {
                        sendMessage("Posts: ");
                        for (Post post: chatServer.getPosts()) {
                            sendMessage(post.title);
                        }
                    }
                }, 1000*60*10,1000*60*10);

                msg = reader.readLine();
                switch (msg) {
                    case "bye":
                        break;
                    case "update":
                        sendMessage("Posts: ");
                        for (Post post: chatServer.getPosts()) {
                            sendMessage(post.title);
                        }
                        break;
                    case "post":
                        sendMessage("Enter title: ");
                        String title = reader.readLine();
                        sendMessage("Enter content: ");
                        String content = reader.readLine();
                        chatServer.addPost(title, content, username);
                        sendMessage("Post added!");
                        break;
                }
            } while (true);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void sendMessage(String message) {
        writer.println(message);
    }

}
