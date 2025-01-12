<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.sql.Connection" %>
<jsp:useBean id="sqlbean" scope="page" class="chrkey.bean.SqlConn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>My JSP 'modifyto.jsp' starting page</title>

  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!-- <link rel="stylesheet" type="text/css" href="styles.css">	-->

</head>

<body>
<%
  request.setCharacterEncoding("utf-8");
  String id=request.getParameter("id");
  String name=request.getParameter("name");
  String password=request.getParameter("password");
  String is_admin_or_not=request.getParameter("is_admin_or_not");
  SqlConn sqlconn=new SqlConn();
  Connection connection= SqlConn.getConnection();
  if (connection!=null){
    String sql="update student set  name='"+ name +"', password='"+password+"', is_admin_or_not="+is_admin_or_not+" where id="+id;

    int i=sqlconn.executeUpdate(sql);
    out.print("成功修改"+i+"条数据！");
    out.print("<a href=user_info_list.jsp>返回" + "</a>");
  }else {
    out.print("数据库连接数据失败");
    out.print("添加失败"+"<a href=user_info_list.jsp>返回" + "</a>");
  }
%>

</body>
</html>
