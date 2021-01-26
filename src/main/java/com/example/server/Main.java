package com.example.server;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        int port = 4999;

        ChatServer server = new ChatServer(port);
        server.exec();
    }
}
