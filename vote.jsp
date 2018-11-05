<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 11/3/18
  Time: 9:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Vote</title>
</head>
<body>
<%! Connection conn; Statement st; ResultSet res;%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
    try {
        String url = "jdbc:mysql://localhost:3306/douban_rocketgirl101_group?serverTimezone=UTC&useSSL=" +
                "false&autoReconnect=true&failOverReadOnly=false&useUnicode=true&characterEncoding=UTF-8";
        String user = "root";
        String password = "123456";
        conn = DriverManager.getConnection(url, user, password);
        st = conn.createStatement();
    } catch (java.sql.SQLException e) {
        e.printStackTrace();
    }
    String this_ip = request.getParameter("this_ip");
    String day = request.getParameter("today");
    String table_name = request.getParameter("table_name");
    String put_vote = String.format("INSERT INTO %s(ip, times) VALUES ('%s', '%d') ON DUPLICATE KEY UPDATE times=times+%d",
            table_name, this_ip, 1, 1);
    try{
        st.executeUpdate(put_vote);
    }catch (java.sql.SQLException e) {
        e.printStackTrace();
    }
    String today_table_name = "cprank_" + day;
    String record_the_ip = String.format("INSERT INTO %s(ip) VALUES ('%s')", today_table_name, this_ip);
    try{
        st.executeUpdate(record_the_ip);
    }catch (java.sql.SQLException e) {
        e.printStackTrace();
    }
%>
<%
    try {
        if(res != null)
            res.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    try {
        if(res != null)
            res.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    try {
        if(st != null)
            st.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    try {
        if(conn != null)
            conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    response.sendRedirect("/cprank.jsp");
%>
</body>
</html>
