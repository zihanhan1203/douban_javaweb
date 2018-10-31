<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 10/14/18
  Time: 10:44 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<html>
<head>
    <link rel="icon" href="<%=request.getContextPath()%>/Image/icon.jpeg" type="image/x-icon">
    <title>火箭少女101研究所-研究员势力榜</title>
    <style>
        .tabNav a:hover{
            color: #ec55be;
            cursor: pointer;
        }
        div {
            text-align: center;
        }

        .customer
        {
            font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
            width:100%;
            border-collapse:collapse;
        }

        .customer td, .customer th
        {
            font-size:1em;
            border:1px solid #98bf21;
            padding:3px 7px 2px 7px;
            text-align: center;
        }

        .customer th
        {
            font-size:1.1em;
            text-align:center;
            padding-top:5px;
            padding-bottom:4px;
            background-color:#ec55be;
            color:#080808;
        }

        .customer tr.alt td
        {
            color:#000000;
            background-color:#AB34B4;
            text-align: center;
        }

    </style>
    <script>
        function tab(pid){
            var tabs=["tab1","tab2","tab3"];
            for(var i=0;i<3;i++){
                if(tabs[i]==pid){
                    document.getElementById(tabs[i]).style.display="block";
                }else{
                    document.getElementById(tabs[i]).style.display="none";
                }
            }
        }
    </script>
</head>
<body>
    <div class="content">
        <div class="bg-top">
            <img src="<%=request.getContextPath()%>/Image/bgofrank.jpeg" width="100%">
        </div>
        <div class="rank_name" style="margin-top: 3%;margin-bottom: 3%;">
            <img src="<%=request.getContextPath()%>/Image/rankname.jpeg" style="width: 30%">
        </div>
        <div class="tabNav">
            <a onclick="tab('tab1')">今日榜</a>
            <a>|</a>
            <a onclick="tab('tab2')">昨日榜</a>
            <a>|</a>
            <a onclick="tab('tab3')">总榜</a>
        </div>
        <%! Connection conn; Statement st; ResultSet rs; ResultSet res;%>
        <%
            String format="yyyy_MM_dd";
            SimpleDateFormat sdf = new SimpleDateFormat(format);
            sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
            String today_table = sdf.format(Calendar.getInstance().getTime());
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(new Date());
            calendar.add(calendar.DATE, -1);
            String yesterday_table = sdf.format(calendar.getTime());
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
        %>
        <div class="tab" style="margin-top: 3%">
            <div id="tab1" class="customer">
                <%
                    out.println("<a>" + today_table + "</a>");
                    try{
                        rs = conn.getMetaData().getTables(null, null, today_table, null);
                        if(rs.next()){
                            out.println(
                                    "<table width=\"50%\" style=\"margin: 0 auto\">" +
                                    "<tr>" +
                                            "<th>排名</th>" +
                                            "<th>ID</th>" +
                                            "<th>名字</th>" +
                                            "<th>发言数</th>" +
                                            "<th>开贴数</th>" +
                                            "<th>收到评论数</th>" +
                                            "<th>总分</th>" +
                                    "</tr>"
                            );
                            String get_today_rank = "select * from " + today_table + " order by (comment + " +
                                    " post*5 + comment_got) desc LIMIT 100";
                            res = st.executeQuery(get_today_rank);
                            int i = 0;
                            while(res.next()){
                                if(i == 0){
                                    out.println("<tr style=\"background-color: #f5e17e\">");
                                }else if(i == 1){
                                    out.println("<tr style=\"background-color: #c5c6ce\">");
                                }else if(i == 2){
                                    out.println("<tr style=\"background-color: #b87333\">");
                                }else if(i%2 == 0){
                                    out.println("<tr class=\"alt\">");
                                }else{
                                    out.println("<tr>");
                                }
                                int post = Integer.parseInt(res.getString(3));
                                int comment = Integer.parseInt(res.getString(4));
                                int comment_got = Integer.parseInt(res.getString(5));
                                int sum = comment + post*5 + comment_got;
                                out.println(
                                                "<td>" + (i+1) + "</td>" +
                                                "<td>" + res.getString(1) + "</td>" +
                                                "<td>" + res.getString(2) + "</td>" +
                                                "<td>" + res.getString(4) + "</td>" +
                                                "<td>" + res.getString(3) + "</td>" +
                                                "<td>" + res.getString(5) + "</td>" +
                                                "<td>" + sum + "</td>" +
                                        "</tr>"
                                );
                                i++;
                            }
                            out.println("</table>");
                        }else{
                            out.println("<a>暂时还没有数据</a>");
                        }
                    }catch (java.sql.SQLException e){
                        e.printStackTrace();
                    }
                %>
            </div>
            <div id="tab2" class="customer" style="display: none">
                <%
                    out.println("<a>" + yesterday_table + "</a>");
                    try{
                        rs = conn.getMetaData().getTables(null, null, yesterday_table, null);
                        if(rs.next()){
                            out.println(
                                    "<table width=\"50%\" style=\"margin: 0 auto\">" +
                                            "<tr>" +
                                            "<th>排名</th>" +
                                            "<th>ID</th>" +
                                            "<th>名字</th>" +
                                            "<th>发言数</th>" +
                                            "<th>开贴数</th>" +
                                            "<th>收到评论数</th>" +
                                            "<th>总分</th>" +
                                            "</tr>"
                            );
                            String get_yesterday_rank = "select * from " + yesterday_table + " order by (comment + " +
                                    " post*5 + comment_got) desc LIMIT 100";
                            res = st.executeQuery(get_yesterday_rank);
                            int i = 0;
                            while(res.next()){
                                if(i == 0){
                                    out.println("<tr style=\"background-color: #f5e17e\">");
                                }else if(i == 1){
                                    out.println("<tr style=\"background-color: #c5c6ce\">");
                                }else if(i == 2){
                                    out.println("<tr style=\"background-color: #b87333\">");
                                }else if(i%2 == 0){
                                    out.println("<tr class=\"alt\">");
                                }else{
                                    out.println("<tr>");
                                }
                                int post = Integer.parseInt(res.getString(3));
                                int comment = Integer.parseInt(res.getString(4));
                                int comment_got = Integer.parseInt(res.getString(5));
                                int sum = comment + post*5 + comment_got;
                                out.println(
                                        "<td>" + (i+1) + "</td>" +
                                                "<td>" + res.getString(1) + "</td>" +
                                                "<td>" + res.getString(2) + "</td>" +
                                                "<td>" + res.getString(4) + "</td>" +
                                                "<td>" + res.getString(3) + "</td>" +
                                                "<td>" + res.getString(5) + "</td>" +
                                                "<td>" + sum + "</td>" +
                                                "</tr>"
                                );
                                i++;
                            }
                            out.println("</table>");
                        }else{
                            out.println("<a>暂时还没有数据</a>");
                        }
                    }catch (java.sql.SQLException e){
                        e.printStackTrace();
                    }
                %>
            </div>
            <div id="tab3" class="customer" style="display: none">
                <%
                    try{
                        rs = conn.getMetaData().getTables(null, null, "base_data", null);
                        if(rs.next()){
                            out.println(
                                    "<table width=\"50%\" style=\"margin: 0 auto\">" +
                                            "<tr>" +
                                            "<th>排名</th>" +
                                            "<th>ID</th>" +
                                            "<th>名字</th>" +
                                            "<th>发言数</th>" +
                                            "<th>收到点赞数</th>" +
                                            "<th>开贴数</th>" +
                                            "<th>收到评论数</th>" +
                                            "<th>总分</th>" +
                                            "</tr>"
                            );
                            String get_yesterday_rank = "select * from base_data order by (comment + " +
                                    " post*5 + comment_got) desc LIMIT 100";
                            res = st.executeQuery(get_yesterday_rank);
                            int i = 0;
                            while(res.next()){
                                if(i == 0){
                                    out.println("<tr style=\"background-color: #f5e17e\">");
                                }else if(i == 1){
                                    out.println("<tr style=\"background-color: #c5c6ce\">");
                                }else if(i == 2){
                                    out.println("<tr style=\"background-color: #b87333\">");
                                }else if(i%2 == 0){
                                    out.println("<tr class=\"alt\">");
                                }else{
                                    out.println("<tr>");
                                }
                                int post = Integer.parseInt(res.getString(3));
                                int comment = Integer.parseInt(res.getString(4));
                                int comment_got = Integer.parseInt(res.getString(5));
                                int sum = comment + post*5 + comment_got;
                                out.println(
                                        "<td>" + (i+1) + "</td>" +
                                                "<td>" + res.getString(1) + "</td>" +
                                                "<td>" + res.getString(2) + "</td>" +
                                                "<td>" + res.getString(4) + "</td>" +
                                                "<td>" + res.getString(3) + "</td>" +
                                                "<td>" + res.getString(5) + "</td>" +
                                                "<td>" + sum + "</td>" +
                                                "</tr>"
                                );
                                i++;
                            }
                            out.println("</table>");
                        }else{
                            out.println("<a>暂时还没有数据</a>");
                        }
                    }catch (java.sql.SQLException e){
                        e.printStackTrace();
                    }
                %>
            </div>
            <%
                try {
                    if(rs != null)
                        rs.close();
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
            %>
        </div>
    </div>
</body>
</html>
