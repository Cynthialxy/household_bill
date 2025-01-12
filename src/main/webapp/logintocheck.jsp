<%@ page language="java" pageEncoding="UTF-8" import="java.sql.*"%>

<%--使用SqlConn.class--%>
<jsp:useBean id="sqlbean" scope="page" class="chrkey.bean.SqlConn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

  <title>My JSF 'login.jsp' starting page</title>

  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
<link rel="stylesheet" type="text/css" href="styles.css">
-->

</head>

<body>
<br>
<br>
<form name="form1" action="loginto.jsp" method="post">
  <table width="225" border="1" align="center">
    <tbody>
    <tr>
      <td>用户名</td>
      <td><label>
        <input type="text" name="username">
      </label></td>
    </tr>
    <tr>
      <td>密码	</td>
      <td><label>
        <input type="password" name="password">
      </label></td>
    </tr>
    <tr>
      <td colspan="2" align="center">
        <label>
          <input type="radio" checked="checked" value="1" name="role">
        </label>用户
        &nbsp;&nbsp;&nbsp;
        <label>
          <input type="radio" value="0" name="role">
        </label>管理员
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td><input type="submit" value="登陆" name="login">
        &nbsp;&nbsp;
        <input type="reset" value="重置" name="reset">
      </td>
    </tr>
    </tbody>
  </table>
</form>

<br>
JSP+JavaBean+MySQL实现登陆及增删改查示例<br>
1.单选框登陆<br>
2.增<br>
3.删<br>
4.改<br>
5.下拉框搜索<br>

</body>
</html>