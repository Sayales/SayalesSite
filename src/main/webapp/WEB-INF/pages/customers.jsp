<%@ page import="com.myvisitpage.util.TimeUtil" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="com.myvisitpage.util.ProjectUtil" %>
<%@ page import="com.myvisitpage.util.LoggedUser" %><%--
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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <title>Messages and projects</title>
    <script type="text/javascript" src="<c:url value="/resources/js/customers.js"/>"></script>
</head>
<body>
<div class="container">
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse"
                        data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">Sayales</a>
            </div>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav">
                    <li><a href="/hello">Home</a></li>
                    <li class="active"><a href="/customers">For customers</a></li>
                    <li><a href="/credits">Credentials</a></li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li><a href="/admin_userlist">Users</a></li>
                    </sec:authorize>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <sec:authorize access="hasRole('ROLE_ANONYMOUS')">
                        <li><a href="/sign-up"><span class="glyphicon glyphicon glyphicon-pencil"/> SignUp</a></li>
                        <li><a href="/login"><span class="glyphicon glyphicon-log-in"/> Login</a></li>
                    </sec:authorize>
                    <sec:authorize access="hasAnyRole('ROLE_USER','ROLE_ADMIN')">
                        <li><a href="#"><span class="glyphicon glyphicon-user"/> <%= LoggedUser.getName()%>
                        </a></li>
                        <li><a href="#" onclick="logOut();"><span class="glyphicon glyphicon-log-out"/> Logout</a></li>
                    </sec:authorize>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="row">
        <div class="col-md-6">
            <table class="table">
                <c:forEach items="${messages}" var="message">
                    <jsp:useBean id="message" scope="page" type="com.myvisitpage.model.CustomerMessage"/>
                    <tr>
                        <td><c:out value="${message.id}"/></td>
                        <td>
                            <a href="#" onclick="showModal(${message.id})" <%--class="btn btn-link"  data-toggle="modal" data-target="#messageModal" data-whatever="${message.id}"--%>>
                                ${message.title}
                            </a>
                        </td>
                        <td><%=
                        TimeUtil.toString(message.getDateTime())
                        %>
                        </td>
                        <td><a href="/${admin_label}message_update?id=${message.id}">Update</a></td>
                        <td><a href="/${admin_label}message_delete?id=${message.id}"
                               onclick="deleteMessage(${message.id})">Delete</a></td>
                    </tr>
                    <!-- Modal -->
                </c:forEach>
            </table>
            <form:form method="post" commandName="customerMessage" action="${admin_label}add-message">
                <form:hidden path="id"/>
                <form:hidden path="dateTime"/>
                <form:hidden path="userEmail"/>
                <form:label path="text">Message text: </form:label>
                <form:input path="text"/>
                <input type="submit" class="button" value="${message_button_text}" tabindex="5">
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
<div class="modal fade" id="messageModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">Message</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="message-text">Text</label>
                        <p id="message-text"
                           class="form-control-static">Hello i`m modal</p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <%-- <button type="button" class="btn btn-primary">Save changes</button>--%>
            </div>
        </div>
    </div>
</div>
<form name="logOutForm" method="post" action="/logout" style="visibility: hidden">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <button type="submit"><span class="glyphicon glyphicon-log-out"/> Logout
    </button>
</form>
</body>
</html>
