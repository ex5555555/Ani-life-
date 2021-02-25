<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>員工更新</title>
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
<!-- jquery -->
<script type="text/javascript">


</script>

<!-- css -->
<style type="text/css">
html{
	height:100%;
	/* background: linear-gradient(45deg,  rgba(145,155,155,1) 0%, rgba(43,53,53,1) 100%) no-repeat fixed; */
}
#tools a{
	color:#4a4a4a;
	border:none;
}
.updatebutton{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
.updatebutton:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
.deletebutton{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
.deletebutton:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
.collapsing {
  width: 0;
  transition-property: width;
  white-space: nowrap;
  height: 100%;
}
.main{
	position: absolute;
	top:50%;
    left: 50%;
    transform: translate(-50%,-50%);
    weight:100%;
    height:100%;
    margin:100px auto 100px auto;
}
#tools{
	background-color: rgb(146 146 146 / 20%);
	display:flex;
	align-items:center; /* 垂直置中 */
	justify-content:center;  /* 水平置中 */
	margin:2px;
	color:#4a4a4a;
}
.item{
	display:inline-block;
	padding:30px;
}
#employeesmenu{
	margin:50px auto 50px auto;
	font-size: 20px;
	color:#585858;
}
.employeeid{
	color:rgb(3 93 88);
}
.outemployees{
	background-color: rgb(239 239 239 / 50%);
	margin: 2px 25px 25px 25px;
}
#updateemployee{
	color:rgb(3 93 88);
}
#employees{
	padding:10px;
/* 	display:flex;
	align-items:center; /* 垂直置中 */ */
}
.emspan{
	width:70px;
	margin:0;
}
.emspan2{
	margin-right: 20.5px;
}
.text{
	width:calc(100% - 70px);
}
#updatebutton{
	float: left;
}
#updatecancel{
	float: right;
	text-align:right;
}
input[type=text]{
	box-sizing: border-box;
  	border: none;
  	border-bottom: 2px solid #999;
  	background-color:rgba(31, 31, 31, 0%);
  	color: #585858;
}
input[type=text]:focus{
	background-color:white;
	color:rgb(31,31,31);
	outline:none;
}
::placeholder{
	color: #999;
}
select {
	border:none;
  	background-color: rgb(165 165 165 / 50%);
  	color: #999;
}
select:focus{
	outline:none;
	background-color: rgba(131, 131, 131, 50%);
}
select:checked{
	color: #555;
}
option, option:focus{
	color: rgb(97 97 97);
    background-color: #e2e2e2;
}
</style>
</head>



<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>


<div class="main" style="width: 1000px;">
  <div id="tools" style="width: 996px; height:100px; margin:2">
	  <div class="item">
	    <a href="goemployee?eeaccount=${eeaccount}">全部</a>
	  </div>
	  <div class="item">
	    <a href="toaddemployeejsp?eeaccount=${eeaccount}">新增</a>
	  </div>
	  <div class="item">
		<form method="post" action="selectemployeetitle">
		    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <span>員工職稱</span>
		 <select name="title" onchange="this.form.submit()">
			<option value="" selected disabled>請選擇</option>
			<option value="all">總管理員</option>
			<option value="product">產品管理員</option>
			<option value="googlemap">地圖管理員</option>
			<option value="trading">訂單管理員</option>
			<option value="member">會員管理員</option>
		</select>
		</form>
	  </div>
	  <div class="item">
	    <form method="post" action="selectemployeeid">
	        <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <div>
		    <span style="margin-right: 5px;">員工編號</span><input type="text" name="empID" placeholder="請輸入編號" required></input>
		  </div>
		</form>
	  </div>
  </div>

<!-- 更新員工 -->
  <div id="employeesmenu" class="row no-gutters" align="left">
	  <div class="outemployees" style="width: 450px; height: 260px;" align="center">
		<div id="employees" style="width: 300px; height:100%;" align="left">
		<table cellpadding="2" class="my-2">
		  <thread>
			<tr>
			  <th class="employeeid">員工編號: ${employee.empid}</th>
			</tr>
		  </thread>
		  <tbody>
				<tr>
					<td>account</td>
					<td class="empaccount">${employee.empaccount}</td>
				</tr>
				<tr>
					<td>password</td>
					<td class="emppassword">${employee.emppassword}</td>
				</tr>
				<tr>
					<td>name</td>
					<td class="empname">${employee.empname}</td>
				</tr>
				<tr>
					<td>title</td>
					<td class="title">${employee.title}</td>
				</tr>
			</tbody>
		</div>
	  </div>
  
  	  <div class="outemployees" style="width: 450px; height: 260px;" align="center">
  	    <div id="updateemployee" style="width: 306px; height:100%;" align="left" class="pt-3">
	  	    <form class="${employee.empid}" method="post" action="updateemployee">
	  	        <input type="hidden" name="eeaccount" value="${eeaccount}">
			<label class="emspan" style="width: 100px; font-weight:bold;">員工編號</label>
			  <input type="text" class="text" style="width: 200px;" name="empID" value="${employee.empid}" readonly></input><br>
			<label class="emspan" style="width: 100px;">員工帳號</label>
			  <input type="text" class="text" style="width: 200px;" name="empAccount" value="${employee.empaccount}" required></input><br>
			<label class="emspan" style="width: 100px;">員工密碼</label>
			  <input type="text" class="text" style="width: 200px;" name="empPassword" value="${employee.emppassword}" required></input><br>
			<label class="emspan" style="width: 100px;">員工名字</label>
			  <input type="text" class="text" style="width: 200px;" name="empName" value="${employee.empname}" required></input><br>
			<span class="emspan2">員工職稱</span>
			<select name="title">
				<option value="all" <c:if test="${employee.title == 'all' }">selected='selected'</c:if>>總管理員</option>
				<option value="product" <c:if test="${employee.title == 'product' }">selected='selected'</c:if>>產品管理員</option>
				<option value="googlemap" <c:if test="${employee.title == 'googlemap' }">selected='selected'</c:if>>地圖管理員</option>
				<option value="trading" <c:if test="${employee.title == 'trading' }">selected='selected'</c:if>>訂單管理員</option>
				<option value="member" <c:if test="${employee.title == 'member' }">selected='selected'</c:if>>會員管理員</option>
			</select>
			<div id="updatebutton" class="pt-2" style="width: 153px;">
			  <button  class="updatebutton" type="submit" class="confirm">確定</button>
			</div>
			</form>
			<div id="updatecancel" class="pt-2" style="width: 153px;">
			  <input  class="deletebutton" type="button" value="回首頁" onclick="location.href='goemployee?eeaccount=${eeaccount}'"></input>
  	    	</div>
  	    </div>
  	  </div>
			
  
  </div>


<!-- container -->	
</div>
<!-- container -->					
</body>
</html>