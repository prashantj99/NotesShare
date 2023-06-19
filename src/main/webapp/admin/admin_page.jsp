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
                    <li><a href="./viewdepartment.jsp"><span class="sidebar-icon"><i class="fa fa-calendar"></i></span> <span class="menu-title">Department</span></a></li>
                    <li><a href="./viewcourse.jsp"><span class="sidebar-icon"><i class="fa fa-suitcase"></i></span> <span class="menu-title">Course</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>


        <section id="main-content" style="overflow-x: hidden">
            <div class="container-fluid">
                <br>
                <br>
                <br>
                <hr>
                <div class="row d-flex" style="justify-content: space-around; align-items: center">
                    <!--add category-->
                    <div class="col-md-2">
                        <div class="card">
                            <img src="./../img/icons8-category-64.png" class="card-img-top" alt="Image">
                            <div class="card-body">
                                <a href="#" class="btn btn-warning" style="width: 100%;" data-toggle="modal" data-target="#courseModal">
                                    Add Course
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--add course-->
                    <div class="col-md-2">
                        <div class="card">
                            <img src="./../img/icons8-course-48.png" class="card-img-top" alt="Image">
                            <div class="card-body">
                                <a href="#" class="btn btn-success" style="width: 100%;" data-toggle="modal" data-target="#categoryModal">
                                    Add Category
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--add department-->
                    <div class="col-md-2">
                        <div class="card" style="width: 12rem">
                            <img src="./../img/icons8-department-64.png" class="card-img-top" alt="Image">
                            <div class="card-body">
                                <a href="#" class="btn btn-primary" style="width: 100%; font-size: 14px;" data-toggle="modal" data-target="#departmentModal">
                                    Add Department
                                </a>
                            </div>
                        </div>
                    </div>
                    <!--add mail-->
                    <div class="col-md-2">
                        <div class="card">
                            <img src="./../img/icons8-envelope-48.png" class="card-img-top" alt="Image">
                            <div class="card-body">
                                <a href="#" class="btn btn-danger" style="width: 100%;" data-toggle="modal" data-target="#mailModal">
                                    Send Mail
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--show stats-->
            <br>
            <hr>
            <div class="row d-flex justify-content-around">
                <div class="card bg-dark text-light col-sm-2"style="min-height: 200px;">
                    <%
                        CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getSessionFactory());
                    %>
                    <div class="card-body text-center">
                        <h5 class="card-title text-info">Categories</h5>
                        <p class="card-text"><%=categoryDAO.getCategoryCount()%></p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="#" class="btn btn-primary">View</a>
                    </div>
                </div>
                <div class="card bg-dark text-light col-sm-2" style="min-height: 200px;">
                    <%
                        CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
                    %>
                    <div class="card-body text-center">
                        <h5 class="card-title text-info">Courses</h5>
                        <p class="card-text"><%=courseDAO.getCourseCount()%></p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="#" class="btn btn-primary">View</a>
                    </div>
                </div>
                <div class="card bg-dark text-light col-sm-2"style="min-height: 200px;">
                    <%
                        DepartmentDAO departmentDAO = new DepartmentDAO(FactoryProvider.getSessionFactory());
                    %>
                    <div class="card-body text-center">
                        <h5 class="card-title text-info">Departments</h5>
                        <p class="card-text"><%=departmentDAO.getDepartmentCount()%></p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="#" class="btn btn-primary">View</a>
                    </div>
                </div>
                <div class="card bg-dark text-light col-sm-2" style="min-height: 200px;">
                    <%
                        NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
                    %>
                    <div class="card-body text-center">
                        <h5 class="card-title text-info">Notes</h5>
                        <p class="card-text text-white">Approved  <%=notesDAO.getNotesCount(1)%></p>
                        <p class="card-text text-white">Pending <%=notesDAO.getNotesCount(0)%></p>
                    </div>
                    <div class="card-footer text-center">
                        <a href="#" class="btn btn-primary">View</a>
                    </div>
                </div>
            </div>
        </section>
        <!--add course form modal start-->
        <div class="modal fade" id="courseModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="top: 120px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Course</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form content goes here -->
                        <form id="add-course-form">
                            <div class="form-group">
                                <label for="couse-name">Course Name</label>
                                <input type="text" class="form-control" id="couse-name" placeholder="Enter couse name" name="courseName" required>
                            </div>
                            <div class="form-group">
                                <label for="no-of-sem">Number of semester</label>
                                <input type="text" class="form-control" id="no-of-sem" placeholder="Enter couse name" name="sem" required>
                            </div>
                            <!-- Add more form fields as needed -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" onClick="save('add-course-form', 'AddCourseServlet', 'error', 'successfully added')">add</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--add category form end --> 
        <div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="top: 120px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Category</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form content goes here -->
                        <form id="add-category-form">
                            <div class="form-group">
                                <label for="category-name">Category Name</label>
                                <input type="text" class="form-control" id="category-name" placeholder="Enter category name" name="categoryName" required>
                            </div>
                            <!--                            <div class="form-group">
                                                            <label for="category-desc">Description</label>
                                                            <input type="text" class="form-control" id="category-desc" placeholder="Description" name="categoryDesc" required>
                                                        </div>-->
                            <!-- Add more form fields as needed -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" onClick="save('add-category-form', 'AddCategoryServlet', 'error', 'successfully added')">
                                    add
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--add depatment modal-->
        <div class="modal fade" id="departmentModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="top: 120px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Department</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form content goes here -->
                        <form id="add-department-form" onsubmit="false">
                            <div class="form-group">
                                <label for="department-name">Department Name</label>
                                <input type="text" class="form-control" id="department-name" placeholder="department name (e.g. MTech(CSE))" name="departmentName" required>
                            </div>
                            <!--                            <div class="form-group">
                                                            <label for="department-desc">Description</label>
                                                            <input type="text" class="form-control" id="department-desc" placeholder="description" name="departmentDesc" required>
                                                        </div>-->
                            <!-- Add more form fields as needed -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary" onClick="save('add-department-form', 'DepartmentOperationServlet', 'error', 'successfully added')">
                                    add
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <!--add mail modal-->
        <div class="modal fade" id="mailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content" style="top: 120px;">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Mail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <!-- Form content goes here -->
                        <form id="add-course-form">
                            <div class="form-group">
                                <label for="mail-to">To</label>
                                <input type="text" class="form-control" id="mail-to" placeholder="To" name="reciever" required>
                            </div>
                            <div class="form-group">
                                <label for="mail-sub">Subject</label>
                                <input type="text" class="form-control" id="mail-sub" placeholder="Subject" name="mailSub" required>
                            </div>
                            <div class="form-group">
                                <label for="mail-msg">Text</label>
                                <input type="text" class="form-control" id="mail-msg" placeholder="write something" name="mailMsg" required>
                            </div>
                            <!-- Add more form fields as needed -->
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <button type="submit" class="btn btn-primary">add</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function save(formName, to, err, done) {
                const form = document.querySelector("#" + formName);
                const formData = new FormData(form);
                const xhr = new XMLHttpRequest();
                xhr.open('POST', "./../" + to);  // Replace with  servlet URL
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onreadystatechange = () => {
                    if (xhr.readyState === XMLHttpRequest.DONE) {
                        if (xhr.status === 200) {
                            let msg = xhr.responseText;
                            console.log(msg);  // Server response
                            form.reset();  // Reset the form
                            if (msg.trim() === "course001") {
                                alert('Similar course already exists!');
                            } else if (msg.trim() === "category001") {
                                alert('Similar category already exists!');
                            } else if (msg.trim() === "department001") {
                                alert('Similar Department already exists!');
                            } else {
                                alert(done);
                            }
                        } else {
                            console.error(xhr.statusText);
                            alert(err);
                        }
                    }
                };
                xhr.send(new URLSearchParams(formData));  // Send the form data as URL-encoded string
            }
        </script>
    </body>
</html>
