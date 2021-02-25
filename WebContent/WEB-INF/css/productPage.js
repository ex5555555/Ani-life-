
$(function(){



	loadMyCart();
	function loadMyCart(){
		
		$.ajax({
		url:"loadMyCart",
		type:"POST",
		dataType:"json",	
		success:function(result){
				//var rs =JSON.parse(JSON.stringify(result));
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
			fetch("addToCart?id="+productid+"&quantity=1",{method:"GET"})
			.then(response=>{
				return response;			
			      })
			.then(result=>{loadMyCart();})

		})
		

	$(document).on('click','.delproduct',function(e){
			e.preventDefault();
		    var productid =$(this).attr('id');
			fetch("deletProduct?id="+productid,{method:"GET"})
			.then(response=>{return response;})
			.then(result=>{loadMyCart();})
		
	})
		
	
})