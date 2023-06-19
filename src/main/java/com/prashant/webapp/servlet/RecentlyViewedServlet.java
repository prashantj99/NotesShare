package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.RecentlyViewedDAO;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RecentlyViewedServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out=response.getWriter();
        try{
        HttpSession sess=request.getSession();
        String noteId = request.getParameter("noteId").trim();
        System.out.println(noteId);
        User user=(User)sess.getAttribute("loginuser");
        if(user == null){
            out.println("user not logged");
            return ;
        }
        String userId=user.getUserId();
        RecentlyViewedDAO rv=new RecentlyViewedDAO(FactoryProvider.getSessionFactory());
        if(rv.add(userId, noteId)){
            out.println("saved");
            return ;
        }
        out.println("not added");
        }catch(Exception e){
            out.print("error");
            e.printStackTrace();
        }
    }

}