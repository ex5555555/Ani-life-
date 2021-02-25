<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單總管</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
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
<style type="text/css">
html{
	height:100%;
	/* background: linear-gradient(45deg,  rgba(145,155,155,1) 0%, rgba(43,53,53,1) 100%) no-repeat fixed; */
}
#tools2 a{
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
#tools{
	background-color: rgb(146 146 146 / 20%);
	/* display:flex; */
	/* align-items:center; */ /* 垂直置中 */
	/* justify-content:center; */  /* 水平置中 */
	margin:2px;
	color:#4a4a4a;
}
#tools2{
	display:flex;
	align-items:center; /* 垂直置中 */
	justify-content:center; /* 水平置中 */
}
.toolbutton{
	background-color:#868e96;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
.toolbutton:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
.toolbutton2{
	background-color:#868e96;
	transition-duration: 0.4s;
	border:none;
	border-radius: 20px;
    padding: 5px 15px;
	color:#eee;
}
.toolbutton2:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
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
.item{
	display:inline-block;
	padding-left: 20px;
	padding-top: 12px;
}
.count{
	margin: 2px;
	margin-top: 10px;
	color: #585858;
}
.inside{
	margin: 2px;
	margin-top: 10px;
	color:#585858;
}
.producttitle{
	font-size:22px;
}
.productlist{
	font-size:18px;
}
.product{
	background-color: rgb(239 239 239 / 50%);
	color:#585858;
}
.product:hover{
	background-color: #ddd;
	transition-duration: 0.4s;
}
.id{
	color:rgb(3 93 88);
	font-weight:bold;
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
.title{
    color: #868e96;
}
.id{
	color:rgb(3 93 88);
	font-weight:bold;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>

<div class="main" style="width: 1300px;">
  <div id="tools" style="width: 1296px;height: 270px;" align="left">
	<div id="tools2" class="search-area" style="width: 1296px;height:200px;" align="left">
	<form action="searchTradingRecord" method="post">
	  <input type="hidden" name="eeaccount" value="${eeaccount}">
	  <div class="item">
		<label style="margin-right: 16px;">訂單編號</label>
		<input type="text" name="id">
	  </div>
	  <div class="item">
		<label>訂單狀態</label>
		<select name="status">
			<option value=""  selected>請選擇</option>
			<option value="已付款">已付款</option>
			<option value="處理中">處理中</option>
			<option value="已出貨">已出貨</option>
			<option value="訂單完成">訂單完成</option>
			<option value="訂單成立">訂單成立</option>
		</select>
	  </div>
	  <div class="item" style="margin-left: 10px;">	
		<label>會員帳號</label>
		<input name="account" type="text">
	  </div>
	  <div class="item">
		<label>收件人</label>
		<input name="recipient" type="text">
	  </div>
	  <div class="item">
		<label>聯絡電話</label>
		<input name="tel" type="text">
	  </div>
	  <div class="item">
		<label>收件人信箱</label>
		<input name="email" type="text">
	  </div>
	  <div class="item">
		<label>收件地址</label>
		<input name="address" type="text">
	  </div>
	  <div class="item">
		<label>訂單金額</label>
		<label class="title">最小金額:</label><input name="min" type="text" value="0" style="margin-left: 3px;">
		<label class="title" style="margin-left: 10px;">最大金額:</label><input name="max" type="text" style="margin-left: 3px;">
	  </div>
	  <div class="item">
		<label>日期</label>
		<label class="title">開始:</label><input type="date"  name="beginDate" style="margin-left: 9px;"/>
		<label class="title" style="margin-left: 40px;">結束:</label><input type="date"  name="endDate" style="margin-left: 31px;"/>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	  </div>
		<input class="toolbutton" type="submit" value="搜尋" style="margin-left: 40px;"/>
	</form>
	
	</div class="item">
	<div style="width: 1296px;height:70px; padding-left: 20px; padding-top: 12px;" align="left">
	  <a href="showAllTrading?eeaccount=${eeaccount}"><button class="toolbutton2">依編號排序</button></a>
	  <a href="showAllTradingOrderByDate?eeaccount=${eeaccount}"><button class="toolbutton2">依日期排序</button></a>
	  <a href="showAllTradingOrderByTotal?eeaccount=${eeaccount}"><button class="toolbutton2">依價格排序</button></a>
	</div>
  </div>
  
  
	<div class="tradingRecord">
	  <div class="inside" style="width: 1296px; height:auto;">
		<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
			<thead class="producttitle">
				<tr>
					<th scope="col" width="5%" style="text-align:center;" class="id">訂單編號</th>
					<th scope="col" width="5%" style="text-align:center;">會員帳號</th>
					<th scope="col" width="5%" style="text-align:center;">訂單金額</th>
					<th scope="col" width="5%" style="text-align:center;">訂單狀態</th>
					<th scope="col" width="5%" style="text-align:center;">下單日期</th>
					<th scope="col" width="5%" style="text-align:center;">操作</th>
				</tr>
			</thead>
			<tbody class="productlist">
				<c:forEach var="record" items="${recordList}">
					<tr class="product" style="line-height:25px;" height="50px">
						<td style="text-align:center;" class="id">${record.id }</td>
						<td style="text-align:center;">${record.member.account }</td>
						<td style="text-align:center;">${record.total }</td>
						<td style="text-align:center;">${record.status }</td>
						<td style="text-align:center;"><fmt:formatDate value="${record.date }" pattern="yyyy-MM-dd"/></td>
						<td style="text-align:center;">
							<a href="delTradingRecord?orderid=${record.id }&eeaccount=${eeaccount}"><button class="deletebutton">刪除</button></a>
							<a href="showTradingRecordnDetail?orderid=${record.id }&eeaccount=${eeaccount}"><button class="updatebutton">訂單詳情/更改</button></a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	  </div>
	</div>
	
	<div class="" style="width: 1296px; height: 100px;" align="center"></div>


</div>
</body>
</html>