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
	function doubleCheck(){
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var oldPassword = document.getElementById("oldPassword");
		var oldPasswordInput = document.getElementById("oldPasswordInput");
		var password = document.getElementById("password");
		var passwordCheck = document.getElementById("passwordCheck");
		if(oldPasswordInput.value != oldPassword.value){
			alert("현재 비밀번호를 정확히 입력해주세요");
			oldPassword.focus();
			return false;
		}
		if(oldPasswordInput.value == password.value){
			alert("이전과 다른 비밀번호를 입력해주세요");
			password.focus();
			return false;
		}
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
	<!-- Logo -->
		<div class="header-logo" style="text-align:center;">
			<a class="logo" href="goMain">
				<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
			</a>
		</div>
	<!-- /Logo -->
	<table style="margin:auto;">
	<tr>
		<td>______________________________________________________________________________________________________<br><br><br></td>
	</tr>
	<tr>
		<c:if test="${member.id ne null}">
		<td>${member.id}님 비밀번호를 변경해주세요.<br>
			현재 회원님께서는 오랫동안 비밀번호를 변경하지 않고 같은 비밀번호를 사용하고 계십니다.<br>
			소중한 개인정보를 안전하게 지키기 위해서는 비밀번호를 가급적 자주 변경하시는 것이 좋습니다.<br>
			이에 E-SHOP에서는 비밀번호를 마지막으로 변경하신 후 일정 기간이 경과하면,<br>
			지금처럼 로그인을 하실 때에 비밀번호 변경을 요청드리는 서비스를 시행하고 있습니다.<br><br><br>
		</td>
		</c:if>
		<c:if test="${seller.id ne null}">
		<td>${seller.id}님 비밀번호를 변경해주세요.<br>
			현재 회원님께서는 오랫동안 비밀번호를 변경하지 않고 같은 비밀번호를 사용하고 계십니다.<br>
			소중한 개인정보를 안전하게 지키기 위해서는 비밀번호를 가급적 자주 변경하시는 것이 좋습니다.<br>
			이에 E-SHOP에서는 비밀번호를 마지막으로 변경하신 후 일정 기간이 경과하면,<br>
			지금처럼 로그인을 하실 때에 비밀번호 변경을 요청드리는 서비스를 시행하고 있습니다.<br><br><br>
		</td>
		</c:if>
	</tr>
	<tr>
		<td>______________________________________________________________________________________________________<br><br><br></td>
	</tr>
	</table>
	<c:if test="${loginIdDivision == 1}">
	<form action="memberOldPasswordChange" method="post" onsubmit="return doubleCheck()">
	<table style="margin:auto;">
		<tr><td><input type="hidden" id="id" name="id" value="${member.id}"></td></tr>
		<tr>
			<td>현재 비밀번호 : <input type="password" id="oldPasswordInput" name="oldPasswordInput"></td>
			<td><input type="hidden" id="oldPassword" name="oldPassword" value="${member.password}"></td>
		</tr>
		<tr>
			<td>새 비밀번호 : <input type="password" id="password" name="password"></td>
		</tr>
		<tr>
			<td>비밀번호 확인 : <input type="password" id="passwordCheck" name="passwordCheck"></td>
		</tr>
		<tr>
			<td><input type="submit" value="확인">&nbsp;<button type="button" onclick="location.href='goMain'">다음에 변경하기</button></td>
		</tr>
	</table>
	</form>
	</c:if>
	<c:if test="${loginIdDivision == 2}">
	<form action="sellerOldPasswordChange" method="post" onsubmit="return doubleCheck()">
	<table style="margin:auto;">
		<tr><td><input type="hidden" id="id" name="id" value="${seller.id}"></td></tr>
		<tr>
			<td>현재 비밀번호 : <input type="password" id="oldPasswordInput" name="oldPasswordInput"></td>
			<td><input type="hidden" id="oldPassword" name="oldPassword" value="${seller.password}"></td>
		</tr>
		<tr>
			<td>새 비밀번호 : <input type="password" id="password" name="password"></td>
		</tr>
		<tr>
			<td>비밀번호 확인 : <input type="password" id="passwordCheck" name="passwordCheck"></td>
		</tr>
		<tr>
			<td><input type="submit" value="확인">&nbsp;<button type="button" onclick="location.href='goMain'">다음에 변경하기</button></td>
		</tr>
	</table>
	</form>
	</c:if>
</body>
</html>