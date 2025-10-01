package com.example;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URI;
import java.util.List;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import org.json.JSONArray;

import java.util.logging.FileHandler;
import java.util.logging.Logger;

public class Main extends Auth {
    protected RequestDispatcher jsp;
    Logger logger = Logger.getLogger(getServletName());

    public void init(ServletConfig config) throws ServletException {
        try {
            FileHandler fh = new FileHandler("myapp.log");
            logger.addHandler(fh);
        } catch (Exception e) {
            throw new ServletException("Error while reading the log file");
        }
        logger.info("Init -> Reading index file");
        ServletContext context = config.getServletContext();
        jsp = context.getRequestDispatcher("/WEB-INF/index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String apiUrl = "https://jsonplaceholder.typicode.com/todos/";
        StringBuilder responseBuilder = new StringBuilder();

        logger.info("Requesting to todos");

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
            logger.severe("Error while requesting todo");
            throw new ServletException(e);
        }

        logger.warning("Not configured path level routes");

        String fileData = Utils.readUtilFile("/todos.json");
        JSONArray jsonArray = new JSONArray(fileData.toString());

        List<Object> todos = jsonArray.toList();

        request.setAttribute("todos", todos);
        request.setAttribute("message", "Welcome to homeeee !");
        response.setStatus(200);
        jsp.forward(request, response);
    }

    protected String getRandomBearer() {
        return "Bearer " + Math.random();
    }
}
