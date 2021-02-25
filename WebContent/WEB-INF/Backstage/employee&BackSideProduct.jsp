<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>員工總管</title>
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
	border-bottom: 2px solid #999;
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
	background-color: rgb(146 146 146 / 20%);
	display:flex;
	align-items:center; /* 垂直置中 */
	justify-content:center;  /* 水平置中 */
	margin:2px;
	color:#4a4a4a;
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
</style>
</head>



<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>


<div class="main" style="width: 1500px;" align="center">

  <div style="width: 1500px; margin-top: 30px; margin-left: 250px;" align="left"><h2>員工</h2></div>
  <div class="tools" style="width: 996px;height: 200px;margin:2;">
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
		    <option value="product">product</option>
		    <option value="forum">forum</option>
		    <option value="employee">employee</option>
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
  
  <div style="width: 1500px; margin-top:100px;" align="left"><h2>產品</h2></div>
  <div class="tools" style="width: 1496px;height: 250px;">
	  <div class="item2">
	    <a href="bsGetAllProduct?eeaccount=${eeaccount}">檢視全部</a>
	  </div>
	  <div class="item2">
	    <a href="statusOpen?status=上架中&eeaccount=${eeaccount}">上架中</a>
	  </div>
	  <div class="item2">
	    <a href="statusClose?status=下架中&eeaccount=${eeaccount}">下架中</a>
	  </div>
	  <div class="item2">
	    <a href="stocknone?stock=0&eeaccount=${eeaccount}">缺貨</a>
	  </div>
	  <div class="item2">
	    <a href="toBsCreateProduct?eeaccount=${eeaccount}">新增產品</a>
	  </div>
	  <div class="item2">
		<form method="post" action="bsSelectSpecies2">
			    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <span>寵物分類</span>
		  <select name="species" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="狗">狗</option>
		    <option value="貓">貓</option>
		  </select>
		</form>
	  </div>
	  <div class="item2">
		<form method="post" action="bsSelectClass2">
		  <span>產品分類</span>
		  	    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <select name="classification" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="飼料">飼料</option>
			<option value="罐頭">罐頭</option>
			<option value="玩具">玩具</option>
			<option value="用品">用品</option>
			<option value="美容護理">美容護理</option>
			<option value="環境清潔">環境清潔</option>
		  </select>
		</form>
	  </div>
	  <div class="item2">
		<form method="post" action="bsSelectBrand2">
			    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <span>品牌分類</span>
		  <select name="brand" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="ROYAL法國皇家">ROYAL 法國皇家</option>
			<option value="BLACKWOOD柏萊富">BLACKWOOD 柏萊富</option>
			<option value="ORIJEN渴望">ORIJEN 渴望</option>
			<option value="Toma-pro優格">Toma-pro 優格</option>
			<option value="Nutram紐頓">Nutram 紐頓</option>
			<option value="Hills希爾思">Hills 希爾思</option>
		  </select>
		</form>
	  </div>
	  <div class="item2">
	    <form method="post" action="bsSelectPrice">
	    	    <input type="hidden" name="eeaccount" value="${eeaccount}">
		  <div>
		  	<div>
		      <span>最低價格</span><input type="text" name="min" placeholder="請輸入價格" value="1000"></input>
		    </div>
		    <div>
		      <span>最高價格</span><input type="text" name="max" placeholder="請輸入價格" value="2000"></input>
		    </div>
		    <button type="submit" style="display:none;">送出</button>
		  </div>
		</form>
	  </div>
  </div>


<!--  -->

	


<!--  -->	
</div>
<!-- container -->					
</body>
</html>