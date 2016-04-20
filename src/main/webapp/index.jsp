<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hello page</title>
</head>
<body>
<!--<h1>Hello everyone</h1>
<p>Hi I am Pavel, and I develop some visit page</p> <br>
<ul>
    <li><a href="/login">Login</a></li>
    <li><a href="/customers">For customers</a> </li>
    <li><a href="/credits">Credentials</a></li>
    <li><a href="/sign-up">Sign up!</a> </li>
</ul>-->
<% response.sendRedirect("/hello"); %>
</body>
</html>