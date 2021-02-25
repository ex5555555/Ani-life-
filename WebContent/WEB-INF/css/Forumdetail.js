$(function(){
 $(".dropdown-menu").hide();

		$(".dropdown-toggle").click(function(e){
    	e.preventDefault();
        var id =$(this).attr('id');
        if(!($(`#${id} +  .dropdown-menu`).hasClass("a-show"))){
            $(`#${id} + .dropdown-menu`).show();
            $(`#${id} + .dropdown-menu`).addClass("a-show");
        }else{
            $(`#${id} + .dropdown-menu`).hide();
            $(`#${id} + .dropdown-menu`).removeClass("a-show");
        }
    })
	
})