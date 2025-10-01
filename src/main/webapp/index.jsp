<%
    String contextPath = request.getContextPath();
    if (contextPath == null || contextPath.isEmpty()) {
        contextPath = "";
    }
    response.sendRedirect(contextPath + "/home");
%>