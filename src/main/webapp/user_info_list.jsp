<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.util.List" %>
<%@ page import="chrkey.bean.UserInfo" %>

<html>
<head>
    <title>user_info_list.jsp</title>
    <style>
        .container {
            text-align: right;
            margin-top: 20px;
            margin-bottom: 5px;
            margin-right: 330px;
        }
    </style>

    <script>
        function editUser(id, name, password, is_admin_or_not) {
            window.location.href = "user_info_modify.jsp?id=" + id + "&name=" + name + "&password=" + password + "&is_admin_or_not=" + is_admin_or_not;
        }
        function deleteUser(id, name, password, is_admin_or_not) {
            window.location.href = "user_info_del.jsp?id=" + id + "&name=" + name + "&password=" + password + "&is_admin_or_not=" + is_admin_or_not;
        }

    </script>

</head>
<body>
<form action="user_info_add.jsp" method="post">
    <div class="container" align="center">
        <button onclick="window.location.href='user_info_add.jsp'">新增</button>
    </div>
</form>
<form action="bill_info_list_admin.jsp" method="post">
    <div class="container" align="center">
        <button onclick="window.location.href='bill_info_list_admin.jsp'">账单</button>
    </div>
</form>
<br>

<%
    Connection connection = SqlConn.getConnection();
    if (connection != null) {
        List<UserInfo> list = SqlConn.selectAllFromUserInfo();
        out.print("<table border='1' cellspacing='1' align='center'><tr>");
        out.print("<caption>用户信息表</caption>");
        out.print("<tr style='border: none;'><th width='60'>序号</th>"
                + "<th width='120'>用户id</th>"
                + "<th width='80'>用户名</th>"
                + "<th width='60'>密码</th>"
                + "<th width='120'>管理员?</th>"
                + "<th width='100'>操作</th>");
        int count = 0;
        for (UserInfo user_info : list) {
            out.print("<tr style='border: none;'>");
            out.print("<td align='center'>" + (++count) + "</td>");
            out.print("<td align='center'>" + user_info.getId() + "</td>");
            out.print("<td align='center'>" + user_info.getName() + "</td>");
            out.print("<td align='center'>" + user_info.getPassword() + "</td>");
            out.print("<td align='center'>" + user_info.getIs_admin_or_not() + "</td>");
            out.print("<td align='center'> <button type='button' onclick=\"deleteUser('" + user_info.getId() + "','" + user_info.getName() + "','" + user_info.getPassword() + "','" + user_info.getIs_admin_or_not() + "')\">Del</button>"
                    + " <button type='button' onclick=\"editUser('" + user_info.getId() + "','" + user_info.getName() + "','" + user_info.getPassword() + "','" + user_info.getIs_admin_or_not() + "')\">Edit</button>" + "</td>");
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