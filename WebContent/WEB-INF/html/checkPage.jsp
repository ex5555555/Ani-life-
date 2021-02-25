<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品結帳</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js"/></script>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${path}/css/checkPage.css">
</head>
<body>
 <jsp:include page="/header.jsp"></jsp:include>
    <div class="form-container">
    
    <form action="checkConfirm" method="post">
        
        <table>
            <thead>
                <tr>
                    <td>訂單商品</td>
                    <td>單價</td>
                    <td>數量</td>
                    <td>總計</td>
                </tr>
            </thead>
            <tbody>
                <c:set var="total" value="0" />
                <c:forEach var="list" items="${sessionScope.cart}">
                <c:set var="total" value="${total+(list.quantity*list.product.price) }" />
                    <tr> 
                        <td>
                            <div class="img-container">
                                <c:if test="${list.product.img!=null}">
									<img src="/img/${list.product.img}" alt="">
								</c:if>
                            </div>
                            <p class="productname">${list.product.productName}</p>
                            <input type="hidden" name="productID" value="${ list.product.productID}">
                        </td>
                        <td>${list.product.price}</td>
                        <td>${list.quantity}
                            <input type="hidden" name="quantity" value="${list.quantity}">
                        </td>
                        
                        <td>$ ${list.quantity*list.product.price}</td> 
                    </tr>
                </c:forEach> 
            </tbody>
        </table>
    
        <div class="total-amount">
                <div class="shipping">運費: + $ 100 </div>
                <div class="total">總計: $ ${total+100}<input type="hidden" name="total" value="${total}"></div>
        </div>

        <div class="memberInfo">
            <h3>訂貨人資料</h3>
            <div class="info">
                <lable>收件人姓名</lable>
                <input type="text" name="recipient"/>
                <small>**請填寫真實姓名</small>
            </div>

            <div class="info">
                <lable>聯絡電話</lable>
                <input type="text" name="tel"/>
            </div>

            <div class="info">
                <lable>電子信箱</lable>
                <input type="text" name="email"/>
            </div>

            <div class="info addr">
                <lable>收件地址</lable>
                <input type="text" name="address"/>
            </div>
            
            <div class="info remark">
                <lable>備註</lable><br>
                <textarea rows="5" cols="10" name="remarks"></textarea>
            </div>
            <c:if test="${memberdata.pdauthority == 't'}"> <div class="sub-btn"><button type="submit">前往結帳</button></div></c:if>
            <c:if test="${memberdata.pdauthority == 'f'}"> <div class="sub-btn"><button type="button">無法結帳</button></div></c:if>
        </div>
       	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
    </div>
</body>
</html>