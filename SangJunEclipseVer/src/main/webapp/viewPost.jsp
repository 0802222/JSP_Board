<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .post-container {
            border: 1px solid #ddd;
            padding: 20px;
            margin-bottom: 20px;
        }
        .post-container h2 {
            margin-top: 0;
        }
        .actions {
            margin-top: 20px;
        }
        .actions button {
            margin-right: 10px;
        }
    </style>
</head>

<body>
<h1>게시글 보기</h1>
<%
    // 게시글 no를 가져옴
    String postNo = request.getParameter("no");
    if (postNo == null) {
        out.println("<script>alert('잘못된 접근입니다.'); location.href='board.jsp';</script>");
        return;
    }

    // DB 연결 및 게시글 내용 가져오기
    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678";
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);

        // 조회수 증가
        String updateQuery = "UPDATE board SET views = views + 1 WHERE no = ?";
        pstmt = conn.prepareStatement(updateQuery);
        pstmt.setString(1, postNo);
        pstmt.executeUpdate();

        // 게시글 내용 가져오기
        String query = "SELECT * FROM board WHERE no = ?";
        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, postNo);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String title = rs.getString("title");
            String writer = rs.getString("writer");
            String content = rs.getString("content");
            String register = rs.getString("register");
            int views = rs.getInt("views");
%>
<div class="post-container">
    <h2><%= title %></h2>
    <p><strong>작성자:</strong> <%= writer %></p>
    <p><strong>작성일:</strong> <%= register %></p>
    <p><strong>조회수:</strong> <%= views %></p>
    <hr>
    <p><%= content %></p>
</div>
<%
        } else {
            out.println("<script>alert('게시글이 존재하지 않습니다.'); location.href='board.jsp';</script>");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (pstmt != null) pstmt.close();
        if (conn != null) conn.close();
    }
%>

<!-- 버튼 영역 -->
<div class="actions">
    <button onclick="location.href='board.jsp'">목록으로</button>
    <button onclick="location.href='edit.jsp?no=<%= postNo %>'">수정</button>
    <button onclick="if(confirm('삭제하시겠습니까?')) location.href='delete.jsp?no=<%= postNo %>';">삭제</button>
</div>
</body>
</html>