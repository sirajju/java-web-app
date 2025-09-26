package com.example;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Auth extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String method = request.getMethod();
        String authHeader = request.getHeader("authorization");
        System.out.println(authHeader);
        if (authHeader == null || !authHeader.contains("authorized") || authHeader.isEmpty()) {
            response.setStatus(402);
            response.sendRedirect("/login");
            return;
        } else if (method.equals("GET")) {
            return;
        }
        response.getWriter().write("Method not allowedddddd" + authHeader);
    }
}
