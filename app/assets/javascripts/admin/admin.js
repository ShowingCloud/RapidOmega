// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
var loading={
    on:function(){
        $("#loading").removeClass("hidden");
    },
    off:function(){
        $("#loading").addClass("hidden");
    }
}
var media_picker={
    init:function(selector,query_option,callback){
        query_option.type = query_option.type || "news";
        query_option.offset = query_option.offset || "0";
        query_option.count = query_option.count || "10";
        $(selector).on('click',function(){
            var _query_option = jQuery.extend({}, query_option);
            media_picker.fetch(_query_option,callback);
        });
    },
    fetch:function(query_option,callback){
        loading.on();
        console.log("query_option:"+JSON.stringify(query_option));
        var trans={"news":"图文","image":"图片","video":"视频","voice":"语音"};
        $.ajax({
                url: "/admin/materials",
                data: query_option,
                dataType: "json"
            }).done(function(response) {
                loading.off();
                console.log(response);
                $('#mediaModal').modal();
                $('#mediaModal .modal-body .row').empty();
                if (response.item.length) {
                    $('#mediaModal .modal-title').text("选择"+trans[query_option.type]+"("+response.total_count+")");
                    response.item.forEach(function(ele) {
                        console.log(JSON.stringify(ele));
                        var col = $('<div class="col-sm-4 item"></div>');
                        col.data('media_id', ele.media_id);
                        if(query_option.type==="news"){
                            var ul = $('<ul class="media-content"></ul>');
                            ele.content.news_item.forEach(function(c) {
                                var li= $('<li><h5>' + c.title + '</h5></li>');
                                ul.append(li);
                            }); 
                            col.append(ul);
                        }
                        
                        if(query_option.type==="image"){
                            var image_wrapper = $('<div class="media-content"></div>');
                            var image = $('<img style="width:100%">');
                            image.attr("src",ele.url);
                            image_wrapper.append(image)
                            col.append(image_wrapper);
                        }

                        $('#mediaModal .modal-body .row').append(col);
                    });
                    query_option.offset=parseInt(query_option.offset) + parseInt(query_option.count);
                    var page_num = Math.ceil(query_option.offset/ query_option.count);
                    console.log(page_num);
                    jspager.init(query_option.count,response.total_count,$("#mediaModal .modal-footer"),page_num,function(page){
                        media_picker.fetch(query_option,callback);
                    });
                }
                $('#mediaModal .item').on('click',function(){
                    callback(this);
                });
            }).fail(function() {
                loading.off();
                alert("获取素材列表失败");
            });
    }
};

var jspager = {
    init: function(page_size,total_count,append_target,page_num,callback){
        var page_count;
        if (total_count > page_size) {
            page_count = Math.ceil(total_count / page_size);
            console.log("page_count:" + page_count);
            var current_page = page_num || 1;
            var prev_page = $('<li><a href="#" data-page="' + (parseInt(current_page) - 1) + '">上一页</a></li>');
            var next_page = $('<li><a href="#" data-page="' + (parseInt(current_page) + 1) + '">下一页</a></li>');
            var pager = $('<ul class="pager"></ul>');
            if (current_page > 1) {
                pager.append(prev_page);
            }
            pager.append('<li><select></select></li>');
            if (current_page < page_count) {
                pager.append(next_page);
            }
            var selectList = pager.find('select');
            for (var i = 1; i <= page_count; i++) {
                var option = document.createElement("option");
                option.value = i;
                option.text = i;
                selectList.append(option);
            }
            selectList.val(current_page);
            $(".pager").remove();
            append_target.append(pager);
            $(".pager a").click(function(e) {
                e.preventDefault();
                var target_page = $(this).data("page");
                callback(target_page);
            });
    
            $('.pager select').on('change', function() {
                var target_page = $(this).val();
                callback(target_page);
            });
    }
}
    
};