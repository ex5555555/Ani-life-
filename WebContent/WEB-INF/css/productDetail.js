$(function(){
	//購物車隱藏
	$(".mycart").hide();

	loadMyCart();
	function loadMyCart(){
		$.ajax({
		url:"loadMyCart",
		type:"POST",
		dataType:"json",
		success:function(result){
			//	var rs =JSON.parse(JSON.stringify(result));
				var s ="";
				var sum=0;
				var count =0;
				if(result.length==0){
					$("#cartTable").html("購物車是空的");
					$("#badge").html(count);
					$(".sum-btn").html(`<h3>總計${sum}</h3>`);
					
				}else{
				
				$.each(result,function(i,v){
					count+=1;
					sum+=v.price*v.quantity;
					s+=`<tr><td>${v.name}</td><td>${v.quantity}</td><td>${v.price*v.quantity}</td><td class="brand"><button type="button" id="${v.id}" class="delproduct"><i class="fa fa-trash "></i></button></td></tr>`
				});
				$("#cartTable").html(s);
				$(".sum-btn").html(`<h3>總計${sum}</h3><a href="goToCart"><button class="gocart">查看購物車<i class="fa fa-hand-o-right "></i></button></a>`)
				$("#badge").html(count);}
				}
		})
		}
	
	$(document).on('click','.add2Cart',function(e){
			e.preventDefault();
		    var productid =$(this).attr('id');
			var qty=$(".pqty").val();
			fetch("addToCart?id="+productid+"&quantity="+qty,{method:"GET"})
			.then(response=>{return response;})
			.then(result=>{loadMyCart();})

		})
		

	$(document).on('click','.delproduct',function(e){
			e.preventDefault();
		    var productid =$(this).attr('id');

			fetch("deletProduct?id="+productid,{method:"GET"})
			.then(response=>{return response;})
			.then(result=>{loadMyCart();})
		
				
	})
	$(".pqty").val(1);
	$("#qtyMinus").click(function(){
		var qty=$(".pqty").val();
		if(qty<=1){
			return;
		}else{
			$(".pqty").val(qty-1);
		}
	})
	
	$("#qtyAdd").click(function(){
		var qty=parseInt($(".pqty").val());
		var stock =$(".stock").attr("name");
		if(qty>=stock){
			$(".pqty").val(stock);
			alert("已達上限");
		}else{
			$(".pqty").val(qty+1);}
		
	})
	
	//評價非同步
	$("#grade-button").click(function(e){
		e.preventDefault();
		$(".gen-grade").hide();
		$.ajax({
			url:"genGrade",
			type:"POST",
			data:$("#grade-form").serialize(),
			dataType:"json",
			success:function(result){
				console.log(result);
				var grade = result.detail.grade;
				var str ="";
				for(let i =0;i<5;i++){
					if(i<grade){
						str += '<i class="fa fa-star star-selected"></i>';
					}else{
						str += '<i class="fa fa-star-o"></i>';
					}
				}
				$("#new-grade").addClass("each-grade");
				$("#new-account").append(`<div>${result.detail.account}</div>`);
				$("#new-grade").append('<div class="grade">'+str+'</div>');
				$("#new-gradecontent").append(`<div>${result.detail.gradecontent}</div>`);
				
			}})
	})
	
	$(".score_star i").hover(function(){
		var index = $(this).index();
		var i =$(this).parent().find("i");
		i.removeClass("star-selected");
		i.removeClass("fa-star");
		i.addClass("fa-star-o");
		switch(index){
			case 0:
				i.slice(0,1).removeClass("fa-star-o");
				i.slice(0,1).addClass("fa-star");
				i.slice(0,1).addClass("star-selected");
				$("#grade-value").val(1);
			break;
			
			case 1:
				i.slice(0,2).removeClass("fa-star-o");
				i.slice(0,2).addClass("fa-star");
				i.slice(0,2).addClass("star-selected");
				$("#grade-value").val(2);
			break;
			
			case 2:
				i.slice(0,3).removeClass("fa-star-o");
				i.slice(0,3).addClass("fa-star");
				i.slice(0,3).addClass("star-selected");
				$("#grade-value").val(3);
			break;
			
			case 3:
				i.slice(0,4).removeClass("fa-star-o");
				i.slice(0,4).addClass("fa-star");
				i.slice(0,4).addClass("star-selected");
				$("#grade-value").val(4);
			break;
			
			case 4:
				i.slice(0,5).removeClass("fa-star-o");
				i.slice(0,5).addClass("fa-star");
				i.slice(0,5).addClass("star-selected");
				$("#grade-value").val(5);
			break;
			
			default:
			
			alert("操作錯誤");
			break;
			
		}
	})
	
	//五星評分
	$(".score_star i").click(function(){
		var index = $(this).index();
		var i =$(this).parent().find("i");
		i.removeClass("star-selected");
		i.removeClass("fa-star");
		i.addClass("fa-star-o");
		switch(index){
			case 0:
				i.slice(0,1).removeClass("fa-star-o");
				i.slice(0,1).addClass("fa-star");
				i.slice(0,1).addClass("star-selected");
				$("#grade-value").val(1);
				console.log($("#grade-value").val());
			break;
			
			case 1:
				i.slice(0,2).removeClass("fa-star-o");
				i.slice(0,2).addClass("fa-star");
				i.slice(0,2).addClass("star-selected");
				$("#grade-value").val(2);
				console.log($("#grade-value").val());
			break;
			
			case 2:
				i.slice(0,3).removeClass("fa-star-o");
				i.slice(0,3).addClass("fa-star");
				i.slice(0,3).addClass("star-selected");
				$("#grade-value").val(3);
				console.log($("#grade-value").val());
			break;
			
			case 3:
				i.slice(0,4).removeClass("fa-star-o");
				i.slice(0,4).addClass("fa-star");
				i.slice(0,4).addClass("star-selected");
				$("#grade-value").val(4);
				console.log($("#grade-value").val());
			break;
			
			case 4:
				i.slice(0,5).removeClass("fa-star-o");
				i.slice(0,5).addClass("fa-star");
				i.slice(0,5).addClass("star-selected");
				$("#grade-value").val(5);
				console.log($("#grade-value").val());
			break;
			
			default:
			
			alert("操作錯誤");
			break;
			
		}
		
	})
		
	
})