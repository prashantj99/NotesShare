<%@page import="com.prashant.webapp.entities.Course"%>
<%@page import="com.prashant.webapp.dao.CourseDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page import="com.prashant.webapp.dao.CategoryDAO"%>
<%@page import="com.prashant.webapp.entities.Category"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header_resources.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="components/footer.css"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <script type="text/javascript" src="components/nav_bar_js.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <link rel="stylesheet" href="./css/index_bannar_style.css"/>
        <link rel="stylesheet" href="components/nav_bar_style.css"/>
        <script src="https://use.fontawesome.com/07b0ce5d10.js"></script>
        <title>Home | NotesShare </title>
    </head>
    <body>
        <!--navbar start-->
        <%@include file="navbar.jsp" %>
        <!--navbar end-->
        <div class="jumbotron jumbotron-fluid text-center" >
            <div class="container">
                <h1 class="display-4">Welcome to NotesShare</h1>
                <p class="lead">Take notes, organize your thoughts, and stay productive.</p>
                <a class="btn btn-warning btn-lg" href="./login_page.jsp" role="button">Get Started</a>
            </div>
        </div>
        <section class="container" >
            <div class="row">
                <div class="col-md-6">
                    <h2>Upload Notes</h2>
                    <p>Easily upload your notes and keep them securely stored in the cloud. Access them from any device with an internet connection.</p>
                </div>
                <div class="col-md-6">
                    <h2>View Notes</h2>
                    <p>Browse and search through your uploaded notes to quickly find the information you need. Read your notes in a clean and distraction-free interface.</p>
                </div>
            </div>
        </section>
        <br>
        <br>
        <br>
        <section class="cta-section text-center">
            <div class="container">
                <h2>Unlock Premium Features</h2>
                <p>Upgrade to our premium plan to enjoy unlimited note views, advanced search capabilities, and more.</p>
                <a class="btn btn-primary btn-lg" href="#" role="button">Upgrade Now</a>
            </div>
        </section>
        <br>
        <br>
        <%@include file="footer.jsp" %>
    </body>
</html>
