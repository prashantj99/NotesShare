package com.prashant.webapp.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.prashant.webapp.entities.User;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class CheckSessionServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        boolean sessionExpired = (session == null);
        boolean differentUser = (session != null && !((User) session.getAttribute("loginuser")).getUserId().equals(request.getParameter("userId")));
        System.err.println("sessionExp" + sessionExpired + "diffuser" + differentUser);
        
        // Create a JsonObject and set the sessionExpired and differentUser properties
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("sessionExpired", sessionExpired);
        jsonResponse.addProperty("differentUser", differentUser);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Use Gson to convert the JsonObject to a JSON string and send it as the response
        Gson gson = new Gson();
        String jsonResult = gson.toJson(jsonResponse);
        response.getWriter().write(jsonResult);
    }
}
