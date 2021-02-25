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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
	<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
	
<link rel="stylesheet" href="${path}/css/websco.css">
<title>Webscoket</title>
<style type="text/css">
html{
	height:100%;
	/* background: linear-gradient(45deg,  rgba(145,155,155,1) 0%, rgba(43,53,53,1) 100%) no-repeat fixed; */
}
#tools a{
	color:#4a4a4a;
	border-bottom: 2px solid #999;
}
.updatebutton{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
.updatebutton:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
.deletebutton{
	background-color:gray;
	transition-duration: 0.4s;
	border:none;
	border-radius:5px;
	padding:8px 10px;
	color:#eee;
}
.deletebutton:hover{
	background-color: #eee;
	transition-duration: 0.4s;
	color:#555;
}
.collapsing {
  width: 0;
  transition-property: width;
  white-space: nowrap;
  height: 100%;
}
.main{
	position: absolute;
	top:50%;
    left: 50%;
    transform: translate(-50%,-50%);
    weight:100%;
    height:100%;
    margin:100px auto 100px auto;
}
#tools{
	background-color: rgb(146 146 146 / 20%);
	display:flex;
	align-items:center; /* 垂直置中 */
	justify-content:center;  /* 水平置中 */
	margin:2px;
	color:#4a4a4a;
}
.item{
	display:inline-block;
	padding:30px;
}
#employeesmenu{
	margin:50px auto 50px auto;
	font-size: 20px;
	color:#585858;
}
.employeeid{
	color:rgb(3 93 88);
}
.outemployees{
	background-color: rgb(239 239 239 / 50%);
	margin: 2px 25px 25px 25px;
}
#employees{
	padding:10px;
/* 	display:flex;
	align-items:center; /* 垂直置中 */ */
}
.emspan{
	width:70px;
	margin:0;
}
.emspan2{
	margin-right:2.5px;
}
.text{
	width:calc(100% - 70px);
}
input[type=text]{
	box-sizing: border-box;
  	border: none;
  	border-bottom: 2px solid #999;
  	background-color:rgba(31, 31, 31, 0%);
  	color: #585858;
}
input[type=text]:focus{
	background-color:white;
	color:rgb(31,31,31);
	outline:none;
}
::placeholder{
	color: #999;
}
select {
	border:none;
  	background-color: rgb(165 165 165 / 50%);
  	color: #999;
}
select:focus{
	outline:none;
	background-color: rgba(131, 131, 131, 50%);
}
select:checked{
	color: #555;
}
option, option:focus{
	color: rgb(97 97 97);
    background-color: #e2e2e2;
}
</style>
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
		 if(JSON.stringify(msg.header).includes('收到來自')){
			 $("#msg-io").append(`<div class='user-name' style='color:red;'></div>&emsp;<span ><span>`); 	
			   $(".user-name:last").text(msg.header);
			   $("span:last").text(msg.value);
		   }else if(JSON.stringify(msg.header).includes('名成員在線上')){
			   $("#msg-io").append(`<div class='user-name'></div><span><span>`); 
			   $("#connect-count").text(msg.header);
			   $("span:last").text(msg.value);
			   }
		   else{
	   $("#msg-io").append(`<div class='user-name'></div>&emsp;<span><span>`); 	
	   $(".user-name:last").text(msg.header);
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




})

</script>
</head>
<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>

<br>
<br>
<br>
<br>
<div class="page-wrapper">

	<div class="chatroom">
	   	<div class="chatheader">
			<h3 class="title">後臺客服</h3>
			<span id="connect-member"></span>
			<span id="connect-count"></span>
			<span id="connect-status">離線中</span>
		</div>
		<form id="form1">
			<div class="form-group">
				<div class="form-control" id="msg-io"></div>
			
			<div class="input-area">
			<select id="select" name="selector">
						<option selected value="all">聊天室廣播</option>
						<option  value="one">悄悄話</option>
						
		    </select>
				<input type="text"   name="msg-input2" id="msg-name" placeholder="請輸入對象" >
				<input type="text" name="msg-input" id="msg-input"
					placeholder="請輸入訊息" />
				<button type="submit" id="submit">送出</button>
			</div>
			</div>

		</form>
		



	</div>
</div>


</body>
</html>