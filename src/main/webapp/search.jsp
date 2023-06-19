<%@page import="com.prashant.webapp.entities.Department"%>
<%@page import="com.prashant.webapp.dao.DepartmentDAO"%>
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
    <title>Home | NotesShare</title>
    <style>
        .filters {
            min-width: 200px;
        }
    </style>
</head>
<body>
<!--navbar start-->
<%@include file="navbar.jsp" %>
<!--navbar end-->
<div class="container-fluid p-5">
    <div class="p-1 bg-light rounded rounded-pill shadow-sm mb-4">
        <div class="input-group text-uppercase">
            <input id="search-box" type="search" placeholder="What're you searching for? just keep typing..." aria-describedby="button-addon1" class="form-control border-0 bg-light">
            <div class="input-group-append">
                <button id="search-btn" type="submit" class="btn btn-link text-primary"><i class="fa fa-search"></i></button>
            </div>
        </div>
    </div>
    <br>
    <!--filter form-->
    <div class="container">
        <h5 class="text-center">
            <img src="img/icons8-filter-60.png" alt="filter">
        </h5>
        <div class="row align-items-center justify-content-center">
            <div class="form-group">
                <select class="form-control filters" id="categoryDropdown" disabled="true" name="categoryName">
                    <option value="">Select Category</option>
                    <% CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getSessionFactory());
                    List<Category> categories = categoryDAO.getAllCategories();
                    for (Category c : categories) {
                        if (c.getCategoryId().equals("-1")) {
                            continue;
                        } %>
                        <option style="text-transform: capitalize; color: black" value="<%=c.getCategoryId()%>"><%=c.getCategoryName()%></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <select class="form-control filters" id="courseDropdown" disabled="true" name="courseName">
                    <option value="">Select Course</option>
                    <% CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
                    List<Course> courses = courseDAO.getAllCourses();
                    for (Course c : courses) {
                        if (c.getCourseId().equals("-1")) {
                            continue;
                        } %>
                        <option style="text-transform: capitalize;" value="<%=c.getCourseId()%>"><%=c.getCourseName()%></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <select class="form-control filters" id="semesterDropdown" disabled="true" name="sem">
                    <option value="">Select Semester</option>
                    <% int[] arr = new int[]{1, 2, 3, 4, 5, 6, 7, 8};
                    for (int c : arr) { %>
                        <option style="text-transform: capitalize;" value="<%=c%>"><%=c%></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <select class="form-control filters" id="departmentDropdown" disabled="true" name="departmentName">
                    <option value="">Select Department</option>
                    <% DepartmentDAO departmentDAO = new DepartmentDAO(FactoryProvider.getSessionFactory());
                    List<Department> departments = departmentDAO.getAllDepartments();
                    for (Department d : departments) {
                        if (d.getDepartmentId().equals("-1")) {
                            continue;
                        } %>
                        <option style="text-transform: capitalize;" value="<%=d.getDepartmentId()%>"><%=d.getDepartmentName()%></option>
                    <% } %>
                </select>
            </div>
            <div class="form-group">
                <button class="btn btn-secondary" onClick="resetFilters()">Reset</button>
            </div>
        </div>
    </div>
    <br>
    <p class="text-center" id="query"></p>
    <div id="search-result">
        <!--search content-->
        <p class="text-center">
            <br>
            <br>
            <h3 class="text-center" style="color: gray;">
                Search your result from 1000+ notes
            </h3>
            <br>
            <br>
            <br>
            <div class="text-center">
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vel eleifend ligula.
                Maecenas at dolor sapien. Aenean eu risus sem. Pellentesque ultricies nisi non leo tristique,
                in commodo sapien consequat. Mauris bibendum magna in lacus tincidunt, id suscipit neque congue.
                Phasellus nec dui eget purus laoreet pellentesque.
            </div>
        </p>
    </div>
</div>
<!--footer-->
<%@include file="footer.jsp" %>
<!--footer end-->
<script>
    var offset = 0;
    var isLoading = false;
    let ele = document.getElementsByClassName("filters");
    for (i = 0; i < ele.length; i++) {
        ele[i].addEventListener('change', () => {
            offset = 0;
            document.getElementById("search-result").innerHTML = "";
            search();
        });
    }
    function search() {
        for (i = 0; i < ele.length; i++) {
            ele[i].disabled = false;
        }
        var courseId = document.getElementById("courseDropdown").value;
        var departmentId = document.getElementById("departmentDropdown").value;
        var categoryId = document.getElementById("categoryDropdown").value;
        var sem = document.getElementById("semesterDropdown").value;
        var universityName = "";
        console.log(courseId);
        var query = document.getElementById("search-box").value;
        console.log(query);
        if (query.length >= 0) {
            var xhr = new XMLHttpRequest();
            xhr.open("POST", "./SearchServlet");
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var result = xhr.responseText;
                    document.getElementById("query").innerHTML = 'search results for ' + '<span style="font-size: 20px; color : black">' + query + '</span>';
                    document.getElementById("search-result").innerHTML += result;
                    console.log(result);
                    offset += 10;
                    isLoading = false;
                } else {
                    document.getElementById("query").innerHTML = 'no search results found for ' + '<span style="font-size: 20px; color : black">' + query + '</span>';
                }
            };
            xhr.send("query=" + encodeURIComponent(query) + "&offset=" + offset + "&categoryId=" + categoryId + "&courseId=" + encodeURIComponent(courseId) + "&sem=" + sem + "&departmentId=" + departmentId + "&universityName=" + universityName);
        }
    }
    function searchOnEnter(event) {
        if (event.keyCode === 13) {
            event.preventDefault();
            document.getElementById("search-result").innerHTML = "";
            offset = 0;
            search();
        }
    }
    document.getElementById("search-btn").addEventListener("click", function () {
        offset = 0;
        document.getElementById("search-result").innerHTML = "";
        search();
    });
    document.getElementById("search-box").addEventListener("keyup", searchOnEnter);
    window.addEventListener("scroll", function () {
        var scrollPosition = window.innerHeight + window.pageYOffset;
        var pageHeight = document.documentElement.scrollHeight;
        if (scrollPosition >= pageHeight / 2 && !isLoading) {
            isLoading = true;
            search();
        }
    });
    function resetFilters() {
        for (i = 0; i < ele.length; i++) {
            ele[i].value = "";
        }
        offset = 0;
        document.getElementById("search-result").innerHTML = "";
        search();
    }
</script>
</body>
</html>
