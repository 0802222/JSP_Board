<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="userDAO" class ="user.UserDAO"/>
<%@ page import="java.io.PrintWriter" %>

<%
    request.setCharacterEncoding("UTF-8");

    String userID = request.getParameter("userID");
    String userPassword = request.getParameter("userPassword");

    // JSP에서 기본 제공되는 session 객체를 그대로 사용
    if (session == null) {
        session = request.getSession(); // 새로운 세션 생성
    }

    PrintWriter script = response.getWriter();

    if (userID == null || userPassword == null || userID.trim().isEmpty() || userPassword.trim().isEmpty()) {
        script.println("<script>");
        script.println("alert('아이디와 비밀번호를 입력해주세요.');");
        script.println("location.href='login.jsp';"); // 로그인 페이지로 이동
        script.println("</script>");
        script.close();
        return;
    }

    String sessionUserID = (String) session.getAttribute("userID");
    if (sessionUserID != null) {
        script.println("<script>");
        script.println("alert('이미 로그인되어 있습니다.');");
        script.println("location.href='board.jsp';");
        script.println("</script>");
        script.close();
        return;
    }

    boolean loginSuccess = userDAO.login(userID, userPassword);

    if (loginSuccess) {
        session.setAttribute("userID", userID);
        script.println("<script>");
        script.println("alert('로그인에 성공했습니다.');");
        script.println("location.href = 'board.jsp';");
        script.println("</script>");
    } else {
        script.println("<script>");
        script.println("alert('아이디 또는 비밀번호가 올바르지 않습니다.');");
        script.println("history.back();");
        script.println("</script>");
    }
    script.close();
%>