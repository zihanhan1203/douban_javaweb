<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 9/25/18
  Time: 4:35 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.TimeZone" %>
<html>
  <head>
      <link rel="icon" href="<%=request.getContextPath()%>/Image/icon.jpeg" type="image/x-icon">
    <title>豆瓣火箭少女101研究所数据中心</title>
      <style>
          .logo {
              margin: 0 auto;
              width: 50%;
              height: auto;
              text-align:center;
              display:block;
          }
          .bg {
              margin: 0 auto;
              width: 16%;
          }
          form {
              text-align:center;
              margin-bottom: 25px;
          }
          .search-box {
              width: 500px;
              height: 40px;
              font-size: 15px;
          }
          .submit {
              width: 100px;
              height: 40px;
              color: #fff;
              font-size: 15px;
              letter-spacing: 1px;
              background: #ec55be;
              border-bottom: 1px solid #2d78f4;
              outline: medium;
              *border-bottom: 0;
              -webkit-appearance: none;
              -webkit-border-radius: 0
          }
          .inline_bg{
              display: inline;
              margin: 0px;
              position: relative;
              width: 16%;
          }

      </style>
  </head>
  <body>
    <div class="content">
        <div class="inline_bg" style="margin-left: 11px">
            <img src="<%=request.getContextPath()%>/Image/bg1.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg2.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg3.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg4.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg5.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg6.jpeg" class="bg">
        </div>

        <div>
            <img src="<%=request.getContextPath()%>/Image/logo.jpeg" class="logo">
        </div>


        <div class="search_form">
            <form action="search" method="post">
                <input type = "text" name = "name_or_id" placeholder="请大胆地搜索你心中的那位研究员吧" class="search-box">
                <input type = "submit" value = "发射" class="submit"/>
            </form>
        </div>

        <div style="margin-bottom: 25px">
            <a href="${pageContext.request.contextPath}/rank" style="display: block;text-align: center; color: #ec55be; text-decoration:none;">研究员势力榜</a>
        </div>
        <%! Connection conn; Statement st; ResultSet res;%>
        <%
            String format="yyyy_MM_dd";
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
            String today_table = sdf.format(Calendar.getInstance().getTime());
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            }catch (ClassNotFoundException e){
                e.printStackTrace();
            }
            try{
                String url="jdbc:mysql://localhost:3306/douban_rocketgirl101_group?serverTimezone=UTC&useSSL=" +
                        "false&autoReconnect=true&failOverReadOnly=false";
                String user="root";
                String password="123456";
                conn = DriverManager.getConnection(url, user, password);
                st = conn.createStatement();
            }catch (java.sql.SQLException e){
                e.printStackTrace();
            }
            String getdata = "Select * from eachday_groupdata where date = '" + today_table + "'";
            int people = 0;
            int post = 0;
            try{
                res = st.executeQuery(getdata);
                if(res.next()){
                    people = Integer.parseInt(res.getString(3));
                    post = Integer.parseInt(res.getString(2));
                }else{
                    System.out.print("no");
                }
            }catch (java.sql.SQLException e){
                e.printStackTrace();
            }
        %>
        <div style="margin-bottom: 25px">
            <a style="display: block; text-align: center; color: darkmagenta">今日开贴数: <% out.print(post);%> 今日活跃人数: <% out.print(people);%></a>
        </div>

        <div class="inline_bg" style="margin-left: 11px">
            <img src="<%=request.getContextPath()%>/Image/bg7.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg8.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg9.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg10.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg11.jpeg" class="bg">
        </div>
        <div class="inline_bg">
            <img src="<%=request.getContextPath()%>/Image/bg12.jpeg" class="bg">
        </div>
    </div>
  </body>
</html>
