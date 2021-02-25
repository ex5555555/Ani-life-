	<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ani-life</title>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path}/css/javascripts/jquery-3.5.1.min.js" /></script>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>







<link href="<c:url value="/css/home.css"/>" rel="stylesheet">
</head>
<script>
	$(function() {
		$('header').hide();

		$(window).scroll(function() {
			var height = $(window).scrollTop();
			if (height > 0) {
				$('header').show();
				$('header').addClass('sticky')
			} else {
				$('header').removeClass('sticky');
				$('header').hide();
			}
		})

		$('.slider').slick({
			arrows : false,
			dots : true,
			centerMode : true,
			centerPadding : 0,
			slidesToShow : 4,
			slidesToScroll : 3,
			autoplaySpeed : 2000,
			responsive : [ {
				breakpoint : 1300,
				settings : {
					arrows : true,
					centerMode : true,
					centerPadding : 0,
					slidesToShow : 3
				}
			}, {
				breakpoint : 910,
				settings : {
					arrows : true,
					centerMode : true,
					centerPadding : 0,
					slidesToShow : 2
				}
			}, {
				breakpoint : 850,
				settings : {
					arrows : true,
					centerMode : true,
					centerPadding : 0,
					slidesToShow : 2
				}
			}, {
				breakpoint : 680,
				settings : {
					arrows : true,
					centerMode : true,
					centerPadding : 0,
					slidesToShow : 1
				}
			} ]
		})



	
			



		
			

	})
</script>
</head>
<body>

	<header>
 <% 
String account=SecurityContextHolder.getContext().getAuthentication().getName();
boolean status= false;
if(account.equals("qwerty")){
	status=false;
}else{
	status=true;
}
%>


		<a href="#" class="logo">Ani-life</a>
		<ul class="navigation">
            
			<%
			if ("anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
			%>
			
			<a href="perform_login"><li>登入 </li></a>
			<a href="${path}/register.jsp"><li>註冊</li></a>
         <%--  
			<a href="perform_login"><li>登入 <c:url
						value="/perform_logoin" var="logoutUrl" />
					<form method="post" action="${logoutUrl}">
						<input type="hidden" value="Login" type="submit"> <input
							type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
			</li></a>
			<a href="${path}/register.jsp"><li>註冊</li></a> --%>
			<%
			}
			%>

			<%
			if (!"anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
			%>
			<a class="nav-link active" aria-current="page" href="select_member"><li>我的帳號</li></a>
			 <c:url value="/perform_logout" var="logoutUrl" />
				<form method="post" action="${logoutUrl}">
					<div class="nav-link active" aria-current="page">
					<input value="登出" type="submit" class="logout">
					</div>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>


			<%
			}
			%>


		</ul>
	</header>
	<section class="banner" id="banner"
		style="background-image: url('/img/thum.jpg');">
		<div class="content">
			<div class="header-imgcontainer">
               	<img alt="" src="/img/ani-lifewhite.png">
             </div>
			<h2>Always by Your Side.</h2>
			
			<a class="btn-action" href="goforum?currpage=0"><button class="btn">
					前往討論版<i class="fa fa-angle-double-right"></i>
				</button></a><br> <a class="btn-action" href="SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0"><button
					class="btn">
					寵物用品<i class="fa fa-angle-double-right"></i>
				</button></a><br> <a class="btn-action" href="gomap?currpage=0"><button class="btn">
					地圖查詢<i class="fa fa-angle-double-right"></i>
				</button></a><br>
				<c:choose>
				<c:when test="<%=status%>">
				<a target="_new" class="btn-action" href="gowebscoket"><button class="btn">
					客服/聊天<i class="fa fa-angle-double-right"></i>
				</button></a>
				<br>
				</c:when>
				<c:otherwise>
				<a target="_new" class="btn-action" href="goBSwebscoket?eeaccount=all"><button class="btn">
					後台客服<i class="fa fa-angle-double-right"></i>
				</button></a>
				<br>
				</c:otherwise>
				</c:choose>
				
				
			<%
			if ("anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
			%>
			
			<a class="btn-action" href="perform_login">		<!-- perform_login  /  login.jsp-->
				<button class="btn" id="login">登入/註冊<i class="fa fa-angle-double-right"></i>
				</button>
			</a>
	
			<%
			} else {
			%>
			
			<c:url value="/perform_logout" var="logoutUrl" />
			<form method="post" action="${logoutUrl}">
				<button class="btn" id="login" type="submit">登出<i class="fa fa-angle-double-right"></i></button>	
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</form>
		

			<%
			}
			%>
		</div>
	</section>

	<%-- 	<%=  SecurityContextHolder.getContext().getAuthentication().getName() %> --%>




	<div class="discuss-area">
		<h2 class="title">熱門討論</h2>
		<div>
			<ul class="articleList">			
				<a href="goforumdetail?forumid=${hotforum0.copyfdid}">
					<li>
						<div class="eachArticle">
							<h3 class="artTitle">${hottitle0}</h3>
							<p>${hotforum0.content}</p>
							<small>${hotforum0.date}</small>
						</div>
				</li>
				</a>				
				<a href="goforumdetail?forumid=${hotforum1.copyfdid}">
					<li>
						<div class="eachArticle">
							<h3 class="artTitle">${hottitle1}</h3>
							<p>${hotforum1.content}</p>
							<small>${hotforum1.date}</small>
						</div>
				</li>
				</a>
				<a href="goforumdetail?forumid=${hotforum2.copyfdid}">
					<li>
						<div class="eachArticle">
							<h3 class="artTitle">${hottitle2}</h3>
							<p>${hotforum2.content}</p>
							<small>${hotforum2.date}</small>
						</div>
				</li>
				</a>
				<a href="goforumdetail?forumid=${hotforum3.copyfdid}">
					<li>
						<div class="eachArticle">
							<h3 class="artTitle">${hottitle3}</h3>
							<p>${hotforum3.content}</p>
							<small>${hotforum3.date}</small>
						</div>
				</li>
				</a>
				<a href="goforumdetail?forumid=${hotforum4.copyfdid}">
					<li>
						<div class="eachArticle">
							<h3 class="artTitle">${hottitle4}</h3>
							<p>${hotforum4.content}</p>
							<small>${hotforum4.date}</small>
						</div>
				</li>
				</a>	
			</ul>
		</div>
		<div class="gotochat">
			<a href="goforum?currpage=0"><button>查看更多</button></a>
		</div>
	</div>
	<!-- 商品 -->
	<div class="product-area">
		<h2 class="title">熱銷商品</h2>

		<div class="product-p1 product-page slider">
			<c:forEach var="product" items="${productlist }">
			<a href="getProductDetail?id=${product.productID}&status=none&recordid=0">
				<div class="eachproduct">
					<div class="pimg-container">
					<c:if test="${product.img!=null}">
						<img src="/img/${product.img}" alt="">
					</c:if>
					</div>
					<p>${product.productName }</p>
				</div>
			</a>
		</c:forEach>
		</div>


		<div class="gotoShop">
			<a href="getAllProduct"><button>去購物</button></a>
		</div>
	</div>

	<!-- 地圖查詢 -->
	<div class="map-area">
		<div class="map-title" style="background-image: url('/img/map.jpg');">
		<div class="all-info">
				<h2>地圖查詢<i class="fa fa-hospital-o"></i></h2>
				
				<div class="content">
					<p>提供全台多間動物醫院地址和路線規劃，及時滿足您的需求!</p>
					<div class="gobtn">
						<a href="gomap?currpage=0"><button id="hbtn">前往查詢</button></a>
					</div>
				</div>
			</div>

		</div>
		</div>

	</div>

<jsp:include page="footer.jsp"></jsp:include>


</body>
</html>