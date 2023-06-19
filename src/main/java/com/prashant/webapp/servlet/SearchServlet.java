package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.NotesDAO;
import com.prashant.webapp.entities.Course;
import com.prashant.webapp.entities.Notes;
import com.prashant.webapp.util.FactoryProvider;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.HashSet;
import java.util.Iterator;

public class SearchServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query").trim();
        String universityName = request.getParameter("universityName").trim();
        String departmentId = request.getParameter("departmentId").trim();
        String courseId = request.getParameter("courseId").trim();
        String sem = request.getParameter("sem").trim();
        String categoryId = request.getParameter("categoryId").trim();
        int offset = Integer.parseInt(request.getParameter("offset").trim());
        System.out.println("req : " + query + " " + offset + " " + courseId);

        NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
        HashSet<Notes> results = notesDAO.search(query, offset);
        results = filterNotes(results, courseId, sem, universityName, departmentId, categoryId);

        PrintWriter out = response.getWriter();
        out.println("<ul class=\"list-group\">");
        for (Notes result : results) {
            out.println("<div class=\"card rounded justify-content-center mt-3\">");
            out.println("    <div class=\"card-body\" style=\"background-color: #ecf0f1;\">");
            out.println("        <div class=\"row align-items-center\">");
            out.println("            <div class=\"col-md-6\">");
//            String applicationPath = request.getContextPath();
//            String uploadPath = applicationPath + File.separator + "uploads" + File.separator + result.getNoteId() + ".pdf";
            String noteName = result.getNoteName().isEmpty() ? "default" : result.getNoteName();
            out.println("                <h6><a href=\"./user/displayPDF.jsp?file="+result.getNoteId()+".pdf" + "\">" + noteName + "</a></h6>");
            out.println("            </div>");
            out.println("            <div class=\"col-md-2\">");
            out.println("                <i class=\"fa fa-eye\"></i>");
            out.println("                <span class=\"badge badge-warning\">" + result.getViews() + "</span>");
            out.println("            </div>");
            out.println("            <div class=\"col-md-2\">");
            out.println("                <i class=\"fa fa-thumbs-up\"></i>");
            out.println("                <span class=\"badge badge-primary\">" + result.getLikes() + "</span>");
            out.println("            </div>");
            out.println("            <div class=\"col-md-2\">");
            out.println("                <i class=\"fa fa-thumbs-down\"></i>");
            out.println("                <span class=\"badge badge-primary\">" + result.getDislikes() + "</span>");
            out.println("            </div>");
            out.println("        </div>");
            out.println("    </div>");
            out.println("</div>");
        }
        out.println("</ul>");
    }

    public HashSet<Notes> filterNotes(HashSet<Notes> result, String courseId, String sem, String universityName, String departmentId, String categoryId) {
        HashSet<Notes> filteredNotes = new HashSet<>();
        if (!courseId.isEmpty()) {
            Iterator<Notes> iterator = result.iterator();
            while (iterator.hasNext()) {
                Notes note = iterator.next();
                System.out.println("Note Id "+note.getNoteId());
                boolean flag = false;
                for (Course c : note.getCourse()) {
                    System.out.println("Course Id "+c.getCourseId());
                    if (c.getCourseId().equals(courseId)) {
                        flag = true;
                        break;
                    }
                }
                if (!flag) {
                    iterator.remove(); // Remove the element using iterator's remove method
                }
            }
        }
        for (Notes note : result) {
            if ((categoryId.isEmpty() || categoryId.equals(note.getCategory().getCategoryId()))
                    && (departmentId.isEmpty() || departmentId.equals(note.getDepartment().getDepartmentId()))
                    && (sem.isEmpty() || Integer.parseInt(sem) == Integer.parseInt(note.getNoteSemester()))
                    && (universityName.isEmpty() || universityName.equalsIgnoreCase(universityName.trim()))) {
                filteredNotes.add(note);
            }
        }
        return filteredNotes;
    }
}
