<%@page import="com.prashant.webapp.entities.RecentlyViewed"%>
<%@page import="com.prashant.webapp.dao.RecentlyViewedDAO"%>
<%@page import="java.util.List"%>
<%@page import="com.prashant.webapp.entities.User"%>
<%@page import="com.prashant.webapp.entities.Notes"%>
<%@page import="com.prashant.webapp.util.FactoryProvider"%>
<%@page import="com.prashant.webapp.dao.SavedNotesDao"%>
<%@page import="com.prashant.webapp.entities.SavedNotes"%>
<section class="pt-5 pb-5">
    <div class="container">
        <div class="row">
            <div class="col-6">
                <h3 class="mb-3"><img src="../img/recent.png" style="width: 50px;" title="recent icons" /></h3>
            </div>
            <div class="col-6 text-right">
                <a class="btn btn-primary mb-3 mr-1" href="#carouselExampleIndicators2" role="button" data-slide="prev">
                    <img src="./../img/back.png" style="width: 20px;">
                </a>
                <a class="btn btn-primary mb-3 " href="#carouselExampleIndicators2" role="button" data-slide="next">
                    <img src="./../img/arrow.png" style="width: 20px;">
                </a>
            </div>
            <%
                RecentlyViewedDAO recentlyViewedDAO = new RecentlyViewedDAO(FactoryProvider.getSessionFactory());
                List<Notes> notes = null;
                try {

                    notes = recentlyViewedDAO.getRecentNotes(((User) session.getAttribute("loginuser")).getUserId());

                } catch (Exception e) {
            %>
            <h6 class="text-center text-danger">Error In Loading....</h6>
            <%
                    e.printStackTrace();
                }
            %>
            <div class="col-12">
                <div id="carouselExampleIndicators2" class="carousel slide" data-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <%
                                int i = 0;
                                if (notes != null) {
                            %>
                            <div class="row d-flex justify-content-around">
                                <%
                                    if (notes.size() == 0) {
                                %>
                                <h6 class="text-center">No Item found...</h6>
                                <%
                                    }
                                %>
                                <%
                                    for (; i < notes.size() && i < 3; i++) {
                                %>
                                <div class="col-md-3 m-3">
                                    <div class="card bg-dark text-white" style="width: 18rem;">
                                        <img class="img-fluid" alt="100%x280" src="https://picsum.photos/id/1/5000/3333">
                                        <div class="card-body" style="min-height: 180px;">
                                            <h6 class="card-title" style="text-transform: capitalize;"><%=notes.get(i).getNoteName()%></h6>
                                            <p>
                                                <%
                                                    String desc = notes.get(i).getNoteDescription();
                                                    out.println(desc.length() >= 50 ? desc.substring(0, 50) + "..." : desc);
                                                %>
                                            </p>
                                            <a href="./displayPDF.jsp?file=<%=notes.get(i).getNoteId()%>.pdf">read now</a>
                                        </div>
                                        <div class="card-footer  d-flex" style="justify-content: space-between">
                                            <i class="text-danger fa fa-thumbs-up"><%=notes.get(i).getLikes()%></i>
                                            <i class="text-info fa fa-thumbs-down"><%=notes.get(i).getDislikes()%></i>
                                            <i class="text-success fa fa-eye"><%=notes.get(i).getViews()%></i>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <%
                            if (notes != null && i >= 3) {
                        %>
                        <div class="carousel-item">
                            <div class="row d-flex justify-content-around">
                                <%
                                    for (; i < notes.size() && i < 6; i++) {
                                %>
                                <div class="col-md-3 m-3">
                                    <div class="card bg-dark text-white" style="width: 18rem;">
                                        <img class="img-fluid" alt="100%x280" src="https://picsum.photos/id/1/5000/3333">
                                        <div class="card-body" style="min-height: 180px;">
                                            <h6 class="card-title" style="text-transform: capitalize;"><%=notes.get(i).getNoteName()%></h6>
                                            <p>
                                                <%
                                                    String desc = notes.get(i).getNoteDescription();
                                                    out.println(desc.length() >= 30 ? desc.substring(0, 30) + "..." : desc);
                                                %>
                                            </p>
                                            <a href="./displayPDF.jsp?file=<%=notes.get(i).getNoteId()%>.pdf">read now</a>
                                        </div>
                                        <div class="card-footer  d-flex" style="justify-content: space-between">
                                            <i class="text-danger fa fa-thumbs-up"><%=notes.get(i).getLikes()%></i>
                                            <i class="text-info fa fa-thumbs-down"><%=notes.get(i).getDislikes()%></i>
                                            <i class="text-success fa fa-eye"><%=notes.get(i).getViews()%></i>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <%
                            }
                        %>
                        <%
                            if (notes != null && notes.size() >= 6) {
                        %>
                        <div class="carousel-item">
                            <div class="row d-flex justify-content-around">
                                <%
                                    for (; i < notes.size(); i++) {
                                %>
                                <div class="col-md-3 m-3">
                                    <div class="card bg-dark text-white"style="width: 18rem;">
                                        <img class="img-fluid" alt="100%x280" src="https://picsum.photos/id/1/5000/3333">
                                        <div class="card-body" style="min-height: 180px;">
                                            <h6 class="card-title" style="text-transform: capitalize;"><%=notes.get(i).getNoteName()%></h6>
                                            <p>
                                                <%
                                                    String desc = notes.get(i).getNoteDescription();
                                                    out.println(desc.length() >= 30 ? desc.substring(0, 30) + "..." : desc);
                                                %>
                                            </p>
                                            <a href="./displayPDF.jsp?file=<%=notes.get(i).getNoteId()%>.pdf">read now</a>
                                        </div>
                                        <div class="card-footer  d-flex" style="justify-content: space-between">
                                            <i class="text-danger fa fa-thumbs-up"><%=notes.get(i).getLikes()%></i>
                                            <i class="text-info fa fa-thumbs-down"><%=notes.get(i).getDislikes()%></i>
                                            <i class="text-success fa fa-eye"><%=notes.get(i).getViews()%></i>
                                        </div>
                                    </div>
                                </div>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>