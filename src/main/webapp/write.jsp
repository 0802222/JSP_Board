<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>        
<%@ page import="jakarta.servlet.http.HttpSession" %>

<% 
    String userID = (String) session.getAttribute("userID");
    if (userID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
</head>

<body>
	<h1>글쓰기</h1>
		<form action="savePost.jsp" method="post">
		    <label for="writer">작성자:</label>
		    <input type="text" id="writer" name="writer" value="<%= userID != null ? userID : "" %>" readonly><br>
			
		    <label for="title">제목:</label>
			<input type="text" id="title" name="title" required>
		    <br>
		    
		    <label for="content">내용:</label>
		    <input type="text" id="content" name="content" required><br>
		    
		    <input type="submit" value="저장">
		</form>
	</body>
</html>
