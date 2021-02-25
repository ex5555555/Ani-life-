<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>地圖總管</title>
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
	border: none;
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
	padding: 15px;
}
.id {
    color: rgb(3 93 88);
    font-weight: bold;
}
#googlemapmenu{
	margin:50px auto 50px auto;
	font-size: 20px;
	color:#585858;
}
.outgooglemap{
	background-color: rgb(239 239 239 / 50%);
	margin: 2px 25px 25px 25px;
}
.outgooglemap:hover{
	background-color: #ddd;
	transition-duration: 0.4s;
}
#googlemap{
	padding:10px;
/* 	display:flex;
	align-items:center; /* 垂直置中 */ */
}
.emspan{
	width:70px;
	margin:0;
}
.emspan2{
	margin-right:2.5px;
}
.text{
	width:calc(100% - 70px);
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
	    <a href="gogooglemap?eeaccount=${eeaccount}">全部</a>
	  </div>
	  <div class="item">
	    <a href="toaddgooglemapjsp?eeaccount=${eeaccount}">新增</a>
	  </div>
	  <div class="item">
		<form method="post" action="selectgooglemapcity">
		  <span>縣市查詢</span>
		    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <select name="city" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="基隆市">基隆市</option>
			<option value="台北市">台北市</option>
			<option value="新北市">新北市</option>
			<option value="桃園市">桃園市</option>
			<option value="新竹市">新竹市</option>
			<option value="新竹縣">新竹縣</option>
			<option value="苗栗縣">苗栗縣</option>
			<option value="台中市">台中市</option>
			<option value="彰化縣">彰化縣</option>
			<option value="南投縣">南投縣</option>
			<option value="雲林縣">雲林縣</option>
			<option value="嘉義市">嘉義市</option>
			<option value="嘉義縣">嘉義縣</option>
			<option value="台南市">台南市</option>
			<option value="高雄市">高雄市</option>
			<option value="屏東縣">屏東縣</option>
			<option value="宜蘭縣">宜蘭縣</option>
			<option value="花蓮縣">花蓮縣</option>
			<option value="台東縣">台東縣</option>
		  </select>
		</form>
	  </div>
	  <div class="item">
		<form method="post" action="selectgooglemaper">
		  <span>急診查詢</span>
		    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <select name="er" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="y">有</option>
			<option value="n">無</option>
		  </select>
		</form>
	  </div>
	  <div class="item">
		<form method="post" action="selectgooglemaph24">
		  <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <span>24h營業查詢</span>
		  <select name="h24" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="y">有</option>
			<option value="n">無</option>
		  </select>
		</form>
	  </div>
	  <div class="item">
	    <form method="post" action="selectgooglemapid">
	      <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <div>
		    <span style="margin-right: 5px;">編號查詢</span><input type="text" name="id" placeholder="請輸入編號" required></input>
		  </div>
		</form>
	  </div>
  </div>


<!--  -->
  <div id="googlemapmenu" class="" align="center">
    <c:forEach var="googlemap" items="${goolemapList}">
	  <div class="outgooglemap" style="width: 900px; height: 400px;" align="center">
		<div id="googlemap" style="width: 550px; height:100%;" align="left">
		<table cellpadding="2" class="my-2">
		  <thread>
			<tr>
			  <th class="id">地圖編號  ${googlemap.id}</th>
			</tr>
		  </thread>
		  <tbody>
		  	<tr>
		  	  <td>醫院</td>
		  	  <td class="mapname">${googlemap.mapname}</td>
		  	</tr>
		  	<tr>
		  	  <td>電話</td>
		  	  <td class="tel">${googlemap.tel}</td>
		  	</tr>
		  	<tr>
		  	  <td>地址</td>
		  	  <td class="dress">${googlemap.dress}</td>
		  	</tr>
		  	<tr>
		  	  <td>緯度</td>
		  	  <td class="lat">${googlemap.lat}</td>
		  	</tr>
		  	<tr>
		  	  <td>經度</td>
		  	  <td class="lng">${googlemap.lng}</td>
		  	</tr>
		  	<tr>
		  	  <td>縣市</td>
		  	  <td class="city">${googlemap.city}</td>
		  	</tr>
		  	<tr>
		  	  <td>急診</td>
		  	  <td class="er">${googlemap.er}</td>
		  	</tr>
		  	<tr>
		  	  <td>24h營業</td>
		  	  <td class="h24">${googlemap.h24}</td>
		  	</tr>
		  	<tr>
		  	  <td>
		  	  	<input class="updatebutton" type="button" value="更新" onclick="location.href='toupdategooglemapjsp?id=${googlemap.id}&eeaccount=${eeaccount}'"></input>
		  	  	<input class="deletebutton" type="button" value="刪除" onclick="location.href='deletegooglemap?id=${googlemap.id}&eeaccount=${eeaccount}'"></input>	  	  	
		  	  </td>
	  	    </tr>
		  </tbody>
		</table>
		</div>
	  </div>
	</c:forEach>
  </div>
  
  
  <div style="width: 900px; height: 100px;" align="center">


<!--  -->	
</div>


<!-- container -->					
</body>
</html>