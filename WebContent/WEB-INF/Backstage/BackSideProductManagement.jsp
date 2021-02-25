<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>產品總管</title>
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
#tools a{
	color:#4a4a4a;
	border: none;
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
  	color: #383838;
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
	padding: 20px;
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
</style>
</head>
<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>


<div class="main" style="width: 1500px;">
  <div id="tools" style="width: 1496px; height:100px;" align="left">
	  <div class="item">
	    <a href="bsGetAllProduct?eeaccount=${eeaccount}">檢視全部</a>
	  </div>
	  <div class="item">
	    <a href="statusOpen?status=上架中&eeaccount=${eeaccount}">上架中</a>
	  </div>
	  <div class="item">
	    <a href="statusClose?status=下架中&eeaccount=${eeaccount}">下架中</a>
	  </div>
	  <div class="item">
	    <a href="stocknone?stock=0&eeaccount=${eeaccount}">缺貨</a>
	  </div>
	  <div class="item">
	    <a href="toBsCreateProduct?eeaccount=${eeaccount}">新增產品</a>
	  </div>
	  <div class="item">
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
	  <div class="item">
		<form method="post" action="bsSelectClass2">
		<input type="hidden" name="eeaccount" value="${eeaccount}">
		  <span>產品分類</span>
		  <select name="classification" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="飼料">飼料</option>
			<option value="罐頭">罐頭</option>
			<option value="玩具">玩具</option>
			<option value="寵物用品">寵物用品</option>
			<option value="美容護理">美容護理</option>
			<option value="環境清潔">環境清潔</option>
		  </select>
		</form>
	  </div>
	  <div class="item">
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
	  <div class="item">
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
  <!-- tools -->




		<%-- 全部產品TABLE --%>
		<c:choose>
			<c:when test="${selected == 'bsAll' or empty selected}">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID}&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			
			<c:when test="${selected == 'bsselectStatus' or selected == 'open' or selected == 'close'  or selected == 'none'}">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			
			
			
			<%--  產品種類TABLE--%>
			<c:when test="${selected == 'bsSelectClass' }">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>

			<%-- 品牌TABLE--%>
			<c:when test="${selected == 'bsSelectBrand' }">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>

			<%-- 物種TABLE--%>
			<c:when test="${selected == 'bsSelectSpecies'}">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>


			<c:when test="${selected == 'bsLimitPrice'}">
				<p class="count">共 ${bscount}筆資料</p>
				<div class="inside" style="width: 1496px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">狀態</th>
								<th scope="col" width="5%" style="text-align:center;">ID</th>
								<th scope="col" width="15%"style="text-align:center;">名稱</th>
								<th scope="col" width="4%" style="text-align:center;">寵物</th>
								<th scope="col" width="6%" style="text-align:center;">類型</th>
								<th scope="col" width="4%" style="text-align:center;">價格</th>
								<th scope="col" width="4%" style="text-align:center;">庫存</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="30%"style="text-align:center;">說明</th>
								<th scope="col" width="5%" style="text-align:center;">圖示</th>
								<th scope="col" width="5%" style="text-align:center;"></tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${bsproductList }">
								<tr class="product" style="line-height:25px;" height="250px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									<td class="id" style="text-align:center;">${product1.productID }</td>
									<td class="name">
									  <div class="scrollable">${product1.productName }</div>
									</td>
									<td class="species" style="text-align:center;">${product1.species }</td>
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">${product1.price }</td>
									<td class="stock" style="text-align:center;">${product1.stock }</td>
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td class="descripton">
									  <div class="scrollable">${product1.descripton}</div>
									</td>
									<c:if test="${product1.img!=null}">
										<td><img src="/img/${product1.img}" height="200"	width="200"></td> 
									</c:if>
									<td style="text-align:center; padding: 10px;">
									<input class="updatebutton" type="button" value="更新" onclick="location.href='toBsUpdateProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									<input class="deletebutton" type="button" value="刪除" onclick="location.href='bsDelProduct?id=${product1.productID }&eeaccount=${eeaccount}'"></input>
									</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			
			
			
		</c:choose>
		

  <div style="width: 1496px; height:100px;" align="left">

<!-- main -->
</div>

	

</body>
</html>