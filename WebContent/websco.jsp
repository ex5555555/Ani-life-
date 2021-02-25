<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page
	import="org.springframework.security.core.context.SecurityContextHolder"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path}/css/javascripts/jquery-3.5.1.min.js" /></script>
<script src="${path}/css/javascripts/jquery-ui.min.js"></script>
<script src="${path}/css/productPage.js"></script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
<link rel="stylesheet" href="${path }/css/websco.css">
<title>Ani-life即時聊天</title>

<script type="text/javascript">
$(function(){  

	var websocket;
	//啟動連線
		connect();
	function connect(){ //初始化連線 
		try {
			var protocol = window.location.protocol;
			if(protocol == "https:"){
				websocket = new WebSocket("wss://"+ window.location.host + "/websocket");
		      }else{		    	 
		        	websocket = new WebSocket("ws://"+ window.location.host + `/SpringHibernate/websocket?user=${user}`);		        	
		      }
		     
		} catch (ex) {
			console.log(ex);
			console.log("websocket連接異常");
		}
		connecting();
		window.addEventListener("load", connecting, false);
	}
	
	

	function connecting() {
		websocket.onopen = function(evt) {
			onOpen(evt)
		}
		websocket.onclose = function(evt) {
			onClose(evt)
		}
		websocket.onmessage = function(evt) {
			onMessage(evt)
		}
		websocket.onerror = function(evt) {
			onError(evt)
		}
	}


	//連線上事件
	function onOpen(evt) {	
		console.log("WebSocket 連線成功");	
	
		$("#connect-status").text("連線中"); 
		$("#connect-member").text(`目前使用者：${user}`); 
		
	}
	
	//關閉事件
	function onClose(evt) {
		console.log("WebSocket 離線成功");	
		$("#connect-status").text("離線中"); 
		console.log("WebSocket獲得目前在線人數：" + evt.data);
		}
	//後端推送事件
	
	//發生錯誤
	function onError(evt) {}
	//瀏覽器主動斷開連線
	function wsclose() {
		websocket.close();
	}
// 	function showMessage(message) {
// 		$("#header_visitors").html('線上人數：' + message);
// 		$("#footer_visitors").html('線上人數：' + message);
// 	}
	function onMessage(evt) {
		var msg = JSON.parse(evt.data);	
		//showMessage(evt.data);
		console.log(evt.data);
		 if(JSON.stringify(msg.header).includes('管理員')){
			 $("#msg-io").append(`<div class='user-name' style='color:red;'></div>&emsp;<span ><span>`); 	
			   $(".user-name:last").text(msg.header);
			   $("span:last").addClass("bubble");
			   $("span:last").text(msg.value);
		   }else if(JSON.stringify(msg.header).includes('名成員在線上')){
			   $("#msg-io").append(`<div class='user-name'></div><span><span>`); 
			   $("#connect-count").text(msg.header);
			   $("span:last").text(msg.value);
			   }
		   else{
	   $("#msg-io").append(`<div class='user-name'></div>&emsp;<span><span>`); 	
	   $(".user-name:last").text(msg.header);
	   //$("span:last").addClass("bubble");
	   $("span:last").text(msg.value);
		   }
	    var msgIoDiv = $("#msg-io")[0];
	    msgIoDiv.scrollTo(0,msgIoDiv.scrollHeight);
	}
		
	$("#msg-name").hide();
   $("#select").change(function () {
  if($("#select").val() == "one"){
        $("#msg-name").show();
        
  }	else{
	  $("#msg-name").hide();
	  }
})
	$("#msg-io").on("click",".user-name",function(){
		 var name=$(this).text();
         $("#msg-name").val(name);
		})

	$("#form1").submit(function(){
		 var msg = {
				    type: $("#select").val(),
				    text: $("#msg-input").val(),
				    id: $("#msg-name").val(),				  
				  };
		
		websocket.send(JSON.stringify(msg));
		$("#msg-input").val("");
		return false;
	});
  
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


	/*
$("#btn2").bind("click",function () {
	var url = `${pageContext.request.contextPath}/websocket/sendMsg`;


	 var content = $("#text").val(); 
	 var toUserName = $("#UserName").val(); 
		 $.ajax({ 
			 data: {'content':  content ,'toUserName' :toUserName },
			  type: "get",
			   dataType: 'text',
			    async: false,
			     contentType: "application/x-www-form-urlencoded;charset=UTF-8", 
			     encoding: "UTF-8", 
			     url: url, 
			     success: function (data) { console.log(data.toString()); },
			      error: function (msg) { alert(msg);
			       },
			      });

		 return false;
                })

	*/
})

</script>
</head>
<body>
<% 
String account=SecurityContextHolder.getContext().getAuthentication().getName();
boolean status= false;
if(account.equals("qwerty")){
	status=false;
}else{
	status=true;
}
%>

	<div>
    <header>
        <div class="header-logo">
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
                    
                </li></a>
                
                <a class="showMyCart"><li id="cart-con"><i class="fa fa-shopping-cart" ></i><span class="p-1" id="badge">0</span></li></a>
            	</c:when>
            	<c:otherwise>
            		<c:url value="/perform_logoin" var="logoutUrl" />
            		<a href="perform_login"><li>

 					</li></a>
                	<a href="${path}/register.jsp"><li>註冊</li></a>
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
<div class="page-wrapper">

	<div class="chatroom">
	
	   	<div class="chatheader">
			<span id="connect-member"></span>
			
			<span id="connect-status">離線中</span>
		</div>
		<div class="chat-count">
			<span id="connect-count"></span>
		</div>
		<form id="form1">
			<div class="form-group">
				<div class="form-control" id="msg-io"></div>
			
			<div class="input-area">
				<div class="selector">
					<select id="select" name="selector">
							<option selected value="all">聊天室廣播</option>
							<option  value="one">悄悄話</option>
			    	</select>
					<input type="text"   name="msg-input2" id="msg-name" placeholder="請輸入對象" >
				</div>
				<div class="textnSubmit">
					<div class="input-content">
					<input type="text" name="msg-input" id="msg-input"
						placeholder="請輸入訊息" />
					</div>
					<button type="submit" id="submit"><i class="fa fa-paper-plane"></i></button>
				</div>
			</div>
			</div>
			<!--<button type="button" class="btn btn-danger float-right" id="disconnect-btn">離線</button> -->
		</form>
		
<!-- 		<input type="text" id="text">		 -->
<!-- 		<input type="text" id="UserName">		 -->
<!-- 		 <button id="btn2" value="發送給其他用戶">發送給其他用戶</button> -->


	</div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>