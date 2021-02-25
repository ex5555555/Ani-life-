<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>忘記密碼</title>
<style>
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    .container{
        width: 100%;
        text-align: center;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        padding: 70px 0;
    }
    h2{
        width: 100%;
        text-align: center;
        background-color: rgb(235, 112, 55);
        color: rgb(59, 59, 59);
        padding: 10px;
        margin-bottom: 20px;
    }
    .form{
        width: 500px;
        border: gray 2px solid;
        padding-bottom: 20px;
    }

    .content{
        margin: 20px 0;
    }
    input{
        line-height: 25px;
        margin-left: 5px;
    }
    .err-msg{
        color: red;
        margin: 5px 0 10px 0;
    }
    .sub-btn{
        width: 100%;
        margin-bottom: 10px;
    }

    #send{
        border: rgb(235, 112, 55) 1px solid;
        color: rgb(59, 59, 59);
        font-weight: 600;
        background: none;
        outline: none;
        font-size: 20px;
        letter-spacing: 5px;
        height: 40px;
        width: 80%;
        cursor: pointer;
    }
    #send:hover{
        background: rgb(235, 112, 55);
        color: white;
    }
</style>
</head>
<body>
<jsp:include page="header.jsp"></jsp:include>
<div class="container">

<div class="form">
<h2>忘記密碼</h2>
<form action="forgetpwd.controller" method="post">

<div class="content">
<label>帳號</label>
<input type="text" id="account" name="account" />
</div>

<div class="content">
<label>信箱</label>
<input type="text" id="email" name="email" />
</div>
<div class="err-msg">${err.emailformat }</div>
<div class="err-msg">${err.err }</div>

<div class="sub-btn">
    <input type="submit" id="send" value="送出" />
</div>

<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>
</div>
</div>
</body>
</html>