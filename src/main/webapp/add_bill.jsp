<%@ page import="chrkey.bean.AccountInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.util.List" %>
<%@ page import="com.mysql.cj.jdbc.result.ResultSetImpl" %>
<%@ page import="chrkey.bean.Bill" %>
<%@ page import="chrkey.bean.UserInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

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
    .select-label {
      display: inline-block;
      width: 50%;
    }

    .select-input {
      width: 100%;
    }
  </style>

  <script>

function validateForm() {
      var time = document.forms["form"]["time"].value;
      var in_or_out = document.forms["form"]["in_or_out"].value;
      var type = document.forms["form"]["type"].value;
      var account = document.forms["form"]["account"].value;
      var sum = document.forms["form"]["sum"].value;
      var person = document.forms["form"]["person"].value;
      var remarks = document.forms["form"]["remarks"].value;

      if (time.trim() === "" || in_or_out.trim() === ""  || type.trim() === ""  || account.trim() === ""    || sum.trim() === ""  || person.trim() === ""  || remarks.trim() === "") {
        alert("时间、收/支、类型、账户、金额、人员、描述不能为空");
        return false;
      }
      return true;
    }

    function submitBill() {
      if (validateForm()) {
        document.forms["form"].submit();
      }
    }
    function handleRadioClick(radio) {
  let previousRadio = null;

  if (previousRadio !== null && previousRadio !== radio) {
    previousRadio.checked = false;
  }
  previousRadio = radio;

  if (!radio.checked) {
    radio.checked = true;
  }

  // 获取类型下拉框元素
  var typeSelect = document.getElementById("type");
  // 清空类型下拉框的选项
  typeSelect.innerHTML = "";

  if (radio.value === "收入") {
    // 添加收入类型的选项
    var incomeOptions = [" ","工资", "投资", "其他收入"];
    for (var i = 0; i < incomeOptions.length; i++) {
      var option = document.createElement("option");
      option.value = incomeOptions[i];
      option.text = incomeOptions[i];
      typeSelect.appendChild(option);
    }
  } else if (radio.value === "支出") {
    // 添加支出类型的选项
    var expenseOptions = [" ","日常消费", "文化体育", "其他消费"];
    for (var i = 0; i < expenseOptions.length; i++) {
      var option = document.createElement("option");
      option.value = expenseOptions[i];
      option.text = expenseOptions[i];
      typeSelect.appendChild(option);
    }
  }
}
   function populateForm() {
      var urlParams = new URLSearchParams(window.location.search);
      var time = urlParams.get("time");
      var in_or_out = urlParams.get("in_or_out");
      var type = urlParams.get("type");
      var account = urlParams.get("account");
      var sum = urlParams.get("sum");
      var person = urlParams.get("person");
      var remarks = urlParams.get("remarks");

      if (time && in_or_out && type && account && sum && person && remarks) {
        document.getElementById("time").value = time;
        document.getElementById("in_or_out").value = in_or_out;
        document.getElementById("type").value = type;
        document.getElementById("account").value = account;
        document.getElementById("sum").value = sum;
        document.getElementById("person").value = person;
        document.getElementById("remarks").value = remarks;
      }
    }
  </script>
</head>
<body onload="populateForm()">
<form method="post" name="form" action="add_bill_to.jsp" onsubmit="return false">
  <table width="230" border="1">
    <tbody>
    <tr>
      <td style="border: none;"><div class="inline"><span>时</span><span>间</span></div></td>
      <td style="border: none;"><div class="inline">

        <label class="select-label">
          <select name="year" class="select-input" id="time" name="time">
            <%-- 设置年份选项 --%>
            <% for (int year = 2000; year <= 2024; year++) { %>
            <option value="<%= year %>" id="year" name="year"><%= year %></option>
            <% } %>
          </select>
        </label>
        <label class="select-label">
          <select name="month" class="select-input">
            <%-- 设置月份选项 --%>
            <% for (int month = 1; month <= 12; month++) { %>
            <option value="<%= month %>" id="month" name="month"><%= month %></option>
            <% } %>
          </select>
        </label>

      </div></td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>收</span><span>/</span><span>支</span></div></td>
      <td style="border: none;">
        <label>
          <input type="radio" name="in_or_out" value="收入" onclick="handleRadioClick(this)">
          收入
        </label>

        <label>
          <input type="radio" name="in_or_out" value="支出" onclick="handleRadioClick(this)">
          支出
        </label>
      </td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>类</span><span>型</span></div></td>
      <td style="border: none;">
        <label>
          <select name="type" id="type">
          </select>
        </label>
      </td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>金</span><span>额</span></div></td>
      <td style="border: none"><label><input type="text" name="sum" id="sum" /></label></td>
    </tr>

    <tr>
      <%
        Connection connection = SqlConn.getConnection();
        if (connection != null) {
          List<UserInfo> list = SqlConn.selectAllFromUserInfo();

          out.print("<td style=\"border: none;\"><div class=\"inline\"><span>人</span><span>员</span></div></td>");
          out.print("<td style=\"border: none;\">"
                  + "<label>"
                  + "<select name=\"person\" id=\"person\">"
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
      <%
        Connection connection1 = SqlConn.getConnection();
        if (connection1 != null) {
          List<AccountInfo> list = SqlConn.selectAllFromAccountInfo();

          out.print("<td style=\"border: none;\"><div class=\"inline\"><span>账</span><span>户</span></div></td>");
          out.print("<td style=\"border: none;\">"
                  + "<label>"
                  + "<select name=\"account\" id=\"account\">"
                  + "<option value=\"account\" >"+"</option>");

          for (AccountInfo accountInfo : list) {
            out.print("<option value=\"" + accountInfo.getAccount_number() + "\">" + accountInfo.getAccount_number() + "</option>");
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
      <td style="border: none;">
        <div class="inline">
          <span>描</span><span>述</span>
        </div>
      </td>
      <td style="border: none;">
        <div class="inline">
          <textarea name="remarks" rows="5" cols="20"></textarea>
        </div>
      </td>
    </tr>

    </tbody>
  </table>
  <div style="text-align:center">
    <input type="reset" value="重置"/>
    <input type="submit" onclick="submitBill()" value="提交"/>
  </div>
</form>
</body>
</html>