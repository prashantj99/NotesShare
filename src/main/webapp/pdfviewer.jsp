<%-- 
    Document   : pdfviewer
    Created on : 7 May, 2023, 4:26:22 PM
    Author     : hp 1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!DOCTYPE html>
<html>
    <head>
        <title>Bootstrap PDF Viewer</title>
        <!-- Load Bootstrap CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <h1>Bootstrap PDF Viewer</h1>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- Load PDF viewer -->
                    <iframe src="http://127.0.0.1:8080/NotesShare/uploads/552360cf-8353-4de3-973d-9774d9ef5dab.pdf" width="100%" height="600px"></iframe>
                </div>
            </div>
        </div>

        <!-- Load Bootstrap JavaScript -->
        <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        
        <script type="text/javascript">
            document.addEventListener("contextmenu", function (e) {
                e.preventDefault();
            }, false);

            document.addEventListener("keydown", function (e) {
                if (e.ctrlKey && (e.keyCode === 67 || e.keyCode === 86 || e.keyCode === 85 || e.keyCode === 117)) {
                    // Disable copying, pasting, and printing using keyboard shortcuts
                    e.preventDefault();
                }
            }, false);
        </script>

    </body>
</html>
