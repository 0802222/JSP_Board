<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="post.Post" %>
<%@ page import="config.DatabaseConfig" %>
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
    // 게시글 번호
    int no = Integer.parseInt(request.getParameter("no"));
    Post post = null;

    try (Connection connection = DatabaseConfig.getConnection()) {
        String query = "SELECT writer, title, content, register FROM board WHERE no = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, no); // no 값 바인딩
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    String writer = resultSet.getString("writer");
                    String title = resultSet.getString("title");
                    String content = resultSet.getString("content");
                    String register = resultSet.getString("register");
                    post = new Post(no, writer, title, content, register);
                }
            }
        }
    } catch (Exception ex) {
        out.println("<p style='color: red;'>오류 발생: " + ex.getMessage() + "</p>");
    }

    if (post != null) {
%>
<h1>수정</h1>
<form action="updatePost.jsp" method="post">
    <input type="hidden" name="no" value="<%= post.getNo() %>">
    <br>
    <label for="title">제목:</label>
    <textarea id="title" name="title" required><%= post.getTitle() %></textarea>
    <br>
    <label for="content">내용:</label>
    <textarea id="content" name="content" required><%= post.getContent() %></textarea>
    <br>
    <button type="submit">수정</button>
</form>
<%
} else {
%>
<p style="color: red;">해당 글을 찾을 수 없습니다.</p>
<%
    }
%>
</body>
</html>