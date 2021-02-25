<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>我的購物車</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
<script type="text/javascript" src="${path }/css/cartPage.js">
</script>
<link rel="stylesheet" href="${path }/css/cartPage.css">
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

            
        })
    </script>
</head>
<body>
<% 
String account=SecurityContextHolder.getContext().getAuthentication().getName();
boolean status= false;
if(account==null||account=="anonymousUser"){
	status=false;
}else{
	status=true;
}
%>
	<div>
    <header>
        <div>
        <a href="gohome" class="logo">Animal</a>
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
                       
                        </li>
                    </ul>
                </li></a>
               
            	</c:when>
          
            	<c:otherwise>
            		<c:url value="/perform_logoin" var="logoutUrl" />
            		<a href="perform_login"><li>

 					</li></a>
                	<a href="${path}/register.jsp"><li>註冊</li></a>
            	</c:otherwise>
            	
            	</c:choose>
            	
            	<%
					if (!"anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
				%>
            	<li>
            	<c:url value="/perform_logout" var="logoutUrl" />
				<form method="post" action="${logoutUrl}">
					<input value="登出" type="submit" class="logout">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				</li>
				<%
					}
				%>
            
            	
            </ul> 
        </div>
        
    </header>
    </div>

<div class="page-wrapper">
 <div class="container">
    <div class="row">
	<div class=" mycart col-12 col-sm-12">
        <h4><strong>我的購物車</strong></h4>
		<table class="carttable" >
 	<thead>
 	<tr>
 		<th>商品</th>
        <th></th>
		<th>數量</th>
		<th>單價</th>
		<th>總價</th>
		
 	</tr>
 	</thead>
 	<tbody id="cartTable">
	 	
 	</tbody>
 </table>
 <div class="total-price"></div>
 </div>
 </div>
  </div>
 </div>
 
 <%@ include file="footer.jsp" %>
</body>
</html>