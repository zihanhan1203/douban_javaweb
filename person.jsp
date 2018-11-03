<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 11/2/18
  Time: 4:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.Connection,java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
<html>
<head>
    <link rel="icon" href="<%=request.getContextPath()%>/Image/icon.jpeg" type="image/x-icon">
    <title>个人信息</title>
    <style>
        div {
            text-align: center;
            margin-bottom: 50px;
        }
    </style>
</head>
<body>
    <div class="bg-top" style="margin-bottom: 100px">
        <img src="<%=request.getContextPath()%>/Image/bgofperson.jpeg" width="100%">
    </div>
    <%! Connection conn; Statement st; ResultSet res;%>
    <%
        String id = request.getParameter("id");
        String format="yyyy_MM_dd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
        String today = sdf.format(Calendar.getInstance().getTime());
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(calendar.DATE, -1);
        String yesterday = sdf.format(calendar.getTime());
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch (ClassNotFoundException e){
            e.printStackTrace();
        }
        try{
            String url="jdbc:mysql://localhost:3306/douban_rocketgirl101_group?serverTimezone=UTC&useSSL=" +
                    "false&autoReconnect=true&failOverReadOnly=false";
            String user="root";
            String password="hjp00hxl";
            conn = DriverManager.getConnection(url, user, password);
            st = conn.createStatement();
        }catch (java.sql.SQLException e){
            e.printStackTrace();
        }
    %>
    <%
        String get_info = "SELECT * from base_data where ID=" + id;
        try {
            res = st.executeQuery(get_info);
        }catch (Exception e){
            res = null;
        }
    %>
    <div>
        <%
            if(res != null){
                try{
                    while(res.next()){
                        String name = res.getString(2);
                        int post = Integer.parseInt(res.getString(3));
                        int comment = Integer.parseInt(res.getString(4));
                        int comment_got = Integer.parseInt(res.getString(5));
                        int sum = comment + post*5 + comment_got;
                        String achievement = "";
                        if (sum >= 0 && sum <= 500) {
                            achievement = "节奏学徒";
                        } else if (sum <= 1000) {
                            achievement = "节奏弟弟";
                        } else if (sum <= 2000) {
                            achievement = "节奏哥哥";
                        } else if (sum <= 3000) {
                            achievement = "节奏大师";
                        } else {
                            achievement = "你好闲哦";
                        }
                        out.println("ID: " + id + "<br>");
                        out.println("名字: " + name + "<br>");
                        out.println("总分: " + sum + "<br>");
                        out.println("成就: " + achievement + "<br>");
                    }
                }catch (java.sql.SQLException e){
                    e.printStackTrace();
                }
            }
        %>
    </div>
        <%
            String table_name = id + "_posts";
            String get_posts = String.format("SELECT * from %s", table_name);
            try {
                res = st.executeQuery(get_posts);
            }catch (Exception e){
                res = null;
            }
            List<String> today_post = new LinkedList<>();
            List<String> yesterday_post = new LinkedList<>();
            List<String> before_post = new LinkedList<>();
            if(res != null){
                try{
                    while(res.next()){
                        if(res.getString(2).equals(today)){
                            today_post.add(res.getString(1));
                        }else if(res.getString(2).equals(yesterday)){
                            yesterday_post.add(res.getString(1));
                        }else {
                            before_post.add(res.getString(1));
                        }
                    }
                }catch (java.sql.SQLException e){
                    e.printStackTrace();
                }
            }
        %>
    <div>
        <%
            out.println("今日开贴:<br>");
            if(!today_post.isEmpty()){
                for(String i : today_post){
                    out.println(String.format("<a href=\"%s\">%s</a><br>", i, i));
                }
            }else{
                out.println("今日还未开贴！");
            }
        %>
    </div>
    <div>
        <%
            out.println("昨日开贴:<br>");
            if(!yesterday_post.isEmpty()){
                for(String i : yesterday_post){
                    out.println(String.format("<a href=\"%s\">%s</a><br>", i, i));
                }
            }else{
                out.println("昨天没有开贴！真是弟弟！<br>");
            }
        %>
    </div>
    <div>
        <%
            out.println("历史开贴:<br>");
            if(!before_post.isEmpty()){
                for(String i : before_post){
                    out.println(String.format("<a href=\"%s\">%s</a><br>", i, i));
                }
            }else{
                out.println("以前没有开贴！不知道在干嘛！<br>");
            }
        %>
    </div>
</body>
</html>
