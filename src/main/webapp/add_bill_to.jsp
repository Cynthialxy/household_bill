<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.sql.Connection" %>

<jsp:useBean id="sqlbean" scope="page" class="chrkey.bean.SqlConn" />

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <title>My JSP 'addto.jsp' starting page</title>

  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
</head>
<body>
<%
  request.setCharacterEncoding("utf-8");

  String year=request.getParameter("year");
  String month=request.getParameter("month");
  String time=year+"."+month;
  String in_or_out=request.getParameter("in_or_out");
  String type=request.getParameter("type");
  String sum=request.getParameter("sum");
  String person=request.getParameter("person");
  String account=request.getParameter("account");
  String remarks=request.getParameter("remarks");

  SqlConn sqlconn=new SqlConn();
  Connection connection= SqlConn.getConnection();
  if (connection!=null){
    int i=sqlconn.insertIntoBill(time,type,account,sum,person,remarks,in_or_out);
    out.print("成功添加"+i+"条数据");
    out.print("<a href=add_bill.jsp>返回" + "</a>");
  }else {
    out.print("数据库连接数据失败");
    out.print("添加失败"+"<a href=add_bill.jsp=>返回" + "</a>");
  }
%>
</body>
</html>
