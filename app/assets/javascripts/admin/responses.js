// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function(){
    
    $(".response_content,.preview").each(function(){
    	var _this = $(this);
    	var media_id = _this.data("media_id");
    	var msgtype = _this.data("msgtype");
    	if(msgtype==="text"){
    	    _this.text(media_id);
    	}
    	$.ajax({
    		url:"/admin/materials/"+media_id,
    		dataType: "json",
            success:function(response){
                var media_wrapper=$("<div class='response_media_wrapper'></div>");
    			if(msgtype==="mpnews"){
    			    var ul = $("<ul></ul>");
    			    response.content.news_item.forEach(function(item){
    			        var li = "<li>"+item.title+"</li>";
    			        ul.append(li);
    			    });
    			    media_wrapper.append(ul);
    			}else if(msgtype==="image"){
    			   var image = "<img src='"+ response.url +"'>"
    			   media_wrapper.append(image);
    			}
    			media_wrapper.appendTo(_this);
    		},
    		error:function(response){
    			console.log(response);
    		}
        });
    });
    
    $(".new_response #response_msgtype,.edit_response #response_msgtype").change(function(){
        var msgtype = $(this).val();
        var input= $("#response_message");
        input.val("");
        if(msgtype === "mpnews"){
            input.attr('readonly', true).addClass("hidden");
            media_picker.fetch({type:"news",offset:"0",count:"10"},function(target){
                var media_id = $(target).data('media_id');
                input.val(media_id);
                $('.preview').empty().append($(target).removeClass('col-sm-4'));
                $('#mediaModal').modal('hide');
            });
        }else if(msgtype === "image"){
            input.attr('readonly', true).addClass("hidden");
            media_picker.fetch({type:"image",offset:"0",count:"10"},function(target){
                var media_id = $(target).data('media_id');
                input.val(media_id);
                $('.preview').empty().append($(target).removeClass('col-sm-4'));
                $('#mediaModal').modal('hide');
            });
        }else{
            input.attr('readonly', false).removeClass("hidden");
        }
    });
});