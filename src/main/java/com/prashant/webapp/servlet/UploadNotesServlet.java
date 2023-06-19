package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.*;
import com.prashant.webapp.entities.*;
import com.prashant.webapp.util.*;
import java.io.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 100, // 100MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class UploadNotesServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //check for valid user
        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loginuser");
            if (user == null) {
                response.sendRedirect("./login_page.jsp");
                return;
            }
            String noteUniversity = request.getParameter("noteUniversity").trim();
            String noteId = UserIdGenerator.generateUserId();
            String noteTitle = request.getParameter("noteTitle").trim();
            String noteName = noteTitle;
            String noteSemester = request.getParameter("noteSemester").trim();
            String type = request.getParameter("noteType").trim();
            String noteDescription = request.getParameter("noteDescription").trim();
            String categoryId = request.getParameter("category").trim();
            //get  Category
            CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getSessionFactory());
            Category category = categoryDAO.getCategoryById(categoryId);
            PrintWriter out = response.getWriter();
            if (category == null) {
                out.println("null category");
                response.sendRedirect("error.jsp");
                return;
            }
            String noteTags = request.getParameter("noteTags");
            int status = 0;
            String[] coursesId = request.getParameterValues("courses");//got course-id

            //get all courses
            List<Course> courses = new ArrayList<>();
            CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
            for (String cId : coursesId) {
                Course c = courseDAO.getCourseById(cId);
                if (c == null) {
                    out.println("null course");
                    response.sendRedirect("error.jsp");
                    return;
                }
                courses.add(c);
            }

            String departmentId = request.getParameter("department");
            Department department = new DepartmentDAO(FactoryProvider.getSessionFactory()).getDepartmentById(departmentId);
            if (department == null) {
                out.println("null department");
                response.sendRedirect("error.jsp");
                return;
            }
            //check for null values or empty
            if (noteName.length() == 0 
                    || noteTitle.length() == 0
                    || noteUniversity.length() == 0
                    || type.length() == 0
                    || noteDescription.length() == 0
                    || noteSemester.length() == 0
                    || noteTags.length() == 0
                    || courses.size() == 0) {
                session.setAttribute("msg", "Error in Uploading...Try Again!!!");
                session.setAttribute("type", "danger");
                response.sendRedirect("./user/upload_notes.jsp");
                System.out.println("not saved");
                return;
            }
            
            //file upload
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            try {
                Part part = request.getPart("notes");
                String fileName = part.getSubmittedFileName();
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1);
                if (!fileExtension.equalsIgnoreCase("pdf")) {
                    session.setAttribute("msg", "Error in Uploading...Only PDF files are allowed.!!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./user/upload_notes.jsp");
                    return;
                }
                // Check the MIME type
                String mimeType = part.getContentType();
                if (!mimeType.equalsIgnoreCase("application/pdf")) {
                    session.setAttribute("msg", "Error in Uploading...Only PDF files are allowed.!!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./user/upload_notes.jsp");
                    return;
                }
                try {
                    FileOutputStream fos = new FileOutputStream(uploadDir + File.separator + noteId+".pdf");
                    InputStream fin = part.getInputStream();
                    if (fin.available() == 0) {
//                      empty file
                        session.setAttribute("msg", "Error in Uploading...Empty File!!!");
                        session.setAttribute("type", "danger");
                        response.sendRedirect("./user/upload_notes.jsp");
                        return;
                    }
                    byte[] data = new byte[fin.available()];
                    fin.read(data);
                    fin.close();
                    fos.write(data);
                    fos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("msg", "Error in Uploading...Please refresh the page and try again!!!");
                    session.setAttribute("type", "danger");
                    response.sendRedirect("./user/upload_notes.jsp");
                    return;
                }
                Notes note = new Notes(noteId, noteName, noteTitle, noteUniversity, type, noteDescription, noteSemester, noteTags, status, category, department, user, courses);
                NotesDAO notesDAO = new NotesDAO(FactoryProvider.getSessionFactory());
                if (notesDAO.saveNotes(note)) {
                    System.out.println("saved");
                    response.sendRedirect("./user/notes_stats.jsp");
                } else {
                    System.out.println("not saved");
                    File del=new File(uploadDir + File.separator + noteId+".pdf");
                    if(del.exists()){
                        del.delete();
                    }
                    response.sendRedirect("error.jsp");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
