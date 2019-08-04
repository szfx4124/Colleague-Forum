<!DOCTYPE html>
<html>
<head>
    <title>同事圈-注册</title>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <link href="CSS/index.css" type="text/css" rel="stylesheet">
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
            <h2 style="text-align:center">同事圈-注册</h2>
            <div class="form-group">
                <label for="XM">姓名</label>
                <input type="text" class="form-control" id="XM" placeholder="请输入姓名..">
            </div>
            <div class="form-group">
                <label for="GH">工号</label>
                <input type="text" class="form-control" id="GH" placeholder="请输入工号..">
            </div>
            <div class="form-group">
                <label for="MM">设置密码</label>
                <input type="password" class="form-control" id="MM" placeholder="请设置密码..">
            </div>
            <div class="form-group">
                <label for="QRMM">确认密码</label>
                <input type="password" class="form-control" id="QRMM" placeholder="请再次输入密码..">
            </div>
            <div class="form-group">
                <label for="images">上传头像</label>
                <input type="file" id="images">
            </div>
            <button type="submit" class="btn btn-success btn-lg btn-block" onclick ="register()">确认注册</button>
            <button type="button" class="btn btn-warning btn-lg btn-block" onclick="window.location.href='Login.aspx'">返回登录页</button>
        </form>
    </div>
    <script>
        function getFileName(o) {
            var pos = o.lastIndexOf("\\");
            return o.substring(pos + 1);
        }
        function register() {
            var images = $("#images").val();
            var fileName = getFileName(images);
            var XM = $("#XM").val()
            var GH = $("#GH").val()
            var MM = $("#MM").val()
            var QRMM = $("#QRMM").val()
            $.ajax({
                url: "../back/back.aspx?Tmethod=register",
                data: {
                    XM: XM,
                    GH: GH,
                    MM: MM,
                    QRMM: QRMM,
                    fileName: fileName
                },
                type: "post",
                async:false,
                success: function (text) {
                    alert(text);
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    alert(jqXHR.responseText,800);
                }
            });
        }
    </script>
</body>
</html>