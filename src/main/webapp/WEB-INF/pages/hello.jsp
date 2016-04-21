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
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script src="<c:url value="/resources/js/validate.js"/> "></script>
</head>
<body>
<script>
    function logOut(){
        document.logOutForm.submit();
    }
</script>
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
                    <li class="active"><a href="/hello">Home</a></li>
                    <li><a href="/customers">For customers</a></li>
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
                        <li><a href="#"><span class="glyphicon glyphicon-user"/> ${name}</a></li>
                        <li><a href="#" onclick="logOut();"><span class="glyphicon glyphicon-log-out"/> Logout</a> </li>
                    </sec:authorize>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="jumbotron">
        <h1>Hello everyone!</h1>
        <p> You logged in as ${name} </p>
    </div>

</div>
<form name="logOutForm" method="post" action="/logout" style="visibility: hidden">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <button type="submit"><span class="glyphicon glyphicon-log-out"/> Logout
    </button>
</form>
</body>
</html>
