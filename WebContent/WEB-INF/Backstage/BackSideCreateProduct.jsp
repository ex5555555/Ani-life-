<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>產品新增</title>
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
<script src="${path }/css/javascripts/jquery-ui.min.js"></script>
<style type="text/css">
html{
	height:100%;
	/* background: linear-gradient(45deg,  rgba(145,155,155,1) 0%, rgba(43,53,53,1) 100%) no-repeat fixed; */
}
#tools a{
	color:#4a4a4a;
	border: none;
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
  	color: #383838;
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
	padding: 20px;
}
.inside{
	margin: 2px;
	margin-top: 50px;
	background-color: rgb(239 239 239 / 50%);
	font-size:18px;
	color:#585858;
}
h2{
	color: #cccccc;
	font-size:36px;
	padding-top: 15px;
}
.addproduct{
	/* padding-bottom:15px; */
	padding: 5px;
}
.textarea{
	float:right;
}
</style>
<meta name="viewport" content="width=device-width">
</head>
<body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>


<div class="main" style="width: 1500px;">
  <div id="tools" style="width: 1496px; height:100px;" align="left">
	  <div class="item">
	    <a href="bsGetAllProduct?eeaccount=${eeaccount}">檢視全部</a>
	  </div>
	  <div class="item">
	    <a href="statusOpen?status=上架中&eeaccount=${eeaccount}">上架中</a>
	  </div>
	  <div class="item">
	    <a href="statusClose?status=下架中&eeaccount=${eeaccount}">下架中</a>
	  </div>
	  <div class="item">
	    <a href="stocknone?stock=0&eeaccount=${eeaccount}">缺貨</a>
	  </div>
	  <div class="item">
	    <a href="toBsCreateProduct?eeaccount=${eeaccount}">新增產品</a>
	  </div>
	  <div class="item">
		<form method="post" action="bsSelectSpecies2">
		  <span>寵物分類</span>
		  <select name="species" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="狗">狗</option>
		    <option value="貓">貓</option>
		  </select>
		  <input type="hidden" name="eeaccount" value="${eeaccount}">
		</form>
	  </div>
	  <div class="item">
		<form method="post" action="bsSelectClass2">
		  <span>產品分類</span>
		  <select name="classification" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="飼料">飼料</option>
			<option value="罐頭">罐頭</option>
			<option value="玩具">玩具</option>
			<option value="寵物用品">寵物用品</option>
			<option value="美容護理">美容護理</option>
			<option value="環境清潔">環境清潔</option>
		  </select>
		   <input type="hidden" name="eeaccount" value="${eeaccount}">
		</form>
	  </div>
	  <div class="item">
		<form method="post" action="bsSelectBrand2">
		  <span>品牌分類</span>
		  <select name="brand" onchange="this.form.submit()">
		    <option value="" selected disabled>請選擇</option>
		    <option value="ROYAL法國皇家">ROYAL 法國皇家</option>
			<option value="BLACKWOOD柏萊富">BLACKWOOD 柏萊富</option>
			<option value="ORIJEN渴望">ORIJEN 渴望</option>
			<option value="Toma-pro優格">Toma-pro 優格</option>
			<option value="Nutram紐頓">Nutram 紐頓</option>
			<option value="Hills希爾思">Hills 希爾思</option>
		  </select>
		   <input type="hidden" name="eeaccount" value="${eeaccount}">
		</form>
	  </div>
	  <div class="item">
	    <form method="post" action="bsSelectPrice">
		  <div>
		  	<div>
		      <span>最低價格</span><input type="text" name="min" placeholder="請輸入價格" value="1000"></input>
		    </div>
		    <div>
		      <span>最高價格</span><input type="text" name="max" placeholder="請輸入價格" value="2000"></input>
		    </div>
		    <button type="submit" style="display:none;">送出</button>
		  </div>
		   <input type="hidden" name="eeaccount" value="${eeaccount}">
		</form>
	  </div>
  </div>
  <!-- tools -->


  <div class="inside" style="width: 1496px; height:auto;" align="center">
  	 <h2>新增產品</h2>
	 <hr style ="border：2px;">
	 
	 <div class="addproduct" style="width: 800px;height:auto;" align="left">
			<form action="bsAddProduct" method="post" enctype="multipart/form-data">
			
					<div class="textarea">
					<span style="margin-right: 20px; margin-left:20px; vertical-align:top;">說明</span>
					<textarea name="descripton" autocomplete="off" required id="descripton" style="width: 450px; height:300px; 
					max-width:450px; max-height:300px; color: #585858;" placeholder="descripton" class="insertbox">
					</textarea>
					<br>
					<br>
					 <input type="hidden" name="eeaccount" value="${eeaccount}">
					<div align="right">
					<p>
		        	<input class="updatebutton" type="submit" value="新增產品">
		        	</p>
		        	
		        	<input class="deletebutton" type="button" value="回產品頁" onclick="location.href='bsProductManagement?eeaccount=${eeaccount}'"></input>
					</div>
					</div>
					
					<div class="left">
					<div>
					<span style="margin-right: 20px;">名稱</span>
					<input type="text" name="productname" id="productName"
					placeholder="productname" class="insertbox" autocomplete="off" required>
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">價格</span>
					<input type="text" name="price" id="price" placeholder="price"
					class="insertbox" autocomplete="off" required>
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">庫存</span>
					<input type="text"
					name="stock" id="stock" placeholder="stock" class="insertbox" 
					autocomplete="off" required>
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">狀態</span>
					<select name="status" style="width: 194px;">
					<option disabled="true">請選擇</option>
					<option value="上架中" selected>上架中</option>
					<option value="下架中">下架中</option>
					</select>
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">寵物</span>
					<select name="species" style="width: 194px;">
					<option disabled="true">請選擇</option>
					<option value="狗" selected>狗</option>
					<option value="貓">貓</option>
					</select> 
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">類型</span>
					<select name="classification" style="width: 194px;">
					<option disabled="true">請選擇</option>
					<option value="飼料" selected>飼料</option>
					<option value="罐頭">罐頭</option>
					<option value="玩具">玩具</option>
					<option value="寵物用品">寵物用品</option>
					<option value="美容護理">美容護理</option>
					<option value="環境清潔">環境清潔</option>
					</select>
					</div>
					<br>
					
					<div>
					<span style="margin-right: 20px;">品牌</span>
					<select name="brand" style="width: 194px;">
					<option disabled="true">請選擇</option>
					<option value="ROYAL法國皇家" selected>ROYAL 法國皇家</option>
					<option value="BLACKWOOD柏萊富">BLACKWOOD 柏萊富</option>
					<option value="ORIJEN渴望">ORIJEN 渴望</option>
					<option value="Toma-pro優格">Toma-pro 優格</option>
					<option value="Nutram紐頓">Nutram 紐頓</option>
					<option value="Hills希爾思">Hills 希爾思</option>
					</select>
					</div>
					<br>
					
					<div>
						<input type="file" name="myfile" />
					</div>
					<div>
						<img height="200" width="200"/>
					</div>
					<script src="https://code.jquery.com/jquery-3.1.0.js"></script>
					<script>
					 $('input').on('change', function(e){      
					      const file = this.files[0];
					      
					      const fr = new FileReader();
					      fr.onload = function (e) {
					        $('img').attr('src', e.target.result);
					      };
					      fr.readAsDataURL(file);
					    });
					</script>
					
		        
		        
				<!--         <input type ="button" onclick="history.back()" value="回到上一頁"></input> -->
					</div>

		    </form>
		    
		    
	 </div>
	 <br>
	 <br>
	 
	 
  </div>
  
  <div style="width: 1496px; height:100px;" align="left">
    
<!-- main -->
</div>
<!--  -->
</body>
</html>