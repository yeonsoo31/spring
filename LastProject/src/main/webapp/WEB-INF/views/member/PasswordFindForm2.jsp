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
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<script>
	function memberPasswordModify(){
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
		location.href="newPassword?id="+id+"&password="+password;
	}
</script>
</head>
<body>
<div class="product-tab">
	<ul class="tab-nav">
		<li class="active"><a data-toggle="tab">비밀번호 변경</a></li>
	</ul>
		<div class="tab-content">
		<form action="newPassword" method="post" id="newPasswordForm">
				<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
					<div>
						<a>아이디 :</a>
						<input class="input" type="text" id="id" name="id" value="${findEmail}" readonly style="width: 30%; margin-left: 61px;" >
					</div>
					<div style="margin-top:20px;">
						<a>새 비밀번호 :  </a>
						<input class="input" type="password" id="password" name="password"style="width: 30%; margin-left: 24px;">
					</div>
					<div style="margin-top:20px;">
						<a>비밀번호 확인 :  </a>
						<input class="input" type="password" id="passwordCheck" name="passwordCheck" style="width: 30%; margin-left: 10px;">
					</div>
				</div>
					<button type="button" onclick="memberPasswordModify()" class="primary-btn" style="margin-left: 200px;margin-top: 50px;">확인</button>
				<button type="button" onclick="window.close()" class="primary-btn">닫기</button>
				</form>
			</div>
	</div>
</body>
</html>