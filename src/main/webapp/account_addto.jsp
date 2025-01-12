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
    String account_number=request.getParameter("account_number");
    String name=request.getParameter("name");
    String bank=request.getParameter("bank");
    SqlConn sqlconn=new SqlConn();
    Connection connection= SqlConn.getConnection();
    if (connection!=null){
        int i=sqlconn.insertIntoAccountInfo(account_number,name,bank);
        out.print("成功添加"+i+"条数据");
        out.print("<a href=account_info_list.jsp>返回" + "</a>");
    }else {
        out.print("数据库连接数据失败");
        out.print("添加失败"+"<a href=account_info_list.jsp>返回" + "</a>");
    }
%>
</body>
</html>
