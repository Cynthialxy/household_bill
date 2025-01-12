<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.util.List" %>
<%@ page import="chrkey.bean.Bill" %>
<%@ page import="chrkey.bean.AccountInfo" %>

<html>
<head>
  <title>bill_info_list.jsp</title>
  <style>
    .container {
      display: flex;
      justify-content: space-between;
      margin-right: 300px;
      margin-left:295px;
    }
    .con{
      margin-left:850px;
      margin-top: 10px;
      margin-bottom: 10px;
    }
    .conn{
      margin-top: 10px;
      margin-bottom: 10px;
    }
    .container select {
      margin-right: 10px;
    }
    .hyn{
      display: flex;
    }
  </style>

</head>
<body>
<form action="account_add.jsp" method="post">
  <div class="container" align='center'>
    <div>
      <button type="submit">新增</button>
    </div>
  </div>
</form>
<%
  Connection connection = SqlConn.getConnection();
  if (connection != null) {
    List<AccountInfo> list = SqlConn.selectAllFromAccountInfo();

    out.print("<table border='1' cellspacing='1' align='center'><tr>");
    out.print("<tr style='border: none;'>"
            + "<th width='120'>账户</th>"
            + "<th width='80'>名称</th>"
            + "<th width='100'>开户行</th>");

    for (AccountInfo accountInfo : list) {
      out.print("<tr style='border: none;'>");
      out.print("<td align='center'>" + accountInfo.getAccount_number() + "</td>");
      out.print("<td align='center'>" + accountInfo.getName() + "</td>");
      out.print("<td align='center'>" + accountInfo.getBank() + "</td>");
      out.print("</tr>");
    }
    out.print("</table>");

    try {
      connection.close();
    } catch (SQLException e) {
      throw new RuntimeException(e);
    }
  } else {
    out.println("数据库连接失败");
  }
%>
</body>
</html>