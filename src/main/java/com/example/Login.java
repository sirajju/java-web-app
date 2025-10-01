package com.example;

import jakarta.servlet.http.*;
import java.io.IOException;
import jakarta.servlet.*;

public class Login extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String logout = request.getParameter("logout");
        if ("true".equals(logout)) {
            Cookie myCookie = new Cookie("sessionId", null);
            myCookie.setMaxAge(0);
            response.addCookie(myCookie);
            request.setAttribute("message", "Logged out successfully");
        }

        if (new Auth().isLoggedIn(request.getCookies())) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null && !username.isEmpty() && !password.isEmpty()) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            Cookie cookie = new Cookie("sessionId", "12333");
            response.addCookie(cookie);
            response.sendRedirect(request.getContextPath() + "/");
        } else {
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/WEB-INF/login.jsp").forward(request, response);
        }
    }
}
