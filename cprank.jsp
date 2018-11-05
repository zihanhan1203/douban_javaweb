<%--
  Created by IntelliJ IDEA.
  User: dreamer
  Date: 11/3/18
  Time: 8:12 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.TimeZone" %>
<html>
<head>
    <title>cp排行榜</title>
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
            String password = "hjp00hxl";
            conn = DriverManager.getConnection(url, user, password);
            st = conn.createStatement();
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        String this_ip = request.getRemoteAddr();
        String format="yyyy_MM_dd";
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        sdf.setTimeZone(TimeZone.getTimeZone("Asia/Shanghai"));
        String today = sdf.format(Calendar.getInstance().getTime());
        String today_table_name = "cprank_" + today;
        String check_if_this_ip_has_voted = String.format("SELECT * FROM %s WHERE ip='%s'", today_table_name, this_ip);
        try{
            res = st.executeQuery(check_if_this_ip_has_voted);
        }catch (SQLException e){
            e.printStackTrace();
        }
    %>
    <style>
        div {
            text-align: center;
            margin-bottom: 15px;
        }
        .bg {
            margin: 0 auto;
            width: 40%;
            height: 180px;
        }
        .votemodel {
            float: left;
            display: inline-block;
            width: 50%;
        }
        .mybt {
            width:86px;
            text-align:center;
            line-height:100%;
            padding: 0.5em 2em 0.55em;
            font-family:Arial,sans-serif;
            font-size:14px;
            font-style:normal;
            font-variant:normal;
            font-weight:normal;
            text-decoration:none;
            margin: 0px 2px;
            vertical-align:text-bottom;
            display:inline-block;
            cursor:pointer;
            zoom:1;
            outline: invert medium;
            font-size-adjust:none;
            font-stretch:normal;
            border-radius: 0.5em;
            box-shadow:0px 1px 2px rgba(0,0,0,0.2);
            text-shadow:0px 1px 1px rgba(0,0,0,0.3);
            color:#fefee9;
            border: 1px solid #da7c0c;
            background-position-x:0%;
            background-position-y:0%;
            background-size:auto;
            background-origin:padding-box;
            background-clip:padding-box;
            background: #f78d1d none repeat scroll;
        }
        <%
            try {
                if(res.next()){
                    out.println(".hide {display: none;}");
                }
            }catch (SQLException e) {
                e.printStackTrace();
            }
        %>
    </style>
    <script>
        function vote(this_ip, today, table_name) {
            alert("投票成功!");
            window.location.href = "./vote.jsp?this_ip=" + this_ip + "&today=" + today + "&table_name=" + table_name;
        }
    </script>
</head>
<body>
    <%
        String[][] names = new String[12][12];
        names[1][2] = "美宣";
        names[1][3] = "岐越";
        names[1][4] = "美眷";
        names[1][5] = "迷梦";
        names[1][6] = "山七";
        names[1][7] = "美宁";
        names[1][8] = "美晴";
        names[1][9] = "美婷";
        names[1][10] = "傅岐";
        names[1][11] = "美梦";
        names[2][3] = "宣花";
        names[2][4] = "宣娟";
        names[2][5] = "宣鸭";
        names[2][6] = "宣云";
        names[2][7] = "宣宁";
        names[2][8] = "美晴";
        names[2][9] = "宣婷";
        names[2][10] = "宣菁";
        names[2][11] = "宣梦";
        names[3][4] = "超奥";
        names[3][5] = "超鸭";
        names[3][6] = "超云";
        names[3][7] = "越宁";
        names[3][8] = "越晴";
        names[3][9] = "越婷";
        names[3][10] = "父子";
        names[3][11] = "越虹";
        names[4][5] = "奥鸭";
        names[4][6] = "奥运";
        names[4][7] = "奥宁";
        names[4][8] = "奥晴";
        names[4][9] = "奥亭";
        names[4][10] = "奥菁";
        names[4][11] = "奥梦";
        names[5][6] = "押韵";
        names[5][7] = "鸭宁";
        names[5][8] = "鸭晴";
        names[5][9] = "鸭婷";
        names[5][10] = "压惊";
        names[5][11] = "鸭梦";
        names[6][7] = "紫云";
        names[6][8] = "云晴";
        names[6][9] = "云庭";
        names[6][10] = "云菁";
        names[6][11] = "云梦";
        names[7][8] = "子晴";
        names[7][9] = "紫婷";
        names[7][10] = "纸巾";
        names[7][11] = "紫梦";
        names[8][9] = "晴婷";
        names[8][10] = "清静";
        names[8][11] = "晴梦";
        names[9][10] = "婷菁";
        names[9][11] = "挺猛";
        names[10][11] = "惊梦";
        for(int i = 1; i <= 10; i++){
            for(int j = i+1; j <= 11; j++){
                String number = String.valueOf(i) + String.valueOf(j);
                String cpname = "cp_" + number;
                String query = String.format("SELECT times FROM %s", cpname);
                try {
                    res = st.executeQuery(query);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                int num = 0;
                try {
                    if(res.next()){
                        do{
                            num += res.getInt(1);
                        }while(res.next());
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                out.println("<div class=\"votemodel\">" +
                                "<div>" +
                                    "<a>" + names[i][j] + " 票数: " + num + "</a>" +
                                "</div>" +
                                "<div><img src=\"" + request.getContextPath() + "/Image/" + number + ".jpeg\" class=\"bg\"></div>" +
                                "<div class=\"hide\"><input class=\"mybt\" type=\"button\" value=\"投票\" onclick=\"vote('" + this_ip + "', '" + today + "', '" + cpname + "')\"></div>" +
                            "</div>");
            }
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
    %>
</body>
</html>
