<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${title}</title>

 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">


<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<script src="${path }/css/javascripts/jquery-ui.min.js"></script>

<script type="text/javascript" src="${path}/css/Forumdetail.js"></script> 
<link rel="stylesheet" href="${path}/css/forumdetail.css">
<script >
 $(function(){
	
		 $(window).scroll(function(){
         var height =$(window).scrollTop();
         if(height>0){
             $('header').addClass('sticky');
         }else{
        	 $('header').removeClass('sticky');
         }

         if(height>380){
        	 $('.btn-class').addClass('btn-sticky');
             
         }else{
        	 $('.btn-class').removeClass('btn-sticky');
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
	    

 });
</script>

</head>
<body>
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
        <a href="gohome" class="logo">Animal</a>
        </div>

        <div class="menu-bar">
            <ul >
                <a href="goforum?currpage=0"><li>討論專區</li></a>
                <a href="SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0"><li>寵物用品</li></a>
                <a href="gomap?currpage=0"><li>地圖查詢</li></a>
                <c:choose>
                <c:when test="<%=status %>">
                <a href="#" id="member"><li> <%= SecurityContextHolder.getContext().getAuthentication().getName() %>	
                    <ul class="memder-list">
                        <li>會員專區</li>
                        <li><c:url value="/perform_logout" var="logoutUrl" />
                            <form method="post" action="${logoutUrl}">
                                 <input value="登出" type="submit" id="logout">  
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                             </form>
                        </li>
                    </ul>
                </li></a>
                <a class="showMyCart"><li id="cart-con"><i class="fa fa-shopping-cart" ></i><span  id="badge">0</span></li></a>
            	</c:when>
            	<c:otherwise>
            		<a href="#"><li>
            		<c:url value="/perform_logoin" var="logoutUrl" />
 						<form method="post" action="${logoutUrl}">
							<input value="登入" type="submit" id="login">  
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
 						</form> 
 					</li></a>
                	<a href=""><li>註冊</li></a>
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
 

 <div class="header-background" style="background-image: url('/img/forumbackground.jpg');"></div>
  <div class="category-select">
<button onClick="location.href='goforum?currpage=0';">全部主題</button>
  <c:forEach var="AllSpecies" items="${AllSpecies}">
        <button onClick="location.href='selectforumspecies?fiid=${AllSpecies.fsid}&currpage=0';">${AllSpecies.species}</button>    
   </c:forEach>
   		<c:if test="${memberdata.frauthority == 't'}"> <button id="create-forum" onClick="location.href='gocreateeditor?forumid=${forumid}';">我要發文</button></c:if>

</div>


<!--  -->


<div class="big-container">
  <div class="dis-container">
<!--  -->
<c:forEach var="forumdata" items="${forumdata}">
	<c:choose><%--第一層文章 --%>
	 <c:when test="${forumdata.content=='[此樓層文章已由原作者刪除]'}">
	  <div class="recommend con"> 
                
                <p class="text" style="color:#ACACAC ">
                  ${forumdata.content}
                </p>
       </div>
	 </c:when>  
 
  	 <c:when test="${forumdata.content!='[此樓層文章已由原作者刪除]'}">
  	 <c:choose>
  		<c:when  test="${forumdata.fl==1}">
		<div class="art-content con">
		<h2 class="art-title">${title}</h2>
    	<div class="floor"><small class="author">${forumdata.account}</small><span>樓主</span></div>
			<div class="content">
              <p class="text">
                ${forumdata.content}
              </p>
            </div>
           <c:if test="${forumdata.img!=null}"> 
  			<div class="img-container">
                <img  src="${url}${forumdata.img}" />
            </div>
         </c:if>
		<p class="art-date">${forumdata.date} </p>

  	
	 	<c:if test="${forumdata.account==user}"> 
		  	<div   class="dropdown">
                <button id="${forumdata.fdid}" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                    <i class="fa fa-pencil-square-o"></i></button>
                <div class="dropdown-menu" >
                <a class="dropdown-item" href="goeditor?forumid=${id}&fdid=${forumdata.fdid}">編輯文章</a>
                <a class="dropdown-item" href="delete?forumid=${id}&fdid=${forumdata.fdid}&fl=${forumdata.fl}">刪除文章</a>
                </div>  
            </div>
	  	</c:if>
	  	</div>
	  	</c:when>
	
  	<c:otherwise>
  		<div class="recommend con"> 
                <div class="floor"><small class="author">${forumdata.account}</small><span>${forumdata.fl}樓</span></div>
                <p class="text">
                  ${forumdata.content}
                </p>
                <p class="rec-date">${forumdata.date}</p>
                 <c:if test="${forumdata.img!=null}"> 
		  			<div class="img-container">
		                <img  src="${url}${forumdata.img}" />
		            </div>
		         </c:if>
            <c:if test="${forumdata.account==user}"> 
		  	<div   class="dropdown">
                <button  id="${forumdata.fdid}" class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown">
                    <i class="fa fa-pencil-square-o"></i></button>
                <div class="dropdown-menu" >
                <a class="dropdown-item" href="goeditor?forumid=${id}&fdid=${forumdata.fdid}">編輯文章</a>
                <a class="dropdown-item" href="delete?forumid=${id}&fdid=${forumdata.fdid}&fl=${forumdata.fl}">刪除文章</a>
                </div>  
            </div>
            </c:if>
          </div>

  	</c:otherwise>
  	</c:choose>
  	</c:when>
 	</c:choose>
<!--  	<div class="btn-class"> -->
<%--  	<c:if test="${forumdata.content!='[此樓層文章已由原作者刪除]'}"> --%>
<%--   <button><a href="goeditor?forumid=${id}&fdid=0" class="show-update">回覆</a> </button> --%>
<%-- </c:if>	 --%>
<!-- </div> -->
</c:forEach>


<!--  -->
</div>
	<div class="btn-class">
        <a href="goforum?currpage=0" class="show-update"><button class="abtn">回討論區</button></a> 
        <c:if test="${memberdata.frauthority == 't'}">   <a href="goeditor?forumid=${id}&fdid=0" class="show-update"><button class="abtn">回覆 </button> </a></c:if>

      
	</div>


</div>




 <!-- footer -->
 <div class="footer">
    <div class="footer-container">
        <div class="footer-row">
            <div class="footer-col-1">
                <h3>聯絡我們</h3>
                <p>我們會用最快的速度回應您的需求</p>
            </div>
        </div>
        <hr>
        <p class="footer-bottom"> &copy; Animal.com | Alawys by Your Side</p>
    </div>
</div>
 
  
</body>
</html>