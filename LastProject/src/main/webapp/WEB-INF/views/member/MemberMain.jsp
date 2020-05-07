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
	function memberList(){
		location.href="memberList";
	}
	function memberModifyForm(){
		location.href="memberModifyForm";
	}
	function memberAttendance(){
		location.href="memberAttendance";
	}
	function sellerModifyForm(){
		location.href="sellerModifyForm";
	}
</script>
</head>
<body>
	${sessionScope.loginId}님 환영합니다.
	<!-- ${nickName} -->
	<!-- ${kakaoProfile}
	<h1>${nickName}</h1>
	<img src="${thumbnail}"> -->
	<c:if test="${sessionScope.loginId eq 'admin@icia.com'}">
		<button onclick="memberList()">회원 목록</button>
	</c:if>
	<c:if test="${sessionScope.loginIdDivision eq 1}">
		<button onclick="memberModifyForm()">회원 정보 수정</button>
	</c:if>
	<c:if test="${sessionScope.loginIdDivision eq 2}">
		<button onclick="sellerModifyForm()">판매자 정보 수정</button>
	</c:if>
	<c:if test="${sessionScope.loginIdDivision eq 2}">
		<button onclick="#">상품등록</button>
	</c:if>
	<button onclick="memberAttendance()">출석</button>
	<button onclick="location.href='boardList'">게시판</button>
	<button onclick="location.href='boardListPaging'">게시판(페이징)</button>
	<button onclick="memberLogout()">로그아웃</button>
</body>
</html>