<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="utf-8">
    <link href="CSS/index.css" type="text/css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
</head>
<body>
    <div id="list">
        <form>
            <label for="NR">发布内容</label>
            <div class="form-group">
                <textarea id="NR" cols="70" rows="4" style="height:80px;border-style: groove"></textarea>
            </div>
            <div class="form-group">
                <label for="images">上传图片</label>
                <input type="file" id="images">
            </div>
            <div class="form-group">
                <button type="button" class="btn btn-success" style="float:right" onclick="release()">发布</button>
            </div>
            <div class="form-group">
                <input type="button" class="btn btn-warning btn-lg" value="返回所有动态" onclick="window.location.href = 'Content.aspx'" />
            </div>
        </form>
    </div>
    <script>
        var S_GH = '<%=Session("GH")%>'
            console.log(S_GH)
        if (S_GH == "") {
            alert("未登录，请先登录！")
            window.location.href = 'Login.aspx'
        }
        function getFileName(o) {
            var pos = o.lastIndexOf("\\");
            return o.substring(pos + 1);
        }
        function release() {
            var images = $("#images").val();
            var fileName = getFileName(images);
            var NR = $(" #NR ").val()
            $.ajax({
                url: "../back/back.aspx?Tmethod=release",
                data: {
                    NR: NR,
                    fileName: fileName
                },
                type: "post",
                async: false,
                success: function (text) {
                    alert(text)
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert("发布失败，请重试！");
                }
            });
        }
    </script>
</body>
</html>