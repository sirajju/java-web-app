<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
  <head>
    <title>Login</title>
  </head>
  <body>
    <h1>Welcome to Login</h1>
    
    <c:if test="${not empty error}">
      <div style="color: red; margin-bottom: 10px;">
        ${error}
      </div>
    </c:if>
    
    <c:if test="${not empty message}">
      <div style="color: green; margin-bottom: 10px;">
        ${message}
      </div>
    </c:if>
    
    <form method="post" action="${pageContext.request.contextPath}/login">
      <div style="margin-bottom: 10px;">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" required />
      </div>
      <div style="margin-bottom: 10px;">
        <label for="password">Password:</label>
        <input type="password" id="password" name="password" required />
      </div>
      <button type="submit">Login</button>
    </form>
    
    <p><a href="${pageContext.request.contextPath}/test">Test Page (no auth required)</a></p>
    
    <style>
      h4 {
        color: red;
      }
      form {
        max-width: 300px;
        margin: 20px 0;
      }
      label {
        display: block;
        margin-bottom: 5px;
      }
      input {
        width: 100%;
        padding: 5px;
      }
      button {
        padding: 10px 20px;
        background-color: #007bff;
        color: white;
        border: none;
        cursor: pointer;
      }
      button:hover {
        background-color: #0056b3;
      }
    </style>
  </body>
</html>
