package com.example.client;

public class Main {
    public static void main(String[] args) {

        int port = 4999;

        ChatClient client = new ChatClient("localhost", port);
        client.execute();
    }
}
