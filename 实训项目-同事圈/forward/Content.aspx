<!DOCTYPE html>
<html>
<head>
    <title>同事圈-动态内容</title>
    <meta charset="utf-8">
    <link href="CSS/index.css" type="text/css" rel="stylesheet">
    <link href="//at.alicdn.com/t/font_1317950_ou808vb6c5r.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
        <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <div class="form-group">
        <input type="button" class="btn btn-warning btn-lg" value="发布我的动态" onclick="window.location.href='Release.aspx'" />
        <input type="button" class="btn btn-success btn-lg" value="查看我的动态" onclick="window.location.href = 'MyContent.aspx'" />
        <input type="button" class="btn btn-danger btn-lg" value="注销" onclick="Cancellation()"/>
    </div>
    <div id="list">
    </div>
    <script>
        var f = 0
        $(function () {
            var S_GH = '<%=Session("GH")%>'
                        console.log(S_GH)
            if (S_GH == "") {
                alert("未登录，请先登录！")
                window.location.href = 'Login.aspx'
            } else {
                ajax_s(f)
            }
                });
        $(window).scroll(function () {
            var scrollTop = $(this).scrollTop();
            var scrollHeight = $(document).height();
            var windowHeight = $(this).height();
            if (scrollTop + windowHeight >= scrollHeight - 0.5) {
                f += 5
                ajax_s(f)
            }
        });
        function Cancellation() {
            sessionStorage.clear()
            window.location.href="Login.aspx"
        }
        function ajax_s(f) {
            $.ajax({
                url: "../back/back.aspx?Tmethod=content",
                data: {
                    f:f
                },
                type: "post",
                async: false,
                success: function (text) {
                    console.log(text)
                    if (text == "]") {
                        alert("已经到底了！")
                    }
                    var content = JSON.parse(text)
                    for (var i = 0; i < content.length; i++) {
                        var html = document.getElementById("list").innerHTML;
                        $("#list").append(
                            '<div class="box clearfix">' +
                            '<a class="close" href="javascript:;" onclick="content_delete(' + content[i].ID + ')">' + '×' + '</a>' +     //删除
                            '<img class="head" src="' + 'images/' + content[i].TX + '' + '" alt=""/>' +      //图片
                            '<div class="content">' +
                            '<div class="main">' +
                            '<p class="txt">' +
                            '<span class="user">' + content[i].ZDR + '：</span>' + content[i].NR +       //姓名工号
                            '</p>' +
                            '<img class="pic" src="images/' + content[i].TP + '" alt=""/>' +
                            '</div>' +
                            '<div class="info clearfix">' +
                            '<span class="time">' + content[i].ZDRQ + '</span>' +      //时间
                            '<a class="praise" data-cd="0" id="like_' + content[i].ID + '"onclick="like_judge(' + content[i].ID + ')"><i class="iconfont icon-zan1"></i>未点赞</a>' +      //点赞
                            '</div>' +
                            '<div class="comment-list" id="show_comment_' + content[i].ID + '">' +
                            '</div>' +
                            '<div class="form-group">' +
                            '<div class="text-box">' +
                            '<textarea class="comment" id = "comment_number' + content[i].ID + '">评论…</textarea>' +
                            '</div>' +
                            '</div>' +
                            '<div class="form-group">' +
                            '<input class="btn btn-success" id = "reply_submit' + content[i].ID + '" type="button" value="回复" style="float:right" onclick="content_comment(' + content[i].ID + ')">' +
                            '</div>' +
                            '</div>' +
                            '</div>'
                        );
                        like_status(content[i].ID)
                        $.ajax({
                            url: "../back/back.aspx?Tmethod=show_comment",
                            data: {
                                comment_id: content[i].ID
                            },
                            type: "post",
                            async: false,
                            success: function (text) {
                                console.log(text)
                                var comment_list = JSON.parse(text)
                                for (var j = 0; j < comment_list.length; j++) {
                                    var html = document.getElementById("show_comment_" + content[i].ID + "").innerHTML;
                                    $("#show_comment_" + content[i].ID + "").append(
                                        '<div class="comment-box clearfix" user="self">' +
                                        '<img class="myhead" src="images/' + comment_list[j].TX + '" alt=""/>' +     //评论人头像
                                        '<div class="comment-content">' +
                                        '<p class="comment-text" onclick="reply_onclick(' + comment_list[j].LTID + ',' + content[i].ID + ')"><span class="user">' + comment_list[j].XM + '</span>回复<span class="user">' + comment_list[j].BPLXM + '：</span>' + comment_list[j].PLNR + '</p>' +       //评论人姓名和内容
                                        '<p class="comment-time">' +
                                        comment_list[j].PLSJ +        //评论时间
                                        '<a href="javascript:;" class="comment-operate" onclick="comment_delete(' + comment_list[j].LTID + ')">删除</a>' +        //删除评论
                                        '</p>' +
                                        '</div>' +
                                        '</div>'
                                    );
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(jqXHR.responseText, 800);
                            }
                        });
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });

        }
        function content_delete(id) {
            $.ajax({
                url: "../back/back.aspx?Tmethod=delete",
                data: {
                    ID:id
                },
                type: "post",
                async: false,
                success: function (text) {
                    alert(text)
                    window.location.reload()
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
        function reply_onclick(LTID,ID) {
            $(" #comment_number" + ID + "").text("回复评论：")
            var HFNR = $(" #comment_number" + ID + "").val()
            $("#reply_submit" + ID + "").attr("onclick", "comment_reply('" + HFNR + "'," + LTID + "," + ID + ")");
        }
        function comment_reply(HFNR, LTID, ID) {
            var HFNR = $(" #comment_number" + ID + "").val()
            $.ajax({
                url: "../back/back.aspx?Tmethod=comment_reply",
                data: {
                    HFNR: HFNR,
                    LTID: LTID,
                    ID:ID
                },
                type: "post",
                async: false,
                success: function (text) {
                    alert(text)
                    window.location.reload()
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
        function content_comment(id) {
            var comment_NR = $(" #comment_number" + id + "").val()
            $.ajax({
                url: "../back/back.aspx?Tmethod=comment",
                data: {
                    comment_NR: comment_NR,
                    LB: "评论",
                    ID: id
                },
                type: "post",
                async: false,
                success: function (text) {
                    window.location.reload()
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
        function comment_delete(id) {
            $.ajax({
                url: "../back/back.aspx?Tmethod=comment_delete",
                data: {
                    ID: id
                },
                type: "post",
                async: false,
                success: function (text) {
                    alert(text)
                    window.location.reload()
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
        function like_judge(id) {
            var f = ($("#like_" + id + "").attr("data-cd"));
            if (f == 0) {
                $('#like_' + id + '').html('<i class="iconfont icon-zan"></i>已点赞');
                $("#like_" + id + "").attr("data-cd", "1")
                data_f = 1
            }
            else {
                $('#like_' + id + '').html('<i class="iconfont icon-zan1"></i>未点赞');
                $("#like_" + id + "").attr("data-cd","0")
                data_f = -1
            }
            $.ajax({
                url: "../back/back.aspx?Tmethod=like",
                data: {
                    ID: id,
                    data_f: data_f
                },
                type: "post",
                async: false,
                success: function (text) {
                    console.log(text)
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
        function like_status(id) {
            $.ajax({
                url: "../back/back.aspx?Tmethod=like_status",
                data: {
                    ID: id
                },
                type: "post",
                async: false,
                success: function (text) {
                    if (text >= 1) {
                        $('#like_' + id + '').html('<i class="iconfont icon-zan"></i>已点赞');
                        $("#like_" + id + "").attr("data-cd", "1")
                    } else {
                        $('#like_' + id + '').html('<i class="iconfont icon-zan1"></i>未点赞');
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText, 800);
                }
            });
        }
    </script>
</body>
</html>