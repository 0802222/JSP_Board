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
    int no = Integer.parseInt(request.getParameter("no")); // int로 변환

    try (Connection conn = DatabaseConfig.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(
                 "UPDATE board SET title = ?, content = ? WHERE no = ?")) {

        // 쿼리 파라미터 설정
        pstmt.setString(1, title);
        pstmt.setString(2, content);
        pstmt.setInt(3, no);

        // 실행 및 결과 확인
        int result = pstmt.executeUpdate();

        if (result > 0) {
%>
<script>
    alert("글이 성공적으로 수정되었습니다.");
    window.location.href = "board.jsp";
</script>
<%
} else {
%>
<script>
    alert("글 수정에 실패하였습니다.");
    window.location.href = "board.jsp";
</script>
<%
    }
} catch (Exception e) {
    // 예외 처리
    System.out.println("Error: " + e.getMessage());
    e.printStackTrace();
%>
<script>
    alert("오류 발생: <%= e.getMessage() %>");
    window.location.href = "board.jsp";
</script>
<%
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>글 수정 완료</title>
</head>
<body>
</body>
</html>