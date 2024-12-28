<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%
    // 요청과 응답 인코딩 설정
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");

    // 입력 데이터 수집
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String register = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
    String writer = (String) session.getAttribute("userID");

    // 기본값 설정
    if (writer == null || writer.isEmpty()) {
        writer = "Unknown"; // 기본값
    }

    // 데이터베이스 작업
    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
                 "INSERT INTO board (title, writer, content, register) VALUES (?, ?, ?, ?)")) {

        // 쿼리 파라미터 설정
        pstmt.setString(1, title);
        pstmt.setString(2, writer);
        pstmt.setString(3, content);
        pstmt.setString(4, register);

        // 실행 및 결과 확인
        int result = pstmt.executeUpdate();

        if (result > 0) {
            System.out.println("Debug: 게시글 저장 성공");
        } else {
            System.out.println("Debug: 게시글 저장 실패");
        }
    } catch (Exception e) {
        // 에러 처리
        System.out.println("Error: " + e.getMessage());
        e.printStackTrace();
        response.sendRedirect("error.jsp"); // 에러 페이지로 리디렉션
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 저장</title>
    <script>
        // 성공 메시지와 리디렉션
        alert("게시글이 저장되었습니다.");
        window.location.href = "board.jsp";
    </script>
</head>
<body>
</body>
</html>