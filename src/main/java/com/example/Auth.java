package com.example;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Auth extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookie = request.getCookies();

        if (cookie == null) {
            response.setStatus(402);
            response.sendRedirect("/login");
            return;
        }

        for (Cookie item : cookie) {
            if ("sessionId".equals(item.getName())) {
                if (!item.getValue().equals("12333")) {
                    response.setStatus(402);
                    response.sendRedirect("/login");
                    return;
                }
            }
        }
        super.service(request, response);
    }
}
