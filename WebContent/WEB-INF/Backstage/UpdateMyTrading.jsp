<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>訂單更新</title>
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
	font-weight: bold;
    color: #868e96;
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
.updatetrading{
	/* padding-bottom:15px; */
	padding: 5px;
}
.textarea{
	float:right;
}
.confirm[type=text]{
	box-sizing: border-box;
  	border: none;
  	border-bottom: 2px solid #337ab7;
  	background-color:rgba(31, 31, 31, 0%);
  	color: #2e6da4;
}
.confirm[type=text]:focus{
	background-color:rgba(31, 31, 31, 0%);
	color: #2e6da4;
	outline:none;
}
.id{
	color:rgb(3 93 88);
	font-weight:bold;
}
.id2[type=text]{
	color:rgb(3 93 88);
	font-weight:bold;
	border: none;
}
.id2[type=text]:focus{
	color:rgb(3 93 88);
	font-weight:bold;
	border: none;
}
</style>
</head>

<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>

<div class="main" style="width: 1300px;">
  
  <div class="inside" style="width: 1296px;height: auto;" align="center">
    <h2>更新訂單</h2>
	<hr style ="border：2px;">
	
	<div class="updatetrading" style="width: 340px; height: 540px;" align="left">
		<form action="updateTrading" method="post">
		  <input type="hidden" name="eeaccount" value="${eeaccount}">
		<div>
		  <label class="id" style="margin-right: 13px;">訂單編號</label>
		  <input class="id2" type="text" name="id" value="${trecord.id }" readonly/>
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">會員帳號</label>
		  <input class="confirm" type="text" name="account" value="${trecord.member.account }" disabled="disabled">
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">訂單狀態</label>
		  <select name="status">
				<option value="${trecord.status }"  selected>${trecord.status }</option>
				<option value="已付款">已付款</option>
				<option value="處理中">處理中</option>
				<option value="已出貨">已出貨</option>
				<option value="訂單完成">訂單完成</option>
				<option value="訂單成立">訂單成立</option>
		  </select>
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">下單日期</label>
		  <input class="confirm" type="text" name="date" value="${trecord.date }" disabled="disabled">
		  <label style="margin-right: 13px; margin-top: 10px;">訂單金額</label>
		  <input class="confirm" type="text" name="total" value="${trecord.total }" disabled="disabled">
		</div>
		<div>
		  <label style="margin-right: 31px; margin-top: 10px;">收件人</label>
		  <input type="text" name="recipient" value="${trecord.recipient }">
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">聯絡電話</label>
		  <input type="text" name="tel" value="${trecord.tel }">
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">聯絡信箱</label>
		  <input type="text" name="email" value="${trecord.email }">
		</div>
		<div>
		  <label style="margin-right: 13px; margin-top: 10px;">收件地址</label>
		  <input type="text" name="address" value="${trecord.address }">
		</div>
		
		
		<div style="margin-top: 20px; float: left; width: 100px; height:auto;">
		  <input class="updatebutton" type="submit" value="儲存更新">
		</div>
		</form>
		<div style="margin-top: 20px; float: left; width: 100px; height:auto;">
		  <a href="showAllTradingOrderByDate?eeaccount=${eeaccount}"><button class="deletebutton">取消更新</button></a>
		</div>
	</div>
  </div>
  
  
  <div class="inside" style="width: 1296px; height:auto;">
  		<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
			<thead>
				<tr>
					<th class="id" style="text-align:center;">產品編號</th>
					<th style="text-align:center;">產品名稱</th>
					<th style="text-align:center;">購買數量</th>
					<th style="text-align:center;">產品單價</th>
					<th style="text-align:center;">評分</th>
					<th style="text-align:center;">評價</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="detail" items="${tradingDetail}">
					<tr>
						<td style="text-align:center;"><input class="id" style="width: 150px; border: none; text-align:center;" name="productid" value="${detail.productid }" disabled="disabled"/></td>
						<td style="text-align:center;"><input style="width: 515px; border: none; text-align:center;" name="productname" value="${detail.productname }" disabled="disabled"/></td>
						<td style="text-align:center;"><input style="width: 100px; border: none; text-align:center;" name="qty" value="${detail.qty }" disabled="disabled"/></td>
						<td style="text-align:center;"><input style="width: 100px; border: none; text-align:center;" name="price" value="${detail.price }" disabled="disabled"/></td>
						<td style="text-align:center;"><input style="width: 100px; border: none; text-align:center;" name="grade" value="${detail.grade }"  disabled="disabled"/></td>
						<td style="text-align:center;"><input style="width: 319px; border: none; text-align:center;" name="gradecontent" value="${detail.gradecontent }"  disabled="disabled"/></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
  </div>
  
  <div class="" style="width: 1296px; height: 100px;" align="center"></div>

</div>
</body>
</html>