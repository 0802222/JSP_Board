<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <meta name="description" content="자유롭게 등록해보세요">
    <style>
        .container {
            width: 740px;
            margin: 20px auto;
            padding: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
        }
        th {
            background-color: #f4f4f4;
            text-align: center;
        }
        .write-button {
            text-align: right;
            margin-bottom: 10px;
        }
    </style>
</head>

<body>
<h1>게시판</h1>

<!-- 로그아웃 버튼 -->
<div class="write-button">
    <button onclick="location.href='index.jsp'">로그아웃</button>
</div>

<img src="images/dongdong.png" alt="장모치와와 동동이 사진">

<!-- 전체 컨테이너 -->
<div class="container">

    <!-- 글쓰기 버튼 -->
    <div class="write-button">
        <button onclick="location.href='write.jsp'">글쓰기</button>
    </div>

    <!-- 게시글 테이블 -->
    <table>
        <thead>
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <%
            // 디버깅 로그 추가
            System.out.println("Debug: 게시판 로드 시작");
            String jdbcUrl = "jdbc:mysql://localhost:3306/tutorial";
            String dbId = "root";
            String dbPwd = "12345678";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                System.out.println("Debug: 데이터베이스 연결 시도");
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcUrl, dbId, dbPwd);
                System.out.println("Debug: 데이터베이스 연결 성공");

                String query = "SELECT no, title, writer, content, register, views FROM board ORDER BY no DESC";
                System.out.println("Debug: 실행할 쿼리 -> " + query);

                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                System.out.println("Debug: 쿼리 실행 성공");

                while (rs.next()) {
                    int no = rs.getInt("no");
                    String title = rs.getString("title");
                    String writer = rs.getString("writer");
                    String content = rs.getString("content");
                    String register = rs.getString("register");
                    int views = rs.getInt("views");

                    // 디버깅 출력
                    System.out.println("Debug: 게시글 번호 -> " + no);
                    System.out.println("Debug: 제목 -> " + title);
                    System.out.println("Debug: 작성자 -> " + writer);
        %>

        <tr>
            <td><%= no %></td>
            <td><a href="viewPost.jsp?no=<%= no %>"><%= title %></a></td>
            <td><%= writer %></td>
            <td><%= content %></td>
            <td><%= register %></td>
            <td><%= views %></td>
        </tr>

        <%
                }
            } catch (Exception e) {
                System.out.println("Error: " + e.getMessage());
                e.printStackTrace(); // 예외 출력
        %>
        <tr>
            <td colspan="6" style="text-align:center; color:red;">오류가 발생했습니다. 관리자에게 문의하세요.</td>
        </tr>
        <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                    System.out.println("Debug: 데이터베이스 연결 종료");
                } catch (SQLException e) {
                    System.out.println("Error: 연결 종료 중 오류 -> " + e.getMessage());
                }
            }
        %>

        </tbody>
    </table>

</div>
</body>
</html>