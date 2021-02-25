<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>討論版列表</title>

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
<script src="${path}/css/javascripts/jquery-ui.min.js"></script>

<link href="<c:url value="/css/forum.css"/>" rel="stylesheet">
	<script type="text/javascript" src="${path}/css/productPage.js"></script> 

</head>
<body>
	<jsp:include page="header.jsp"></jsp:include>
<!-- 文章推薦 -->

<div class="header-background" style="background-image: url('/img/forumbackground.jpg');">
</div>
<div class="category-select">
<button onClick="location.href='goforum?currpage=0';">全部主題</button>
<c:forEach var="AllSpecies" items="${AllSpecies}">
 <button  onClick="location.href='selectforumspecies?fiid=${AllSpecies.fsid}&currpage=0';">${AllSpecies.species}</button>
</c:forEach> 
<c:if test="${memberdata.frauthority == 't'}"> <button id="create-forum" onClick="location.href='gocreateeditor?forumid=${forumid}';">我要發文</button></c:if>


 
</div>

<div class="search">
		 <form action="selectkeyword?currpage=0" method="post"> 
		<input name="keyword" id="search-name" type="text" placeholder="尋找文章">
		<input type="submit" id="submit-btn" value="搜尋" >
		</form>
	</div>

			<div class="container">
  
  <div class="art-area">
   <h3 class="article-title">全部文章</h3>
   <div class="list-group">
   
   
   <c:choose>
   <c:when test="${selection == 'all' or empty selection}">
   <c:forEach var="AllForum" items="${AllForum}">	

	
	 <a href="goforumdetail?forumid=${AllForum.forum.fid}" class="list-group-item">
      <div class="art-content">
        <h5 class="art-title">${AllForum.forum.title}</h5>
        <small>${AllForum.forum.account}</small>
        <p class="text">
      ${AllForum.forumdetail.content}
        </p>
        <p class="date">${AllForum.forum.date} / 留言(${AllForum.flcount}) </p>
      </div>
    </a>
 
   	</c:forEach>			
				 <c:if test="${totalpage<=10 && totalpage>1}">		
		<ul class="pagination">
		  <li class="page-item"><a class="page-link" href="goforum?currpage=0">&laquo;</a></li>
		  <c:forEach begin="1" end="${totalpage}" var="page">
		  <c:if test="${page==currpage+1}">		 
		  <li class="page-item active" class="page-item"><a class="page-link" href="goforum?currpage=${page-1}">${page}</a></li>		 
		 </c:if>
		  <c:if test="${page!=currpage+1}">		 
		  <li class="page-item " class="page-item"><a class="page-link" href="goforum?currpage=${page-1}">${page}</a></li>		
		  </c:if>
		  </c:forEach>
		  <li class="page-item"><a class="page-link" href="goforum?currpage=${totalpage-1}">&raquo;</a></li>
		</ul>
		</c:if>
		
		 <c:if test="${totalpage>10}">		
		<ul class="pagination">
		  <li class="page-item"><a class="page-link" href="goforum?currpage=0">&laquo;</a></li>
		  <c:forEach begin="${currpage-3}" end="${currpage+7}" var="page">		 
		  <c:if test="${page==currpage+1}">		 
		  <li class="page-item active" class="page-item"><a class="page-link" href="goforum?currpage=${page-1}">${page}</a></li>		 
		 </c:if>
		  <c:if test="${page!=currpage+1}">		 
		  <li class="page-item " class="page-item"><a class="page-link" href="goforum?currpage=${page-1}">${page}</a></li>		
		  </c:if>
		  </c:forEach>
		  <li class="page-item"><a class="page-link" href="goforum?currpage=${totalpage}">&raquo;</a></li>
		</ul>
		</c:if>			
   </c:when>
   <c:when test="${selection == 'selectClass' }">
   <c:forEach var="forumlist" items="${forumlist}">
    <a href="goforumdetail?forumid=${forumlist.forum.fid}" class="list-group-item ">
      <div class="art-content">
        <h5 class="art-title">${forumlist.forum.title}</h5>
        <small>${forumlist.forum.account}</small>
        <p class="text">
        ${forumlist.content}
        </p>
        <p class="date">${forumlist.forum.date} / 留言(${forumlist.flcount})</p>
      </div>
    </a>
       </c:forEach>
       	  <c:if test="${totalpage<=10 && totalpage>1}">		
		<ul class="pagination">
		  <li class="page-item"><a class="page-link" href="selectforumspecies?currpage=0&fiid=${copyfid}">&laquo;</a></li>
		  <c:forEach begin="1" end="${totalpage}" var="page">		 
		  <c:if test="${page==currpage+1}">		 
		  <li class="page-item active" class="page-item"><a class="page-link" href="selectforumspecies?currpage=${page-1}&fiid=${copyfid}">${page}</a></li>		 
		 </c:if>
		  <c:if test="${page!=currpage+1}">		 
		  <li class="page-item " class="page-item"><a class="page-link" href="selectforumspecies?currpage=${page-1}&fiid=${copyfid}">${page}</a></li>			 
		 </c:if>
		  </c:forEach>
		  <li class="page-item"><a class="page-link" href="selectforumspecies?currpage=${totalpage-1}&fiid=${copyfid}">&raquo;</a></li>
		</ul>
		</c:if>
		
		 <c:if test="${totalpage>10}">		
		<ul class="pagination">
		  <li class="page-item"><a class="page-link" href="selectforumspecies?currpage=0&fiid=${copyfid}">&laquo;</a></li>
		  <c:forEach begin="${currpage-3}" end="${currpage+7}" var="page">		 
	     <c:if test="${page==currpage+1}">		 
		  <li class="page-item active" class="page-item"><a class="page-link" href="selectforumspecies?currpage=${page-1}&fiid=${copyfid}">${page}</a></li>		 
		 </c:if>
		   <c:if test="${page!=currpage+1}">		 
		  <li class="page-item " class="page-item"><a class="page-link" href="selectforumspecies?currpage=${page-1}&fiid=${copyfid}">${page}</a></li>		
		  </c:if>
		    </c:forEach>
		  <li class="page-item"><a class="page-link" href="selectforumspecies?currpage=${totalpage}&fiid=${copyfid}">&raquo;</a></li>
		</ul>
		</c:if>
   </c:when>
    <c:when test="${selection == 'keyword' }">
    <c:if test="${forumkeyword!=null}">
   <c:forEach var="forumkeyword" items="${forumkeyword}">
    <a href="goforumdetail?forumid=${forumkeyword.forum.fid}" class="list-group-item ">
      <div class="art-content">
        <h5 class="art-title">${forumkeyword.forum.title}</h5>
        <small>${forumkeyword.forum.account}</small>
        <p class="text">
        ${forumkeyword.content}
        </p>
        <p class="date">${forumkeyword.forum.date} /留言(1)</p>
      </div>
    </a>
       </c:forEach>
       </c:if>
         <c:if test="${forumkeyword==null}">
         <a href="goforum?currpage=0" class="list-group-item ">
      <div class="art-content">
        <h5 class="art-title">查詢無結果</h5>
        <small></small>
        <p class="text">
                          返回全部主題
        </p>
        <p class="date"></p>
      </div>
    </a>
          </c:if>

       </c:when>
   </c:choose>
  </div>
</div>
<div class="recommend">
    <h3 class="recommend-title">最新討論</h3>
  
   
    <ul>
       <c:forEach var="newforum" items="${newforum}">
       <c:if test="${newforum.title!= '[此文章已由原作者刪除]'  }">
      <a class="newforum" href="goforumdetail?forumid=${newforum.fid}"><li>${newforum.title}</li></a> 
      </c:if>   
      </c:forEach>
    </ul>
  </div>

</div>
<%-- 		 <%@ include file="/websco.jsp" %>			 --%>
</body>
</html>