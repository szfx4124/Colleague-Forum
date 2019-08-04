<!DOCTYPE html>
<html>
<head>
    <title>同事圈-登陆</title>
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
            <h2 style="text-align:center">同事圈-登录</h2>
            <div class="form-group">
                <label for="GH">工号</label>
                <input type="text" class="form-control" id="GH" placeholder="请输入工号..">
            </div>
            <div class="form-group">
                <label for="MM">密码</label>
                <input type="password" class="form-control" id="MM" placeholder="请输入密码..">
            </div>
            <button type="button" class="btn btn-success btn-lg btn-block" onclick="login()">登录</button>
            <button type="button" class="btn btn-warning btn-lg btn-block" onclick="window.location.href='Register.aspx'">注册</button>
        </form>
    </div>
    <script>
        function login() {
        var GH = $(" #GH ").val()
        var MM = $(" #MM ").val()
    $.ajax({
        url: "../back/back.aspx?Tmethod=login",
        data: {
            GH: GH,
            MM: MM
        },
        type: "post",
        async:false,
        success: function (text) {
            if (text == "success") {
                window.location.href = "Content.aspx";
            } else {
                alert(text)
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            alert(jqXHR.responseText,800);
        }
    });
    }
    </script>
</body>
</html>