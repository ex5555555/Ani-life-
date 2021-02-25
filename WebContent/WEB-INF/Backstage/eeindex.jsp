<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Employee Login</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path}/css/javascripts/jquery-3.5.1.min.js" /></script>
<script src="${path }/css/javascripts/jquery-ui.min.js"></script>

<%-- <link rel="stylesheet" href="<c:url value="/css/eelogin.css"/>"> --%>
<style type="text/css">
.html{

}
.container{
    width: 350px;
    height: 500px;
    transform: translate(0%,30%);
    border-radius: 10px;
    padding: 40px;
    text-align: center;
    box-shadow: 0 0 5px black;
    background: rgb(146 146 146 / 20%);
    font-family: Arial, sans-serif;
}
.center{
    margin: 0 auto;
    float: none;
}
#warning{
	color: rgb(223, 92, 92);
}
#btn-submit{
	border-radius: 5px;
}
.label1{
	text-align:left;
}
h2{
	color: #6b6b6b;
    font-size: 42px;
    text-shadow: 3px 3px rgb(204 204 204);
}
#btn-submit{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
#btn-submit:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
</style>
</head>
<body>

<div class="container">
<div class="row">

<div class="w-100">
<form method="get" action="employeelogin" class="loginform">
		<div class="mt-3">
		 <h2>Login</h2>
		</div>
		<div class="form-group input1 col-10 center mt-5">
			<label class="label1 text-muted" for="inputaccount" style="text-align:left;">Account</label>
            <input id="inputaccount" type="text" style="text-align:center;" name="empAccount" class="form-control" autocomplete="off" required/>
        </div>
        <div class="form-group input2 col-10 center mt-3">
        	<label class="label2 text-muted" for="inputpassword" style=";">Password</label>
            <input id="inputpassword" type="password" style="text-align:center;" name="empPassword" class="form-control"  autocomplete="off" required/>
        </div>
        <div class="mt-5">
            <input type="submit" value="submit" id="btn-submit" class=""/>
        </div>
        <div class="mt-4">
            <small id="warning" class="form-text">${err.msg}${err.empAccount}<br>${err.empPassword}</small>
        </div>
</form>
</div>


</div>
</div>

</body>
</html>







