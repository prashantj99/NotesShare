<%-- 
    Document   : error
    Created on : 2 May, 2023, 11:37:38 AM
    Author     : hp 1
--%>

<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Error 500 - Internal Server Error</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
              integrity="sha384-pzjw6AFs5hy1xtJ+w6+0n33/4qPX4rjjpTc5/6e+vvo6Tq+D1IbbVXJmi0l9U4N1"
              crossorigin="anonymous">
        <style>
            body {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 100vh;
            }
        </style>
    </head>
    <body>
        <div class="container text-center">
            <h1>Error 500 - Internal Server Error</h1>
            <p>An unexpected error occurred on the server.</p>
            <p>Please try again later.</p>
            <p><a href="./index.jsp">Home Page</a></p>
        </div>
    </body>
</html>
