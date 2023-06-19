<!--navbar start-->
<style>
    .navbar-mainbg {
    background-color: #35395c;
    padding: 0px;
}
.hori-selector .right:before,
.hori-selector .left:before{
    content: '';
    position: absolute;
    width: 50px;
    height: 50px;
    border-radius: 50%;
    background-color: #35395c;
    /*edited*/
}
</style>
<nav class="navbar navbar-expand-custom navbar-mainbg">
            <a class="navbar-brand navbar-logo" href="#"><img src="img/icons8-making-notes-30.png" />NotesShare</a>
            <button class="navbar-toggler" type="button" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <i class="fas fa-bars text-white"></i>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav ml-auto">
                    <div class="hori-selector"><div class="left"></div><div class="right"></div></div>
                    <li class="nav-item active">
                        <a class="nav-link" href="user/user_dashboard.jsp">
                            <i class="fa fa-tachometer" aria-hidden="true"></i>Dashboard
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link" href="#"><i class="fas fa-calendar" ></i>Calendar</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="login_page.jsp"><i class="fa fa-user" ></i>Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="register.jsp"><i class="fa fa-unlock"></i>Register</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!--navbar end-->