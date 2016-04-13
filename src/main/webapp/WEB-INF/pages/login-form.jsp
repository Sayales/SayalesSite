<%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 05.04.2016
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<?xml version="1.0" encoding="ISO-8859-1" ?>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>Login page</title>
    <style>
        .error {
            color: red;
        }
    </style>
</head>
<body>
<h1>Login page</h1>
<p>${sign_message}</p> <br>
<p>
    <c:if test="${error == true}">
        <b class="error">Invalid login or password.</b>
    </c:if>
</p>

<form method="post" action=<c:url value='/j_spring_security_check'/>>
    <table>
        <tbody>
        <tr>
            <td>Login:</td>
            <td> <input type="text"  id="j_username" name="j_username"></td>
        </tr>
        <tr>
            <td>Password:</td>
            <td><input type="password" id="j_password" name="j_password"/></td>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </tr>
        <tr>
            <td></td>
            <td><input type="submit" value="Login" /></td>
            <td><a href="/hello">Enter as guest</a> </td>
        </tr>
        </tbody>
    </table>
</form>

<p>
    <a href="${pageContext.request.contextPath}/hello">Home page</a><br/>
</p>
</body>
</html>