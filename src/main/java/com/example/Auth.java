package com.example;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class Auth extends HttpServlet {
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookie = request.getCookies();
        if (!this.isLoggedIn(cookie)) {
            response.setStatus(302);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        super.service(request, response);
    }

    public boolean isLoggedIn(Cookie[] cookie) {
        if (cookie == null) {
            return false;
        }
        for (Cookie item : cookie) {
            if ("sessionId".equals(item.getName())) {
                if (item.getValue().equals("12333")) {
                    return true;
                }
            }
        }
        return false;
    }
}
