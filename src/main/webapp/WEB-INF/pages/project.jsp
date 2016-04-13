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
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table>
    <c:forEach items="${chunks}" var="chunk">
        <jsp:useBean id="projectChunk" scope="request" class="com.myvisitpage.model.ProjectChunk"/>
        <tr>
            <td>${chunk.id}"</td>
            <td>${chunk.description}</td>
            <td><%=
            TimeUtil.toString(projectChunk.getDate())
            %></td>
        </tr>
    </c:forEach>
    <form:form method="post" commandName="newChunk" action="add-chunk">

    </form:form>
</table>
</body>
</html>
