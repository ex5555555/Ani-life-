<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<script src="${path }/css/myTrading.js"/></script>
<script src="${path }/css/productAll.js"/></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${path}/css/myTrading.css">
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>
<div class="page-wrapper">
	<div class="leftbar">
        <ul>
            <li><a href="updatePage"><span>修改資料<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
            <li><a href="changepwd.jsp"><span>更換密碼<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
            <li><span>我的訂單</span></li>
             <li><a href="gomyforum"><span>管理文章</span></a></li>
            <li><a href="gohome"><span>回首頁<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" /></span></a></li>
        </ul>
     </div>
     
 <div class="list-container">
         
        <div class="list-bar">
            <div class="list-bar-tab">全部訂單</div>
        </div>
        
        <div class="trading-list">
			<c:forEach var="record" items="${allDetail}">
			
			 <div class="each-trading">
                <div class="trading-record">
				<div class="orderid">訂單編號:${record.tradingRecord.id }</div>
				<div class="datenstatus">
                        <div class="date">下單日期:<fmt:formatDate value="${record.tradingRecord.date }" pattern="yyyy-MM-dd"/></div>
                        <div class="status">${record.tradingRecord.status}</div>
                </div>
                </div>
                	
                	

					<c:set value="${record.tradingDetail }" var="tdetail"></c:set>
					<c:forEach var="detail" items="${tdetail }">
					 <div class="trading-detail">
					  <div class="imgndescript">
					  
					  <c:choose>
					  	<c:when test="${record.tradingRecord.status=='訂單完成' && empty detail.gradecontent}">
                            <a href="getProductDetail?id=${detail.productid}&status=done&recordid=${record.tradingRecord.id }">
	                			<div class="img-container">
	                                <img src="/img/${detail.img }" alt="">
	                            </div>
                        	</a> 
                            <div class="product-name">
                                <p>${detail.productname }</p> 
                                <p class="qty">x${detail.qty }</p>
                            </div>
                        </div>
                        
                        <div class="go-grade">
                        	<div class="price">$ ${detail.price}</div>
                        	<a href="getProductDetail?id=${detail.productid}&status=done&recordid=${record.tradingRecord.id }">
                        		<button id="gograde-btn">評價商品</button>
                        	</a>
                        </div>
                        
                        </c:when>
                        <c:otherwise>
                        	
                        	 <a href="getProductDetail?id=${detail.productid}&status=none&recordid=0">
	                			<div class="img-container">
	                                <img src="/img/${detail.img }" alt="">
	                            </div>
                        	</a> 
                            <div class="product-name">
                                <p>${detail.productname }</p> 
                                <p class="qty">x${detail.qty }</p>
                            </div>
                        </div>
                        <div class="price">$ ${detail.price}</div>
                        </c:otherwise>
                       </c:choose>
                    </div>
						
					</c:forEach>
					 <div class="trading-total">訂單金額:$ ${record.tradingRecord.total }</div>
	                <div class="btn">
	                    <button class="show-detail" name="${record.tradingRecord.id }">查看訂單詳情</button>
	                </div> 
	                <div class="detail-info" id="${record.tradingRecord.id }">
	                    <div class="recipetor">
	                    	
	                    	收件人 ${record.tradingRecord.recipient } 
	                    </div>
	                    <div class="email">聯絡信箱  ${record.tradingRecord.email }</div>
	                    <div class="addr">收件地址  ${record.tradingRecord.address }</div>
	                    <div class="remark">訂單備註  ${record.tradingRecord.remarks }</div>
	                </div>
	               </div>
			</c:forEach>
		</div>
</div>
</div>
 <jsp:include page="/footer.jsp"></jsp:include>
</body>
</html>