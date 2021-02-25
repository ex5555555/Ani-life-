<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>會員中心</title>
    <link rel="stylesheet" href="<c:url value="/css/membercenter.css"/>">		<!-- <c:url value="/css/home.css"/> -->
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="page-wrapper">
   <div class="leftbar">
        <ul>
            <li><a href="updatePage"><span>修改資料<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
            <li><a href="changepwd.jsp"><span>更換密碼<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
            <li><a href="showTradingRecord"><span>我的訂單</span></a></li>
            <li><a href="gomyforum"><span>管理文章</span></a></li>
            <li><a href="gohome"><span>回首頁<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
        </ul>
     </div>
     	
    
     
     <div class="member-cont">
        
        
        <c:choose>
        <c:when test="${selection == 'all' }">
        <c:forEach var="member" items="${memberList }">
            
        <div class="work-area">
            <h2>會員資料</h2>
            
            <div class="text-box">
                <label>姓名</label>
                <input type="text" name="username" id="username" value="${member.userName}" disabled>
            </div>
    
            <div class="text-box">
                <label>信箱</label>
                <input type="text" name="email" id="email" value="${member.email}"  disabled>
            </div>
    
            <div class="text-box">
                <label>電話</label>
                <input type="text" name="phone" id="phone" value="${member.phone}"  disabled>
            </div>
    
            <div class="text-box">
                <label>地址</label>
                <input type="text" name="address" id="address" value="${member.address}"  disabled>
            </div>
    
     
            <div class="text-box">
                <label>生日</label>
                <input type="text" name="birthday" id="birthday" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>"  disabled><!-- ${member.birthday} -->
            </div>
             <div class="text-box">
                <label>購物權限</label>
                <c:if test="${member.pdauthority == 't'}">
                  <input type="text"  value="正常"  disabled>
                </c:if>
                 <c:if test="${member.pdauthority == 'f'}">
                 <input type="text"  value="禁止"  disabled>
                </c:if>             
            
            </div>
            
            <div class="text-box">
                <label>發文權限</label>
                <c:if test="${member.frauthority == 't'}">
                <input type="text"  value="正常"  disabled>
                </c:if>
                 <c:if test="${member.frauthority == 'f'}">
                  <input type="text"  value="禁止"  disabled>
                </c:if>             
            
            </div>
            
            <div class="text-box">
                
                <div class="selector-gender">
                    <label>性別</label>
                    <input type="radio" id="gender1" name="gender" value="男" <c:if test="${member.gender=='男' }">checked="checked"</c:if>  disabled/>
                    <label for="gender1">男</label>
                    <input type="radio" id="gender2" name="gender" value="女" <c:if test="${member.gender=='女' }">checked="checked"</c:if>   disabled/>
                    <label for="gender1">女</label>
                    <input type="radio" id="gender3" name="gender" value="秘密" <c:if test="${member.gender=='秘密' }">checked="checked"</c:if>   disabled/>
                    <label for="gender1">秘密</label>
                </div>		<!-- <input type="text" name="gender" id="gender" value="${member.gender}"> -->
            </div> 
            
            <div class="btn-area text-box" >
                <a href="updatePage"><input type="button" id="send" value="修改" /></a>
            </div>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </div>

        </c:forEach>
        
        </c:when>
    
        
        
        <c:when test="${selection == 'update'}">
        <c:forEach var="member" items="${memberList }">
        <c:url value="update_member" var="memberUrl" />
        <form method="post" action="${memberUrl} ">
        
        <script type="text/javascript">
            
        
        </script>
        <div class="work-area">
        <h2>修改資料</h2>
        
        <div class="text-box">
            <label>姓名</label>
            <input type="text" name="username" id="username" value="${member.userName}">
        </div>

        <div class="text-box">
            <label>信箱</label>
            <input type="text" name="email" id="email" value="${member.email}">
        </div>

        <div class="text-box">
            <label>電話</label>
            <input type="text" name="phone" id="phone" value="${member.phone}">
        </div>

        <div class="text-box">
            <label>地址</label>
            <input type="text" name="address" id="address" value="${member.address}">
        </div>

 
        <div class="text-box">
            <label>生日</label>
            <input type="text" name="birthday" id="birthday" value="<fmt:formatDate value="${member.birthday}" pattern="yyyy-MM-dd"/>"><!-- ${member.birthday} -->
        </div>
        
        <div class="text-box">
            
            <div class="selector-gender">
                <label>性別</label>
                <input type="radio" id="gender1" name="gender" value="男" <c:if test="${member.gender=='男' }">checked="checked"</c:if> />
                <label for="gender1">男</label>
                <input type="radio" id="gender2" name="gender" value="女" <c:if test="${member.gender=='女' }">checked="checked"</c:if> />
                <label for="gender1">女</label>
                <input type="radio" id="gender3" name="gender" value="秘密" <c:if test="${member.gender=='秘密' }">checked="checked"</c:if> />
                <label for="gender1">秘密</label>
            </div>		<!-- <input type="text" name="gender" id="gender" value="${member.gender}"> -->
        <div> 
        
        <div class="btn-area">
            <input type="submit" id="send" value="儲存" />
        </div>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    </div>
        </form>
        </c:forEach>
        </c:when>
        
         <c:when test="${gomyforum == 'myforum'}">
         
       <h2>我的文章</h2>
      
       <c:if test="${myforum == 'null'}">
        <div class="my-forum">     
	        <div class="forum-content">            	 
	                <label >你沒有發表過的文章</label>                
	        </div>
   		 </div>
       </c:if>
      <c:if test="${myforum != 'null'}">
        <c:forEach var="myforum" items="${myforum}">  
            
         <div class="my-forum">         
           
            <div class="forum-content">
                <div class="content" onClick="location.href='goforumdetail?forumid=${myforum.fid}';">${myforum.title} 
                	<span class="date">
              			<fmt:formatDate value="${myforum.date}" pattern="yyyy-MM-dd hh:mm"/>　
              		</span>
                </div>                       
              　　　　	
            </div>
         </div>   
         
          </c:forEach>
        </c:if>
          
        <h2>我的留言</h2>
            
        <c:if test="${myforumdetail == 'null'}">
        <div class="myforum" >     
	        <div class="forum-content">            	 
	                <label >你沒有發表過的留言</label>                
	        </div>
        </div>
       </c:if>
        <c:if test="${myforumdetail != 'null'}">
            <c:forEach var="myforumdetail" items="${myforumdetail}">
         		<div class="my-forum forum-reply" > 

		            <div class="forum-content">
		               <div class="each-content" onClick="location.href='goforumdetail?forumid=${myforumdetail.copyfdid}';">內文：${myforumdetail.content}
			               
		               </div> 
		               <div class="each-date">
			               		<fmt:formatDate value="${myforumdetail.date}" pattern="yyyy-MM-dd hh:mm"/>
			           </div>
		            </div>

      			 </div>   
              </c:forEach>
     	</c:if>
        
        </c:when>
        
        
        </c:choose>
        
        </div>
        </div>
        </div>
         </div>
	<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>





