<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
    request.setCharacterEncoding("UTF-8"); // 사용자가 보낸 데이터를 UTF-8로 받음
    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");
    String userName = request.getParameter("userName");

    // 입력값 검증
    if (userID == null || userPassword == null || userName == null ||
        userID.trim().isEmpty() || userPassword.trim().isEmpty() || userName.trim().isEmpty()) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('입력되지 않은 항목이 있습니다.');");
        script.println("history.back();"); // 이전 페이지로 이동
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO(); // userDAO 인스턴스 생성

    // 중복 확인
    if (userDAO.isUserExists(userID)) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('이미 사용 중인 아이디입니다. 다른 아이디를 입력하세요.');");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    // 회원가입 시도
    int result = userDAO.join(userID, userPassword, userName);
    if (result == 1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 성공했습니다.');");
        script.println("location.href = 'index.jsp';"); // 메인 페이지로 이동
        script.println("</script>");
        script.close();
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert('회원가입에 실패했습니다. 다시 시도해주세요.');");
        script.println("history.back();"); // 이전 페이지로 이동
        script.println("</script>");
        script.close();
    }
%>