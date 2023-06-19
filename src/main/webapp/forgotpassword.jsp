<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Font Awesome Icons  -->
        <%@include file="header_resources.jsp" %>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"/>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <title>Forgot Password | NotesShare </title>
        <style>
            * {
                margin: 0;
                padding: 0;
                font-family: 'Poppins', sans-serif;
            }
            body{
                overflow: hidden;
                background-color: #ecf0f1;
            }
            .bdy {
                color: white;
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 12rem 0;
            }

            .card {
                backdrop-filter: blur(16px) saturate(180%);
                background-color: rgba(0, 0, 0, 0.75);
                border-radius: 12px;
                /*width: 50%;*/
                border: 1px solid rgba(255, 255, 255, 0.125);
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 30px 40px;
            }

            .lock-icon {
                font-size: 3rem;
            }

            h2 {
                font-size: 1.5rem;
                margin-top: 10px;
                text-transform: uppercase;
            }

            p {
                font-size: 12px;
            }

            .passInput {
                margin-top: 12px;
                width: 100%;
                background: transparent;
                border: none;
                border-bottom: 2px solid deepskyblue;
                font-size: 15px;
                color: white;
                outline: none;
            }

            .mybutton {
                margin-top: 15px;
                width: 100%;
                background-color: deepskyblue;
                color: white;
                padding: 10px;
                text-transform: uppercase;
                cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div class="bdy">
            <%@include file="message.jsp" %>
            <div class="card">
                <p class="lock-icon"><i class="fas fa-lock"></i></p>
                <h2>Forgot Password?</h2>
                <p>You can reset your Password here</p>
                <form action="./SendCodeServlet" method="POST">
                    <input type="email" class="passInput" placeholder="Email address" name="email" required>
                    <button class="mybutton" type="submit">Send My Password</button>
                </form>
                <a href="./login_page.jsp"  style="color : white; ">Back to Login</a>
            </div>
        </div>
    </body>

</html>