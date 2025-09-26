package com.example;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import org.json.JSONArray;

public class Main extends Auth {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String apiUrl = "https://jsonplaceholder.typicode.com/todos/";
        StringBuilder responseBuilder = new StringBuilder();

        try {
            HttpURLConnection connection = (HttpURLConnection) new URI(apiUrl).toURL().openConnection();
            connection.setRequestMethod("GET");

            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String line;
            while ((line = reader.readLine()) != null) {
                responseBuilder.append(line);
            }
            reader.close();
            connection.disconnect();
        } catch (Exception e) {
            throw new ServletException(e);
        }

        String fileData = Utils.readUtilFile("/todos.json");
        JSONArray jsonArray = new JSONArray(fileData.toString());

        List<Object> todos = jsonArray.toList();

        request.setAttribute("todos", todos);
        response.setStatus(300);
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }

    protected String getRandomBearer() {
        return "Bearer " + Math.random();
    }
}
