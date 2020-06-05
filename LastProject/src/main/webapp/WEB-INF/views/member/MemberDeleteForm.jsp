<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
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



<div class="product-tab">
	<ul class="tab-nav">
		<li class="active"><a data-toggle="tab">회원탈퇴</a></li>
	</ul>
		<div class="tab-content">
				<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
					<div>
						<a>아이디 :</a>
						<input class="input" type="text" id="id" name="id" value="${sessionScope.loginId}" readonly style="width: 30%; margin-left: 61px;" >
					</div>
					<div style="margin-top:20px;">
						<a>비밀번호 :</a>
						<input class="input" type="password" id="password" name="password"style="width: 30%; margin-left: 48px;">
					</div>
				</div>
				<c:if test="${sessionScope.loginIdDivision eq 1}">
					<button type="button" onclick="memberDeleteProcess()" class="primary-btn" style="margin-left: 150px;margin-top: 50px;">회원탈퇴하기</button>
				</c:if>	
				<c:if test="${sessionScope.loginIdDivision eq 2}">
					<button type="button" onclick="sellerDeleteProcess()" class="primary-btn" style="margin-left: 150px;margin-top: 50px;">기업회원탈퇴하기</button>
				</c:if>
					<button type="button" onclick="window.close()" class="primary-btn">닫기</button>
			</div>
	</div>
</body>
</html>