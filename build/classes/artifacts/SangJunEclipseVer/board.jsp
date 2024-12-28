<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="config.DatabaseConfig" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <meta name="description" content="자유롭게 등록해보세요">
    <link rel="stylesheet" href="css/style.css" />
</head>

<body>
<h1>게시판</h1>

<!-- 로그아웃 버튼 -->
<button onclick="location.href='index.jsp'">로그아웃</button>

<div class="image-container">
    <img src="images/dongdong.png" alt="장모치와와 동동이 사진">
</div>

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
            try (Connection conn = DatabaseConfig.getConnection()) {
                String query = "SELECT no, title, writer, content, register, views FROM board ORDER BY no DESC";

                try (PreparedStatement pstmt = conn.prepareStatement(query);
                     ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
                        int no = rs.getInt("no");
                        String title = rs.getString("title");
                        String writer = rs.getString("writer");
                        String content = rs.getString("content");
                        String register = rs.getString("register");
                        int views = rs.getInt("views");
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
            }
        } catch (Exception e) {
            // 예외 발생 시 사용자 메시지 출력
        %>
        <tr>
            <td colspan="6" style="text-align:center; color:red;">오류가 발생했습니다. 관리자에게 문의하세요.</td>
        </tr>
        <%
                e.printStackTrace();
            }
        %>
        </tbody>
    </table>

</div>
</body>
</html>