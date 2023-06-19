package com.prashant.webapp.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.prashant.webapp.dao.UserDAO;
import com.prashant.webapp.entities.User;
import com.prashant.webapp.entities.UserGoogleDto;
import com.prashant.webapp.util.Constants;
import com.prashant.webapp.util.FactoryProvider;
import com.prashant.webapp.util.PasswordEncrypter;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;

public class GoogleLoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        String accessToken = getToken(code);
        UserGoogleDto user = getUserInfo(accessToken);
        System.out.println(user);
        //saving details to database
        User saveUser = new User();
        saveUser.setUserEmail(user.getEmail());
        saveUser.setUserId(user.getId());
        saveUser.setUserName(user.getName());
        saveUser.setUserPassword(PasswordEncrypter.hashPassword(user.getEmail() + user.getId() + user.getPicture()));
        saveUser.setUserType("normal");
        UserDAO userDAO = new UserDAO(FactoryProvider.getSessionFactory());
        HttpSession session = request.getSession();
        if (userDAO.getUserByUserId(user.getId()) != null) {
            //user already registered
            //redirect to dashboard page
            session.setAttribute("loginuser", saveUser);
            response.sendRedirect("./user/user_dashboard.jsp");
            return;
        }

        if (userDAO.addUser(saveUser)) {
            //succesfully saved user
            session.setAttribute("loginuser", saveUser);
            response.sendRedirect("./user/user_dashboard.jsp");
            return;
        }
        session.setAttribute("msg", "sorry !!! an error has been occurred !! try again");
        session.setAttribute("type", "danger");
        response.sendRedirect("./login_page.jsp");
        return;
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        // call api to get token
        String response = Request.Post(Constants.GOOGLE_LINK_GET_TOKEN)
                .bodyForm(Form.form().add("client_id", Constants.GOOGLE_CLIENT_ID)
                        .add("client_secret", Constants.GOOGLE_CLIENT_SECRET)
                        .add("redirect_uri", Constants.GOOGLE_REDIRECT_URI)
                        .add("code", code)
                        .add("grant_type", Constants.GOOGLE_GRANT_TYPE).build())
                .execute().returnContent().asString();

        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogleDto getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = Constants.GOOGLE_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();

        UserGoogleDto googlePojo = new Gson().fromJson(response, UserGoogleDto.class);

        return googlePojo;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
