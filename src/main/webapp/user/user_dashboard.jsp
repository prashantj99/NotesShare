<%@page import="com.prashant.webapp.entities.User"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--redirect to login page if session out-->
<%
    User user = (User) session.getAttribute("loginuser");
    if (user == null) {
        response.sendRedirect("./../login_page.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" type="image/png" href="img/icons8-making-notes-16.png" sizes="16x16">
        <%@include file="../header_resources.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard | NotesShare</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.4.0/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="../css/user_dashboard_style.css">
        <script src="../js/user_dashboard_js.js"></script>
    </head>
    <body >
        <div class="page-topbar">

            <div class="logo-area"></div>
            <div class="quick-area">

                <ul class="pull-left info-menu  user-notify">
                    <button id="menu_icon"><i class="fa fa-bars" aria-hidden="true"></i></button>        
                </ul>

                <ul class="pull-right info-menu user-info">
                    <li class="profile">
                        <a href="#" data-toggle="dropdown" class="toggle" aria-expanded="false">
                            <img src="../img/icons8-user-24.png" class="img-circle rounded img-inline">
                            <span><%=user.getUserName().trim()%> <i class="fa fa-angle-down"></i></span>
                        </a>
                        <ul class="dropdown-menu profile fadeIn ">
                            <li>
                                <a href="#settings">
                                    <i class="fa fa-wrench"></i>
                                    Settings
                                </a>
                            </li>
                            <li>
                                <a href="#profile">
                                    <i class="fa fa-user"></i>
                                    Profile
                                </a>
                            </li>

                            <li class="last">
                                <a href="./../LogoutServlet">
                                    <i class="fa fa-lock"></i>
                                    Sign Out
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>

            </div>
        </div>

        <div class="page-sidebar expandit text-light" >
            <div class="sidebar-inner" id="main-menu-wrapper">
                <div class="profile-info row ">
                    <div class="profile-image ">
                        <a href="#">
                            <img alt="" src="../img/icons8-user-64.png" class="img-circle img-inline img-responsive img-circle">
                        </a>
                    </div>
                    <div class="profile-details" >
                        <h3 style="text-transform: capitalize;">
                            <a href="#"><%=user.getUserName()%></a> 
                        </h3>
                        <p class="profile-title">#<%=user.getUserEmail()%></p>
                    </div>
                </div>

                <ul class="wraplist" style="height: auto;">	
                    <!--          <li class="menusection">Main</li>-->
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-dashboard"></i></span> <span class="menu-title">Dashboard</span></a></li>
                    <li><a href="./upload_notes.jsp" onclick="showLoader()"><span class="sidebar-icon"><i class="fa fa-bullseye"></i></span> <span class="menu-title">Upload Notes</span></a></li>
                    <li><a href="./notes_stats.jsp" ><span class="sidebar-icon"><i class="fa fa-bar-chart"></i></span> <span class="menu-title">Notes Stats</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-cog" aria-hidden="true"></i></i></span> <span class="menu-title">Settings</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>
        <section id="main-content">
            <section class="wrapper main-wrapper row">
                <div class="col-md-12">
                    <!--search bar-->
                    <div class="p-1 bg-light rounded rounded-pill shadow-sm mb-4">
                        <div class="input-group">
                            <a href="./../search.jsp" style="text-decoration: none;"  class="form-control border-0 bg-light" >search notes</a>
                            <div class="input-group-append">
                                <a href="./../search.jsp"  type="button" class="btn btn-link text-primary" ><i class="fa fa-search"></i></a>
                            </div>
                        </div>
                    </div>
                    <!--search bar end-->
                    <section class="box">
                        <!--//recently viewed items-->
                        <%@include file="recentnotes.jsp" %>

                        <!--//recently viewed items end -->
                    </section>
                </div>
                <div class="col-md-12">              
                    <section class="box">
                        <div class="container">
                            <h2><i class="fa fa-bookmark-o text-success" aria-hidden="true"></i></h2>
                        </div>
                        <%@include file="usersavednotes.jsp" %>
                    </section>
                </div>

                <div class="clearfix"></div> 

                <div class="col-md-12">              
                    <section class="box">

                    </section>
                </div>

            </section>
        </section>
        <%@include file="./page_loader.jsp" %>
        <script>
//            $(document).ready(function () {
//                $('.carousel').carousel();
//            });
//            window.onload = function () {
//                var userId = '<%=user.getUserId()%>';
//                checkSessionStatus(userId);
//            };
//            window.addEventListener('pageshow', function (event) {
//                window.location.reload();
//            });
//            function checkSessionStatus(userId) {
//                fetch('/NotesShare/CheckSessionServlet?userId=' + encodeURIComponent(userId))
//                        .then(response => response.json())
//                        .then(data => {
//                            if (data.sessionExpired || data.differentUser) {
//                                window.location.reload();
//                            }
//                        })
//                        .catch(error => {
//                            console.error('Error checking session status:', error);
//                        });
//            }
//            ;

        </script>
    </body>
</html>
