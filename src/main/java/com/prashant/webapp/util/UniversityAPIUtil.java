package com.prashant.webapp.util;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class UniversityAPIUtil {

    private static final String API_URL = 
            "http://universities.hipolabs.com/search?country=India";

    public static List<String> getIndianUniversityNames() {
        try {
            // Create URL object
            URL url = new URL(API_URL);
            // Create connection object
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            // Set request method
            connection.setRequestMethod("GET");
            // Send the request and receive the response
            int responseCode = connection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // Read the response
                BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                String line;
                StringBuilder response = new StringBuilder();
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                reader.close();
                // Close the connection
                connection.disconnect();

                // Parse the response and extract university names
                ObjectMapper objectMapper = new ObjectMapper();
                JsonNode rootNode = objectMapper.readTree(response.toString());
                List<String> universityNames = new ArrayList<>();
                for (JsonNode universityNode : rootNode) {
                    String universityName = universityNode.get("name").asText();
                    universityNames.add(universityName);
                }
                return universityNames;
            } else {
                System.out.println("Error: " + responseCode);
            }
            // Close the connection
            connection.disconnect();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
}
