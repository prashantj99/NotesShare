<%@page import="java.io.File"%>
<%@page import="com.prashant.webapp.entities.Notes"%>
<%@page import="com.prashant.webapp.dao.NotesDAO"%>
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
        <style>
            #overlay {
                position: fixed;
                z-index: 100000;
                top: 0;
                left: 0;
                bottom: 0;
                right: 0;
                background-color: rgba(0,0,0,0.5);
                /*display: flex;*/
                align-items: center;
                justify-content: center;
            }
            .page-sidebar{
                margin: 0px!important;
            }
            #overlay .spinner-border {
                width: 3rem;
                height: 3rem;
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
                    <li><a href="./admin_page.jsp"><span class="sidebar-icon"><i class="fa fa-dashboard"></i></span> <span class="menu-title">Dashboard</span></a></li>
                    <li><a href="./approve_notes.jsp"><span class="sidebar-icon"><i class="fa fa-check"></i></span> <span class="menu-title">Approve Notes</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-users"></i></span> <span class="menu-title">Category</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-calendar"></i></span> <span class="menu-title">Department</span></a></li>
                    <li><a href=""><span class="sidebar-icon"><i class="fa fa-suitcase"></i></span> <span class="menu-title">Meetings</span></a></li>
                    <li><a href="./../LogoutServlet"><span class="sidebar-icon"><i class="fa fa-lock"></i></span> <span class="menu-title">Sign Out</span></a></li>
                </ul>
            </div>
        </div>
        <section id="main-content">
            <!--notes upload info-->
            <%
                NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
                List<Notes> notes = notesDAO.getAllNotVerifiedNotes();
            %>
            <section class="wrapper main-wrapper row d-flex">
                <div class="col-md-12">
                    <section class="box">
                        <%
                            int modelId=1;
                            for (Notes note : notes) {
                        %>
                        <div class="card rounded justify-content-center">
                            <div class="card-body m-2" style="background-color: #ecf0f1;">
                                <div class="row align-items-center">
                                    <div class="col-md-8">
                                        <%
                                            String applicationPath = request.getContextPath();
                                            String uploadPath = applicationPath + File.separator + "uploads" + File.separator + note.getNoteId();
                                        %>
                                        <h6>
                                            <a href="<%=uploadPath + ".pdf"%>">
                                                <%=note.getNoteName()%>
                                            </a>
                                            <a class="btn text-secondary" data-toggle="popover" title="Notes Detail" 
                                               data-content="
                                               University : <%=note.getNoteUniversity()%> 
                                               || Sem : <%=note.getNoteSemester()%>
                                               || Tags : <%=note.getNoteTags()%>
                                               || Type : <%= (note.getType().equals("1")) ? "Handwritten" : "Printed"%>
                                               || Category : <%= note.getCategory().getCategoryName()%>
                                               || Department : <%=note.getDepartment().getDepartmentName()%>
                                               || Courses : 
                                               <%
                                                   for (Course c : note.getCourse()) {
                                                       out.println(c.getCourseName() + " ");
                                                   }
                                               %>
                                               " >
                                                <i class="fa fa-info-circle" aria-hidden="true"></i>
                                            </a>
                                        </h6>
                                    </div>
                                    <div class="col-md-2">
                                        <a title="change to approve state" class="btn" style="width: 100px;" data-toggle="modal" data-target="#Model<%=modelId%>">
                                            <img src="./../img/icons8-approve-50.png" style="width: 30px;" alt="alt"/>     
                                        </a>
                                    </div>
                                    <div class="col-md-2">
                                        <a title="change to reject state" class="btn text-danger" data-toggle="modal" data-target="#Disapprove<%=modelId%>">
                                            <i class="fa fa-times fa-2x" ></i>
                                        </a>
                                    </div>
<!--                                    <div class="col-md-2">
                                        <a title="undo operation" class="btn text-primary" onclick="updateNotes('<%=note.getNoteId()%>', '<%=0%>')">
                                            <i class="fa fa-undo fa-2x" ></i>
                                        </a>
                                    </div>-->
                                </div>
                            </div>
                        </div>
                        <div class="modal fade mt-4" id="Model<%=modelId%>" tabindex="-1" role="dialog" aria-labelledby="approveModalLabel1"
                             aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="<%=note.getNoteId()%>"><%=note.getNoteName()%></h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to approve <%=note.getNoteId()%>?</p>
                                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-outline-success" onclick="updateNotes('<%=note.getNoteId()%>', '<%=1%>')">Approve</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--disapprove-->
                        <div class="modal fade mt-4" id="Disapprove<%=modelId++%>" tabindex="-1" role="dialog" aria-labelledby="approveModalLabel1"
                             aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="<%=note.getNoteId()%>"><%=note.getNoteName()%></h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to reject <%=note.getNoteId()%>?</p>
                                        <p>This operation is irrecoverable</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-outline-danger" onclick="updateNotes('<%=note.getNoteId()%>', '<%=-1%>')">Reject</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <!--end of notes lists-->
                    </section>
                </div>
            </section>
        </section>
        <!--loader-->
        <div id="overlay">
            <div class="spinner-border text-white spinner" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <script defer>
            document.getElementById("overlay").style.display = "none";
            function updateNotes(id, newStatus) {
                document.getElementById("overlay").style.display = "flex";
                var xhr = new XMLHttpRequest();
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        // Handle the server response here
                        setTimeout(function () {
                            document.getElementById("overlay").style.display = "none";
                        }, 3000);
                        console.log("updated");

                    } else {
                        setTimeout(function () {
                            document.getElementById("overlay").style.display = "none";
                        }, 3000);
                    }
                };
                xhr.open('GET', './../NotesOperation?noteId=' + id + '&status=' + newStatus, true);
                xhr.send();
            }
            $(document).ready(function () {
                $('[data-toggle="popover"]').popover();
            });
        </script>
    </body>
</html>
