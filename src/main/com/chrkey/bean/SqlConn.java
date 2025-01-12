/*
 * SqlConn.java
 * Text file encoding: utf8
 */

package chrkey.bean;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class SqlConn {
    private static final String url = "jdbc:mysql://localhost:3306/household_bill?characterEncoding=utf8&useSSL=false&useUnicode=true&allowPublicKeyRetrieval=true&serverTimezone=GMT%2B8";
    private static final String user = "root";    //数据库用户名
    private static final String password = "20031126";    //数据库密码

    private static Connection conn = null;   //建立与数据库的连接
    private static Statement stmt = null;   //用于执行静态 SQL 语句的对象
    private static ResultSet rs = null;   //用于表示数据库执行查询后返回的结果集

    PreparedStatement preparedStatement;

    //构造方法，在创建SqlConn对象时执行，尝试加载MySQL数据库驱动程序
    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");     //加载数据库驱动
            conn = DriverManager.getConnection(url, user, password);
        } catch (java.lang.ClassNotFoundException e) {
            System.err.println("SqlConn():" + e.getMessage());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return conn;
    }

    public static UserInfo checkAdminInfo(String name, String password) throws SQLException {
        UserInfo userInfo = new UserInfo();
        String sql1="select is_admin_or_not from user_info where name=?";
        String sql2="select password from user_info where name=?";
        PreparedStatement statement1 = conn.prepareStatement(sql1);
        PreparedStatement statement2 = conn.prepareStatement(sql2);
        statement1.setString(1, name);
        statement2.setString(1, name);
        ResultSet resultSet1 = statement1.executeQuery();
        ResultSet resultSet2 = statement2.executeQuery();

        if (resultSet1.next()){   //判断是否有输入名字的记录
            String is_admin_or_not_Datebase = resultSet1.getString("is_admin_or_not");
            if(Objects.equals(is_admin_or_not_Datebase, "yes")){    //判断是否为管理员
                if (resultSet2.next()){    //使用rs.getString();前一定要加上rs.next();
                    String passwordInDatabase = resultSet2.getString("password");
                    if (Objects.equals(passwordInDatabase, password)) {    //判断密码是否正确
                        userInfo = new UserInfo();
                        userInfo.setName(name);
                        userInfo.setPassword(password);
                    } else {
                        System.out.println("密码错误");
                        userInfo=null;
                    }
                }
            }
            else {
                System.out.println("非管理员");
                userInfo=null;
            }
            }
            else {
                userInfo=null;
                System.out.println("管理员名错误");
            }
        return userInfo;
    }

    public static UserInfo checkUserInfo(String name, String password) throws SQLException {
        UserInfo userInfo = new UserInfo();
        String sql1="select is_admin_or_not from user_info where name=?";
        String sql2="select password from user_info where name=?";
        PreparedStatement statement1 = conn.prepareStatement(sql1);
        PreparedStatement statement2 = conn.prepareStatement(sql2);
        statement1.setString(1, name);
        statement2.setString(1, name);
        ResultSet resultSet1 = statement1.executeQuery();
        ResultSet resultSet2 = statement2.executeQuery();

        if (resultSet1.next()){   //判断是否有输入名字的记录
            String is_admin_or_not_Datebase = resultSet1.getString("is_admin_or_not");
            if(Objects.equals(is_admin_or_not_Datebase, "no")){    //判断是否为用户
                if (resultSet2.next()) {    //使用rs.getString();前一定要加上rs.next();
                    String passwordInDatabase = resultSet2.getString("password");
                    if (Objects.equals(passwordInDatabase, password)) {    //判断密码是否正确
                        userInfo = new UserInfo();
                        userInfo.setName(name);
                        userInfo.setPassword(password);
                    } else {
                        System.out.println("密码错误");
                        userInfo=null;
                    }
                }
            }
            else{
                System.out.println("非用户");
                userInfo=null;
            }
        }
        else {
            userInfo=null;
            System.out.println("用户名错误");
        }
        return userInfo;
    }

    //用于执行SELECT语句，建立连接后创建Statement对象并执行SQL查询，最后返回结果集ResultSet
    public ResultSet executeQuery(String sql) {
        try {
            conn = DriverManager.getConnection(url, user, password);   //建立连接
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            rs = stmt.executeQuery(sql);
        } catch (SQLException ex) {
            System.err.println("SqlConn.executeQuery:" + ex.getMessage());
        }
        return rs;
    }

    //用于执行INSERT、UPDATE或DELETE语句，与数据库建立连接后创建Statement对象并执行SQL更新操作
    public int executeUpdate(String sql) {
        int i =0;
        try {
            conn = DriverManager.getConnection(url, user, password);
            stmt = conn.createStatement();
            i = stmt.executeUpdate(sql);
            stmt.close();
            conn.close();
        } catch (SQLException ex) {
            System.err.println("SqlConn.executeUpdate: " + ex.getMessage());
        }
        return i;
    }

    //关闭Statement对象，释放资源
    public void closeStmt() {
        try {
            stmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //关闭Connection对象，释放数据库连接资源
    public void closeConn() {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static List<Bill> selectAllFromBill() {
        String selectAll = "select * from bill";
        try {
            stmt = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<Bill> list = null;
        try {
            list = new ArrayList<>();
            rs = stmt.executeQuery(selectAll);
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setTime(rs.getString("time"));
                bill.setIn_or_out(rs.getString("in_or_out"));
                bill.setType(rs.getString("type"));
                bill.setSum(rs.getString("sum"));
                bill.setPerson(rs.getString("person"));
                bill.setAccount(rs.getString("account"));
                bill.setRemarks(rs.getString("remarks"));
                bill.setName(rs.getString("name"));
                list.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        // 统计每种收支类型的金额
        int salary = 0;
        int investment = 0;
        int otherIncome = 0;
        int dailyConsumption = 0;
        int cultureAndSports = 0;
        int otherConsumption = 0;

        for (Bill bill : list) {
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
        return list;
    }

    public int insertIntoBill(String time,String type,String account,String sum,String person,String remarks,String in_or_out){
        String sql="insert into `bill`(`time`,`type`,`account`,`sum`,`person`,`remarks`,`in_or_out`) values(?,?,?,?,?,?,?) ";
        int i = 0;
        try {
            preparedStatement=conn.prepareStatement(sql);
            preparedStatement.setString(1,time);
            preparedStatement.setString(2,type);
            preparedStatement.setString(3,account);
            preparedStatement.setString(4,sum);
            preparedStatement.setString(5,person);
            preparedStatement.setString(6,remarks);
            preparedStatement.setString(7,in_or_out);
            i=preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                assert preparedStatement != null;
                preparedStatement.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return i;
    }
    public static List<UserInfo> selectAllFromUserInfo() {
        String selectAll = "select * from user_info";
        try {
            stmt = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<UserInfo> list = null;
        try {
            list = new ArrayList<>();
            rs = stmt.executeQuery(selectAll);
            while (rs.next()) {
                UserInfo user_info = new UserInfo();
                user_info.setId(rs.getString("id"));
                user_info.setName(rs.getString("name"));
                user_info.setPassword(rs.getString("password"));
                user_info.setIs_admin_or_not(rs.getString("is_admin_or_not"));
                list.add(user_info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int insertIntoUserInfo(String id,String name,String password,String is_admin_or_not){
        String sql="insert into `user_info`(`id`,`name`,`password`,`is_admin_or_not`) values(?,?,?,?) ";
        int i = 0;
        try {
            preparedStatement=conn.prepareStatement(sql);
            preparedStatement.setString(1,id);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,password);
            preparedStatement.setString(4,is_admin_or_not);
            i=preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                assert preparedStatement != null;
                preparedStatement.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return i;
    }

    public static List<AccountInfo> selectAllFromAccountInfo() {
        String selectAll = "select * from account_info";
        try {
            stmt = conn.createStatement();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        List<AccountInfo> list = null;
        try {
            list = new ArrayList<>();
            rs = stmt.executeQuery(selectAll);
            while (rs.next()) {
                AccountInfo account_info = new AccountInfo();
                account_info.setAccount_number(rs.getString("account_number"));
                account_info.setName(rs.getString("name"));
                account_info.setBank(rs.getString("bank"));
                list.add(account_info);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    public int insertIntoAccountInfo(String account_number, String name, String bank) {
        String sql="insert into `account_info`(`account_number`,`name`,`bank`) values(?,?,?) ";
        int i = 0;
        try {
            preparedStatement=conn.prepareStatement(sql);
            preparedStatement.setString(1,account_number);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,bank);
            i=preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            try {
                assert preparedStatement != null;
                preparedStatement.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }

        }
        return i;
    }
}
