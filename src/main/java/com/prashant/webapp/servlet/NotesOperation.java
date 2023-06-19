package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.NotesDAO;
import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class NotesOperation extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginuser");
        if (user == null || !user.getUserType().equals("admin")) {
            session.setAttribute("msg", "you are not authorize to access this page");
            session.setAttribute("type", "danger");
            response.sendRedirect("./login_page.jsp");
            return;
        }
        String noteId = request.getParameter("noteId");
        int newStatus = Integer.parseInt(request.getParameter("status"));
        // Perform update operation
        NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
        Notes note = notesDAO.getNotesById(noteId);
        if (note == null) {
            response.setStatus(400);
            return;
        }
        if (newStatus == 1 || newStatus == 0) {
            if (notesDAO.updateNotesStatus(noteId, newStatus)) {
                response.setStatus(HttpServletResponse.SC_OK);
            };
        }
        if (newStatus == -1) {
            if (notesDAO.updateNotesStatus(noteId, newStatus)) {
                response.setStatus(HttpServletResponse.SC_OK);
            };
        }
        // Send updated note as JSON response
        response.setStatus(500);
    }
}
