<%@page import="com.prashant.webapp.entities.User"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@page import="com.prashant.webapp.entities.Notes"%>
<%@page import="com.prashant.webapp.dao.SavedNotesDao"%>
<br>
<div class="row d-flex p-5 d-flex justify-content-between" style="flex-wrap: wrap;">

    <%
        SavedNotesDao savedNotesDao = new SavedNotesDao(FactoryProvider.getSessionFactory());
        List<Notes> savednotes = null;
        try {
            savednotes = savedNotesDao.getAllNotesFromSavedNotesByUser(((User) session.getAttribute("loginuser")).getUserId());
        } catch (Exception e) {
    %>
    <h6 class="text-center text-danger">Error In Loading....</h6>
    <%
            e.printStackTrace();
        }
    %>
    <%
        if (savednotes != null) {
            for (Notes note : savednotes) {
    %>
    <div class="col-sm-3 m-2" >
        <div class="card bg-dark text-light m-2" >
            <div class="card-body" style="min-height: 200px;">
                <h5 class="card-title" style="text-transform: capitalize;"><%=note.getNoteName()%></h5>
                <p class="card-text"><%=note.getNoteDescription()%></p>
            </div>
            <p class="text-center">
                <%
                    String userId = ((User) session.getAttribute("loginuser")).getUserId();
                    String noteId = note.getNoteId();

                    String encodedUserId = URLEncoder.encode(userId, "UTF-8");
                    String encodedNoteId = URLEncoder.encode(noteId, "UTF-8");

                    String encodedURL = "./../RemoveSavedNotesServlet?userId=" + encodedUserId + "&noteId=" + encodedNoteId;

                %>
                <a href="./displayPDF.jsp?file=<%=note.getNoteId() + ".pdf"%>" class="btn btn-primary">Read</a>
                <a href="<%=encodedURL%>" class="btn btn-danger">Remove</a>
            </p>
            <div class="card-footer  d-flex" style="justify-content: space-between">
                <i class="text-danger fa fa-thumbs-up"><%=note.getLikes()%></i>
                <i class="text-info fa fa-thumbs-down"><%=note.getDislikes()%></i>
                <i class="text-success fa fa-eye"><%=note.getViews()%></i>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
</div>