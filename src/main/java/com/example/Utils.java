package com.example;

public class Utils {
    public static String readUtilFile(String path) {
        try {
            System.out.println(path);
            return new String(Utils.class.getResourceAsStream(path).readAllBytes());
        } catch (Exception e) {
            throw new RuntimeException("Error reading file", e);
        }
    }
}
