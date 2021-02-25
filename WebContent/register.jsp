<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>註冊會員</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="<c:url value="/css/register.css"/>">
</head>
<body>


<div class="register-container">
    <div class="form">
<form action="register.controller" method="post">
<h1>會員註冊</h1>

<div class="field">
<label>帳號</label>
<input type="text" id="account" name="account" />
<span class="err-msg">${err.account }${err.repeat}${err.accountformat }</span>
</div>

<div class="field">
<label>密碼</label>
<input type="password" id="password" name="password" />
<span class="err-msg">${err.password }${err.passwordformat }</span>
</div>

<div class="field">
<label>確認密碼</label>
<input type="password" id="configpwd" name="configpwd" />
<span class="err-msg">${err.againpwd }${err.checkpwd }</span>
</div>

<div class="field">
<label>姓名</label>
<input type="text" id="username" name="username" />
<span class="err-msg">${err.userName }</span>
</div>

<div class="field">
<label>信箱</label>
<input type="email" id="email" name="email" />
<span class="err-msg">${err.email }</span>
</div>

<div class="telnbirth field">
    <div class="tel">
        <label>電話</label>
        <input type="text" id="phone" name="phone" />
    </div>
    <div class="birth">
        <label>生日</label>
        <input type="date" id="birthday" name="birthday" />
       
    </div>
    
    <!-- <span class="err-msg">${err.phone }${err.birthday }</span> -->
</div>

<div class="field">
<label>地址</label>
<input type="text" id="address" name="address" />
<span class="err-msg">${err.address }</span>
</div>

<div class="field genders">
<label>性別</label>
    <input type="radio" id="gender1" name="gender" value="男"  />
	<label for="gender1">男</label>
	<input type="radio" id="gender2" name="gender" value="女" />
	<label for="gender1">女</label>
	<input type="radio" id="gender3" name="gender" value="秘密"  checked="checked"/>
	<label for="gender1">秘密</label>

<span class="err-msg">${err.gender }</span>
</div>

<div class="sum-btn">
    <input type="submit" id="btn-submit" value="送出" />
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</div>

<div class="sub-cont">
    <div class="img">
        <div class="img-text">
            <a href="perform_login"><button>已有帳號?</button></a>
        </div>
    </div>
</div>


</div>
</body>
</html>