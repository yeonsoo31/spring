<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	function doubleCheck(){
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var password = document.getElementById("password");
		var passwordCheck = document.getElementById("passwordCheck");
		if((password.value) == "") {
			alert("비밀번호를 입력해 주세요");
			password.focus();
			return false;
		}
		if(!re_password.test(password.value)) {
			alert("최소 1개의 숫자 혹은 특수문자를 포함시켜주세요");
			return false;
		}
		// 비밀번호 확인 유효성
		if((passwordCheck.value) == "") {
			alert("비밀번호 확인을 입력해 주세요");
			passwordCheck.focus();
			return false;
		}
		if((password.value)!=(passwordCheck.value)) {
			alert("비밀번호가 일치하지 않습니다");
			password.focus();
			passwordCheck.focus();
			return false;
		}
	}
</script>
</head>
<body>
	<form action="newPassword" method="post" onsubmit="return doubleCheck()">
		아이디 : <input type="text" name="id" value="${findEmail}" readonly><br>
		새 비밀번호 : <input type="password" id="password" name="password"><br>
		비밀번호 확인 : <input type="password" id="passwordCheck" name="passwordCheck"><br>
	<input type="submit" value="확인">
	</form>
</body>
</html>