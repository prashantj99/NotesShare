<%
    String msg = (String) session.getAttribute("msg");
    String type = (String) session.getAttribute("type");
    if (msg != null) {
%>
<div style="text-transform: capitalize;" class="alert text-center alert-<%=type%> alert-dismissible fade show" role="alert">
    <strong><%=msg%></strong>  
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>
<%
        session.removeAttribute("msg");
        session.removeAttribute("type");
    }
%>