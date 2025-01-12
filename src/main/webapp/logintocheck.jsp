<%@ page language="java" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="chrkey.bean.UserInfo" %>

<%
  // 获取提交的用户名和密码
  String name = request.getParameter("name");
  String password = request.getParameter("password");

  if (name != null && password != null) {
// 在数据库中查找对应的用户信息
    Connection connection = SqlConn.getConnection();
    if (connection != null) {
      UserInfo userInfo;
      try {
        userInfo = SqlConn.checkUserInfo(name, password);
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }

      // 检查用户名和密码是否正确
      if (userInfo != null) {
        // 用户名和密码正确，可以进行跳转到目标页面
        response.sendRedirect("bill_info_list.jsp?name="+name);
        return;
      } else {
        // 用户名或密码不正确，显示错误提示
        out.println("用户名或密码不正确");
      }

      try {
        connection.close();
      } catch (SQLException e) {
        throw new RuntimeException(e);
      }
    } else {
      out.println("数据库连接失败");
    }
  }
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

  <title>My JSF 'logintocheck.jsp' starting page</title>

  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->
<style type="">
  /*指定文本对齐方式为水平居中*/
  form {
    text-align: center;
  }
  /*使表格在容器中水平居中显示*/
  table {
    margin: 0 auto;
  }
  /*设置单元格的内边距位10px*/
  td {
    padding: 10px;
  }
  .button-container {
    text-align: center;
  }
</style>
</head>

<body>
<br>
<br>
<form name="form"method="post">
  <table width="300" border="1" align="center">
    <tbody>
    <tr style='border: none;'>
      <td><div style='text-align:center;'><span>家庭成员名</span></div></td>
      <td><label>
        <input type="text" name="name" id="name">
      </label></td>
    </tr>
    <tr style='border: none;'>
      <td><div style='text-align:center;'><span>密码</span></div></td>
      <td>
        <label>
        <input type="password" name="password">
      </label>
      </td>
    </tr>

    <tr style='border: none;'>
      <td colspan="2">
        <div class="button-container">
          <input type="submit"value="登录" name="login">
          <input type="reset" value="重置" name="reset">
        </div>
      </td>
    </tr>

    </tbody>
  </table>
</form>
</body>
</html>