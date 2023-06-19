package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.DepartmentDAO;
import com.prashant.webapp.entities.Department;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.UserIdGenerator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DepartmentOperationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String departmentId = UserIdGenerator.generateUserId();
        String departmentName = request.getParameter("departmentName").trim();
        DepartmentDAO departmentDAO = new DepartmentDAO(FactoryProvider.getSessionFactory());
        if (hasSimilarDepartment(departmentName)) {
            String errorMessage = "department001";
            PrintWriter out = response.getWriter();
            out.println(errorMessage);
        } else {
            Department department=new Department(departmentId, departmentName);
            if (departmentDAO.saveDepartment(department)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    private boolean hasSimilarDepartment(String departmentName) {
        List<Department> departments = new DepartmentDAO(FactoryProvider.getSessionFactory()).getAllDepartments();
        for (Department department : departments) {
            if (departmentName.equalsIgnoreCase(department.getDepartmentName())) {
                return true;
            }
        }
        return false;
    }
}
