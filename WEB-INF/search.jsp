<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 10/15/18
  Time: 10:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*" %>
<html>
<head>
    <link rel="icon" href="<%=request.getContextPath()%>/Image/icon.jpeg" type="image/x-icon">
    <title>你想的人</title>
    <style>
        .customer a:hover{
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
            background-color:#FFD9EC;
            text-align: center;
        }
    </style>
    <script>
        function get_to_id(id) {
            window.location.href = "./person.jsp?id="+id;
        }
    </script>
</head>
<body>
    <div class="bg-top" style="margin-bottom: 100px">
        <img src="<%=request.getContextPath()%>/Image/bgofsearch.jpeg" width="100%">
    </div>
    <%! Connection conn; Statement st; ResultSet res;%>
    <div class="customer">
        <%
            request.setCharacterEncoding("utf-8");
            String name_or_id = request.getParameter("name_or_id");
            String ip = request.getRemoteAddr();
            if(name_or_id == ""){
                out.print("<a>东西都不输入，你想搜什么？？？</a>");
            }else {
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
                try {
                    String get_person_info = String.format("SELECT * FROM base_data WHERE ID LIKE '%%%s%%' OR name LIKE '%%%s%%'", name_or_id, name_or_id);
                    res = st.executeQuery(get_person_info);
                    if (res.next()) {
                        res.previous();
                        out.println(
                                "<table width=\"50%\" style=\"margin: 0 auto\">" +
                                        "<tr>" +
                                        "<th>序号</th>" +
                                        "<th>ID</th>" +
                                        "<th>名字</th>" +
                                        "<th>发言数</th>" +
                                        "<th>开贴数</th>" +
                                        "<th>收到评论数</th>" +
                                        "<th>总分</th>" +
                                        "<th>成就</th>" +
                                        "</tr>"
                        );
                        int i = 0;
                        while (res.next()) {
                            if (i % 2 == 0) {
                                out.println("<tr class=\"alt\">");
                            } else {
                                out.println("<tr>");
                            }
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
                            out.println(
                                    "<td>" + (i + 1) + "</td>" +
                                            "<td>" + res.getString(1) + "</td>" +
                                            "<td><a onclick=\"get_to_id("+ res.getString(1) + ")\">"
                                            + res.getString(2) + "</a></td>" +
                                            "<td>" + res.getString(4) + "</td>" +
                                            "<td>" + res.getString(3) + "</td>" +
                                            "<td>" + res.getString(5) + "</td>" +
                                            "<td>" + sum + "</td>" +
                                            "<td>" + achievement + "</td>" +
                                            "</tr>"
                            );
                            i++;
                        }
                        out.println("</table>");
                    } else {
                        out.println("没有找到该研究员, 好气哦!!!");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
