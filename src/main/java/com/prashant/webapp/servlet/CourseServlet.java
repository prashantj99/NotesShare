package com.prashant.webapp.servlet;

import com.google.gson.Gson;
import com.prashant.webapp.dao.CourseDAO;
import com.prashant.webapp.entities.Course;
import com.prashant.webapp.util.FactoryProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//for pagination view
public class CourseServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNumber = Integer.parseInt(request.getParameter("page"));
        int itemsPerPage = Integer.parseInt(request.getParameter("limit"));

        CourseDAO courseDAO = new CourseDAO(FactoryProvider.getSessionFactory());
        List<Course> courses = courseDAO.getPaginatedCourses(pageNumber, itemsPerPage);
        int totalCourses = (int)courseDAO.getCourseCount();

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(buildJSONResponse(courses, totalCourses));
        out.flush();
    }

    private String buildJSONResponse(List<Course> courses, int totalCourses) {
        Gson gson = new Gson();
        return gson.toJson(new PaginatedResponse(courses, totalCourses));
    }

    private static class PaginatedResponse {
        private final List<Course> courses;
        private final int totalCourses;

        public PaginatedResponse(List<Course> courses, int totalCourses) {
            this.courses = courses;
            this.totalCourses = totalCourses;
        }
    }
}
