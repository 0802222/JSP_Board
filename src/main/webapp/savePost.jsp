<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678";
    Connection conn = null;
    PreparedStatement pstmt = null;

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String register = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    String writer = (String) session.getAttribute("userID");

    if (writer == null || writer.isEmpty()) {
        writer = "Unknown"; // 기본값 설정
    }

    try {
        System.out.println("Debug: 게시글 저장 시작");
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);
        System.out.println("Debug: 데이터베이스 연결 성공");

        String query = "INSERT INTO board (title, writer, content, register) VALUES (?, ?, ?, ?)";
        System.out.println("Debug: 실행할 쿼리 -> " + query);

        pstmt = conn.prepareStatement(query);
        pstmt.setString(1, title);
        pstmt.setString(2, writer);
        pstmt.setString(3, content);
        pstmt.setString(4, register);

        int result = pstmt.executeUpdate();
        System.out.println("Debug: 게시글 삽입 성공, 삽입된 행 -> " + result);

        if (result > 0) {
            System.out.println("Debug: 게시글 저장 완료");
        } else {
            System.out.println("Debug: 게시글 저장 실패");
        }
    } catch (Exception e) {
        System.out.println("Error: " + e.getMessage());
        e.printStackTrace();
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
            System.out.println("Debug: 데이터베이스 연결 종료");
        } catch (SQLException e) {
            System.out.println("Error: 연결 종료 중 오류 -> " + e.getMessage());
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글 저장</title>
    <script>
        // 게시글 저장 후 리디렉션
        alert("게시글이 저장되었습니다.");
        window.location.href = "board.jsp";
    </script>
</head>
<body>
</body>
</html>