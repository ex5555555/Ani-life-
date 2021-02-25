<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>後台header</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<%-- <c:set var="path" value="${pageContext.request.contextPath}"></c:set> --%>
<%-- <script src="${path}/css/javascripts/jquery-3.5.1.min.js" /></script> --%>
<%-- <script src="${path }/css/javascripts/jquery-ui.min.js"></script> --%>
<!-- jquery -->


<!-- css -->
<style type="text/css">
html{
	height:100%;
	/* background: linear-gradient(45deg,  rgba(145,155,155,1) 0%, rgba(43,53,53,1) 100%) no-repeat fixed; */
}
</style>
</head>
<body>


      <c:choose>
      <c:when test="${eeaccount =='all'}">
	   <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployee?eeaccount=${eeaccount}">員工</a></li>
			<li class="nav-item"><a class="nav-link" href="bsProductManagement?eeaccount=${eeaccount}">產品</a></li>
			<li class="nav-item"><a class="nav-link" href="gogooglemap?eeaccount=${eeaccount}">地圖</a></li>
			<li class="nav-item"><a class="nav-link" href="showAllTrading?eeaccount=${eeaccount}">訂單</a></li>
			<li class="nav-item"><a class="nav-link" href="selectAllMember?eeaccount=${eeaccount}">會員</a></li>
			<li class="nav-item"><a class="nav-link" href="paper?how=1&eeaccount=${eeaccount}">報表</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  <c:when test="${eeaccount =='employee'}">
	   <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployee?eeaccount=${eeaccount}">員工</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  
	  <c:when test="${eeaccount =='product'}">
		<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="bsProductManagement?eeaccount=${eeaccount}">產品</a></li>
			<li class="nav-item"><a class="nav-link" href="paper?how=1&eeaccount=${eeaccount}">報表</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  
	  <c:when test="${eeaccount =='member'}">
	    <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
	    	<li class="nav-item"><a class="nav-link" href="selectAllMember?eeaccount=${eeaccount}">會員</a></li>
	    	<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  
	  <c:when test="${eeaccount =='googlemap'}">
	    <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="gogooglemap?eeaccount=${eeaccount}">地圖</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  
	  <c:when test="${eeaccount =='trading'}">
	    <nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
	    <ul class="navbar-nav">
	    	<li class="nav-item active"><a class="navbar-brand" href="gobackhome?eeaccount=${eeaccount}">Home</a></li>
			<li class="nav-item"><a class="nav-link" href="showAllTrading?eeaccount=${eeaccount}">訂單</a></li>
			<li class="nav-item"><a class="nav-link" href="goemployeelogin">登出</a></li>
		</ul>
      </nav>
	  </c:when>
	  </c:choose>
<!-- -->

</body>
</html>







