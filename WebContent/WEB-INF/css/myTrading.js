 $(function(){

            $(".detail-info").hide();

            $(".show-detail").click(function(){
            	var index =$(this).attr("name");
            	console.log(index);
                if(!$(this).hasClass("selected")){ 
                    $(`#${index}`).show();
                    $(this).addClass("selected");
                }else{ 
                    $(`#${index}`).hide();
                    $(this).removeClass("selected");
                }
            })
        })
