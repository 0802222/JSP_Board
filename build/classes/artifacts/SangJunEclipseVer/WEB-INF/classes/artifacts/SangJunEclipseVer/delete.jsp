<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>
<%
    request.setCharacterEncoding("UTF-8");
    response.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>삭제</title>
</head>
<body>
<%
    //삭제 대상 게시글 번호 int로 반환
    int no = Integer.parseInt(request.getParameter("no"));

    try (Connection connection = DatabaseConfig.getConnection()) {
        //SQL 삭제 쿼리
        String query = "DELETE FROM board WHERE no = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, no); // 'no' 값 바인딩
            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                out.println("<script>alert('글이 성공적으로 삭제되었습니다.'); location.href='board.jsp';</script>");
            } else {
                out.println("<script>alert('글 삭제에 실패하였습니다.'); location.href='board.jsp';</script>");
            }
        }
    } catch (Exception ex) {
        out.println("<script>alert('오류 발생: " + ex.getMessage() + "'); location.href='board.jsp';</script>");
    }
%>
</body>
</html>