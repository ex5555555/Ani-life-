$(function(){
	loadMyCart();
	function loadMyCart(){
		$.ajax({
		url:"loadMyCart",
		type:"POST",
		dataType:"json",
		success:function(result){
				var s ="";
				var sum=0;
				var count =0;
				if(result.length==0){
					$("#cartTable").html("<div style:'text-align:center'>購物車是空的</div>");
					$("#badge").html(count);
					$(".total-price").html(`<div class=container><div class="row"><div class="col-12"><a href="getAllProduct"><button id="backToshop" class="check">去購物</button></a></div></div></div>`)
				}else{
				$.each(result,function(i,v){
					count+=1;
					sum+=v.price*v.quantity;
					s+=`<tr><td><div class="cart-info"><c:if test="${v.img!=null}"><div class="img-container"><img src="/img/${v.img}" ></div></c:if><div><p>${v.name}</p><small>庫存:${v.Stock}</small></div></div></td><td id="delAction"><button type="button" id="${v.id}" class="delproduct btn bg-danger"><i class="fa fa-trash" ></i></button></td><td><div class="btnninput"><button class='qtyMinus' name="${v.id}"><i class="fa fa-minus"></i></button><input type="text" class="pqty" value="${v.quantity}"><button class='qtyAdd' name="${v.id}"><i class="fa fa-plus"></i></button></div></td><td>${v.price}</td><td>${v.price*v.quantity}</td></tr>`
				});
				$("#cartTable").html(s);
				$(".total-price").html(`<table><tr><td colspan="2"><h3>總計</h3></td><td>${sum}</td></tr><tr><td colspan="2"><a href="SelectCondition?how=1&currpage=0&condition=不用&max=0&min=0"><button id="back2shop" class="check">繼續購物</button></a></td><td><a href="check"><button class="check">結帳</button></a></td></tr></table>`)
				$("#badge").html(count);}
				
				}
		})
		}
		
		$(document).on('click','.qtyMinus',function(e){
			e.preventDefault();
			var index=$(this).parent().parent().parent().index();
			console.log(index)
			var qty=parseInt($(`.pqty:eq(${index})`).val());
			if(qty<=1){return;
			}else{
		    var productid =$(this).attr('name');
			fetch("changeQuantity?id="+productid+"&quantity="+(qty-1),{method:"GET"})
			.then(response=>{return response;})
			.then(result=>{loadMyCart();})}		
	})
		$(document).on('click','.qtyAdd',function(e){
			e.preventDefault();
			var index=$(this).parent().parent().parent().index();
			var qty=parseInt($(`.pqty:eq(${index})`).val());
		    var productid =$(this).attr('name');
			var stock =$(`.${productid}stock`).attr('name');
			
			fetch("changeQuantity?id="+productid+"&quantity="+(qty+1),{method:"GET"})
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
		
	
})