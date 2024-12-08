<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="post.Post" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>수정</title>
</head>
<body>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678"; /* mysql 패스워드 입력 */
    Connection connection = null;

    int no = Integer.parseInt(request.getParameter("no")); // int로 변환
    Post post = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);

        String query = "SELECT writer, title, content, register FROM board WHERE no = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, no); // setInt로 설정
        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            String writer = resultSet.getString("writer");
            String title = resultSet.getString("title");
            String content = resultSet.getString("content");
            String register = resultSet.getString("register");
            post = new Post(no, writer, title, content, register);
        }

        resultSet.close();
        preparedStatement.close();
        connection.close();
    } catch (Exception ex) {
        out.println("오류 발생: " + ex.getMessage());
    }

    if (post != null) {
%>
<h1>수정</h1>
<form action="updatePost.jsp" method="post">
    <input type="hidden" name="no" value="<%= post.getNo() %>">
    <br>
    <label for="title">제목:</label>
    <textarea id="title" name="title" required><%= post.getTitle() %></textarea>
    
	<label for="content">제목:</label>
    <textarea id="content" name="content" required><%= post.getContent() %></textarea>
    
    <br>
    <button type="submit">수정</button>
</form>
<%
    } else {
        out.println("해당 글을 찾을 수 없습니다.");
    }
%>
</body>
</html>