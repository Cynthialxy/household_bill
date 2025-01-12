<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.sql.Connection" %>
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
      var studentId = document.forms["form"]["id"].value;
      var name = document.forms["form"]["name"].value;
      var phone = document.forms["form"]["phone"].value;

      if (studentId.trim() === "" || name.trim() === ""  || gender.trim() === "") {
        alert("学号、姓名、性别不能为空");
        return false;
      }
      if (!/^\d{11}$/.test(phone)) {
        alert("电话格式必须是11位数字");
        return false;
      }

      return true;
    }

    function submitStudent() {
      if (validateForm()) {
        document.forms["form"].submit();
      }
    }

    function populateForm() {
      var urlParams = new URLSearchParams(window.location.search);
      var id = urlParams.get("id");
      var name = urlParams.get("name");
      var gender = urlParams.get("gender");
      var phone = urlParams.get("phone");

      if (id && name && gender && phone) {
        document.getElementById("id").value = id;
        document.getElementById("name").value = name;
        document.getElementById("gender").value = gender;
        document.getElementById("phone").value = phone;
      }
    }
    function handleRadioClick(radio) {
    let previousRadio = null;

  let previousRadio = null;

  function handleRadioClick(radio) {
    if (previousRadio !== null && previousRadio !== radio) {
      previousRadio.checked = false;
    }
    previousRadio = radio;

    if (!radio.checked) {
      radio.checked = true;
    }
  }
  </script>
</head>
<body onload="populateForm()">
<form method="post" name="form" action="addto.jsp" onsubmit="return false">
  <table width="230" border="1">
    <tbody>
    <tr>
      <td style="border: none;"><div class="inline"><span>时</span><span>间</span></div></td>
      <td style="border: none;"><div class="inline">

        <label class="select-label">
          <select name="year" class="select-input">
            <%-- 设置年份选项 --%>
            <% for (int year = 2000; year <= 2024; year++) { %>
            <option value="<%= year %>"><%= year %></option>
            <% } %>
          </select>
        </label>
        <label class="select-label">
          <select name="month" class="select-input">
            <%-- 设置月份选项 --%>
            <% for (int month = 1; month <= 12; month++) { %>
            <option value="<%= month %>"><%= month %></option>
            <% } %>
          </select>
        </label>

      </div></td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>收</span><span>/</span><span>支</span></div></td>
      <td style="border: none;">
    <label>
      <input type="radio" name="in_or_out" value="1">
      收入
    </label>

    <label>
      <input type="radio" name="in_or_out" value="0">
      支出
    </label>
      </td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>类</span><span>型</span></div></td>
      <td style="border: none;">
        <label>
          <select name="type" id="type">
            <option value=""></option>
            <option value="工资">工资</option>
            <option value="投资">投资</option>
            <option value="其他">其他</option>
          </select>
        </label>
      </td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>金</span><span>额</span></div></td>
      <td style="border: none"><label><input type="text" name="sum" id="sum" /></label></td>
    </tr>

    <tr>
      <td style="border: none;"><div class="inline"><span>账</span><span>户</span></div></td>
      <td style="border: none;">
        <label>
          <select name="account" id="account">
            <option value="account1"></option>
            <option value="account2"></option>
            <option value="account3"></option>
          </select>
        </label>
      </td>
    </tr>

    <tr>
      <td style="border: none;">
        <div class="inline">
          <span>描</span><span>述</span>
        </div>
      </td>
      <td style="border: none;">
        <div class="inline">
          <textarea name="remark" rows="5" cols="20"></textarea>
        </div>
      </td>
    </tr>

    </tbody>
  </table>
  <div style="text-align:center">
    <input type="reset" value="重置"/>
    <input type="submit" onclick="submitStudent()" value="提交"/>
  </div>
</form>
</body>
</html>