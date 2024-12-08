<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="post.Post" %>
<%@ page import="java.util.ArrayList" %>
<%--<%@ page import="org.apache.logging.log4j.LogManager" %>--%>
<%--<%@ page import="org.apache.logging.log4j.Logger" %>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title> 동동 게시판 </title>

</head>
<body>

<%
    // Log4j 2.x Logger 초기화
//    Logger logger = LogManager.getLogger("JSP");

    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678"; // MySQL 비밀번호
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    ArrayList<Post> postList = new ArrayList<>();

    String message = request.getParameter("message");
    if (message != null) {
%>
<p style="color: red;"><%= message %></p>
<%
    }

    try {
        // 데이터베이스 연결
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);

        String query = "SELECT no, writer, title, content, register FROM board";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(query);

        while (resultSet.next()) {
            int no = resultSet.getInt("no");
            String writer = resultSet.getString("writer");
            String title = resultSet.getString("title");
            String content = resultSet.getString("content");
            String register = resultSet.getString("register");
            Post post = new Post(no, writer, title, content, register);
            postList.add(post);
        }
//        logger.info("MySQL 연결 성공!");
    } catch (ClassNotFoundException | SQLException ex) {
//        logger.error("MySQL 연결 실패: {}", ex.getMessage(), ex);
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException ex) {
//            logger.error("리소스 해제 실패: {}", ex.getMessage(), ex);
        }
    }
%>

<form action="loginAction.jsp" method="post" style="margin-bottom: 20px;">
    <label for="userID">아이디:</label>
    <input type="text" id="userID" name="userID" required>
    <label for="userPassword">비밀번호:</label>
    <input type="password" id="userPassword" name="userPassword" required>
    <button type="submit">로그인</button>
</form>

<!-- 회원가입 버튼 -->
<button onclick="location.href='userJoin.jsp'">회원가입</button>


</body>
</html>