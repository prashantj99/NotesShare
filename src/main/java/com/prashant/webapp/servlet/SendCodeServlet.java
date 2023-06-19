package com.prashant.webapp.servlet;

import com.prashant.webapp.util.OTPGenerator;
import com.prashant.webapp.dao.UserDAO;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.GEmailSender;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SendCodeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session=request.getSession();
        String email = request.getParameter("email").trim();
        UserDAO userDAO = new UserDAO(FactoryProvider.getSessionFactory());
        String otp = OTPGenerator.generateOTP();
//        String applicationPath = request.getContextPath();
//        String path = applicationPath + File.separator + "mail_properties.properties";
//        System.out.println(path);
//        String path = "./../util/mail_properties.properties";
//        Properties props = new Properties();

        try {
//            FileInputStream fis = new FileInputStream(path);
//            props.load(fis);
//            fis.close();
            if (!email.isEmpty() && userDAO.getUserByEmail(email) != null) {
                GEmailSender.sendEmail("C:\\Users\\hp 1\\Documents\\NetBeansProjects\\NotesShare\\src\\main\\webapp\\mail_properties.properties", "YOUR ORG MAIL", email, "Reset Password Request", "OTP " + otp);
                session.setAttribute("otp", otp);
                session.setAttribute("curruser", userDAO.getUserByEmail(email));
                response.sendRedirect("./passwordreset.jsp");
            } else {
                session.setAttribute("msg", "email not found!!!");
                session.setAttribute("type", "danger");
                response.sendRedirect("./forgotpassword.jsp");
            }
        } catch (IOException e) {
            System.out.println("Error loading email properties: " + e.getMessage());
            response.sendRedirect("./error.jsp");
        }
    }
}
