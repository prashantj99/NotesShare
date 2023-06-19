package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.UserDAO;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.PasswordEncrypter;
import com.prashant.webapp.util.UserIdGenerator;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.*;

public class SignUpServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            try {
                String userName = request.getParameter("userName");
                String userEmail = request.getParameter("userEmail");
                String userPassword = request.getParameter("userPassword");
                String retype = request.getParameter("retype");
                HttpSession session=request.getSession();
                //validation
                if(userName.isEmpty() || userEmail.isEmpty() || userPassword.isEmpty() || retype.isEmpty()){
                    session.setAttribute("msg", "one of the field is empty!!!");
                    session.setAttribute("type", "warning");
                    response.sendRedirect("./register.jsp");
                    return;
                }
                if(!retype.equals(userPassword)){
                    session.setAttribute("msg", "password must be same");
                    session.setAttribute("type", "warning");
                    response.sendRedirect("./register.jsp");
                    return;
                }
                //check if user already exist
                UserDAO userdao=new UserDAO(FactoryProvider.getSessionFactory());
                if(userdao.getUserByEmail(userEmail) != null){
                    //user already exist
                    session.setAttribute("msg", "seems your are already registered!!!");
                    session.setAttribute("type", "warning");
                    response.sendRedirect("./login_page.jsp");
                    return;
                }
                String userId=UserIdGenerator.generateUserId();
                String userPic="default.png";
                String userType="normal";
                //encrypt password
                userPassword=PasswordEncrypter.hashPassword(userPassword);
                out.println(userPassword);
                User user=new User(userId, userName, userPassword, userEmail, userPic,userType);
                Session hiberSession=FactoryProvider.getSessionFactory().openSession();
                //save user info in database
                Transaction tx=hiberSession.beginTransaction();
                String id=(String)hiberSession.save(user);
                tx.commit();
                hiberSession.close();
                session.setAttribute("msg", "registration successfull");
                session.setAttribute("type", "success");
                response.sendRedirect("./login_page.jsp");
                return;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
