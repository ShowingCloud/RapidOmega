// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(function(){
    $(".new_response_rule #response_msgtype").on("change",function(){
        var msgtype = $(this).val();
        var response = $("#response_rule_response_id");
        if(msgtype){
            $.ajax({
                url:"/admin/responses",
                data:{msgtype:msgtype},
                dataType: "json"
            }).done(function(data){
                console.log(data);
                if (data.length){
                    response.empty();
                    data.forEach(function(d){
                        response.append("<option value='"+d.id+"'>"+d.message+"</option>");
                    });

                }
            });
        }
    });
});
