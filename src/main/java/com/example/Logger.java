package com.example;

public class Logger {
    public enum Color {
        RED("\u001B[31m"),
        GREEN("\u001B[32m"),
        BLUE("\u001B[34m"),
        RESET("\u001B[0m"),
        YELLOW("\u001B[33m");

        private final String code;

        Color(String code) {
            this.code = code;
        }

        public String code() {
            return code;
        }
    }

    public void log(String level, String messsage) {
        System.out.printf(level + messsage + Color.RESET.code());
    }

    public void warning(String message) {
        this.log(Color.YELLOW.code(), message);
    }

    public void severe(String message) {
        this.log(Color.RED.code(), message);
    }

    public void info(String message) {
        this.log(Color.BLUE.code(), message);
    }
}
