package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.SavedNotesDao;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SavedNotesServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            //get parameters
            PrintWriter out=response.getWriter();
            String userId=request.getParameter("userId").trim();
            String noteId=request.getParameter("noteId").trim();
            SavedNotesDao savedNotesDao=new SavedNotesDao(FactoryProvider.getSessionFactory());      
            if(savedNotesDao.add(userId, noteId)){
                out.println("saved");
                return ;
            }
            out.println("notsaved");
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
