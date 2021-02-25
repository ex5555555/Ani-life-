<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>地圖新增</title>
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
.inside{
	margin: 2px;
	margin-top: 50px;
	background-color: rgb(239 239 239 / 50%);
	font-size:18px;
	color:#585858;
}
h2{
	color: #cccccc;
	font-size:36px;
	padding-top: 15px;
}
.addgooglemap{
	/* padding-bottom:15px; */
	padding: 5px;
}
.textarea{
	float:right;
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
  
  <!-- 新增地圖 -->
  <div class="inside" style="width: 996px;  height: 640px;" align="center">
	<h2>新增地圖</h2>
	<hr style ="border：2px;">
	
	<div class="addgooglemap" style="width: 300px; height:auto;" align="left">
	<form action="addgooglemap" method="post" enctype="multipart/form-data">
		 <input type="hidden" name="eeaccount" value="${eeaccount}">
		<div>
		<span style="margin-right: 30px;">醫院</span>
		<input type="text" name="mapname" id="mapname"
			placeholder="mapname" class="insertbox" autocomplete="off" required>
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">電話</span>
		<input type="text" name="tel" id="tel" placeholder="tel"
			class="insertbox" autocomplete="off" required>
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">地址</span>
		<input type="text" name="dress" id="dress" placeholder="dress" 
			class="insertbox" autocomplete="off" required>
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">緯度</span>
		<input type="text" name="lat" id="lat" placeholder="lat" 
			class="insertbox" autocomplete="off" required>
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">經度</span>
		<input type="text" name="lng" id="lng" placeholder="lng" 
			class="insertbox" autocomplete="off" required>
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">縣市</span>
		<select name="city" style="width: 191px;">
			<option disabled="true">請選擇</option>
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
		</div>
		<br>
		
		<div>
		<span style="margin-right: 30px;">急診</span>
		<select name="er" style="width: 191px;">
			<option disabled="true">請選擇</option>
			<option value="y">有</option>
			<option value="n">無</option>
		</select> 
		</div>
		<br>
		
		<div>
		<span style="margin-right: 0px;">24h營業</span>
		<select name="h24" style="width: 191px;">
			<option disabled="true">請選擇</option>
			<option value="y">有</option>
			<option value="n">無</option>
		</select>
		</div>
		<br>
		
		<div style="float: left; width: 100px; height:auto;">
		  <input class="updatebutton" type="submit" value="新增地圖">
		</div>
		
		<div style="float:left; width: 100px; height:auto;">
		  <input class="deletebutton" type="button" value="回地圖頁" onclick="location.href='gogooglemap?eeaccount=${eeaccount}'"></input>
		</div>
		
		</div>
	</form>
		<!-- <input type="button" onclick="history.back()" value="回到上一頁"></input> -->
		
		
	</div>
  </div>


<!-- container -->	
</div>
<!-- container -->	
  

</body>
</html>