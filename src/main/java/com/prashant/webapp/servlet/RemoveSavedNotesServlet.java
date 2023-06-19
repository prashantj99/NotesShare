package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.SavedNotesDao;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RemoveSavedNotesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String userId = request.getParameter("userId").trim();
            String noteId = request.getParameter("noteId").trim();
            SavedNotesDao savedNotesDao = new SavedNotesDao(FactoryProvider.getSessionFactory());
            if (savedNotesDao.removeNote(userId, noteId)) {
                response.sendRedirect("./user/user_dashboard.jsp");
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
