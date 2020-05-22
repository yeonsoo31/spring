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
	function memberDeleteProcess(){
		var id = document.getElementById("id").value;
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var password = document.getElementById("password").value;
		if(password==""){
			alert("비밀번호를 입력해주세요");
			password.focus();
			return false;
		} else if(!re_password.test(password)){
			alert("최소 1개의 숫자 혹은 특수문자를 포함시켜주세요");
			password.focus();
			return false;
		} else {
		$.ajax({
			type : "post",
			url : "memberDelete",
			data : {
				"id" : id,
				"password" : password,
			},
			dataType : "text",
			success: function(result){
				if(result=="OK"){
					alert("탈퇴되었습니다");
					opener.window.location="goMain";
					window.close();
				} else {
					alert("아이디 혹은 비밀번호가 틀렸습니다");
					return false;
				}
			},
			error: function(){
				alert("통신오류");
			}
		});
	}
}
	
	function sellerDeleteProcess(){
		var id = document.getElementById("id").value;
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var password = document.getElementById("password").value;
		if(password==""){
			alert("비밀번호를 입력해주세요");
			password.focus();
			return false;
		} else if(!re_password.test(password)){
			alert("최소 1개의 숫자 혹은 특수문자를 포함시켜주세요");
			password.focus();
			return false;
		} else {
			$.ajax({
				type : "post",
				url : "sellerDelete",
				data : {
					"id" : id,
					"password" : password,
				},
				dataType : "text",
				success: function(result){
					if(result=="OK"){
						alert("탈퇴되었습니다");
						opener.window.location="goMain";
						window.close();
					} else {
						alert("아이디 혹은 비밀번호가 틀렸습니다");
						return false;
					}
				},
				error: function(){
					alert("통신오류");
				}
			});
		}
	}

</script>
</head>
<body>
<h3 style="text-align:center">회원탈퇴</h3>
아이디 : <input type="text" id="id" name="id" value="${sessionScope.loginId}" readonly><br>
비밀번호 : <input type="password" id="password" name="password"><br>
<c:if test="${sessionScope.loginIdDivision eq 1}">
<button onclick="memberDeleteProcess()">회원탈퇴하기</button>
</c:if>
<c:if test="${sessionScope.loginIdDivision eq 2}">
<button onclick="sellerDeleteProcess()">기업회원탈퇴하기</button>
</c:if>
<button onclick="window.close()">취소</button>
</body>
</html>