// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
jQuery(document).ready(
    function() {
        function toggleAdd(ul) {
            console.log(ul.children('.item').length);
            if (ul.hasClass("level1")) {
                if (ul.children('.item').length > 2) {
                    ul.children('.add').addClass("hidden");
                } else {
                    ul.children('.add').removeClass("hidden");
                }
            } else {
                if (ul.children('.item').length > 4) {
                    ul.children('.add').addClass("hidden");
                } else {
                    ul.children('.add').removeClass("hidden");
                }
            }
        }

        function buid_menu() {
            var menu = {
                button: []
            };

            function valid(value) {
                return value && value !== "";
            }

            $(".menu-preview .level1>.item").each(function() {
                var _this = $(this);
                var item = {};
                var a_tag = _this.children('a');
                var name_lv1 = $.trim(a_tag.text());
                var type_lv1 = a_tag.data('type');
                var url_lv1 = a_tag.data('url');
                if (valid(name_lv1)) {
                    item.name = name_lv1;
                }
                if (valid(type_lv1)) {
                    item.type = type_lv1;
                }

                if (valid(url_lv1)) {
                    item.url = url_lv1;
                }

                var sub_button = [];
                var child_item = _this.find(".item");
                if (child_item.length) {
                    child_item.each(function() {
                        var item_lv2 = {};
                        var _this = $(this);
                        var a_tag = _this.children('a');
                        var name_lv2 = $.trim(a_tag.text());
                        var type_lv2 = a_tag.data('type');
                        var url_lv2 = a_tag.data('url');
                        if (valid(name_lv2)) {
                            item_lv2.name = name_lv2;
                        }
                        if (valid(type_lv2)) {
                            item_lv2.type = type_lv2;
                        }

                        if (valid(url_lv2)) {
                            item_lv2.url = url_lv2;
                        }
                        sub_button.push(item_lv2);

                    });
                }
                if (sub_button.length) {
                    item.sub_button = sub_button;
                }
                menu.button.push(item);
            });
            return JSON.stringify(menu);
        }


        $(".menu-preview ul").each(function() {
            var ul = $(this);
            var add = $("<li class='add'><i class='fa fa-plus' title='添加'></i></li>");
            if (ul.hasClass("level1")) {
                if (ul.children('li').length > 2) {
                    add.addClass("hidden");
                }
                add.appendTo(ul);
            } else {
                if (ul.children('li').length > 4) {
                    add.addClass("hidden");
                }
                add.prependTo(ul);
            }

        });

        var target, add_to;
        var menuName = $("#menuName");
        var menuType = $("#menuType");
        var menuUrl = $("#menuUrl");
        var menuMedia = $("#menuMedia");
        menuName.val("");
        menuType.val("");
        menuUrl.val("");
        $(".menu-preview").on('click', 'a', function() {
            var _this = $(this);
            target = _this;
            if (_this.parent().parent().hasClass("level1")) {
                menuType.html('<option value="view">跳转网页链接</option><option value="media_id">下发媒体消息</option><option value="">普通按钮</option>');
            } else {
                menuType.html('<option value="view">跳转网页链接</option><option value="media_id">下发媒体消息</option>');
            }
            menuName.val($.trim(_this.text()));
            menuType.val(_this.data("type"));
            menuUrl.val(_this.data("url"));
        });

        $(".menu-preview").on('click', '.add', function() {
            $(this).after("<li class='item'><a>请编辑</a></li>");
            var add = $(this);
            var ul = add.parent();
            toggleAdd(ul);
        });

        menuType.on('change', function() {
            var value = $(this).val();
            if (value === "view") {
                menuUrl.parents(".form-group").removeClass("hidden");
                menuMedia.parents(".form-group").addClass("hidden");
            } else if (value === "media_id") {
                menuUrl.parents(".form-group").addClass("hidden");
                menuMedia.parents(".form-group").removeClass("hidden");
            }
        });

        $("#save").click(function(e) {
            var name = menuName.val();
            var type = menuType.val();
            var url = menuUrl.val();
            if (name && name !== "") {
                target.text(name);
            }

            if (type === "view" && url && url !== "") {
                target.data("url", url);
            }
            if (target.data("type") !== type) {
                target.data("type", type);
                if (type === "") {
                    target.parent().addClass("dropup open");
                    target.append("<span class='caret'></span>").after("<ul class='dropdown-menu leve2'><li class='add'><i class='fa fa-plus' title='添加'></i></li></ul>");
                } else {
                    target.parent().removeClass("dropup open");
                    target.siblings().remove();
                }
            } else {
                console.log("same");
            }
        });

        $("#delete").click(function(e) {
            if (window.confirm("是否删除此项??")) {
                var li = target.parent();
                var ul = li.parent();
                li.next('dropdown-menu').remove();
                li.remove();
                toggleAdd(ul);
            }
        });

        $("#done").click(function() {
            $.ajax({
                method: "POST",
                url: "/admin/menu",
                data: {
                    "menu": buid_menu()
                }
            }).done(function() {
                alert('发布成功');
            }).fail(function(response) {
                if (response.responseJSON.msg) {
                    alert(response.responseJSON.msg);
                } else {
                    alert("错误");
                }
            });
        });
    }
);
