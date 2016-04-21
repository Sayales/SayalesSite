<%--
  Created by IntelliJ IDEA.
  User: Павел
  Date: 05.04.2016
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<?xml version="1.0" encoding="ISO-8859-1" ?>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page isELIgnored="false"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            var anchor = window.location.hash;
            if (anchor != '') {
                $("#login-form").append('<div class="alert alert-danger fade in"> <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>' +
                        ' <strong>Wrong nickname or password!</strong></div>');
            }
        })
    </script>
    <title>Login page</title>
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
                        <li><a href="/sign-up"><span class="glyphicon glyphicon glyphicon-pencil"/> SignUp</a></li>
                        <li class="active"><a href="/login"><span class="glyphicon glyphicon-log-in"/> Login</a></li>
                    </sec:authorize>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-4 col-md-offset-4" id="login-form">
                <p>${sign_message}</p>
                <form method="post" action=<c:url value='/j_spring_security_check'/>>
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div  class="form-group">
                            <label for="j_username">Email: </label>
                            <input type="text"  id="j_username" name="j_username" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <label for="j_password">Password: </label>
                            <input type="password" id="j_password" name="j_password" class="form-control"/>
                        </div>
                        <button class="btn btn-info" type="submit">Login</button>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>