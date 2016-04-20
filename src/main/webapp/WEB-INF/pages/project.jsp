<%@ page import="com.myvisitpage.util.TimeUtil" %><%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 04.04.2016
  Time: 16:34
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
    <title>Title</title>
</head>
<body>
<table>
    <c:forEach items="${chunks}" var="chunk">
        <jsp:useBean id="chunk" scope="request" class="com.myvisitpage.model.ProjectChunk"/>
        <tr>
            <td>${chunk.id}"</td>
            <td>${chunk.description}</td>
            <td><%=
            TimeUtil.toString(chunk.getDate())
            %></td>
            <td><a href="/admin_chunk_edit?id=${chunk.id}">Edit</a></td>
            <td><a href="/admin_chunk_delete?id=${chunk.id}">Delete</a></td>
        </tr>
    </c:forEach>
    <sec:authorize access="hasRole('ROLE_ADMIN')">
    <form:form method="post" commandName="newChunk" action="admin_add_chunk">
        <jsp:useBean id="newChunk" scope="request" class="com.myvisitpage.model.ProjectChunk"/>
        <form:hidden path="id"/>
        <table>
            <tr>
                <td>Description: </td>
                <td><form:input path="description"/></td>
                <td>Value: </td>
                <td><form:input path="value"/></td>
                <td><input type="submit" value="Add chunk"/></td>
            </tr>
        </table>
    </form:form>
        </sec:authorize>
</table>
</body>
</html>
