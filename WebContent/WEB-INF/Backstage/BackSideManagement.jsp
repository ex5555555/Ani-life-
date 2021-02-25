<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>後臺總管</title>
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
.tools a{
	color:#4a4a4a;
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
.main{
	position: absolute;
	top:50%;
    left: 50%;
    transform: translate(-50%,-50%);
    weight:100%;
    height:100%;
    margin:100px auto 100px auto;
}
.tools{
	color:#4a4a4a;
}
.tools2{
	align-items:center; /* 垂直置中 */
	justify-content:center;  /* 水平置中 */
}
.updatebutton{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
	margin-bottom: 25px;
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
.item{
	display:inline-block;
	padding:30px;
}
.item2{
	display:inline-block;
	padding: 20px;
}
.count{
	margin: 2px;
	margin-top: 10px;
}
.inside{
	margin: 2px;
	margin-top: 10px;
	color: rgb(32, 32, 37);
}
.producttitle{
	font-size:22px;
}
.productlist{
	font-size:18px;
}
.product{
	background-color: rgba(31, 31, 31,50%);
	color:white;
}
.id{
	color:rgb(0 255 243);
}
div.scrollable  /* scrollbar */
{
	width:100%;
	max-height: 150px;
	overflow-y: scroll;
	padding:10px;
}
div::-webkit-scrollbar { 
    display: none; 
}
.img:hover{
	-webkit-filter: opacity(.5) drop-shadow(0 0 0 #5bc0de);
	transition-duration: 0.4s;
}
</style>
</head>



<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>




<div class="main" style="width: 1500px;" align="center">
  
  <div style="width: 1000px; margin-top:50px;" align="center">
    <c:choose>
    
      <c:when test="${eeaccount =='all'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;">員工</h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<a href="goemployee?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-05.png"></img></a>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;">產品</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="bsProductManagement?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-02.png"></img></a>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">地圖</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="gogooglemap?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-03.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">訂單</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="showAllTrading?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-04.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">會員</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="selectAllMember?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-01.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">報表</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="paper?how=1&eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-06.png"></img></a>
		  	</div>
		  </div>
      </c:when>
      
      <c:when test="${eeaccount =='employee'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;">員工</h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<a href="goemployee?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-05.png"></img></a>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-02.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-03.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-04.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-01.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-06.png"></img>
		  	</div>
		  </div>
      </c:when>
      
      <c:when test="${eeaccount =='product'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-05.png"></img>
			</div> 
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;">產品</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="bsProductManagement?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-02.png"></img></a>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-03.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-04.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-01.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">報表</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="paper?how=1&eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-06.png"></img></a>
		  	</div>
		  </div>
      </c:when>
      
      <c:when test="${eeaccount =='member'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-05.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-02.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-03.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-04.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">會員</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="selectAllMember?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-01.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-06.png"></img>
		  	</div>
		  </div>
      </c:when>
      
      <c:when test="${eeaccount =='googlemap'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-05.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-02.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">地圖</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="gogooglemap?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-03.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-04.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-01.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-06.png"></img>
		  	</div>
		  </div>
      </c:when>
      
      <c:when test="${eeaccount =='trading'}">
	      <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
			<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-05.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-02.png"></img>
			</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-03.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;">訂單</h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<a href="showAllTrading?eeaccount=${eeaccount}"><img class ="img" width="200px" height="200px" src="/img/icon-04.png"></img></a>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-01.png"></img>
		  	</div>
		  </div>
		  <div class="tools" style="width: 320px;height: 300px; display:inline-block; margin:auto;">
		  	<h2 style="margin-top: 16px;"></h2>
		  	<div class="tools2" style="margin-top: 10px;">
		  	<img style="opacity: 0.3;" width="200px" height="200px" src="/img/icon-06.png"></img>
		  	</div>
		  </div>
      </c:when>
      
    </c:choose>
	  
  </div>
</div>
<!--  -->
	


<!--  -->	

<!-- container -->					
</body>
</html>