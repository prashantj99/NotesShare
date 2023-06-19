package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.UserDAO;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.PasswordEncrypter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginWithoutGoogle", urlPatterns = {"/LoginWithoutGoogle"})
public class LoginWithoutGoogle extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            try{
                HttpSession session=request.getSession();
                String userEmail=request.getParameter("userEmail");
                String userPassword=request.getParameter("userPassword");
                if(userEmail.isEmpty() || userPassword.isEmpty()){
                    session.setAttribute("msg", "please enter your password and email!!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./login_page.jsp");
                    return;
                }
                UserDAO userdao=new UserDAO(FactoryProvider.getSessionFactory());
                User user=userdao.getUserByEmail(userEmail);
                System.out.println(user.getUserType());
                if(user == null){
                    session.setAttribute("msg", "seems your are not registered!!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./login_page.jsp");
                    return;
                }
                if(!PasswordEncrypter.verifyPassword(userPassword, user.getUserPassword())){
                    session.setAttribute("msg", "invalid email or password !!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./login_page.jsp");
                    return;
                }
                //if user verified 
//                out.println("successfull login"+user.getUserType());
                if(user.getUserType().equals("normal")){
                    session.setAttribute("loginuser", user);
                    response.sendRedirect("./user/user_dashboard.jsp");
                    return;
                }
                if(user.getUserType().equals("admin")){
                    session.setAttribute("loginuser", user);
                    response.sendRedirect("./admin/admin_page.jsp");
                    return;
                }
            }catch(Exception e){
                e.printStackTrace();   
                response.sendRedirect("./error.jsp");
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
