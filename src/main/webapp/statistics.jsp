<%@ page import="chrkey.bean.AccountInfo" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="chrkey.bean.SqlConn" %>
<%@ page import="java.util.List" %>
<%@ page import="chrkey.bean.Bill" %>
<%@ page import="chrkey.bean.UserInfo" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="src/main/resources/js/js/echarts.min.js"></script>

<div class="inline">
    <label class="select-label">
        <select name="year" class="select-input">
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
</div>

<div id="main" name="main" class="col-sm-6" style="height:400px;"></div>
<div id="chart2" name="chart2" class="col-sm-6" style="height:400px;"></div>

<%
    SqlConn sqlconn = new SqlConn();
    Connection connection = SqlConn.getConnection();
    List<Bill> billList = null;
    if (connection != null) {
        billList = SqlConn.selectAllFromBill();

        // 统计每种收支类型的金额
        int salary = 0;
        int investment = 0;
        int otherIncome = 0;
        int dailyConsumption = 0;
        int cultureAndSports = 0;
        int otherConsumption = 0;

        for (Bill bill : billList) {
            switch (bill.getType()) {
                case "工资":
                    salary += bill.getSum();
                    break;
                case "投资":
                    investment += bill.getSum();
                    break;
                case "其他收入":
                    otherIncome += bill.getSum();
                    break;
                case "日常消费":
                    dailyConsumption += bill.getSum();
                    break;
                case "文化体育":
                    cultureAndSports += bill.getSum();
                    break;
                default:
                    otherConsumption += bill.getSum();
                    break;
            }
        }

        // 将统计结果传递给JavaScript
        pageContext.setAttribute("salary", salary);
        pageContext.setAttribute("investment", investment);
        pageContext.setAttribute("otherIncome", otherIncome);
        pageContext.setAttribute("dailyConsumption", dailyConsumption);
        pageContext.setAttribute("cultureAndSports", cultureAndSports);
        pageContext.setAttribute("otherConsumption", otherConsumption);
    } else {
        out.println("数据库连接失败");
    }
%>

<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));
    // 指定图表的配置项和数据
    myChart.title = '账单收支统计';

    option = {
        color: ['#3398DB'],
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: ['工资', '投资', '其他收入', '日常消费', '文化体育','其他消费'],
                axisTick: {
                    alignWithLabel: true
                }
            }
        ],
        yAxis: [
            {
                type: 'value'
            }
        ],
        series: [
            {
                type: 'bar',
                barWidth: '50%',
                // data:[335, 310, 234
                //     , 135, 154]
                data: [
                    <%= pageContext.getAttribute("salary") %>,
                    <%= pageContext.getAttribute("investment") %>,
                    <%= pageContext.getAttribute("otherIncome") %>,
                    <%= pageContext.getAttribute("dailyConsumption") %>,
                    <%= pageContext.getAttribute("cultureAndSports") %>,
                    <%= pageContext.getAttribute("otherConsumption") %>
                ]
            }
        ]
    };

    myChart.setOption(option);

    var pieChart = echarts.init(document.getElementById('chart2'));

    option2 = {
        tooltip: {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: ['工资', '投资', '其他收入', '日常消费', '文化体育','其他消费']
        },
        series: [
            {
                type: 'pie',
                radius: '50%',
                center: ['50%', '60%'],
                // data:[
                //     {value:335, name:'直接访问'},
                //     {value:310, name:'邮件营销'},
                //     {value:234, name:'联盟广告'},
                //     {value:135, name:'视频广告'},
                //     {value:1548, name:'搜索引擎'}
                // ],
                data: [
                    { value: <%= pageContext.getAttribute("salary") %>, name: '工资' },
                    { value: <%= pageContext.getAttribute("investment") %>, name: '投资' },
                    { value: <%= pageContext.getAttribute("otherIncome") %>, name: '其他收入' },
                    { value: <%= pageContext.getAttribute("dailyConsumption") %>, name: '日常消费' },
                    { value: <%= pageContext.getAttribute("cultureAndSports") %>, name: '文化体育' },
                    { value: <%= pageContext.getAttribute("otherConsumption") %>, name: '其他消费' }
                ],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    pieChart.setOption(option2);
</script>