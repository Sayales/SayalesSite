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
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<html>
<head>
    <title>Sign-up</title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="<c:url value="/resources/js/validate.js"/>"></script>
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
                    <li><a href="/customers">For customers</a></li>
                    <li><a href="/credits">Credentials</a></li>
                    <sec:authorize access="hasRole('ROLE_ADMIN')">
                        <li><a href="/admin_userlist">Users</a></li>
                    </sec:authorize>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <sec:authorize access="hasRole('ROLE_ANONYMOUS')">
                        <li class="active"><a href="/sign-up"><span class="glyphicon glyphicon glyphicon-pencil"/> SignUp</a></li>
                        <li><a href="/login"><span class="glyphicon glyphicon-log-in"/> Login</a></li>
                    </sec:authorize>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div id="signform">
                    <form:form method="post" role="form" commandName="newUser"
                          action="login"
                          onsubmit="return checkForm();">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div id="email-group" class="form-group">
                            <label for="email">Email: </label>
                            <form:input path="email" class="form-control" id="email"/>
                        </div>
                        <div class="form-group">
                            <label for="pwd">Password: </label>
                            <form:input type="password" path="password" class="form-control" id="pwd"/>
                        </div>
                        <button class="btn btn-info" type="submit">SignUp</button>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
