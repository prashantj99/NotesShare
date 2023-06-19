package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.CourseDAO;
import com.prashant.webapp.entities.Course;
import com.prashant.webapp.util.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class AddCourseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.err.println("reach");
        String courseId = UserIdGenerator.generateUserId();
        String courseName = request.getParameter("courseName");
        if (hasSimilarCourse(courseName)) {
            String errorMessage = "course001";
            PrintWriter out = response.getWriter();
            out.print(errorMessage);
            return;
        }
        int sem = Integer.parseInt(request.getParameter("sem"));
        Course course = new Course(courseId, courseName, sem);
        CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
        if (courseDAO.saveCourse(course)) {
            response.setStatus(HttpServletResponse.SC_OK);
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private boolean hasSimilarCourse(String courseName) {

        List<Course> courses = new CourseDAO(FactoryProvider.getSessionFactory()).getAllCourses();
        for (Course course : courses) {
            if (courseName.trim().toLowerCase().equals(course.getCourseName().toLowerCase())){
                return true;
            }
        }
        return false;
    }

    
}
