<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="post.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="config.DatabaseConfig" %>

<!DOCTYPE html>
<html lang="ko">
    <head>
        <title> 동동 게시판 </title>
        <link rel="stylesheet" href="css/style.css" />
    </head>
    <body>

<%
    // 초기화
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	ArrayList<Post> postList = new ArrayList<>();

    // "message" 파라미터가 있는 경우 출력
	String message = request.getParameter("message");
	if (message != null) {
%>
<p style="color: red;"><%= message %></p>
<%
    }

    try {
        // DatabaseConfig를 통한 DB 연결
        connection = DatabaseConfig.getConnection();

        // 게시글 가져오기
        String query = "SELECT no, writer, title, content, register FROM board";
        statement = connection.createStatement();
        resultSet = statement.executeQuery(query);

        // 결과를 리스트에 추가
        while (resultSet.next()) {
            int no = resultSet.getInt("no");
            String writer = resultSet.getString("writer");
            String title = resultSet.getString("title");
            String content = resultSet.getString("content");
            String register = resultSet.getString("register");
            Post post = new Post(no, writer, title, content, register);
            postList.add(post);
        }

    } catch (ClassNotFoundException | SQLException ex) {

    } finally {
        // 리소스 해제
        if (resultSet != null) resultSet.close();
        if (statement != null) statement.close();
        if (connection != null) connection.close();
    }
%>

<div class="image-container">
    <img src="images/dongdonghi.jpeg" alt="장모치와와 동동이가 서있는 모습" height="350" width="500">
</div>

<!-- 로그인 폼 -->
<div>
    <form action="loginAction.jsp" method="post">
        <label for="userID">ID:</label>
        <input type="text" id="userID" name="userID" placeholder="ID를 입력해주세요."><br>

        <label for="userPassword">PW:</label>
        <input type="password" id="userPassword" name="userPassword" placeholder="PW를 입력해주세요."><br>

        <input type="submit" value="Log in">
    </form>
    <!-- 회원가입 버튼 -->
    <button onclick="location.href='userJoin.jsp'">회원가입</button>

</div>



</body>
</html>