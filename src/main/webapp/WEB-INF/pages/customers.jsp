<%@ page import="com.myvisitpage.util.TimeUtil" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="com.myvisitpage.util.ProjectUtil" %><%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 01.04.2016
  Time: 16:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <title>Title</title>
    <script type="text/javascript">
        function deleteMessage(id){
            var ans = confirm('Are u sure `bout dis?');
            if(ans) {
                window.location.assign("/admin_message_delete?id=" + id);
            }
        }
        function messageAdd() {
            var ans = confirm('Are u sure `bout dis?');
            if(ans) {
                window.location.assign('/add-message');
            }
        }
    </script>
</head>
<body>
<h1>Messages and Projects</h1>
<div class="container">
    <div class="row">
        <div class="col-md-6">
            <table>
                <c:forEach items="${messages}" var="message">
                    <jsp:useBean id="message" scope="page" type="com.myvisitpage.model.CustomerMessage"/>
                    <tr>
                        <td><c:out value="${message.id}"/></td>
                        <td><c:out value="${message.text}"/></td>
                        <td><%=
                        TimeUtil.toString(message.getDateTime())
                        %>
                        </td>
                        <td><a href="/${admin_label}message_update?id=${message.id}">Update</a></td>
                        <td><a href="/${admin_label}message_delete?id=${message.id}" onclick="deleteMessage(${message.id})">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
            <form:form method="post" commandName="customerMessage" action="${admin_label}add-message">
                <form:hidden path="id"/>
                <form:hidden path="dateTime"/>
                <form:hidden path="userEmail"/>
                <form:label path="text">Message text: </form:label>
                <form:input path="text"/>
                <input type="submit" class="button" value="${message_button_text}" onclick="messageAdd()" tabindex="5">
            </form:form>
        </div>
        <div class="col-md-6">
            <table>
                <c:forEach items="${projects}" var="project">
                    <jsp:useBean id="project" scope="page" type="com.myvisitpage.model.Project"/>
                    <tr>
                        <td>${project.id}</td>
                        <td><a href="${pageContext.request.contextPath}/project?id=${project.id}"> ${project.name}</a>
                        </td>
                        <td>${project.description}</td>
                        <td><%=
                        TimeUtil.toString(project.getStartDate())
                        %>
                        </td>
                        <td>${project.devTime}</td>
                        <td><%=
                        ProjectUtil.totalValue(project.getChunks())
                        %>
                        </td>
                        <sec:authorize access="hasRole('ROLE_ADMNI')">
                            <td><a href="${pageContext.request.contextPath}/project_delete?id=${project.id}">Delete</a>
                            </td>
                        </sec:authorize>
                    </tr>
                </c:forEach>
            </table>
            <form:form method="post" commandName="newProject" action="add-project">
                <form:label path="name">Project name: </form:label>
                <form:input path="name"/> <br>
                <form:label path="description">Project description: </form:label>
                <form:input path="description"/>
                <input type="submit" class="button" value="Add project" tabindex="4">
            </form:form>
        </div>
    </div>
</div>
</body>
</html>
