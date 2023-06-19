<%@page import="com.prashant.webapp.dao.SavedNotesDao"%>
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
    String filename = (String) request.getParameter("file");
    if (filename == null) {
        response.sendRedirect("./../search.jsp");
        return;
    }
    int dotIndex = filename.lastIndexOf(".");
    String noteId = null;
    if (dotIndex != -1) {
        noteId = filename.substring(0, dotIndex);
    } else {
        System.out.println("Invalid filename: " + filename);
        response.sendRedirect("./../search.jsp");
        return;
    }
    NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
    Notes note = notesDAO.getNotesById(noteId);
    if (note == null) {
        response.sendRedirect("./../error.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>PDF Viewer</title>
        <%@include file="./../header_resources.jsp" %>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
        <style>
            #pdfContainer {
                height: 600px;
            }
            .sidebar {
                /*background-color: #f1f1f1;*/
                position: fixed;
                height: 100%;
            }
        </style>
    </head>
    <body class="bg-dark">
        <section class="container-fluid ">

            <div class="row d-flex justify-content-center sd">
                <div class="col-md-2">
                    <!--<div class="container-fluid">-->
                    <div class="sidebar" style="height: 1800px;">
                        <%
                            SavedNotesDao savedNotesDao = new SavedNotesDao(FactoryProvider.getSessionFactory());
                            try {
                                if (savedNotesDao.isAlreadySaved(note.getNoteId(), user.getUserId())) {
                        %>
                        <a class="btn text-white">
                            <img src="./../img/icons8-bookmark-64.png" style="width: 50px; "alt="alt"/>
                            <span class="text-white">Saved</span>
                        </a>
                        <%
                        } else {
                        %>
                        <a class="btn text-white" onclick="saveNote('<%=user.getUserId()%>', '<%=noteId%>')">
                            <img src="./../img/icons8-bookmark-64.png" style="width: 50px; "alt="alt"/>
                            <span id="spinnerTxt">Save Note</span>
                            <span id="spinner" class="spinner-border spinner-border-sm text-info text-white spinner" role="status" style="display : none;">
                                <span class="sr-only"></span>
                            </span>
                        </a>
                        <%
                                }
                            } catch (Exception e) {

                            }
                        %>
                        <br>
                        <hr>
                        <textarea class="form-control mb-3" id="noteInput" placeholder="Enter your note..."></textarea>
                        <button class="btn btn-outline-warning" ><i class="fa fa-plus" aria-hidden="true"></i></button>
                        <br>
                        <hr>
                        <a href="#" class="btn text-warning" ><i class="fa fa-eye" >&nbsp;&nbsp;<%=note.getViews() >= 1000 ? (note.getViews() / 1000) + "k+" : note.getViews()%></i></a><br>
                        <a href="#" class="btn text-light" onclick="noteAction('<%=note.getNoteId()%>', 'like')"><i class="fa fa-thumbs-up">&nbsp;&nbsp;<span id="likebox"><%=note.getLikes() >= 1000 ? (note.getLikes() / 1000) + "k+" : note.getLikes()%></span></i></a><br>
                        <a href="#" class="btn text-danger" onclick="noteAction('<%=note.getNoteId()%>', 'dislike')"><i class="fa fa-thumbs-down">&nbsp;&nbsp;<span id="dislikebox"><%=note.getDislikes() >= 1000 ? (note.getDislikes() / 1000) + "k+" : note.getDislikes()%></span></i></a><br>
                        <button href="#" class="btn text-primary"  data-toggle="modal" data-target="#shareModal"><i class="fa fa-share-alt" aria-hidden="true">&nbsp;&nbsp;Share</i></button><br>
                        <!-- share Modal -->
                        <div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModalLabel" aria-hidden="true">
                            <div class="modal-dialog bg-dark" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="shareModalLabel">Share Link</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Share note link form -->
                                        <div class="form-group">
                                            <input type="text" class="form-control" id="noteLink" placeholder="Enter note link" value="http://localhost:8080/NotesShare/user/displayPDF.jsp?file=<%=filename%>">
                                        </div>
                                        <button id="cpyBtn" type="button" class="btn btn-dark" >copy</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <h6 class="text-white">
                            <a href="./user_dashboard.jsp" class="btn btn-primary">
                                <i class="fa fa-chevron-left">&nbsp;Dashboard</i>
                            </a>
                        </h6>
                        <h6 class="text-white">Your's Note</h6>
                    </div>
                </div>
                <div class="col-md-10">
                    <div class="btn-group row d-flex text-white" style="justify-content: center; align-items: center">
                        <div id="pageNumberContainer" class="page-number col-md-2"></div>
                        <!--<div class="col-md-8"></div>-->
                        <!--                                <div class="form-group mt-2 col-md-2">
                                                            <input type="text" class="form-control" id="searchInput" placeholder="Search" />
                                                        </div>-->
                        <div class="col-md-4">
                            <div class="row d-flex justify-content-center" style="align-items: center">
                                <input type="number" class="form-control col-md-2" id="goToPageInput"/>
                                <button class="btn btn-warning col-md-2" id="goToPageBtn">Go</button>
                            </div>
                        </div>
                        <button class="btn btn-outline-warning col-md-1" id="prevPageBtn" style="width: 30px;">
                            <i class="fa fa-arrow-left" aria-hidden="true"></i>
                        </button>
                        <button class="btn btn-outline-warning col-md-1" id="nextPageBtn" style="width: 30px;">
                            <i class="fa fa-arrow-right" aria-hidden="true"></i>
                        </button>
                    </div>
                    <div id="pdfContainer"></div>
                </div>
            </div>
        </section>


        <%
            String applicationPath = request.getContextPath();
            String uploadPath = applicationPath + "/" + "uploads" + "/";
        %>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/pdf.js/2.8.335/pdf.min.js"></script>
        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                //increment views and add to recent
                                function addToRecentlyViewed() {
                                    const xhr = new XMLHttpRequest();
                                    xhr.open('POST', './../RecentlyViewedServlet', true);

                                    xhr.onreadystatechange = function () {
                                        if (xhr.readyState === 4 && xhr.status === 200) {
                                            console.log(xhr.responseText);
                                        }
                                    };

                                    // Send the request
                                    let queryParams = new URLSearchParams(window.location.search);
                                    let pdfUrl = queryParams.get("file");
                                    var noteId = pdfUrl.split('.')[0];
                                    console.log(noteId);

                                    // Construct the URL-encoded string
                                    const urlEncodedData = 'noteId=' + encodeURIComponent(noteId);

                                    // Set the appropriate headers
                                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                                    xhr.send(urlEncodedData);
                                }

                                setTimeout(addToRecentlyViewed, 180000);//afetr 3 min
                                var queryParams = new URLSearchParams(window.location.search);
                                var pdfUrl = queryParams.get("file");
                                var pdfPath = "<%=uploadPath%>" + pdfUrl; // Specify the path to your PDF file
                                var pdfContainer = document.getElementById("pdfContainer");
                                var pageNumberContainer = document.getElementById("pageNumberContainer");
                                var prevPageBtn = document.getElementById("prevPageBtn");
                                var nextPageBtn = document.getElementById("nextPageBtn");
                                //                var searchInput = document.getElementById("searchInput");
                                var goToPageInput = document.getElementById("goToPageInput");
                                var goToPageBtn = document.getElementById("goToPageBtn");

                                var currentPage = 1;
                                var totalPages = 0;
                                //                var searchText = '';

                                // Load and display the PDF
                                function loadPDF() {
                                    pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
                                        totalPages = pdf.numPages;
                                        renderPage(currentPage);

                                        prevPageBtn.addEventListener("click", function () {
                                            if (currentPage > 1) {
                                                currentPage--;
                                                renderPage(currentPage);
                                            }
                                        });
                                        nextPageBtn.addEventListener("click", function () {
                                            if (currentPage < totalPages) {
                                                currentPage++;
                                                renderPage(currentPage);
                                            }
                                        });

                                        goToPageBtn.addEventListener("click", function () {
                                            var pageNumber = parseInt(goToPageInput.value);
                                            if (pageNumber >= 1 && pageNumber <= totalPages) {
                                                currentPage = pageNumber;
                                                renderPage(currentPage);
                                            }
                                        });
                                    });
                                }

                                // Render the PDF page
                                function renderPage(pageNumber) {
                                    pdfContainer.innerHTML = "";

                                    pdfjsLib.getDocument(pdfPath).promise.then(function (pdf) {
                                        pdf.getPage(pageNumber).then(function (page) {
                                            var viewport = page.getViewport({scale: 2});
                                            var canvas = document.createElement("canvas");
                                            var context = canvas.getContext("2d");
                                            canvas.height = viewport.height;
                                            canvas.width = viewport.width;
                                            pdfContainer.appendChild(canvas);
                                            page.render({
                                                canvasContext: context,
                                                viewport: viewport
                                            });

                                            // Update the page number display
                                            updatePageNumber();
                                        });
                                    });
                                }

                                // Update the page number display
                                function updatePageNumber() {
                                    pageNumberContainer.textContent = "Page " + currentPage + " of " + totalPages;
                                }

                                loadPDF();
                                updatePageNumber();
                            });
                            //copy link
                            function copyLink() {
                                var copyText = document.getElementById("noteLink");

                                // Select the text field
                                copyText.select();
                                copyText.setSelectionRange(0, 99999); // For mobile devices

                                // Copy the text inside the text field
                                navigator.clipboard.writeText(copyText.value);
                                this.innerText = "copied";
                                this.style.backgroundColor = '#27ae60';
                            }
                            document.getElementById("cpyBtn").addEventListener('click', copyLink);

                            function saveNote(userId, noteId) {
                                var spinner = document.getElementById("spinner");
                                spinner.style.display = "block"; // Show the spinner
                                var params = "noteId=" + encodeURIComponent(noteId) + "&userId=" + encodeURIComponent(userId);
                                var xhr = new XMLHttpRequest();
                                xhr.open("POST", "./../SavedNotesServlet", true);
                                xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                xhr.onreadystatechange = function () {
                                    if (xhr.readyState === 4 && xhr.status === 200) {
                                        let msg = xhr.responseText;
                                        console.log(msg);
                                        setTimeout(() => {
                                            spinner.style.display = "none";
                                            let target = document.getElementById("spinnerTxt");
                                            console.log(msg);
                                            if (msg.trim() == "saved") {
                                                target.innerText = "Saved";
                                                target.style.color = 'green';
                                            } else {
                                                target.innerText = "Error";
                                                target.style.color = 'red';
                                            }
                                        }, 4000);
                                    }
                                };
                                xhr.send(params);
                            }
                            function noteAction(noteId, action) {
                                // Create a new XMLHttpRequest object
                                var xhr = new XMLHttpRequest();

                                // Configure the request
                                xhr.open("POST", "./../NoteActionServlet", true);

                                // Set the Content-Type header if necessary
                                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

                                // Set up the request parameters
                                var params = "action=" + encodeURIComponent(action) + "&noteId=" + encodeURIComponent(noteId);

                                // Set up the callback function for when the request completes
                                xhr.onload = function () {
                                    if (xhr.status === 200) {
                                        // Request was successful, handle the response
                                        var response = xhr.responseText;
                                        if (response.trim() != "error") {
                                            var arr = response.trim().split(":");
                                            console.log(arr);
                                            document.getElementById("likebox").innerText = arr[1];
                                            document.getElementById("dislikebox").innerText = arr[3];
                                        }
                                    } else {
                                        // Request failed, handle the error
                                        console.log("Request failed. Status: " + xhr.status);
                                    }
                                };

                                // Send the request
                                xhr.send(params);
                            }


        </script>
    </body>
</html>

