<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Ani-life寵物產品</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
	<script src="${path}/css/javascripts/jquery-3.5.1.min.js"/></script>
    <link rel="stylesheet" href= "https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<script type="text/javascript" src="${path}/css/productPage.js"></script> 
	<link rel="stylesheet" href="${path}/css/productAll.css">
</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
	
	<div class="search">
		 <form action="SelectCondition" method="post"> 
		<input name="productname" id="search-name" type="text" placeholder="尋找商品">
		<input type="submit" id="submit-btn" value="搜尋" >
		<input type="hidden" name="how" value="6"/>
		<input type="hidden" name="condition" value="不用"/>
		<input type="hidden" name="currpage" value="0"/>
		<input type="hidden" name="max" value="0"/>
		<input type="hidden" name="min" value="0"/>
		</form>
	</div>
	
<div class="containerarea">
	<div id="accordion" class="select-area ">
			<div class="card">
				<div class="card-header">
				  <button  onClick="location.href='SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0';" id="button0" name="option" >
				  <a class="card-link" data-toggle="collapse" href="SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0"> 檢視全部</a></button>
				</div>

			  <div class="card-header">
				<a class="card-link" data-toggle="collapse" href="#collapseOne">
				  寵物分類
				</a>
			  </div>
			  <div id="collapseOne" class="collapse" data-parent="#accordion">
				<div class="card-body">
					<form action="selectSpecies" method="post">
						<div class="search-con species">
							<a href="SelectCondition?how=2&currpage=0&condition=狗&max=0&min=0">狗</a> 
				<a href="SelectCondition?how=2&currpage=0&condition=貓&max=0&min=0">貓</a>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			  </div>
			</div>
		  
			<div class="card">
			  <div class="card-header">
				<a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
				  產品分類
				</a>
			  </div>
			  <div id="collapseTwo" class="collapse" data-parent="#accordion">
				<div class="card-body">
					<form action="selectClass" method="post">
						<div class="search-con ctg">
							<a href="SelectCondition?how=3&currpage=0&condition=飼料&max=0&min=0">飼料</a>
							<a href="SelectCondition?how=3&currpage=0&condition=罐頭&max=0&min=0">罐頭</a>
							<a href="SelectCondition?how=3&currpage=0&condition=零食&max=0&min=0">零食</a>
							<a href="SelectCondition?how=3&currpage=0&condition=玩具&max=0&min=0">玩具</a><br>
							<a href="SelectCondition?how=3&currpage=0&condition=寵物保健&max=0&min=0">寵物保健</a>
							<a href="SelectCondition?how=3&currpage=0&condition=美容護理&max=0&min=0">美容護理</a><br>
							<a href="SelectCondition?how=3&currpage=0&condition=環境清潔&max=0&min=0">環境清潔</a>
						</div>
				 		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			  </div>
			</div>
		  
			<div class="card">
			  <div class="card-header">
				<a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
				  品牌查詢
				</a>
			  </div>
			  <div id="collapseThree" class="collapse" data-parent="#accordion">
				<div class="card-body selectBrand">
					<form action="selectBrand" method="post">
						<div class="search-con brand">
							<div class="selec-title"><i class="fa fa-apple"></i>主食(飼料、罐頭)</div>
							<a href="SelectCondition?how=4&currpage=0&condition=ROYAL法國皇家&max=0&min=0">ROYAL法國皇家</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=Hills希爾思&max=0&min=0">Hills希爾思</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=ORIJEN渴望&max=0&min=0">ORIJEN渴望</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=BLACKWOOD柏萊富&max=0&min=0">BLACKWOOD柏萊富</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=Toma-pro優格&max=0&min=0">Toma-pro優格</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=Nutram紐頓&max=0&min=0">Nutram紐頓</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=其他主食&max=0&min=0">其他</a>
							
							<div class="selec-title"><i class="fa fa-delicious"></i>零食</div>
							<a href="SelectCondition?how=4&currpage=0&condition=Chiken奇啃&max=0&min=0">Chiken奇啃</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=DoggyMan&max=0&min=0">DoggyMan</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=飼糧倉&max=0&min=0">飼糧倉</a>
							<a href="SelectCondition?how=4&currpage=0&condition=A-Bones&max=0&min=0">A-Bones</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=cookie mam&max=0&min=0">cookie mam</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=CIAO&max=0&min=0">CIAO</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=其它零食&max=0&min=0">其他</a>
							
							<div class="selec-title"><i class="fa fa-gift"></i>玩具</div>
							<a href="SelectCondition?how=4&currpage=0&condition=其他玩具&max=0&min=0">玩具</a>
							
							<div class="selec-title"><i class="fa fa-bath"></i>美容護理</div>
							<a href="SelectCondition?how=4&currpage=0&condition=URBANER奧本電剪&max=0&min=0">URBANER奧本電剪</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=MAOUP毛起來&max=0&min=0">MAOUP毛起來</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=黃金盾&max=0&min=0">黃金盾</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=其它美容&max=0&min=0">其它</a><br>
							
							<div class="selec-title"><i class="fa fa-shower"></i>環境清潔</div>
							<a href="SelectCondition?how=4&currpage=0&condition=ODOUT臭味滾&max=0&min=0">ODOUT臭味滾</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=木酢達人&max=0&min=0">木酢達人</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=其它清潔&max=0&min=0">其他</a>
							
							<div class="selec-title"><i class="fa fa-heart"></i>寵物保健</div>
							<a href="SelectCondition?how=4&currpage=0&condition=ANIBIO德國家醫&max=0&min=0">ANIBIO德國家醫</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=美國貝克&max=0&min=0">美國貝克</a><br>
							<a href="SelectCondition?how=4&currpage=0&condition=其它保健&max=0&min=0">其他</a>
							
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				</div>
			  </div>
			</div>

			<div class="card">
				<div class="card-header">
				  <a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
					價格範圍
				  </a>
				</div>
				<div id="collapseFour" class="collapse" data-parent="#accordion">
				  <div class="card-body">
					<form action="SelectCondition" method="get">
						<div class="search-con price">
							<label for="min">最低價格:</label>
							<input type="text" name="min" id="min" class="searchbox" value="1000"> 
							<label for="max">最高價格:</label>
							<input type="text" name="max" id="max" class="searchbox" value="2000">
							<input type="hidden" name="currpage"	value="0">
							<input type="hidden" name="how"	value="5">
							<input type="hidden" name="condition"	value="不用">
							<button id="button5" type="submit">
								送出
							</button>
						</div>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					</form>
				  </div>
				</div>
			  </div>
		  
		  </div>
		

		
			<div class="product">
				<div class="title"></div>
			<p class="count">共 ${count}筆資料</p>
			<div class="product-con">
			<c:forEach var="product" items="${productList }">
			
				<div class="product-box">
					<div class="img-box">
						<c:if test="${product.img!=null}">
						<img src="/img/${product.img}" alt="">
						</c:if>
					</div>
					<p class="productname">${product.productName }</p>
					<p class="price">$ ${product.price }</p>
					<div class="btn-con">
					<c:if test="${product.stock!=0 }">
					<button class="add2Cart" type="button"
						id="${product.productID}">加入購物車</button>
					</c:if>
					<a href="getProductDetail?id=${product.productID}&status=check&recordid=0"><button>查看商品</button></a>
					</div>
				</div>
				
			</c:forEach>
			</div>
			<div class="page-num">
			<c:if test="${totalpage<=10 && totalpage>1}">
														<ul class="pagination">
															<li class="page-item"><a class="page-link"
																href="SelectCondition?how=${how}&currpage=0&condition=${condition}&max=${max}&min=${min}&productname=${productname}">&laquo;</a></li>
															<c:forEach begin="1" end="${totalpage}" var="page">
																<c:if test="${page==currpage+1}">
																	<li class="page-item active" class="page-item"><a
																		class="page-link"
																		href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																</c:if>
																<c:if test="${page!=currpage+1}">
																	<li class="page-item " class="page-item"><a
																		class="page-link"
																		href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																</c:if>
															</c:forEach>
															<li class="page-item"><a class="page-link"
																href="SelectCondition?how=${how}&currpage=${totalpage-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">&raquo;</a></li>
														</ul>
													</c:if>

													<c:if test="${totalpage>10}">
																<ul class="pagination">
																	<li class="page-item"><a class="page-link"
																		href="SelectCondition?how=${how}&currpage=0&condition=${condition}&max=${max}&min=${min}&productname=${productname}">&laquo;</a></li>
																	<c:if test="${currpage<5}">
																		<c:forEach begin="1" end="10" var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																		</c:forEach>
																	</c:if>
																	<c:if test="${ totalpage-currpage>=5}">
																		<c:forEach begin="${currpage-5}" end="${currpage+5}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>

																	<c:if test="${totalpage-currpage<5}">
																		<c:forEach begin="${currpage-4}" end="${totalpage}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="SelectCondition?how=${how}&currpage=${page-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>																	
																	<li class="page-item"><a class="page-link"
																href="SelectCondition?how=${how}&currpage=${totalpage-1}&condition=${condition}&max=${max}&min=${min}&productname=${productname}">&raquo;</a></li>
														</ul>
														
															</c:if>
															
														
			
			
	
	</div>
	</div>
	</div>
	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>