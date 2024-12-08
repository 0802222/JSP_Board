<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>로그인</title>
</head>
<body>
<h1>로그인</h1>
<form action="loginAction.jsp" method="post">
    <label for="userID">아이디:</label>
    <input type="text" id="userID" name="userID" required>
    <label for="userPassword">비밀번호:</label>
    <input type="password" id="userPassword" name="userPassword" required>
    <button type="submit">로그인</button>
</form>
</body>
</html>