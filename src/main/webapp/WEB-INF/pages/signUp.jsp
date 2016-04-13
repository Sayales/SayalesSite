<%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 05.04.2016
  Time: 23:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <title>Sign-up</title>
</head>
<body>
<h1>Sign up page</h1>
<form:form method="post" commandName="newUser" action="login">
    <table>
        <tbody>
        <tr>
            <td>Login:</td>
            <td> <form:input path="email"/></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><form:input type="password" path="password" /></td>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Login" /></td>
        </tr>
        </tbody>
    </table>
</form:form>

<p>
    <a href="${pageContext.request.contextPath}/hello">Home page</a><br/>
</p>
</body>
</html>
