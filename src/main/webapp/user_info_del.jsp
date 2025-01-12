<%@ page language="java" import="java.sql.*" pageEncoding="UTF-8"%>
<%@ page import="chrkey.bean.SqlConn" %>
<jsp:useBean id="sqlbean" scope="page" class="chrkey.bean.SqlConn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>My JSP 'del.jsp' starting page</title>

  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!-- <link rel="stylesheet" type="text/css" href="styles.css"> -->
</head>

<body>
<%
  request.setCharacterEncoding("utf-8");
  String id = request.getParameter("id");
  Connection connection = SqlConn.getConnection();
  if (connection != null) {
    String sql = "DELETE FROM user_info WHERE id = ?";

    PreparedStatement pstmt = connection.prepareStatement(sql);
    pstmt.setString(1, id);

    int i = pstmt.executeUpdate();
    pstmt.close();

    if (i > 0) {
      out.print("成功删除" + i + "条数据");
      // 跳转回list.jsp页面
%>
<script>
                    window.location.href = "user_info_list.jsp";
</script>
<%
    } else {
      out.print("删除失败");
    }
  } else {
    out.print("数据库连接失败");
  }
  connection.close();
%>
</body>
</html>