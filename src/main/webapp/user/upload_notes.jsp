<%@page import="com.prashant.webapp.dao.CategoryDAO"%>
<%@page import="com.prashant.webapp.entities.Category"%>
<%@page import="com.prashant.webapp.entities.Course"%>
<%@page import="com.prashant.webapp.dao.CourseDAO"%>
<%@page import="com.prashant.webapp.dao.DepartmentDAO"%>
<%@page import="com.prashant.webapp.entities.Department"%>
<%@page import="com.prashant.webapp.util.UniversityAPIUtil"%>
<%@page import="java.util.List"%>
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
        <link rel="stylesheet" href="../css/user_dashboard_style.css">
        <link rel="stylesheet" href="../css/file_upload_style.css">
        <script src="../js/user_dashboard_js.js" defer="defer"></script>
        <!--multiselect-->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

        <!-- Bootstrap Select CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/css/bootstrap-select.min.css" 
              integrity="sha512-ARJR74swou2y0Q2V9k0GbzQ/5vJ2RBSoCWokg4zkfM29Fb3vZEQyv0iWBMW/yvKgyHSR/7D64pFMmU8nYmbRkg==" 
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/i18n/defaults-am_ET.min.js" 
                integrity="sha512-u/Wb9n1d9DcM1ZspB5sZTIdct4ODkcf0ksSVTaBPkyK7caV7avu0YuceQ+i9975pconz6HQvafwYbrVPqla/Jw==" 
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.13.18/js/bootstrap-select.min.js" 
                integrity="sha512-yDlE7vpGDP7o2eftkCiPZ+yuUyEcaBwoJoIhdXv71KZWugFqEphIS3PU60lEkFaz8RxaVsMpSvQxMBaKVwA5xg==" 
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <script type="text/javascript" defer>
            $(document).ready(function () {
                $('.selectpicker').selectpicker();
            });
        </script>
        <style>
            .bootstrap-select:not([class*=col-]):not([class*=form-control]):not(.input-group-btn) {
                width: 100%;
            }
        </style>
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
                    <!--          <li class="menusection">Main</li>-->
                    <li><a href="./user_dashboard.jsp"><span class="sidebar-icon"><i class="fa fa-dashboard"></i></span> <span class="menu-title">Dashboard</span></a></li>
                    <li><a href="#" ><span class="sidebar-icon"><i class="fa fa-bullseye"></i></span> <span class="menu-title">Upload Notes</span></a></li>
                    <li><a href="./notes_stats.jsp"><span class="sidebar-icon"><i class="fa fa-bar-chart"></i></span> <span class="menu-title">Notes Stats</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-calendar"></i></span> <span class="menu-title">Leaderboard</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-suitcase"></i></span> <span class="menu-title">Meetings</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>


        <section id="main-content">
            <section class="wrapper main-wrapper row">
                <div class="col-md-10">              
                    <section class="box">
                        <%@include file="./../message.jsp" %>
                        <!--add notes form-->
                        <div class="container">
                            <h4><img src="./../img/upload.png" style="width: 50px;" /><span class="pl-3">Upload Note</span></h4>
                            <form action="./../UploadNotesServlet" method="post" enctype="multipart/form-data">

                                <!-- University Selection -->
                                <div class="form-group">
                                    <label for="university">University</label>
                                    <select class="form-control" id="university" name="noteUniversity" required>
                                        <%                                            try {
                                                List<String> universityNames = UniversityAPIUtil.getIndianUniversityNames();
                                                universityNames.sort(null);
                                                if (universityNames != null) {
                                                    for (String name : universityNames) {
                                        %>
                                        <option value="<%=name%>"><%=name%></option>
                                        <%
                                                    }
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                        <option value="-1">Other</option>
                                    </select>
                                </div>
                                <!-- Category Selection -->
                                <div class="form-group">
                                    <label for="noteTitle">Title</label>
                                    <input type="text" class="form-control" id="noteTitle" name="noteTitle" required>
                                </div>
                                <!-- category -->
                                <div class="form-group">
                                    <label for="category">Category</label>
                                    <select class="form-control" id="category" name="category" required>
                                        <%
                                            try {
                                                CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getSessionFactory());
                                                List<Category> categorys = categoryDAO.getAllCategories();
                                                for (Category c : categorys) {
                                        %>
                                        <option  value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                e.printStackTrace();
                                            }
                                        %>
                                        <!-- Add more semesters as needed -->
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="department">Department</label>
                                    <select class="form-control" id="department" name="department" required>
                                        <%
                                            try {
                                                DepartmentDAO depart = new DepartmentDAO(FactoryProvider.getSessionFactory());
                                                List<Department> deptlist = depart.getAllDepartments();
//                                                deptlist.sort(null);
                                                for (Department d : deptlist) {
                                        %>
                                        <option value="<%=d.getDepartmentId()%>"><%=d.getDepartmentName()%></option>  
                                        <%
                                                }
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </select>
                                    <!-- Add more options as needed -->
                                </div>
                                <!--add course-->
                                <div class="form-group">
                                    <label for="courseDropdown">Courses</label>
                                    <%
                                        CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
                                        List<Course> courses = courseDAO.getAllCourses();
                                    %>
                                    <select id="courseDropdown" style="width: 100%;" class="selectpicker" multiple data-live-search="true" name="courses" required>
                                        <%
                                            for (Course c : courses) {
                                        %>
                                        <option value="<%=c.getCourseId()%>"><%=c.getCourseName()%></option>
                                        <%
                                            }
                                        %>
                                        <!-- Add more options as needed -->
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="noteType">Type</label>
                                    <select class="form-control" id="noteType" name="noteType" required>
                                        <option value="1" selected>Handwritten</option>
                                        <option value="2">Printed</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="noteSemester">Semester</label>
                                    <select class="form-control" id="noteSemester" name="noteSemester" required>
                                        <%
                                            for (int i = 1; i <= 8; i++) {
                                        %>
                                        <option value="<%=i%>">Semester <%=i%></option>
                                        <%
                                            }
                                        %>
                                        <option value="-1" selected>Not Applicable</option>
                                    </select>
                                    <!-- Add more options as needed -->
                                </div>

                                <div class="form-group">
                                    <label for="noteTags">
                                        Tags (to appear in search results)
                                    </label>
                                    <input type="text" class="form-control" id="noteTags" name="noteTags" required>
                                </div>
                                <div class="form-group">
                                    <label for="noteDescription">Description</label>
                                    <textarea class="form-control" id="noteDescription" name="noteDescription" rows="4" required></textarea>
                                </div>
                                <!-- Notes Upload -->
                                <div class="form-group">
                                    <label for="notes">Upload Notes</label>
                                    <input type="file" class="form-control-file" id="notes" name="notes" required>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-primary">Upload</button>
                                    <button type="reset" class="btn btn-warning">Reset</button>
                                </div>
                            </form>
                            <br><!-- new line -->
                            <br> 
                        </div>
                    </section>
                </div>                        

            </section>
        </section>
    </body>
</html>
