<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
<title>회원상세조회</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>NAME</th>
			<th>상세조회</th>
			<th>회원탈퇴</th>
		</tr>
	<c:forEach var="memberList" items="${memberList}">
		<tr> 
			<td>${memberList.id}</td>
			<td>${memberList.name}</td>
			<td><a href="memberView?id=${memberList.id}">조회</a></td>
			<td><a href="memberDelete?id=${memberList.id}">탈퇴</a></td>
		</tr>
	</c:forEach>
	</table>
	<button onclick="location.href='memberMain'">이전으로</button>
</body>
</html>