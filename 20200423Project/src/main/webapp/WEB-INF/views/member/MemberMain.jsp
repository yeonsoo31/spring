<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function memberLogout(){
		location.href="memberLogout";
	}
	function modify(){
		location.href="modifyForm";
	}
</script>
</head>
<body>
	${sessionScope.loginId} 님 환영합니다.
	${kakaoProfile}
	<h1>${nickName}</h1>
	<img src="${thumbnail}">
	<c:if test="${sessionScope.loginId eq 'admin93'}">
		<a href="memberList">회원 목록 조회</a>
	</c:if>
	<button onclick="modify()">회원 정보 수정</button>
	<button onclick="location.href='boardList'">게시판</button>
	<button onclick="location.href='boardListPaging'">게시판(페이징)</button>
	<button onclick="memberLogout()">로그아웃</button>
</body>
</html>