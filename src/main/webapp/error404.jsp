<%-- 
    Document   : error404
    Created on : 16 Jun, 2023, 8:38:50 PM
    Author     : hp 1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header_resources.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>404 | NotesShare</title>
        <style>
            body {
                background: #f5f6fa;
                padding-top: 15%;
            }
            .img-error{
                width:220px;
                height:220px;
            }
        </style>
    </head>
    <body>
        <div class="container bootstrap snippets bootdey">
            <div class="row">
                <div class="col-md-12">
                    <div class="pull-right" style="margin-top:10px;">
                        <div class="col-md-10 col-md-offset-1 pull-right">
                            <img class="img-error" src="https://bootdey.com/img/Content/fdfadfadsfadoh.png">
                            <h2>404 Not Found</h2>
                            <p>Sorry, an error has occured, Requested page not found!</p>
                            <div class="error-actions">
                                <a href="./index.jsp" class="btn btn-primary btn-lg">
                                    <span class="glyphicon glyphicon-arrow-left"></span>
                                    Back Home 
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
