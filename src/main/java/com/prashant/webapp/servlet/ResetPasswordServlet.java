package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.UserDAO;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.PasswordEncrypter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ResetPasswordServlet extends HttpServlet {

    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            String newpass = request.getParameter("newpass").trim();
            String confpass = request.getParameter("confpass").trim();
            String userotp = request.getParameter("otp").trim();

            String otp = (String) session.getAttribute("otp");
            if (!newpass.equals(confpass)) {
                session.setAttribute("msg", "both field should be same!!!");
                session.setAttribute("type", "danger");
                response.sendRedirect("./passwordreset.jsp");
                return ;
            }
            if (!otp.equals(userotp)) {
                session.setAttribute("msg", "invalid otp!!!");
                session.setAttribute("type", "danger");
                response.sendRedirect("./passwordreset.jsp");
                return ;
            }
            session.removeAttribute("otp");
            UserDAO userDAO=new UserDAO(FactoryProvider.getSessionFactory());
            User usr=(User)session.getAttribute("curruser");
            if(usr == null){
                session.removeAttribute("otp");
                response.sendRedirect("error.jsp");
                return ;
            }
            usr.setUserPassword(PasswordEncrypter.hashPassword(newpass));
            if(userDAO.updateUser(usr)){
                session.setAttribute("msg", "password reset successfully");
                session.setAttribute("type", "success");
                response.sendRedirect("./login_page.jsp");
                return ;
            }else{
                response.sendRedirect("error.jsp");
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
