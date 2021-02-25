<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${product.productName}</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="${path}/css/productDetail.js"></script>
<link rel="stylesheet" href="${path}/css/productDetail.css">

<style>
     @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap');
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }
    ul{
        list-style: none;
    }
	a:hover{
		text-decoration: none;
		color:white;
	}
    header{
        z-index: 2;
        width: 100%;
        height: 110px;
        padding: 25px 100px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: 0.5s;
        box-sizing: border-box;
        background-color: rgb(248, 248, 248);
       
    }
    header.sticky{
        position: fixed;
        top: 0;
        left:0 ;
        background-color: white;
        padding: 10px 100px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        box-sizing: border-box;
    }

    header .logo{
        color: rgb(20, 20, 20);
        font-weight: 700;
        font-size: 2em;
    }
    header.sticky .logo{
        color: black !important;
    }

    header .menu-bar{
        width: 50%;
        float: right;
        box-sizing: border-box;
        
    }

    header .menu-bar ul{
        display: inline-flex;
        float: right;
        margin:auto 5px;
    }
    .menu-bar ul li{
        border-left: 1px solid #fff;
        padding: 15px 20px;
        text-align: center;
        cursor: pointer;
        min-width: 90px;
        position: relative;
    }

    .menu-bar ul li:hover{
        color: rgb(71, 189, 91) ;
    }
    .menu-bar ul #cart-con:hover{
        background-color: rgba(71, 189, 91, 0);
        color:tomato;
    }

    .menu-bar ul li i{
        font-size: 25px;
        margin-right: 5px;
    }
    .menu-bar ul li ul{
        position: absolute;
        left: 0;
        display: block;
        margin-top: 18px;
        width: 200px;
        padding: 0;
        background-color: rgb(71, 189, 91);
    }
    .menu-bar ul li ul li{
        text-align: left;
        border: none;
        border-bottom: white 1px solid;
        font-weight: 550;
    }
    .menu-bar ul li ul li:hover{
        background-color: rgb(209, 102, 53);
        color: white;
    }
    header .navigation{
        position: relative;
        display: flex;
        
    }
    header .navigation li{
        list-style: none;
        margin-left: 30px;
    }
    a{
        text-decoration: none;
        color: rgb(22, 22, 22);
    }
    header.sticky .navigation a{
        color: black;
    }

    header .navigation li:hover{
        color: rgb(74, 202, 49);
        overflow: hidden;
    }

    .wrapper{
        min-height: 150%;
    }
    #logout,#login{
        outline: none;
        background: none;
        border: none;
        font-weight: 600;
        font-size: 18px;
    }
    #logout:hover{
        color: white;
    }
      #cart-con i{
    	position: relative;
    	font-size: 25px;
    }
    #badge{
    	position: absolute;
    	top:7%;
    	right:25%;
    	background: tomato;
    	border-radius: 50%;
    	width: 20px;
    	height: 20px;
    	font-size:14px;
    	box-sizing: border-box;
    	color:white;
    	display: flex;
    	justify-content: center;
    	align-items: center;
    }	
    .mycart{
    	position:fixed;
    	top:110px;
    	right:10px;
        z-index: 1000000;
        float: right;
        width: 35%;
        margin-right: 20px;
        min-width: 430px;
        padding: 20px 10px;
        background-color: white;
 
        box-shadow: 0 0 4px rgb(175, 175, 175);
    }
    .name p{
        position: relative;
        line-height: 1.5em;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 1;
        overflow: hidden;
    }
    .carttitle{
        color: rgb(114, 93, 87);
        font-size: 30px;
    }
    .mycart th{
        width: 100%;
        height: 8px;
        background-color: rgb(221, 110, 76);
    }
    .mycart td{
        padding: 7px 7px;
    }
    #cartTable{
        padding: 10px 0;
    }
    
    .fa-trash{
        font-size: 18px;
        padding: auto 2px;
    }
    .sum-btn{
        width:100%;
        text-align: end; 
        margin-bottom: 10px;
    }

    .sum-btn h3{
        letter-spacing: 4px;
        margin: 5px 0;
        color: rgb(68, 68, 68);
    }
    .sum-btn h3::before{
        content: "";
        width: 70%;
        height: 2px;
        background-color: rgb(255, 124, 84);
        display: inline-block;
        margin-right: 5px;
    }
    .gocart{
        font-size: 20px;
        background-color: rgb(255, 124, 84);
        height: 50px;
        width: 150px;
        font-weight: 600;
        color: rgb(20, 20, 20);
    }
    .gocart:hover{
        background-color: rgb(226, 103, 66);
        color: white;
        cursor: pointer;
    }
    .gocart i{
        margin-left: 2px;
    }

    @media (max-width:1350px){
        header{
            padding: 25px 50px;
        }
        .menu-bar{
            width: 50%;
        }
        .menu-bar ul{
            margin: 10px 0;
            width: 100%;
        }
        .menu-bar ul li{
            width: 100%;

        }
        .sum-btn{
        width: 100%;
        text-align: end;
        }
        .sum-btn h3::before{
        content: "";
        width: 80%;
        height: 2px;
        background-color: rgb(255, 124, 84);
        display: inline-block;
        margin-right: 5px;
        }
    }

    @media (max-width:1300px){
        header{
            padding: 25px 50px;
        }
        .menu-bar{
            width: 55%;
        }
        .menu-bar ul{
            margin: 10px 0;
            width: 100%;
        }
        .menu-bar ul li{
            width: 100%;

        }
    }

    </style>
<script>
        $(function(){
        	$(window).scroll(function(){
                var height =$(window).scrollTop();
                if(height>0){
                    $('header').addClass('sticky')
                }else{
                    $('header').removeClass('sticky')
                }
            })

            $(".memder-list").hide();
            $("#member").click(function(e){
                e.preventDefault();
                if($("#member").hasClass("show")){
                    $(".memder-list").hide();
                    $("#member").removeClass("show");
                }else{
                    $(".memder-list").show();
                    $("#member").addClass("show");
                }
            })
			$(".mycart").hide();
             $(".showMyCart").click(function(){
		  if(!($(".mycart").hasClass("show"))){
				$(".mycart").show();
				$(".mycart").addClass("show");
				
			}else{
				$(".mycart").hide();
				$(".mycart").removeClass("show");
				
			}
		})
            $('.slider').slick({
                dots: true,
                centerMode: true,
                centerPadding: 0,
                slidesToShow: 4,
                slidesToScroll: 3,
                autoplaySpeed: 2000,
                responsive: [
                    {
                    breakpoint: 1300,
                    settings: {
                        arrows: true,
                        centerMode: true,
                        centerPadding: 0,
                        slidesToShow: 3
                    }
                    },{
                    breakpoint: 910,
                    settings: {
                        arrows: true,
                        centerMode: true,
                        centerPadding: 0,
                        slidesToShow: 2
                    }
                    },
                    {
                    breakpoint: 850,
                    settings: {
                        arrows: true,
                        centerMode: true,
                        centerPadding:0,
                        slidesToShow: 2
                    }
                    },
                    {
                    breakpoint: 680,
                    settings: {
                        arrows: true,
                        centerMode: true,
                        centerPadding: 0,
                        slidesToShow: 1
                    }
                    }
                ]
            })
        })
    </script>
</head>
<body>


 <%-- 
 <button><a href="getAllProduct" class="show-update">回上頁</a> </button> --%>
 <% 
String account=SecurityContextHolder.getContext().getAuthentication().getName();
boolean status= false;
if(account==null||account==""){
	status=false;
}else{
	status=true;
}
%>
	<div>
    <header>
        <div>
        <a href="gohome" class="logo">Ani-life</a>
        </div>

        <div class="menu-bar">
            <ul >
                <a href="goforum?currpage=0"><li>討論專區</li></a>
                <a href="SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0"><li>寵物用品</li></a>
                <a href="gomap?currpage=0"><li>地圖查詢</li></a>
                <a class="btn-action" href="gowebscoket"><li>客服聊天</li></a>
                <c:choose>
                <c:when test="<%=status %>">
                <a href="select_member" id="member"><li> <%= SecurityContextHolder.getContext().getAuthentication().getName() %>	
                    <ul class="memder-list">
                        <li>會員專區</li>
                        <li>
                        <a class="btn-action" href="logoutPage">
						<button class="btn" id="logout">登出</button>
						</a>
                        <<%-- c:url value="/perform_logout" var="logoutUrl" />
                            <form method="post" action="${logoutUrl}">
                                 <input value="登出" type="submit" id="logout">  
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                             </form> --%>
                        </li>
                    </ul>
                </li></a>
                
                <a class="showMyCart"><li id="cart-con"><i class="fa fa-shopping-cart" ></i><span class="p-1" id="badge">0</span></li></a>
            	</c:when>
            	<c:otherwise>
            		<c:url value="/perform_logoin" var="logoutUrl" />
            		<a href="perform_login"><li>
<%--  						<form method="post" action="${logoutUrl}">
							<input value="登入" type="submit" id="login">  
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 						</form>  --%>
 					</li></a>
                	<a href="${path}/register.jsp"><li>註冊</li></a>
            	</c:otherwise>
            	</c:choose>
            </ul> 
        </div>
        
    </header>
    </div>
    
    <div class="mycart">
    <h3 class="carttitle">我的購物車</h3>
		<table>
			<thead>
				<tr>
					<th colspan="4"></th>
				</tr>
			</thead>
			<tbody id="cartTable">
				<c:if test="${empty cart}" />
				<tr>
					<td>購物車是空的</td>
				</tr>

			</tbody>
		</table>
		<div class="sum-btn">
		</div>
	</div>

<form action="goToCart?${_csrf.parameterName}=${_csrf.token}" method="post">


<div class="container">
     <div class="row">
         <div class="col-2">
             <div class="imgcontainer">
            <c:if test="${product.img!=null}">
             <img src="/img/${product.img }"/>
            </c:if>
            </div>
         </div>
         <div class="col-8">
             <h3 class="title">${product.productName}</h3>
             <h3 class="brand">${product.brand }</h3>
             <div><h3 class="price">$ ${product.price}</h3></div>
             <p class="stock" name="${product.stock }">庫存:${product.stock }</p>
             <div class="btnninput">
                 <button id='qtyMinus' type="button"><i class="fa fa-minus"></i></button>
                 <input type="text" min="1" class="pqty" name="quantity"/>
				 
                 <button id='qtyAdd' type="button"><i class="fa fa-plus"></i></button>
                 <input type="hidden" name="id" value="${product.productID}">
                </div>
             <div class="actionbutton">
                <button class="add2Cart" type="button" id="${ product.productID}">加入購物車</button>
                <button type="submit" class="check">直接結帳</button>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
             </div>
             <div class="dis-area">
                <h4 class="discript-title">產品說明</h4>
                <p>${product.descripton }</p>
            </div>
         </div>
     </div>
 </div>

</form>
<div class="more-product">
     <h3>更多商品</h3>
     	<div class="product-show slider">
			<c:forEach var="product" items="${productList }">
			<a href="getProductDetail?id=${product.productID}&status=none&recordid=0">
             <div class="each-product ">
                 <div class="img-con">
                    <c:if test="${product.img!=null}">
						<img src="/img/${product.img}" alt="">
					</c:if>
                 </div>
                 <h4>${product.productName }</h4>
             </div>
         </a>
		</c:forEach>
		</div>
	</div>
<div class="gradecontent">
	
	 
	 <div class="cust-grade">
	 
		 	<div class="grade-title">
		 		<h2>商品評價</h2>
		 	</div>
		 	
		 	 <c:if test="${status=='done' }">
			 	<div class="gen-grade">
			 		<form id="grade-form">
			 			<input type="hidden" name="productid" value="${product.productID}">
			 			<input type="hidden" name="recordid" value="${recordid }">
			 			<label>評分:</label>
			 			<div class="score_star">
							    <i class="fa fa-star-o"></i>
							    <i class="fa fa-star-o" ></i>
							    <i class="fa fa-star-o" ></i>
							    <i class="fa fa-star-o" ></i>
							    <i class="fa fa-star-o" ></i>
						</div>
			 			<input type="hidden" name="grade" value="3" id="grade-value">
			 			<div class="text-area">
			 				<textarea rows="4" cols="30" name="gradecontent" placeholder="寫點評論吧"></textarea>
			 			</div>
			 			<button id="grade-button" type="button">確認</button>
			 		</form>
			 	</div>
	 		</c:if>
	 		
		<c:if test="${!empty detail }">
	 	<c:forEach var="grade" items="${detail }">
	 		<c:if test="${!empty grade.gradecontent || grade.grade != 0}">
	 		<div class="each-grade">
	 			<div class="account">${grade.account }</div>
	 			<div class="grade">
	 				<c:forEach varStatus="i" begin="1" end="${grade.grade }">
	 					<span><i class="fa fa-star"></i></span>
	 				</c:forEach>
	 					
	 				<c:forEach varStatus="j" begin="1" end="${5-grade.grade }">
	 					<span><i class="fa fa-star-o" ></i></span>
	 				</c:forEach>
	 			</div>
	 			<div class="grade-content">${grade.gradecontent }</div>
	 		</div>
	 		</c:if>
	 	</c:forEach>
	 	
	 		<div id="new-grade" >
	 			<div id="new-account" class="account"></div>
	 			<div id="new-grade"></div>
	 			<div id="new-gradecontent" class="grade-content"></div>
	 		</div>
	 </c:if>
	 
	 </div>

</div>
 <%@ include file="footer.jsp" %>
</body>
</html>