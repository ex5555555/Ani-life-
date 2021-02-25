<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${path}/css/orderPage.css">
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>
 <div class="order-content">
        <h2>下單成功!</h2>
        <div class="icon">
            <div class="icon-container">
                <img src="/img/check.png" alt="">
            </div>
        </div>
        <div class="trading-record">
           
                    <label>訂單編號:</label>${tradingRecord.id }<br>
                   <fmt:formatDate value="${tradingRecord.date }" pattern="yyyy-MM-dd"/>
                    ${tradingRecord.status }
                
        </div>
        <div class="trading-detail">
                
                <ul>
                    <li>
                        <div>商品明細</div>
                        <div class="qty">數量</div>
                        <div>小計</div>
                    </li>
                    <c:forEach var="detail" items="${tradingDetail}">
                    <li>
                        <div>${detail.productname }</div>
                        <div class="qty">${detail.qty }</div>
                        <div>${detail.price*detail.qty  }</div>
                    </li>
                    </c:forEach>
                    
                    <li class="shipping">
                       	 處理郵資 + 100 元
                    </li>
                </ul>
             <div class="total"><h3>全部金額: ${tradingRecord.total}</h3></div> 
           
        </div>
        <div class="btn-class">
            <a href="showTradingRecord"><button>查看其他訂單</button></a>
        </div>
    </div>
 <%@ include file="footer.jsp" %>
</body>
</html>