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
    <script>
        function checkForm() {
            var inputEmail = document.getElementById('email').value;
            var msg = '405';
            $.ajax({
                type : "GET",
                contentType : "application/json",
                url : "/hello/is_valid",
                data : ({
                   email:  inputEmail
                }),
                dataType : 'json',
                timeout : 100000,
                async : false,
                success : function(data) {
                    msg = data.answ;
                }
            });
            if (msg != '200') {
                $("#sickform").append('<div class="alert alert-danger"> <strong>Wrong username!</strong> Please try another one.</div>');
                return false;
            }
            var pwd = document.getElementById('pwd').value;
            if (pwd == null || pwd == '') {
                $("#sickform").append('<div class="alert alert-danger"> <strong>Wrong password!</strong> Password must not be empty. </div>');
                return false;
            }
        };
        $(document).ready(function () {
            $('#sickform').css('visibility', 'visible').hide();
            $('#signUpButt').click(function () {
                $('#sickform').toggle('fast');
            })
        });
    </script>
    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>
<body><div class="container">
    <div class="jumbotron">
        <h1>Hello everyone!</h1>
        <p>You logged in as ${name} </ p>
        <br>
        <div class="row">
            <sec:authorize access="hasRole('ROLE_ANONYMOUS')">
                <div class="col-md-1">
                    <button class="btn btn-primary" id="signUpButt">SignUp</button>
                </div>
            </sec:authorize>
            <div class="col-md-1">
                <a class="btn btn-info" href="/login"><span class="glyphicon glyphicon-log-in"/> Login</a>
            </div>
            <sec:authorize access="hasAnyRole('ROLE_ADMIN','ROLE_USER')">
                <div class="col-md-1">
                    <form method="post" action="/logout">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-danger"><span class="glyphicon glyphicon-log-out"/> Logout
                        </button>
                    </form>
                </div>
            </sec:authorize>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div id="sickform" style="visibility: hidden">
                    <form:form method="post" role="form" commandName="newUser" action="login"
                               onsubmit="return checkForm();">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="form-group">
                            <label for="email">Email: </label>
                            <form:input path="email" class="form-control" id="email" rows="2"/>
                        </div>
                        <div class="form-group">
                            <label for="pwd">Password: </label>
                            <form:input type="password" path="password" class="form-control" id="pwd"/>
                        </div>
                        <td><input type="submit" value="SignUp"/></td>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <ul class="nav nav-pills" role="tablist">
        <li class="active"><a href="/hello">Home</a></li>
        <li><a href="/customers">For customers</a></li>
        <li><a href="cresits">Credentials</a></li>
        <sec:authorize access="hasRole('ROLE_ADMIN')">
            <li><a href="/admin_userlist">Users</a></li>
        </sec:authorize>
    </ul>
</div>
</body>
</html>
