<%@page import="java.io.File"%>
<%@page import="com.prashant.webapp.entities.Notes"%>
<%@page import="java.util.List"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page import="com.prashant.webapp.dao.NotesDAO"%>
<%@page import="com.prashant.webapp.entities.User"%>
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
        <title>Notes Stats | NotesShare</title>
        <link rel="stylesheet" href="../css/user_dashboard_style.css">
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
                                <a href="../LogoutServlet">
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
                            <a href="#"><%=user.getUserName()%></a> 
                        </h3>
                        <p class="profile-title">#<%=user.getUserEmail()%></p>
                    </div>
                </div>

                <ul class="wraplist" style="height: auto;">	
                    <li><a href="./user_dashboard.jsp"><span class="sidebar-icon"><i class="fa fa-dashboard"></i></span> <span class="menu-title">Dashboard</span></a></li>
                    <li><a href="./upload_notes.jsp"onclick="showLoader()"><span class="sidebar-icon"><i class="fa fa-bullseye"></i></span> <span class="menu-title">Upload Notes</span></a></li>
                    <li><a href="#"><span class="sidebar-icon"><i class="fa fa-bar-chart"></i></span> <span class="menu-title">Notes Stats</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-calendar"></i></span> <span class="menu-title">Leaderboard</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-suitcase"></i></span> <span class="menu-title">Meetings</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>


        <section id="main-content">
            <section class="wrapper main-wrapper row">
                <div class="col-md-12 mt-3">  
                    <section class="box">
                        <%
                            NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
                            List<Notes> notes = notesDAO.getNotesByUserId(user.getUserId());
                            for (Notes note : notes) {
                        %>
                        <div class="card rounded justify-content-center mt-3">
                            <div class="card-body" style="background-color: #ecf0f1;">
                                <div class="row align-items-center">
                                    <div class="col-md-2">
                                        <%
                                            String applicationPath = request.getContextPath();
                                            String uploadPath = applicationPath + File.separator + "uploads" + File.separator + note.getNoteId()+".pdf";
                                        %>
                                        <h6><a href="./displayPDF.jsp?file=<%=note.getNoteId()+".pdf"%>"><%=note.getNoteName()%></a></h6>
                                    </div>
                                    <div class="col-md-2">
                                        <i class="fa fa-eye"></i>
                                        <span class="badge badge-warning"><%=note.getViews()%></span>
                                    </div>
                                    <div class="col-md-2">
                                        <i class="fa fa-thumbs-up"></i>
                                        <span class="badge badge-primary"><%=note.getLikes()%></span>
                                    </div>
                                    <div class="col-md-2">
                                        <i class="fa fa-thumbs-down"></i>
                                        <span class="badge badge-danger"><%=note.getDislikes()%></span>
                                    </div>
                                    <div class="col-md-2">
                                        <%
                                            int status = note.getStatus();
                                            if (status == 1) {
                                        %>
                                        <i class="fa fa-check" style="color: "></i>
                                        <span class="badge badge-success">accepted</span>
                                        <%
                                        } else if (status == -1) {
                                        %>
                                        <i class="fa fa-times"></i>
                                        <span class="badge badge-warning">rejected</span>
                                        <%
                                        } else if (status == 0) {
                                        %>
                                        <i class="fa fa-spinner"></i>
                                        <span class="badge badge-primary">pending</span>
                                        <%
                                            }
                                        %>
                                    </div>
                                    <div class="col-md-2">
                                        <button class="btn" title="delete">
                                            <i class="fa fa-trash" style="color: red;" aria-hidden="true"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <%
                            }
                        %>
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
    </body>
</html>
