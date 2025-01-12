<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.util.List" %>
<%@ page import="chrkey.bean.Bill" %>

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

  <script>
    function getName() {
      var urlParams = new URLSearchParams(window.location.search);
      var name = urlParams.get("name");
      document.getElementById("name").value = name;
    }
  </script>

</head>
<body onload="getName()">
<form method="post">
  <div class="hyn">
  <div class="con">欢迎你</div>
    <input  style='border: none;' class="conn" name="name" id="name"/>
  <a class="conn" href="logintocheck.jsp">退出</a>
  </div>
  <div class="container" align='center'>
    <div>
      <label>
        <select name="year">
          <%-- 设置年份选项 --%>
          <% for (int year = 2000; year <= 2024; year++) { %>
          <option value="<%= year %>" id="year" name="year"><%= year %></option>
          <% } %>
        </select>
      </label>
      <label>
        <select name="month">
          <%-- 设置月份选项 --%>
          <% for (int month = 1; month <= 12; month++) { %>
          <option value="<%= month %>" id="month" name="month"><%= month %></option>
          <% } %>
        </select>
      </label>
    </div>
    <div>
      <button type="submit">新增</button>
    </div>
  </div>
</form>
<%
  SqlConn sqlconn = new SqlConn();
  Connection connection = SqlConn.getConnection();
  if (connection != null) {
    List<Bill> list = SqlConn.selectAllFromBill();

    out.print("<table border='1' cellspacing='1' align='center'><tr>");
    out.print("<tr style='border: none;'>"
            + "<th width='120'>时间</th>"
            + "<th width='80'>类型</th>"
            + "<th width='60'>账户</th>"
            + "<th width='120'>金额</th>"
            + "<th width='120'>人员</th>"
            + "<th width='120'>描述</th>"
            + "<th width='100'>收/支</th>");

    for (Bill bill : list) {
        out.print("<tr style='border: none;'>");
        out.print("<td align='center'>" + bill.getTime() + "</td>");
        out.print("<td align='center'>" + bill.getType() + "</td>");
        out.print("<td align='center'>" + bill.getAccount() + "</td>");
        out.print("<td align='center'>" + bill.getSum() + "</td>");
        out.print("<td align='center'>" + bill.getPerson() + "</td>");
        out.print("<td align='center'>" + bill.getRemarks() + "</td>");
        out.print("<td align='center'>" + bill.getIn_or_out() + "</td>");
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