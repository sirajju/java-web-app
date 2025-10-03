package com.app.utils;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;

public class Util {
    public static final String INDEX_NAME = "/index.jsp";
    public static final String LOGIN_NAME = "/login.jsp";

    public static String readResourceFile(String path) {
        try {
            return new String(Util.class.getResourceAsStream(path).readAllBytes());
        } catch (Exception e) {
            throw new RuntimeException("Error reading file", e);
        }
    }

    public static RequestDispatcher GetRequestContext(ServletContext Context, String path) {
        try {
            return Context.getRequestDispatcher(path);
        } catch (Exception e) {
            throw new RuntimeException("Error reading file", e);
        }
    }

    public static RequestDispatcher GetIndexPage(ServletContext Context) {
        return GetRequestContext(Context, INDEX_NAME);
    }

    public static RequestDispatcher GetLoginPage(ServletContext Context) {
        return GetRequestContext(Context, LOGIN_NAME);
    }
}
