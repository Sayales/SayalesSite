<%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 09.04.2016
  Time: 20:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <c:forEach items="${users}" var="user">
        <jsp:useBean id="user" scope="request" class="com.myvisitpage.model.User"/>
        <tr>
            <td>${user.id}</td>
            <td><a href="/admin_customers?id=${user.id}">${user.email}</a></td>
            <td>${user.password}</td>
            <td>${user.role.toString()}</td>
            <td><a class="button" href="/admin_user_delete?id=${user.id}">Delete</a> </td>
            <td><a href="/admin_user_update?id=${user.id}">Update</a></td>
        </tr>
    </c:forEach>
</table>
<form:form method="post" commandName="newUser" action="admin_add_user">
    <form:hidden path="id"/>
    <table>
        <tr>
            <td>Email:</td>
            <td><form:input path="email"/></td>
            <td>Password: </td>
            <td><form:input path="password"/></td>
            <td>Role: </td>
            <td><form:select path="role" items="${roleList}"/></td>
            <td><input type="submit" class="button" value="Submit"/></td>
        </tr>
    </table>
</form:form>
</body>
</html>
