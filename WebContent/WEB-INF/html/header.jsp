<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <c:set var="path" value="${pageContext.request.contextPath}"></c:set>
	<script src="${path}/css/javascripts/jquery-3.5.1.min.js"/></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
     @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap');
    *{
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: 'Poppins', sans-serif;
    }
    ul{
        list-style: none;
    }
	a:hover{
		text-decoration: none;
		color:white;
	}
    header{
        z-index: 2;
        width: 100%;
        height: 110px;
        padding: 25px 100px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        transition: 0.5s;
        box-sizing: border-box;
        background-color: rgb(248, 248, 248);
       
    }
    header.sticky{
        position: fixed;
        top: 0;
        left:0 ;
        background-color: white;
        padding: 10px 100px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.05);
        box-sizing: border-box;
    }

    header .logo{
        color: rgb(20, 20, 20);
        font-weight: 700;
        font-size: 2em;
    }
    header.sticky .logo{
        color: black !important;
    }

    header .menu-bar{
        width: 50%;
        float: right;
        box-sizing: border-box;
        
    }

    header .menu-bar ul{
        display: inline-flex;
        float: right;
        margin:auto 5px;
    }
    .menu-bar ul li{
        border-left: 1px solid #fff;
        padding: 15px 20px;
        text-align: center;
        cursor: pointer;
        min-width: 90px;
        position: relative;
    }

    .menu-bar ul li:hover{
        color: rgb(71, 189, 91) ;
    }
    .menu-bar ul #cart-con:hover{
        background-color: rgba(71, 189, 91, 0);
        color:tomato;
    }

    .menu-bar ul li i{
        font-size: 25px;
        margin-right: 5px;
    }
 
   
    header .navigation{
        position: relative;
        display: flex;
        
    }
    header .navigation li{
        list-style: none;
        margin-left: 30px;
    }
    a{
        text-decoration: none;
        color: rgb(22, 22, 22);
    }
    header.sticky .navigation a{
        color: black;
    }

    header .navigation li:hover{
        color: rgb(74, 202, 49);
        overflow: hidden;
    }
    
    .logout{
    	font-size:18px;
	  list-style: none;
   	  background-color: Transparent; 
      border-style: none;     /* 無邊框 */
      outline: none;      /* 獲得焦點也無邊框 */
}

	.logout:hover{
	   color: white;
	}

    .wrapper{
        min-height: 150%;
    }
    #logout,#login{
        outline: none;
        background: none;
        border: none;
        font-weight: 600;
        font-size: 18px;
    }
    
    .logout:hover{
        color: rgb(71, 189, 91) ;
        cursor: pointer;
    }
    #cart-con i{
    	position: relative;
    	font-size: 25px;
    }
    #badge{
    	position: absolute;
    	top:7%;
    	right:25%;
    	background: tomato;
    	border-radius: 50%;
    	width: 20px;
    	height: 20px;
    	font-size:14px;
    	box-sizing: border-box;
    	color:white;
    	display: flex;
    	justify-content: center;
    	align-items: center;
    }	
    .mycart{
    	position:fixed;
    	top:110px;
    	right:10px;
        z-index: 1000000;
        float: right;
        width: 35%;
        margin-right: 20px;
        min-width: 430px;
        padding: 20px 10px;
        background-color: white;
 
        box-shadow: 0 0 4px rgb(175, 175, 175);
    }
    .name p{
        position: relative;
        line-height: 1.5em;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 1;
        overflow: hidden;
    }
    .carttitle{
        color: rgb(114, 93, 87);
        font-size: 30px;
    }
    .mycart th{
        width: 100%;
        height: 8px;
        background-color: rgb(221, 110, 76);
    }
    .mycart td{
        padding: 7px 7px;
    }
    #cartTable{
        padding: 10px 0;
        font-size: 20px;
    }
    
    .fa-trash{
        font-size: 18px;
        padding: auto 2px;
    }
    .sum-btn{
        width:100%;
        text-align: end; 
        margin-bottom: 10px;
    }

    .sum-btn h3{
        letter-spacing: 4px;
        margin: 5px 0;
        color: rgb(68, 68, 68);
    }
    .sum-btn h3::before{
        content: "";
        width: 70%;
        height: 2px;
        background-color: rgb(255, 124, 84);
        display: inline-block;
        margin-right: 5px;
    }
    .gocart{
        font-size: 20px;
        background-color: rgb(255, 124, 84);
        height: 50px;
        width: 150px;
        font-weight: 600;
        color: rgb(20, 20, 20);
    }
    .gocart:hover{
        background-color: rgb(226, 103, 66);
        color: white;
        cursor: pointer;
    }
    .gocart i{
        margin-left: 2px;
    }
    .gocart i{
        margin-left: 2px;
    }

    @media (max-width:1350px){
        header{
            padding: 25px 50px;
        }
        .menu-bar{
            width: 50%;
        }
        .menu-bar ul{
            margin: 10px 0;
            width: 100%;
        }
        .menu-bar ul li{
            width: 100%;

        }
        .sum-btn{
        width: 100%;
        text-align: end;
        }
        .sum-btn h3::before{
        content: "";
        width: 80%;
        height: 2px;
        background-color: rgb(255, 124, 84);
        display: inline-block;
        margin-right: 5px;
        }
    }

    @media (max-width:1300px){
        header{
            padding: 25px 50px;
        }
        .menu-bar{
            width: 55%;
        }
        .menu-bar ul{
            margin: 10px 0;
            width: 100%;
        }
        .menu-bar ul li{
            width: 100%;

        }
    }

    </style>
    <script>
         $(function(){
            $(window).scroll(function(){
                var height =$(window).scrollTop();
                if(height>0){
                    $('header').addClass('sticky')
                }else{
                    $('header').removeClass('sticky')
                }
            })

            $(".memder-list").hide();
           
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

        })
    </script>
</head>
<body>
<% 
String account=SecurityContextHolder.getContext().getAuthentication().getName();
boolean status= false;
if(account==null||account=="anonymousUser"){
	status=false;
}else{
	status=true;
}
%>
	<div>
    <header>
        <div>
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
                <a href="select_member" id="member"><li><%= SecurityContextHolder.getContext().getAuthentication().getName() %>	
					<ul class="memder-list">
                        
                        <li><c:url value="/perform_logout" var="logoutUrl" />
                            <form method="post" action="${logoutUrl}">
                                 <input value="登出" type="submit" id="logout">  
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                             </form>
                        </li>
                    </ul>
                </li></a>
                <a class="showMyCart"><li id="cart-con"><i class="fa fa-shopping-cart" ></i><span class="p-1" id="badge">0</span></li></a>
            	</c:when>
          
            	<c:otherwise>
            		<c:url value="/perform_logoin" var="logoutUrl" />
            		<a href="perform_login"><li>登入

 					</li></a>
                	<a href="${path}/register.jsp"><li>註冊</li></a>
            	</c:otherwise>
            	
            	</c:choose>
            	
            	<%
					if (!"anonymousUser".equals(SecurityContextHolder.getContext().getAuthentication().getName())) {
				%>
            	<li>
            	<c:url value="/perform_logout" var="logoutUrl" />
				<form method="post" action="${logoutUrl}">
					<input value="登出" type="submit" class="logout">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
				</form>
				</li>
				<%
					}
				%>
            
            	
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
    
</body>
</html>