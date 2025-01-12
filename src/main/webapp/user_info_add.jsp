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
    </style>

    <script>
function validateForm() {
      var id = document.forms["form"]["id"].value;
      var name = document.forms["form"]["name"].value;
      var password = document.forms["form"]["password"].value;
      var is_admin_or_not = document.forms["form"]["is_admin_or_not"].value;

      if (id.trim() === "" || name.trim() === ""  || password.trim() === "") {
        alert("用户id、用户名、密码不能为空");
        return false;
      }

      return true;
    }

    function submitUser() {
      if (validateForm()) {
        document.forms["form"].submit();
      }
    }

    function populateForm() {
      var urlParams = new URLSearchParams(window.location.search);
      var id = urlParams.get("id");
      var name = urlParams.get("name");
      var password = urlParams.get("password");
      var is_admin_or_not = urlParams.get("is_admin_or_not");

      if (id && name && password && is_admin_or_not) {
        document.getElementById("id").value = id;
        document.getElementById("name").value = name;
        document.getElementById("password").value = password;
        document.getElementById("is_admin_or_not").value = is_admin_or_not;
      }
    }
  </script>
</head>
<body onload="populateForm()">
<form method="post" name="form" action="user_info_edit_to.jsp" onsubmit="return false">
    <table width="230" border="1">
        <tbody>
        <tr>
            <td style="border: none;"><div class="inline"><span>用</span><span>户</span><span>id</span></div></td>
            <td style="border: none;"><label><input type="text" name="id" id="id" /></label></td>
        </tr>

        <tr>
            <td style="border: none;"><div class="inline"><span>用</span><span>户</span><span>名</span></div></td>
            <td style="border: none"><label><input type="text" name="name" id="name" /></label></td>
        </tr>

        <tr>
            <td style="border: none;"><div class="inline"><span>密</span><span>码</span></div></td>
            <td style="border: none"><label><input type="text" name="password" id="password" /></label></td>
        </tr>

        <tr>
            <td style="border: none;"><div class="inline"><span>管</span><span>理</span><span>员?</span></div></td>
            <td style="border: none;"><label><input type="text" name="is_admin_or_not" id="is_admin_or_not" /></label></td>
        </tr>

        </tbody>
    </table>
    <div style="text-align:center">
        <input type="submit" onclick="submitUser()" value="确认提交"/>
        <input type="reset" value="重置表单"/>
    </div>
</form>
</body>
</html>