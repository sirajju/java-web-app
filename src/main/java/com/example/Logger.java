package com.example;

public class Logger {
    private static enum Color {
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

    private static void log(String level, String messsage) {
        System.out.printf(level + messsage + Color.RESET.code());
    }

    public static void warning(String message) {
        log(Color.YELLOW.code(), message);
    }

    public static void severe(String message) {
        log(Color.RED.code(), message);
    }

    public static void info(String message) {
        log(Color.BLUE.code(), message);
    }
}
