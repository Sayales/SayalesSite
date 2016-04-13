<%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 01.04.2016
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hello page</title>
</head>
<body>
<h1>Hello everyone</h1>
<p>You logged in as ${name} </p>
<form method="post" action="/logout">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="logout"/></form>

<ul>
    <li><a href="/customers">For customers</a> </li>
    <li><a href="/credits">Credentials</a></li>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
        <li><a href="/admin_userlist">Users</a> </li>
    </sec:authorize>
</ul>
</body>
</html>
