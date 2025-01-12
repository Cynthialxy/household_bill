<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="chrkey.bean.UserInfo" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My JSP 'add.jsp' starting page</title>
    <style>
        .inline {
            display: flex;
        }
        .inline span {
            margin-right: 5px;
        }
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

        input[type="text"],
        select {
            margin-right: 0;
            box-sizing: border-box; /* 包含内边距和边框在元素的总宽度和高度中 */
            width: 100%; /* 使输入框和选择框填充可用空间 */
            height: 30px; /* 设置所有输入框和选择框的高度为30px */
        }

        input[type="reset"],
        input[type="submit"] {
            margin: 10px auto; /* 设置按钮在水平方向居中 */
            height: 40px; /* 设置按钮高度为40px */
        }
    </style>

    <script>
function validateForm() {
      var account_number = document.forms["form"]["account_number"].value;
      var name = document.forms["form"]["name"].value;
      var bank = document.forms["form"]["bank"].value;

      if (account_number.trim() === "" || name.trim() === ""  || bank.trim() === "") {
        alert("账号、名称、开户行不能为空");
        return false;
      }

      return true;
    }

    function submitAccount() {
      if (validateForm()) {
        document.forms["form"].submit();
      }
    }

    function populateForm() {
      var urlParams = new URLSearchParams(window.location.search);
      var account_number = urlParams.get("account_number");
      var name = urlParams.get("name");
      var bank = urlParams.get("bank");

      if (account_number && name && bank) {
        account_number.getElementById("account_number").value = account_number;
        name.getElementById("name").value = name;
        bank.getElementById("bank").value = bank;
      }
    }
  </script>
</head>
<body onload="populateForm()">
<form method="post" name="form" action="account_addto.jsp" onsubmit="return false">
    <table width="230" border="1">
        <tbody>
        <tr>
            <td style="border: none;"><div class="inline"><span>账</span><span>号</span></div></td>
            <td style="border: none;"><label><input type="text" name="account_number" id="account_number" /></label></td>
        </tr>

        <tr>
            <%
                Connection connection = SqlConn.getConnection();
                if (connection != null) {
                    List<UserInfo> list = SqlConn.selectAllFromUserInfo();

                    out.print("<td style=\"border: none;\"><div class=\"inline\"><span>人</span><span>员</span></div></td>");
                    out.print("<td style=\"border: none;\">"
                            + "<label>"
                            + "<select name=\"name\" id=\"name\">"
                            + "<option>"+"</option>");

                    for (UserInfo userInfo : list) {
                        out.print("<option value=\""+userInfo.getName() +"\">" + userInfo.getName() + "</option>");
                    }
                    out.print("</select>");
                    out.print("</label>");
                    out.print("</td>");
                    out.print("</td>");
                    try {
                        connection.close();
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    out.println("数据库连接失败");
                }
            %>
        </tr>


        <tr>
            <td style="border: none;"><div class="inline"><span>开</span><span>户</span><span>行</span></div></td>
            <td style="border: none"><label><input type="text" name="bank" id="bank" /></label></td>
        </tr>

        </tbody>
    </table>
    <div style="text-align:center">
        <input type="submit" onclick="submitAccount()" value="确认提交"/>
        <input type="reset" value="重置表单"/>
    </div>
</form>
</body>
</html>