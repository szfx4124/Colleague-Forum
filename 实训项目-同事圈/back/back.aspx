<%@ Import Namespace="System.Data.SqlClient" %>
<script language="vb" runat="server">
    Sub Page_Load(Src As Object, E As EventArgs)
        Dim Connection As SqlConnection = New SqlConnection()       '定义连接
        Connection.ConnectionString = "Data Source=DESKTOP-31O6KV5;Initial Catalog=anywell_test;Persist Security info=True;User ID=sa;Password=15779035570"                 '基础配置信息 
        Connection.Open()
        If LCase(Request("Tmethod")) = LCase("login") Then
            Dim GH As String = Request("GH")
            Dim MM As String = Request("MM")
            Dim XM As String
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "Select XM,MM FROM LT_ACCOUNT_OA WHERE GH = '" & GH & "'" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection)
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            If Len(ReturnValue) > 0 Then
                ReturnValue = "读取失败！"
            End If
            Do While SqlReader.Read()
                If IsDBNull(SqlReader.GetValue(0)) = False Then
                    XM = SqlReader.GetValue(0)
                    ReturnValue = SqlReader.GetValue(1)
                    If ReturnValue = MM Then
                        ReturnValue = "success"
                        Session("GH") = GH
                        Session("XM") = XM
                    Else
                        ReturnValue = "账号或密码错误，请重试！"
                    End If
                End If
            Loop
            Response.Write(ReturnValue)
            Exit Sub
        End If
        If LCase(Request("Tmethod")) = LCase("register") Then
            Dim TX As String = Request("fileName")
            Dim XM As String = Request("XM")
            Dim GH As String = Request("GH")
            Dim MM As String = Request("MM")
            Dim QRMM As String = Request("QRMM")
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            If (MM <> QRMM) Then
                Response.Write("两次密码不一致！")
                Exit Sub
            End If
            Dim Sqlstr As String = "INSERT INTO LT_ACCOUNT_OA (TX,GH,XM,MM) VALUES ('" & TX & "','" & GH & "','" & XM & "','" & MM & "')" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("注册完成！")
        End If
        If LCase(Request("Tmethod")) = LCase("release") Then
            Dim TP As String = Request("fileName")
            Dim NR As String = Request("NR")
            Dim GH As String = Session("GH")
            Dim XM As String = Session("XM")
            Dim ZDRQ As String = DateTime.Now
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "INSERT INTO LT_MAIN_OA (TP,ZDR,GH,ZDRQ,NR) VALUES ('" & TP & "','" & XM & "','" & GH & "','" & ZDRQ & "','" & NR & "')" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("发布成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("content") Then
            Dim num As Integer = Request("f")
            'Dim Sqlstr As String = "select * from LT_MAIN_OA as a inner join LT_ACCOUNT_OA as b on a.GH = b.GH" '定义Sql语句
            Dim Sqlstr As String = "select  *  FROM LT_MAIN_OA as a inner join LT_ACCOUNT_OA as b on a.GH = b.GH where ID  in (Select top " & num + 5 & " ID from LT_MAIN_OA) and ID not in(Select top " & num & " ID from LT_MAIN_OA) order by a.ZDRQ desc" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection)
            Dim SqlReader As SqlDataReader
            Dim Templatei As Integer
            Dim Templatej As Integer = 1
            Dim ReturnValue As String = "["
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Do While SqlReader.Read()
                ReturnValue = ReturnValue & "{"
                For Templatei = 0 To SqlReader.FieldCount - 1
                    ReturnValue = ReturnValue & Chr(34) & SqlReader.GetName(Templatei) & Chr(34) & ":" & Chr(34) & SqlReader.GetValue(Templatei) & Chr(34) & "," & Chr(13) & Chr(10)
                    ReturnValue = Mid(ReturnValue, 1, Len(ReturnValue) - 2)
                Next
                ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
                Templatej = Templatej + 1
                ReturnValue = ReturnValue & "},"
            Loop
            ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
            ReturnValue = ReturnValue & "]"

            Response.Write(ReturnValue)
        End If
        If LCase(Request("Tmethod")) = LCase("my_content") Then
            Dim num As Integer = Request("f")
            'Dim Sqlstr As String = "select  *  FROM LT_MAIN_OA as a inner join LT_ACCOUNT_OA as b on a.GH = b.GH where b.GH = '" & Session(Request("GH")) & "' and ID  in (Select top " & num + 5 & " ID from LT_MAIN_OA) and ID not in(Select top " & num & " ID from LT_MAIN_OA)" '定义Sql语句
            Dim Sqlstr As String = "select  *  FROM LT_MAIN_OA as a inner join LT_ACCOUNT_OA as b on a.GH = b.GH where a.GH = '" & Session("GH") & "' and ID  in (Select top " & num + 5 & " ID from LT_MAIN_OA) and ID not in(Select top " & num & " ID from LT_MAIN_OA) order by a.ZDRQ desc" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection)
            Dim SqlReader As SqlDataReader
            Dim Templatei As Integer
            Dim Templatej As Integer = 1
            Dim ReturnValue As String = "["
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Do While SqlReader.Read()
                ReturnValue = ReturnValue & "{"
                For Templatei = 0 To SqlReader.FieldCount - 1
                    ReturnValue = ReturnValue & Chr(34) & SqlReader.GetName(Templatei) & Chr(34) & ":" & Chr(34) & SqlReader.GetValue(Templatei) & Chr(34) & "," & Chr(13) & Chr(10)
                    ReturnValue = Mid(ReturnValue, 1, Len(ReturnValue) - 2)
                Next
                ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
                Templatej = Templatej + 1
                ReturnValue = ReturnValue & "},"
            Loop
            ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
            ReturnValue = ReturnValue & "]"

            Response.Write(ReturnValue)
        End If
        If LCase(Request("Tmethod")) = LCase("delete") Then
            Dim ID As String = Request("ID")
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "delete from LT_MAIN_OA where ID = " & ID & "" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("删除成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("comment") Then
            Dim LB As String = Request("LB")
            Dim PLNR As String = Request("comment_NR")
            Dim GH As String = Session("GH")
            Dim XM As String = Session("XM")
            Dim PLSJ As String = DateTime.Now
            Dim ID As String = Request("ID")
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "INSERT INTO LT_DETAIL_OA (XM,GH,LB,PLNR,PLSJ,ID) VALUES ('" & XM & "','" & GH & "','" & LB & "','" & PLNR & "','" & PLSJ & "','" & ID & "')" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("评论成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("comment_reply") Then
            Dim LB As String = "回复评论"
            Dim PLNR As String = Request("HFNR")
            Dim LTID As String = Request("LTID")
            Dim GH As String = Session("GH")
            Dim XM As String = Session("XM")
            Dim BPLXM As String
            Dim PLSJ As String = DateTime.Now
            Dim ID As String = Request("ID")
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "select XM from LT_DETAIL_OA where LTID = " + LTID + "" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            If Len(ReturnValue) > 0 Then
                ReturnValue = "读取失败！"
            End If
            Do While SqlReader.Read()
                If IsDBNull(SqlReader.GetValue(0)) = False Then
                    BPLXM = SqlReader.GetValue(0)
                End If
            Loop
            SqlReader.Close()
            Sqlstr = "INSERT INTO LT_DETAIL_OA (XM,GH,LB,PLNR,PLSJ,ID,BPLXM) VALUES ('" & XM & "','" & GH & "','" & LB & "','" & PLNR & "','" & PLSJ & "','" & ID & "','" & BPLXM & "')" '定义Sql语句
            Command = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("回复成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("show_comment") Then
            Dim ID As String = Request("comment_id")
            Dim Sqlstr As String = "select * from LT_DETAIL_OA as a inner join LT_ACCOUNT_OA as b on a.GH = b.GH where (a.LB = '评论' or a.LB = '回复评论') and ID = " + ID + " order by a.PLSJ desc" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection)
            Dim SqlReader As SqlDataReader
            Dim Templatei As Integer
            Dim Templatej As Integer = 1
            Dim ReturnValue As String = "["
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Do While SqlReader.Read()
                ReturnValue = ReturnValue & "{"
                For Templatei = 0 To SqlReader.FieldCount - 1
                    ReturnValue = ReturnValue & Chr(34) & SqlReader.GetName(Templatei) & Chr(34) & ":" & Chr(34) & SqlReader.GetValue(Templatei) & Chr(34) & "," & Chr(13) & Chr(10)
                    ReturnValue = Mid(ReturnValue, 1, Len(ReturnValue) - 2)
                Next
                ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
                Templatej = Templatej + 1
                ReturnValue = ReturnValue & "},"
            Loop
            ReturnValue = ReturnValue.Remove(ReturnValue.Length - 1, 1)
            ReturnValue = ReturnValue & "]"

            Response.Write(ReturnValue)
        End If
        If LCase(Request("Tmethod")) = LCase("comment_delete") Then
            Dim LTID As String = Request("ID")
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "delete from LT_DETAIL_OA where LTID = " & LTID & "" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Response.Write("删除成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("like") Then
            Dim LB As String
            Dim GH As String = Session("GH")
            Dim XM As String = Session("XM")
            Dim PLSJ As String = DateTime.Now
            Dim ID As String = Request("ID")
            Dim data As String = Request("data_f")
            If data = "-1" Then
                LB = "取消点赞"
            Else
                LB = "点赞"
            End If
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "INSERT INTO LT_DETAIL_OA (XM,GH,LB,PLSJ,ID) VALUES ('" & XM & "','" & GH & "','" & LB & "','" & PLSJ & "','" & ID & "')" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection) '定义Sqlcommand
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            Console.Write("执行成功！")
        End If
        If LCase(Request("Tmethod")) = LCase("like_status") Then
            Dim ID As String = Request("ID")
            Dim GH As String = Session("GH")
            Dim Z_0 As String = 0
            Dim Z_1 As Integer = 0
            Dim SqlReader As SqlDataReader
            Dim ReturnValue As String
            Dim Sqlstr As String = "SELECT * FROM LT_DETAIL_OA WHERE GH = '" & GH & "' and LB = '点赞' and ID = '" & ID & "'" '定义Sql语句
            Dim Command As SqlCommand = New SqlCommand(Sqlstr, Connection)
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            If Len(ReturnValue) > 0 Then
                ReturnValue = "数据读取失败！"
            End If
            Do While SqlReader.Read()
                Z_1 += 1
            Loop
            Command.Connection.Close()
            Connection.Close()
            Connection.Open()
            Sqlstr = "select * from lt_detail_oa where gh = '" & GH & "' and lb = '取消点赞' and ID = '" & ID & "'" '定义sql语句
            Command = New SqlCommand(Sqlstr, Connection)
            Try
                SqlReader = Command.ExecuteReader()
            Catch ex As Exception
                Command.Connection.Close()
                Connection.Close()
                ReturnValue = ex.Message
                MsgBox(ex.Message)
            End Try
            If Len(ReturnValue) > 0 Then
                ReturnValue = "数据读取失败！"
            End If
            Do While SqlReader.Read()
                Z_0 += 1
            Loop
            Dim Z As Integer = Z_1 - Z_0
            Response.Write(Z)
            Exit Sub
        End If
    End Sub
</script>