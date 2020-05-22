<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	function sellerPasswordModify(){
		var id = document.getElementById("id").value;
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var password = document.getElementById("password").value;
		var passwordCheck = document.getElementById("passwordCheck").value;
		if(password==""){
			alert("새 비밀번호를 입력해주세요");
			password.focus();
			return false;
		} else if(!re_password.test(password)){
			alert("최소 1개의 숫자 혹은 특수문자를 포함시켜주세요");
			password.focus();
			return false;
		} else if(passwordCheck==""){
			alert("비밀번호확인을 입력해주세요");
			passwordCheck.focus();
			return false;
		} else if(password!=passwordCheck){
			alert("비밀번호가 일치하지 않습니다");
			passwordCheck.focus();
			return false;
		}
		location.href="newSellerPassword?id="+id+"&password="+password;
	}
</script>
</head>
<body>
	<form action="newSellerPassword" method="post">
		아이디 : <input type="text" id="id" name="id" value="${findEmail}" readonly><br>
		새 비밀번호 : <input type="password" id="password" name="password"><br>
		비밀번호 확인 : <input type="password" id="passwordCheck" name="passwordCheck"><br>
	<button type="button" onclick="sellerPasswordModify()">확인</button>&nbsp;<button type="button" onclick="window.close()">닫기</button>
	</form>
</body>
</html>