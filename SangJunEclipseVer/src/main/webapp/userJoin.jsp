<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>회원가입</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
    </style>
</head>
<body>
<h1>회원가입</h1>
<form action="userJoinAction.jsp" method="post">
    <label for="userID">아이디:</label>
    <input type="text" id="userID" name="userID" required><br>
    <label for="userPassword">비밀번호:</label>
    <input type="password" id="userPassword" name="userPassword" required><br>
    <label for="userName">이름:</label>
    <input type="text" id="userName" name="userName" required><br>
    <button type="submit">회원가입</button>
</form>
<button onclick="location.href='login.jsp'">로그인 하기</button>
</body>
</html>