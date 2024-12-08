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
    <title>글 수정 완료</title>
</head>
<body>
<%
    String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
    String dbId = "root";
    String dbPwd = "12345678"; /* mysql 패스워드 입력 */
    Connection connection = null;

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String register = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date());
    int no = Integer.parseInt(request.getParameter("no")); // int로 변환

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);

        // SQL 쿼리 수정 (마지막 쉼표 제거)
        String query = "UPDATE board SET title = ?, content = ? WHERE no = ?";
        PreparedStatement preparedStatement = connection.prepareStatement(query);
        preparedStatement.setString(1, title);
        preparedStatement.setString(2, content);
        preparedStatement.setInt(3, no); // setInt로 설정
        int result = preparedStatement.executeUpdate();

        if (result > 0) {
            out.println("글이 성공적으로 수정되었습니다.");
        } else {
            out.println("글 수정에 실패하였습니다.");
        }

        preparedStatement.close();
        connection.close();
    } catch (Exception ex) {
        out.println("오류 발생: " + ex.getMessage());
    }
%>
<br>
<a href="board.jsp">글 목록으로 돌아가기</a>
</body>
</html>