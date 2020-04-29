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
			<td>${memberView.mid}</td>
			<td>${memberView.mpassword}</td>
			<td>${memberView.mname}</td>
			<td>${memberView.mbirth}</td>
			<td>${memberView.maddress}</td>
			<td>${memberView.mphone}</td>
			<td>${memberView.mprofilepic}</td>
			<td>${memberView.kakaoId}</td>
			<td>${memberView.naverId}</td>
			<td>${memberView.facebookId}</td>
			<td>${memberView.googleId}</td>
	</table>
	<button onclick="location.href='memberList'">이전으로</button>
</body>
</html>