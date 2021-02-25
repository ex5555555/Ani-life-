<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        /* footer */
        *{
            margin: 0;
            padding: 0;
        }
    .footer{
        background-color:#1a1919 ;
        color: #b3b3b3;
        font-size: 15px;
        padding: 0 20px;
        position: relative;
        }
    .footer h3{
        color: #fff;
        margin-bottom: 10px;
        font-size: 40px;
    }
    .footer-col-1{
        flex-basis: 60%;
        min-width: 500px;
        margin-bottom: 20px;
    }
    .footer-imgcontainer{
    	width: 100%;
    	position: relative;
    	height: 100px;
    	border-bottom: 5px solid tomato;
    	margin-bottom: 10px;
    }
    .footer-imgcontainer img{
    	position: absolute;
    	max-height: 100%;
    	top:0;
    	left: 0;
    }

    .footer-container{
            max-width: 1300px;
            margin: auto;
            padding-left: 25px;
            padding-right: 25px;
    }
    .footer-row{
        padding-top:10px;
        padding-bottom: 5px;
        display: flex;
        flex-wrap: wrap;
    }
    .footer-col-1 p{
    	margin-bottom: 5px;
    }
    #footer-hr{
        margin: 10px 0;
        color:white;
    }
    .footer-bottom{
        text-align: center;
		margin-bottom: 0;
    }


    </style>
</head>
<body>
    <!-- footer -->
 <div class="footer">
    <div class="footer-container">
        <div class="footer-row">
            <div class="footer-col-1">
            	<div class="footer-imgcontainer">
               	<img alt="" src="/img/ani-lifewhite.png">
               </div>
                <h3>聯絡我們</h3>
                <p>我們會用最快的速度回應您的需求</p>
               <i class="fa fa-envelope"> aniLife@gamil.com</i>
              
            </div>
        </div>
        <hr id="footer-hr">
        <p class="footer-bottom"> &copy; Ani-life.com | Alawys by Your Side</p>
    </div>
</div>
</body>
</html>