<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="header_resources.jsp" %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login | NotesShare</title>
        <style>
            html,body {
                height: 100%;
            }

            .global-container{
                height:100%;
                display: flex;
                align-items: center;
                justify-content: center;
                background-color: #ecf0f1;
            }

            form{
                padding-top: 10px;
                font-size: 14px;
                margin-top: 30px;
            }

            .card-title{
                font-weight:300;
            }

            .btn{
                font-size: 14px;
                margin-top:20px;
            }


            .login-form{
                width:330px;
                margin:20px;
            }

            .sign-up{
                text-align:center;
                padding:20px 0 0;
            }

            .alert{
                margin-bottom:-30px;
                font-size: 13px;
                margin-top:20px;
            }
        </style>
    </head>
    <body>
        <%@include file="message.jsp" %>
        <!--login form-->
        <div class="global-container">
            <div class="card login-form">
                <div class="card-body">
                    <h3 class="card-title text-center">Log in to NotesShare</h3>
                    <div class="card-text">
                        <form action="./LoginWithoutGoogle" method="post">
                            <div class="form-group">
                                <label for="exampleInputEmail1">Email address</label>
                                <input type="email" class="form-control form-control-sm" id="exampleInputEmail1" aria-describedby="emailHelp" name="userEmail">
                            </div>
                            <div class="form-group">
                                <label for="exampleInputPassword1">Password</label>
                                <a href="./forgotpassword.jsp" style="float:right;font-size:12px;">Forgot password?</a>
                                <input type="password" class="form-control form-control-sm" id="exampleInputPassword1" name="userPassword">
                            </div>
                            <button type="submit" class="btn btn-primary btn-block">Sign in</button>
                            <hr>
                            <!-- Add the Google Sign-In button -->
                            <div class="row justify-content-center">
                                <a href="https://accounts.google.com/o/oauth2/auth?scope=profile%20email&redirect_uri=http://localhost:8080/NotesShare/GoogleLoginServlet&response_type=code
                                   &client_id=216740075014-kkqfurj0g562qfelacs73ecgsl6bfcaa.apps.googleusercontent.com&approval_prompt=force"
                                   class="text-danger"
                                   >
                                    Login With Google
                                </a>
                                <div>
                                    <div class="sign-up">
                                        Don't have an account? <a href="register.jsp" class="text-success">Create One</a>
                                    </div>
                                </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
