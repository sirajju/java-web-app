<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
  <head>
    <title>Demo Application</title>
    <!-- <meta http-equiv="refresh" content="0; url=hello"> -->
  </head>
  <body>
    <h1>Welcome to Demo Application</h1>
    <div style="margin-bottom: 20px;">
      <a href="${pageContext.request.contextPath}/test">Test Servlet</a> | 
      <a href="${pageContext.request.contextPath}/login?logout=true">Logout</a>
    </div>
    
    <c:forEach var="counter" begin="1" end="${2000}">
      <jsp:text>${counter}</jsp:text>
    </c:forEach>
    <div style="display:flex; flex-direction:column;gap:5px">
      <c:forEach var="todo" items="${todos}">
        <h4>${todo.title}</h4>
      </c:forEach>
    </div>
    <style>
      h4 {
        color: blue;
      }
    </style>
  </body>
</html>
