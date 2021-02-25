<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
       <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
        <%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>發表貼文</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" /> 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"/>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" ></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" ></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" ></script>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<script src="${path }/css/javascripts/jquery-ui.min.js"></script>

<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path}/css/javascripts/ckeditor5-build-classic/build/ckeditor.js"/></script>
<link href="<c:url value="/css/editor.css"/>" rel="stylesheet">

<script>
         $(function(){

            $(".memder-list").hide();
            
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

		
					$('#input').on('change', function(e) {
					const file = this.files[0];

					const fr = new FileReader();
					fr.onload = function(e) {
						$('img').attr('src', e.target.result);
					};
					fr.readAsDataURL(file);
				});
		
		
        })
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
            	
            	<%
					if (!"anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
				%>
            	<li>
            	<c:url value="/perform_logout" var="logoutUrl" />
				<form method="post" action="${logoutUrl}">
					<input value="登出" type="submit" class="logout">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				<li>
				<%
					}
				%>
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

<div class="list-group">
	<div class="edit-area">
     <h1 class="title">編輯文章</h1>
     <c:choose>
	<c:when test="${fdid.content!=null}">
	<form class="work-area" action="fileuploadcontroller?forumid=${id}&fdid=${fdid.fdid}&${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
 	<dxa:csrf-token/>
       <c:if test="${fdid.fl==1}">
         <input type="text" name="title" value="${title}" />
       </c:if>
       <c:if test="${fdid.fl!=1}">
          <input readonly="readonly" type="text" name="title" value="${title}" />
       </c:if>
         
        <textarea name="content" id="editor"  >
         ${fdid.content}
        </textarea>
         <img style="height: 200px; width: 200px;" src="/img/picc.png">
         <br>
         <input id="input" type="file" name="myfile" /> 
       <input  id="input2"  type="submit" value="發表回覆"> <a href="goforumdetail?forumid=${id}" ><button  id="input2"  class="esc-update">取消編輯</button></a> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <!-- 將id為editor1的textarea用ckeditor來操作 -->
      <script>
                    ClassicEditor.create(document.querySelector( 
                                '#editor'),{
                             
                            
                            })
                            .then(editor=>{
                                   console.log(editor);
                            })
                            .catch(error=>{
                                   console.error(error);
                            });
                    
                   
      </script>
      

</c:when>
<%--新增留言 --%>
<c:when test="${fdid.content==null}">
<form class="work-area" action="fileuploadcontroller?forumid=${id}&fdid=0&${_csrf.parameterName}=${_csrf.token}" method="post" enctype="multipart/form-data">
      <input readonly="readonly" type="text" name="title" value="${title}" size="35" />
        <textarea name="content" id="editor"  >
     
        </textarea>
       <img style="height: 200px; width: 200px;" src="/img/picc.png">
      <br>
         <input id="input" type="file" name="myfile" /> 
       <input  id="input2"  type="submit" value="發表回覆"> <a href="goforumdetail?forumid=${id}" ><button  id="input2"  class="esc-update">取消編輯</button></a> 
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </form>
    <!-- 將id為editor1的textarea用ckeditor來操作 -->
      <script>
                    ClassicEditor.create(document.querySelector( 
                                '#editor'),{
                             
                            	
                            })
                            .then(editor=>{
                                   console.log(editor);
                            })
                            .catch(error=>{
                                   console.error(error);
                            });
                    
            </script>



</c:when>
</c:choose>
<!-- 	<div class="esc-btn"> -->
<%-- 	<a href="goforumdetail?forumid=${id}" ><button class="esc-update">取消編輯</button></a>  --%>
<!-- 	</div> -->
    </div>    
 </div>
<div class="footer"></div>



</body>
</html>