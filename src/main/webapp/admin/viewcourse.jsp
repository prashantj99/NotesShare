<%@page import="com.prashant.webapp.entities.Category"%>
<%@page import="com.prashant.webapp.dao.NotesDAO"%>
<%@page import="com.prashant.webapp.dao.DepartmentDAO"%>
<%@page import="com.prashant.webapp.dao.CategoryDAO"%>
<%@page import="com.prashant.webapp.entities.Course"%>
<%@page import="java.util.List"%>
<%@page import="com.prashant.webapp.dao.CourseDAO"%>
<%@page import="com.prashant.webapp.entities.User"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--redirect to login page if session out-->
<%
    User user = (User) session.getAttribute("loginuser");
    if (user == null || !user.getUserType().equals("admin")) {
        session.setAttribute("msg", "you are not authorize to access this page");
        session.setAttribute("type", "danger");
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
        <link rel="stylesheet" href="../css/user_dashboard_style.css">
        <script src="../js/user_dashboard_js.js"></script>
    </head>
    <body>
        <div class="page-topbar">
            <div class="logo-area"> 
                <!--NotesShare icon-->
            </div>
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

        <div class="page-sidebar expandit">
            <div class="sidebar-inner" id="main-menu-wrapper">
                <div class="profile-info row ">
                    <div class="profile-image ">
                        <a href="#">
                            <img alt="" src="../img/icons8-user-64.png" class="img-circle img-inline img-responsive img-circle">
                        </a>
                    </div>
                    <div class="profile-details" >
                        <h3 style="text-transform: capitalize;">
                            <a href="#">Hi! <%=user.getUserName()%></a> 
                        </h3>
                        <p class="profile-title">#<%=user.getUserEmail()%></p>
                    </div>
                </div>

                <ul class="wraplist" style="height: auto;">	
                    <li><a href="#"><span class="sidebar-icon"><i class="fa fa-dashboard"></i></span> <span class="menu-title">Dashboard</span></a></li>
                    <li><a href="./approve_notes.jsp"><span class="sidebar-icon"><i class="fa fa-check"></i></span> <span class="menu-title">Approve Notes</span></a></li>
                    <li><a href="./viewcategory.jsp"><span class="sidebar-icon"><i class="fa fa-users"></i></span> <span class="menu-title">Category</span></a></li>
                    <li><a href="#"><span class="sidebar-icon"><i class="fa fa-calendar"></i></span> <span class="menu-title">Department</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-suitcase"></i></span> <span class="menu-title">Meetings</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>


        <section id="main-content" style="overflow-x: hidden">
            <br>
            <br>
            <br>
            <br>
            <div class="container-fluid">
                <div class="row d-flex align-items-center" style="flex-direction: column;">
                    <%
                        CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
                        for (Course c : courseDAO.getAllCourses()) {
                    %>
                    <div class="card col-10 bg-light m-2">
                        <div class="card-body row d-flex text-capitalize justify-content-between">
                            <h6 class="text-muted">
                                <%=c.getCourseName()%>
                            </h6>
                            <div class="btn-group">
                                <button class="btn btn-secondary">
                                    <i class="fa fa-pencil-square"></i>
                                </button>
                                <button class="btn btn-danger">
                                    <i class="fa fa-trash-o"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

    </body>
</html>
