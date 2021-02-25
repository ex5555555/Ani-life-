<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
	<script src="${path}/css/javascripts/jquery-3.5.1.min.js"/></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>

  
   
    <link rel="stylesheet" href= "https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
   
    <script type="text/javascript">
    $(function(){
    	var how=`${how}`
    	var url;
    	var title;
    	if(how==1){
    		url='salepaper ';
    		title= '銷售排名(前10名)';
    	}
    	if(how==2){
    		url=  'brandpaper';
    		title='  品牌銷售排行';
    	}
    	if(how==3){
    		url='monsalepaper';
    		title='  月銷售量';
    	}

    	
    	google.charts.load('current', {'packages':['corechart']});
        google.charts.setOnLoadCallback(drawChart);

     function drawChart() {
    if(how!=3){
    	 var name2 = [];
    	 name2.push(['Task', 'Hours per Day'])
          	$.ajax({
                   url: url,
                   dataType: "json",
                   async: false,
                   success:function(result){
                	   $.each(result,function(i,v){
    						
    					var name = [];
    						name[0]=v.productname;
    						name[1]=v.sum;
    						console.log(name);
    						  name2.push(name);
    						
                    	   })
                       }
             })
        	 
             var data = new google.visualization.arrayToDataTable(name2);

             
             var options = {
               title: title
             };

             var chart = new google.visualization.PieChart(document.getElementById('piechart'));

    }


    if(how==3){
    	 var name2 = [];
    	 name2.push(['Month', '銷售額'])
         	$.ajax({
                  url: url,
                  dataType: "json",
                  async: false,
                  success:function(result){
               	   $.each(result,function(i,v){
    						
    					var name = [];
    						name[0]=v.productname;
    						name[1]=v.sum;
    						console.log(name);
    						  name2.push(name);
    						
                   	   })
                      }
            })
       	 
            var data = new google.visualization.arrayToDataTable(name2);

            
            var options = {
              title: title,
              curveType: 'function',
              legend: { position: 'bottom' }
              
            };

            var chart = new google.visualization.LineChart(document.getElementById('piechart'));

    }



             chart.draw(data, options);
         
        }

    	
    })
    
    </script>
<style type="text/css">

#tools a{
	color:#4a4a4a;
	border: none;
}


.main{
	position: absolute;
	top:50%;
    left: 50%; 
    transform: translate(-50%,-50%); 
    weight:100%;
    height:100%;
    /* margin-top:100px; */
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
}

.inside{
	margin: 2px;
	margin-top: 10px;
	color:#585858;
	float:right;
}
.producttitle{
	font-size:22px;
}
.productlist{
	font-size:18px;
}
.product{
	background-color: rgb(239 239 239 / 50%);
	color:#585858;
}
.product:hover{
	background-color: #ddd;
	transition-duration: 0.4s;
}
.id{
	color:rgb(3 93 88);
	font-weight:bold;
}
div.scrollable  /* scrollbar */
{
	width:100%;
	max-height: 150px;
	overflow-y: scroll;
	padding:10px;
}
div::-webkit-scrollbar { 
    display: none; 
}
#piechart{
position: relative;
right: 50px;
bottom: 150px;

}
</style>
    
  </head>
  <body>
<jsp:include page="/WEB-INF/Backstage/BackSideheader.jsp"></jsp:include>



<div class="main" style="width: 1500px;" align="center">


<div style="margin-top:100px;" align="center">
 
  
  <div id="tools" style="width: 1496px; height:100px;" align="center">
    <div class="item px-5">
    	<a target="blank" href="paper?how=1&eeaccount=${eeaccount}">銷售報表</a>
    </div>
    <div class="item px-5">
    	<a target="blank" href="paper?how=2&eeaccount=${eeaccount}">品牌銷售報表</a>
    </div>
    <div class="item px-5">
    	<a target="blank" href="paper?how=3&eeaccount=${eeaccount}">月銷售報表</a>
    </div>
  </div>
  
  <div style="display: flex; flex-direction: row;">
     <div id="piechart" style="width: 1800px; height: 700px; margin-top:150px; float:left;"></div>
  
  
  <div>
		<c:choose>
		<c:when test="${how==1 }">		
				<div class="inside" style="width:380px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="7%" style="text-align:center;">狀態</th>
								<th scope="col" width="20%"style="text-align:center;">名稱</th>
								<th scope="col" width="7%" style="text-align:center;">類型</th>
								<th scope="col" width="5%" style="text-align:center;">價格</th>
								<th scope="col" width="10%"style="text-align:center;">品牌</th>
								<th scope="col" width="10%" style="text-align:center;">銷量(件)</tr>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${productlist}">
								<tr class="product" style="line-height:25px;" height="100px">
									
									<td class="status" style="text-align:center;">${product1.status }</td>
									
									<td class="name"><div class="scrollable">${product1.productName }</div></td>
								
									<td class="classification" style="text-align:center;">${product1.classification}</td>
									<td class="price" style="text-align:center;">NT$ ${product1.price }</td>
									
									<td class="brand" style="text-align:center;">${product1.brand }</td>
								
									
									<td style="text-align:center; padding: 10px;">${product1.sum }件</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			<c:when test="${how==2 }">		
				<div class="inside" style="width: 380px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">品牌</th>
								<th scope="col" width="5%" style="text-align:center;">總和(元)</th>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${productlist}">
								<tr class="product" style="line-height:25px;" height="100px">
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td style="text-align:center; padding: 10px;">${product1.sum }元</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			<c:when test="${how==3}">		
				<div class="inside" style="width: 380px; height:auto;">
					<table class="producttable" style="border-collapse:separate; border-spacing:0px 10px;">
						<thead class="producttitle">
							<tr>
								<th scope="col" width="5%" style="text-align:center;">月份</th>
								<th scope="col" width="5%" style="text-align:center;">總和(元)</th>
							</tr>
						</thead>
						<tbody class="productlist">
							<c:forEach var="product1" items="${productlist}">
								<tr class="product" style="line-height:25px;" height="100px">
									<td class="brand" style="text-align:center;">${product1.brand }</td>
									<td style="text-align:center; padding: 10px;">${product1.sum }元</td>
										
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</c:when>
			</c:choose>		
  </div>
	</div>
</div>
</div>

			
			
  </body>
</html>