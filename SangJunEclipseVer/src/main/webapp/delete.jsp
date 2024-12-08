<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
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
    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678"; /* mysql 패스워드 입력 */
    Connection connection = null;

    int no = Integer.parseInt(request.getParameter("no")); // int로 변환

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);

        // 잘못된 따옴표 수정
        String query = "DELETE FROM board WHERE no = ?"; // 열 이름은 따옴표 없이
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setInt(1, no); // 'no' 값 설정
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            out.println("<script>alert('글이 성공적으로 삭제되었습니다.'); location.href='board.jsp';</script>");
        } else {
            out.println("<script>alert('글 삭제에 실패하였습니다.'); location.href='board.jsp';</script>");
        }

        preparedStatement.close();
        connection.close();
    } catch (Exception ex) {
        out.println("<script>alert('오류 발생: " + ex.getMessage() + "'); location.href='board.jsp';</script>");
    }
%>
</body>
</html>