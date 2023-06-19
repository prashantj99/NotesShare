package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.NotesDAO;
import com.prashant.webapp.dao.UserLikesDislikesDAO;
import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.entities.UserLikesDislikes;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NoteActionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            PrintWriter out=response.getWriter();
            HttpSession session=request.getSession();
            String action=request.getParameter("action").trim();
            String noteId=request.getParameter("noteId").trim();
            User user=(User)session.getAttribute("loginuser");
            if(user == null){
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                return ;
            }
            NotesDAO notesDAO=new NotesDAO(FactoryProvider.getSessionFactory());
            Notes note=notesDAO.getNotesById(noteId);
            if(note == null){
               response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return ;
            }
            UserLikesDislikesDAO userLikesDislikesDAO=new UserLikesDislikesDAO(FactoryProvider.getSessionFactory());
            if(userLikesDislikesDAO.addOrUpdateLikeOrDislike(user.getUserId(), noteId, action)){
                note=notesDAO.getNotesById(noteId);
                out.println("like:"+note.getLikes()+":dislike:"+note.getDislikes());
            }else{
                out.println("error");
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

}
