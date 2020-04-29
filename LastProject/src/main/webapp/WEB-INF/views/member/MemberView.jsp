<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원상세정보</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>ID</th><th>PASSWORD</th><th>NAME</th>
			<th>BIRTH</th><th>ADDRESS</th>
			<th>PHONE</th><th>PROFILEPIC</th><th>KAKAOID</th><th>NAVERID</th>
			<th>FACEBOOKID</th><th>GOOGLEID</th>
		</tr>
		<tr>
			<td>${memberView.id}</td>
			<td>${memberView.password}</td>
			<td>${memberView.name}</td>
			<td>${memberView.birth}</td>
			<td>${memberView.address}</td>
			<td>${memberView.phone}</td>
			<td>${memberView.profile}</td>
			<td>${memberView.kakaoId}</td>
			<td>${memberView.naverId}</td>
			<td>${memberView.facebookId}</td>
			<td>${memberView.googleId}</td>
	</table>
	<button onclick="location.href='memberList'">이전으로</button>
</body>
</html>