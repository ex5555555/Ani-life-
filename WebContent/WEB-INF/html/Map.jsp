<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD_ry8OhM_uQP_D8VjlwINRaeTvMXeOzy0&callback=initMap&libraries=&v=weekly"
	defer></script>
	<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
	<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<script src="${path }/css/javascripts/jquery-3.5.1.min.js" /></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" />
	<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>



<script type="text/javascript" src="${path }/css/map.js">
</script>
<link href="<c:url value="/css/map.css"/>" rel="stylesheet">
<script type="text/javascript" src="${path}/css/productDetail.js"></script>

<script>

var starting ='南投地理中心'
var  geocoder;
var address = '高雄資策會';
var init = ${init};
var zoom=7 ;
var navigation =${navigation};
if(${neww=='a'}){
	address=`${mmm.dress}`;
}
if(navigation==true){
	starting =	`${starting}`
}

var country =${country} ;
if(country == true){
	 starting = `${countryname}`;
	 zoom = 12;
}

var type= ${type2};

var  lat;
var lng;
var marker
  function initMap() {	
	  if(init==true){
		  
	 var markers = [];
    var infowindows = [];
	 geocoder = new google.maps.Geocoder();  
	    // 初始化地圖
    var  map = new google.maps.Map(document.getElementById("map"), {
       zoom: zoom,               
       mapTypeId: 'terrain',        
        styles: null
   });

   geocoder.geocode( { 'address': starting  }, function(results, status) {
	    if (status == 'OK') { 
	    	 map.setCenter(results[0].geometry.location);  
	  loadMyCart();
		function loadMyCart(){
			$.ajax({
			url:"gomapjson",
			type:"POST",
			data:{'city':starting,'type':type},
			dataType:"json",
			success:function(result){  	
				console.log(result) 
				 
   $.each(result,function(i,v){ 		    	
		    	markers[i] = new google.maps.Marker({
	          map: map,
	          icon: '/img/cathead.png',
	          position: {
	        	  lat: v.mappp.lat  ,
	  	        lng: v.mappp.lng
		          },
	         animation: google.maps.Animation.BOUNCE
	      });

			  infowindows[i] = new google.maps.InfoWindow( 
				  {
				     content:v.mappp.mapname,    
				            
				     position:{
				    	  lat: v.mappp.lat  ,
				  	        lng: 	  v.mappp.lng					     },
				     maxWidth: 200,
				 }

					 )
		        //點擊事件
		     var markerr = markers[i];
                    markerr.addListener('click', function () {
                    	 infowindows[i].open(map, markers[i]);	
                    })				  
  
		    })//foreach
      
			} //success
			})//ajax
		 }
	    }
    })//外框 map中心
}if(init ==false){

	 geocoder = new google.maps.Geocoder();  
	    // 初始化地圖
 var  map = new google.maps.Map(document.getElementById("map"), {
    zoom: 15,               
    mapTypeId: 'terrain',        
     styles: null
});

geocoder.geocode( { 'address': address}, function(results, status) {
	    if (status == 'OK') { 
	    	 map.setCenter(results[0].geometry.location);  
	     	
		    var	marker = new google.maps.Marker({
	          map: map,
	          icon: '/img/cathead.png',
	          position: results[0].geometry.location,
	         animation: google.maps.Animation.BOUNCE
	      });

			var  infowindow= new google.maps.InfoWindow( 
				  {
				     content: `<h1>${mmm.mapname}</h1>`,   				            
				     position:results[0].geometry.location,
				     maxWidth: 200,
				 }
					 )
		        //點擊事件		  
                 marker.addListener('click', function () {
                 	 infowindow.open(map, marker);	
                 })			   
		 }

})	
}	if(navigation==true){
	//取得目前座標
//	 navigator.geolocation.getCurrentPosition((position) => {	
//	 lat = position.coords.latitude;
//	  lng = position.coords.longitude;
		 
	 // 載入路線服務與路線顯示圖層
	 var directionsService = new google.maps.DirectionsService();
    var directionsDisplay = new google.maps.DirectionsRenderer();
    //初始化地址編碼
		 geocoder = new google.maps.Geocoder();  
		    // 初始化地圖
	 		var  map = new google.maps.Map(document.getElementById("map"), {
             zoom: 15,               
             mapTypeId: 'terrain',        
              styles: null
         });
	// 放置路線圖層
	  directionsDisplay.setMap(map);

geocoder.geocode( { 'address':starting }, function(results, status) {
		    if (status == 'OK') {
		 map.setCenter(results[0].geometry.location);
	 //進行地址編碼
	 geocoder.geocode( { 'address': address}, function(results2, status) {
		    if (status == 'OK') {
		     
//路線相關設定

var request;


if(${empty type or type == 1}){
 request = {
              origin:results[0].geometry.location  ,
               destination:results2[0].geometry.location ,
              travelMode: 'DRIVING'              
                        };
}
if(${type==2}){
	   request = {
	    origin: results[0].geometry.location,
	    destination: results2[0].geometry.location ,
	    travelMode: 'TRANSIT',
	    transitOptions: {modes:['BUS']}
	    }; 
	  }

  if(${type==3}){
   request = {
    origin: results[0].geometry.location,
    destination: results2[0].geometry.location ,
    travelMode: 'TRANSIT',
    transitOptions: {modes:['SUBWAY']}
    }; 
  }

// 繪製路線
directionsService.route(request, function (result3, status3) {
    if (status3 == 'OK') {
        //地圖標記   	
   	  directionsDisplay.setDirections(result3);
         }
})
//		繪製路線結束      
		      
		    } else {
		      console.log(status);
		    }
	
	          
		    
		  }); // 地址編碼結束   

		    }//地=ˋ次    

}); //第二次地址編碼
	// }); //取得目前座標結束括號


	
} 
	


//} 

	 //更改風格
     $("#dark").click(function () {
                    map.setOptions({
                        styles: style
                    });
                })
       $("#light").click(function () {
                    map.setOptions({
                        styles: null
                    });
                })

   //initmap結束
	  }
	


</script>

</head>
<body>

	<jsp:include page="/header.jsp"></jsp:include>

		
					<div class="select-list">
					<div class="btn-group">
					<c:if test="${countryname!=null}">
					<button type="button" class="btn btn-default dropdown-toggle"
							data-toggle="dropdown">${countryname}</button>
					</c:if>
					<c:if test="${countryname==null}">
						<button type="button" class="dropdown-toggle"
							data-toggle="dropdown">選擇縣市</button>
					</c:if>
						<div class="dropdown-menu">
							<a class="dropdown-item" href="gomap?currpage=0">各縣市</a> <a
								class="dropdown-item" href="gomapcity?city=基隆市&currpage=0">基隆市</a>
							<a class="dropdown-item" href="gomapcity?city=台北市&currpage=0">台北市</a>
							<a class="dropdown-item" href="gomapcity?city=新北市&currpage=0">新北市</a>
							<a class="dropdown-item" href="gomapcity?city=桃園市&currpage=0">桃園市</a>
							<a class="dropdown-item" href="gomapcity?city=新竹市&currpage=0">新竹市</a>
							<a class="dropdown-item" href="gomapcity?city=新竹縣&currpage=0">新竹縣</a>
							<a class="dropdown-item" href="gomapcity?city=苗栗縣&currpage=0">苗栗縣</a>
							<a class="dropdown-item" href="gomapcity?city=台中市&currpage=0">台中市</a>
							<a class="dropdown-item" href="gomapcity?city=彰化縣&currpage=0">彰化縣</a>
							<a class="dropdown-item" href="gomapcity?city=雲林縣&currpage=0">雲林縣</a>
							<a class="dropdown-item" href="gomapcity?city=台南市&currpage=0">台南市</a>
							<a class="dropdown-item" href="gomapcity?city=高雄市&currpage=0">高雄市</a>
							<a class="dropdown-item" href="gomapcity?city=屏東縣&currpage=0">屏東縣</a>
							<a class="dropdown-item" href="gomapcity?city=宜蘭縣&currpage=0">宜蘭縣</a>
							<a class="dropdown-item" href="gomapcity?city=花蓮市&currpage=0">花蓮市</a>

						</div>
					</div>
				


					<c:if test="${selection == 'selectClass' or selection == '24h' }">
						<label  onClick="location.href='select24h?currpage=0&city=${countryname}&type=1';"><img  src="/img/24.png">24小時</label> 
						<label  onClick="location.href='select24h?currpage=0&city=${countryname}&type=2';"><img   src="/img/急診.jpg">夜間急診</label>
						<label  onClick="location.href='select24h?currpage=0&city=${countryname}&type=3';"><img src="/img/24all.png">24H急診</label>
			     	</c:if>
					
					</div>	<%--SELECT-LIST --%>
					
					<div class="commens">
						<div class="commen"><img src="/img/google-map2.png">點擊查看位置</div>
						<div class="commen"><img src="/img/googlemap.jpg">雙擊進行導航</div>
					</div>
					<!--The div element for the map -->
				<div class="map-container">
					<div id="map" style="min-height: 500px; min-width: 800px;"></div>
				<div class="choose-mode">
					<button id="dark" type="button">夜間模式</button>
					<button id="light" type="button">日間模式</button>
				</div>
				</div>

					<%--result-area --%>
					<div class="result-area">
					<c:choose>
						<c:when test="${selection == 'selectClass' }">
							<c:forEach var="cityList" items="${cityList}">
								<c:if test="${mmm.id==cityList.id}">
								<div class="table-cont">
								<table>
											<tr>
												<td class="mapname">${cityList.mapname}  
												<c:if test="${cityList.h24 == 'y'}">
												<img  src="/img/小24.jpg">
												</c:if>
												<c:if test="${cityList.er == 'y'}">
												<img  src="/img/小急診.jpg">							
												</c:if>		
												</td>

											</tr>
											<tr>
												<%-- 																<td class="id">no.${cityList.id}</td> --%>
												<td class="tel">電話：${cityList.tel}</td>
											</tr>
											<tr>
												<td class="dress">${cityList.dress}</td>

											</tr>
									<table>
							</div>
												</c:if>
												<c:if test="${mmm.id!=cityList.id}">
													<div class="table-cont">
														<table>

															<tr>
																<td class="mapname">${cityList.mapname}
																<c:if test="${cityList.h24 == 'y'}">
												<img  src="/img/小24.jpg">
												</c:if>
												<c:if test="${cityList.er == 'y'}">
												<img  src="/img/小急診.jpg">							
												</c:if>		
																</td>
															</tr>
															<tr>
																<%-- 																<td class="id">no.${cityList.id}</td> --%>
																<td class="tel">電話：${cityList.tel}</td>
															</tr>
															<tr>
																<td><div class="dress">${cityList.dress}</td>
															</tr>
															</c:if>
															<tr>
																<td class="mapntrans">
																<a href="mapselect2get?id=${cityList.id}&city=${cityList.city}"><img
																		src="/img/google-map2.png"></a>
															
																<div class="navigation" id="${cityList.id}">
																		
																		<img src="/img/googlemap.jpg">
																		
																		<form
																			action="mapselect3?&${_csrf.parameterName}=${_csrf.token}"
																			method="post">
																			<input type="hidden" name="id" value="${cityList.id}">
																			<input type="hidden" name="city"
																				value="${cityList.city}"> <input
																				class="mystart" type="text" name="starting">
																			<input class="mystart sub" type="submit" value="導航">
																			<br> <label class="mystart">交通方式:</label> <label
																				class="mystart"><input class="mystart"
																				type="radio" name="type" value="1" checked>自駕車</label>
																			<label class="mystart"><input class="mystart"
																				type="radio" name="type" value="2">公車</label>
																			<c:if
																				test="${cityList.city=='高雄市' or cityList.city == '台北市'}">
																				<label class="mystart"><input
																					class="mystart" type="radio" name="type" value="3">捷運</label>
																			</c:if>
																		</form>
																	</td>

															</tr>
														</table>
													</div>

													</c:forEach>
													
													</div><%--result-area --%>
													
													<div class="page-btn">
													<c:if test="${totalpage<=10 && totalpage>1}">
														<ul class="pagination">
															<li class="page-item"><a class="page-link"
																href="gomapcity?currpage=0&city=${countryname}">&laquo;</a></li>
															<c:forEach begin="1" end="${totalpage}" var="page">
																<c:if test="${page==currpage+1}">
																	<li class="page-item active" class="page-item"><a
																		class="page-link"
																		href="gomapcity?currpage=${page-1}&city=${countryname}">${page}</a></li>
																</c:if>
																<c:if test="${page!=currpage+1}">
																	<li class="page-item " class="page-item"><a
																		class="page-link"
																		href="gomapcity?currpage=${page-1}&city=${countryname}">${page}</a></li>
																</c:if>
															</c:forEach>
															<li class="page-item"><a class="page-link"
																href="gomapcity?currpage=${totalpage}&city=${countryname}">&raquo;</a></li>
														</ul>
													</c:if>

													<c:if test="${totalpage>10}">
														<ul class="pagination">
															<li class="page-item"><a class="page-link"
																href="gomapcity?currpage=0&city=${countryname}">&laquo;</a></li>
															<c:forEach begin="${currpage-3}" end="${currpage+7}"
																var="page">
																<c:if test="${page==currpage+1}">
																	<li class="page-item active" class="page-item"><a
																		class="page-link"
																		href="gomapcity?currpage=${page-1}&city=${countryname}">${page}</a></li>
																</c:if>
																<c:if test="${page!=currpage+1}">
																	<li class="page-item " class="page-item"><a
																		class="page-link"
																		href="gomapcity?currpage=${page-1}&city=${countryname}">${page}</a></li>
																</c:if>
															</c:forEach>
															<li class="page-item"><a class="page-link"
																href="gomapcity?currpage=${totalpage}&city=${countryname}">&raquo;</a></li>
														</ul>
													</c:if>
													</div>
													</c:when>
													<c:when test="${selection == 'all' or empty selection }">
														
															<c:forEach var="MapList" items="${MapList}">
															<div class="table-cont">
																<table>

																	<tr>
																		<td class="mapname">${MapList.mapname}
																		<c:if test="${MapList.h24 == 'y'}">
												<img  src="/img/小24.jpg">
												</c:if>
												<c:if test="${MapList.er == 'y'}">
												<img  src="/img/小急診.jpg">							
												</c:if>		</td>

																	</tr>
																	<tr>
																		<%-- 																<td class="id">no.${cityList.id}</td> --%>
																		<td class="tel">電話：${MapList.tel}</td>
																	</tr>
																	<tr>
																		<td class="dress">${MapList.dress}</td>

																	</tr>
																	<tr>
																		<td class="mapntrans">
																			<a href="mapselect2get?id=${MapList.id}&city=${MapList.city}">
																			<img src="/img/google-map2.png"></a>
																			
																			<div class="navigation" id="${MapList.id}">
																				<img src="/img/googlemap.jpg">
																				
																				<form
																					action="mapselect3?&${_csrf.parameterName}=${_csrf.token}"
																					method="post">
																					<input type="hidden" name="id"
																						value="${MapList.id}"> <input
																						type="hidden" name="city" value="${MapList.city}">
																					<input class="mystart" type="text" name="starting">
																					<input class="mystart sub" type="submit" value="導航"><br>
																					<label class="mystart">交通方式:</label> <label
																						class="mystart"><input class="mystart"
																						type="radio" name="type" value="1" checked>自駕車</label>
																					<label class="mystart"><input
																						class="mystart" type="radio" name="type" value="2">公共運輸</label>
																					<c:if
																						test="${MapList.city=='高雄市' or MapList.city == '台北市'}">
																						<label class="mystart"><input
																							class="mystart" type="radio" name="type"
																							value="3">捷運</label>
																					</c:if>

																				</form>

																			</td>


																	</tr>
																</table>
																</div>
															</c:forEach>
															
															</div> <%--result-area --%>
															
															<div class="page-btn">
															<c:if test="${totalpage<=10 && totalpage>1}">
															
																<ul class="pagination">
																	<li class="page-item"><a class="page-link"
																		href="gomap?currpage=0">&laquo;</a></li>
																	<c:forEach begin="1" end="${totalpage}" var="page">
																		<c:if test="${page==currpage+1}">
																			<li class="page-item active" class="page-item"><a
																				class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																		</c:if>
																		<c:if test="${page!=currpage+1}">
																			<li class="page-item " class="page-item"><a
																				class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																		</c:if>
																	</c:forEach>
																	<li class="page-item"><a class="page-link"
																		href="gomap?currpage=${totalpage}">&raquo;</a></li>
																</ul>
															</c:if>

															<c:if test="${totalpage>10}">
																<ul class="pagination">
																	<li class="page-item"><a class="page-link"
																		href="gomap?currpage=0">&laquo;</a></li>
																	<c:if test="${currpage<5}">
																		<c:forEach begin="1" end="10" var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																		</c:forEach>
																	</c:if>
																	<c:if test="${ totalpage-currpage>=5}">
																		<c:forEach begin="${currpage-5}" end="${currpage+5}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>

																	<c:if test="${totalpage-currpage<5}">
																		<c:forEach begin="${currpage-4}" end="${totalpage}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="gomap?currpage=${page-1}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>
																	<li class="page-item"><a class="page-link"
																		href="gomap?currpage=${totalpage-1}">&raquo;</a></li>
																</ul>
																
															</c:if>
															
														</div>
														</div>
													</c:when>
													
													<c:when test="${selection == '24h' }">
													
															<c:forEach var="cityList" items="${cityList}">
															<div class="table-cont">
																<table>

																	<tr>
																		<td class="mapname">${cityList.mapname}
																		<c:if test="${cityList.h24 == 'y'}">
												<img  src="/img/小24.jpg">
												</c:if>
												<c:if test="${cityList.er == 'y'}">
												<img  src="/img/小急診.jpg">							
												</c:if>		</td>

																	</tr>
																	<tr>
																		<%-- 																<td class="id">no.${cityList.id}</td> --%>
																		<td class="tel">電話：${cityList.tel}</td>
																	</tr>
																	<tr>
																		<td class="dress">${cityList.dress}</td>

																	</tr>
																	<tr>
																		<td class="mapntrans">
																		<a href="mapselect2get?id=${cityList.id}&city=${cityList.city}"><img
																				src="/img/google-map2.png"></a>
																		<div class="navigation" id="${cityList.id}">
																				<img src="/img/googlemap.jpg">
																				<form
																					action="mapselect3?&${_csrf.parameterName}=${_csrf.token}"
																					method="post">
																					<input type="hidden" name="id"
																						value="${cityList.id}"> <input
																						type="hidden" name="city" value="${cityList.city}">
																					<input class="mystart" type="text" name="starting">
																					<input class="mystart sub" type="submit" value="導航"><br>
																					<label class="mystart">交通方式:</label> <label
																						class="mystart"><input class="mystart"
																						type="radio" name="type" value="1" checked>自駕車</label>
																					<label class="mystart"><input
																						class="mystart" type="radio" name="type" value="2">公共運輸</label>
																					<c:if
																						test="${cityList.city=='高雄市' or cityList.city == '台北市'}">
																						<label class="mystart"><input
																							class="mystart" type="radio" name="type"
																							value="3">捷運</label>
																					</c:if>

																				</form>

																			</div>
																			</td>


																	</tr>
																</table>
																</div>
															</c:forEach>
															<div class="page-btn">
															<c:if test="${totalpage<=10 && totalpage>1}">
																<ul class="pagination">
																	<li class="page-item"><a class="page-link"
																		href="select24h?currpage=0&city=${countryname}&type=${type2}">&laquo;</a></li>
																	<c:forEach begin="1" end="${totalpage}" var="page">
																		<c:if test="${page==currpage+1}">
																			<li class="page-item active" class="page-item"><a
																				class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																		</c:if>
																		<c:if test="${page!=currpage+1}">
																			<li class="page-item " class="page-item"><a
																				class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																		</c:if>
																	</c:forEach>
																	<li class="page-item"><a class="page-link"
																		href="select24h?currpage=${totalpage}&city=${countryname}&type=${type2}">&raquo;</a></li>
																</ul>
															</c:if>

															<c:if test="${totalpage>10}">
																<ul class="pagination">
																	<li class="page-item"><a class="page-link"
																		href="gomap?currpage=0">&laquo;</a></li>
																	<c:if test="${currpage<5}">
																		<c:forEach begin="1" end="10" var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																		</c:forEach>
																	</c:if>
																	<c:if test="${ totalpage-currpage>=5}">
																		<c:forEach begin="${currpage-4}" end="${currpage+5}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>

																	<c:if test="${totalpage-currpage<5}">
																		<c:forEach begin="${currpage-4}" end="${totalpage}"
																			var="page">
																			<c:if test="${page==currpage+1}">
																				<li class="page-item active" class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																			<c:if test="${page!=currpage+1}">
																				<li class="page-item " class="page-item"><a
																					class="page-link" href="select24h?currpage=${page-1}&city=${countryname}&type=${type2}">${page}</a></li>
																			</c:if>
																		</c:forEach>

																	</c:if>
																	<li class="page-item"><a class="page-link"
																		href="select24h?currpage=${totalpage-1}&city=${countryname}&type=${type2}">&raquo;</a></li>
																		
																</ul>
															</c:if>
														</div>
														</div>
													</c:when>
													</c:choose>

													</div>


													</div>

													<!-- class:row -->
													</div>
													<!-- class:container -->
													</div>


		 <%@ include file="footer.jsp" %>										
</body>
</html>