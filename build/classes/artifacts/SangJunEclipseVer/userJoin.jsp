<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>회원가입</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<h1>회원가입</h1>
<div>
    <form action="userJoinAction.jsp" method="post">
        <label for="userID">ID:</label>
        <input type="text" id="userID" name="userID" placeholder="ID를 입력해주세요."><br>

        <label for="userPassword">PW:</label>
        <input type="password" id="userPassword" name="userPassword" placeholder="PW를 입력해주세요."><br>

        <label for="userName">이름:</label>
        <input type="text" id="userName" name="userName" placeholder="이름을 입력해주세요."><br>

        <input type="submit" value="Submit">
    </form>
</div>

<button onclick="location.href='index.jsp'">돌아가기</button>
</body>
</html>