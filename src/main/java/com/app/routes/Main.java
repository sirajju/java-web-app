package com.app.routes;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.json.JSONArray;

import com.app.utils.Util;
import com.app.services.Auth;
import com.app.services.Cache;
import com.app.services.Logger;;

public class Main extends Auth {
    protected RequestDispatcher jsp;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        Logger.info("Init -> Reading index file");
        ServletContext context = config.getServletContext();
        jsp = Util.GetIndexPage(context);
        Cache.set("test_key", "test_value");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String apiUrl = "https://jsonplaceholder.typicode.com/todos/";
        StringBuilder responseBuilder = new StringBuilder();

        Logger.info("Requesting to todos");

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
            Logger.severe("Error while requesting todo");
            throw new ServletException(e);
        }

        Logger.warning("Not configured path level routes");

        String fileData = Util.readResourceFile("/todos.json");
        JSONArray jsonArray = new JSONArray(fileData.toString());

        List<Object> todos = jsonArray.toList();

        request.setAttribute("todos", todos);
        request.setAttribute("message", "Welcome to homeeeeeeee !");
        response.setStatus(200);
        jsp.forward(request, response);
    }

    protected String getRandomBearer() {
        return "Bearer " + Math.random();
    }
}
