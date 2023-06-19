package com.prashant.webapp.servlet;

import com.prashant.webapp.dao.CategoryDAO;
import com.prashant.webapp.entities.Category;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.UserIdGenerator;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AddCategoryServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryId = UserIdGenerator.generateUserId();
        String categoryName = request.getParameter("categoryName").trim();
        if (hasSimilarCourse(categoryName)) {
            String errorMessage = "category001";
            PrintWriter out = response.getWriter();
            out.println(errorMessage);
        } else {
            Category cat = new Category(categoryId, categoryName);
            CategoryDAO categoryDAO = new CategoryDAO(FactoryProvider.getSessionFactory());
            if (categoryDAO.saveCategory(cat)) {
                response.setStatus(HttpServletResponse.SC_OK);
            } else {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        }
    }

    private boolean hasSimilarCourse(String categoryName) {
        List<Category> categorys = new CategoryDAO(FactoryProvider.getSessionFactory()).getAllCategories();
        for (Category category : categorys) {
            if (categoryName.equalsIgnoreCase(category.getCategoryName())) {
                return true;
            }
        }
        return false;
    }
}
