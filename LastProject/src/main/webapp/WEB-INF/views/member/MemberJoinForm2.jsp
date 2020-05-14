<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/62dd7438ee.js"	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>MemberJoinForm2</title>
<script language="javascript">
	function doubleCheck() {
		var re_id = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
		var re_name = /^[가-힝a-zA-Z]{2,}$/;
		var re_phone = /^\d{3}-\d{3,4}-\d{4}$/;
		var re_birth = /^(19[0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
		var id = document.getElementById("id");
		var idOverlapValue = document.getElementById("idOverlapValue");
		var password = document.getElementById("password");
		var passwordCheck = document.getElementById("passwordCheck");
		var name = document.getElementById("name");
		var birth = document.getElementById("birth");
		var address1 = document.getElementById("sample6_postcode");
		var address2 = document.getElementById("sample6_address");
		var address3 = document.getElementById("sample6_detailAddress");
		var phone = document.getElementById("phone");
		// 아이디 유효성
		if((id.value) == "") {
			alert("이메일을 입력하지 않았습니다");
			id.focus();
			return false;
		}
		if (!re_id.test(id.value)) {
			alert("사용자의 이메일을 입력해주세요");
			id.focus();
			return false;
		}
		if(idOverlapValue.value=="N"){
			alert("아이디 중복확인을 해주세요");
			return false;
		} else if(idOverlapValue.value=="NN"){
			alert("이미 사용중인 ID 입니다");
			return false;
		} 
		// 비밀번호 유효성
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
		// 이름 유효성
		if((name.value) == "") {
			alert("이름을 입력해 주세요");
			name.focus();
			return false;
		}
		if(!re_name.test(name.value)) {
			alert("정확한 이름을 입력해 주세요");
			return false;
		}
		// 생년월일 유효성
		if(!re_birth.test(birth.value)) {
			alert("생년월일을 입력해 주세요");
			birth.focus();
			return false;
		}
		// 주소 유효성
		if((address1.value.length) < 5) {
			alert("우편번호를 입력해 주세요");
			address1.focus();
			return false;
		}
		if((address2.value) == "") {
			alert("주소를 입력해 주세요");
			address2.focus();
			return false;
		}
		if((address3.value) == "") {
			alert("상세주소를 입력해 주세요");
			address3.focus();
			return false;
		}
		// 휴대폰 유효성
		if((phone.value) == "") {
			alert("휴대폰 번호를 입력해 주세요");
			phone.focus();
			return false;
		}
		if(!re_phone.test(phone.value)) {
			alert("정확한 휴대폰 번호를 입력해 주세요");
			phone.focus();
			return false;
		}
	}
	function idOverlap(){
		var inputId = document.getElementById("id");
		var inputPassword = document.getElementById("password");
		var idOverlapValue = document.getElementById("idOverlapValue");
		$.ajax({
			type : "post",
			url : "idOverlap",
			data : {"id" : inputId.value},
			dataType : "text",
			success : function(result){
				if(result=="OK"){
					alert("중복되지 않은 ID 입니다");
					idOverlapValue.value = "Y";
				} else {
					alert("이미 사용중인 ID 입니다");
					idOverlapValue.value = "NN";
				}
			},
			error : function(){
				console.log("통신 실패!!");
				alert("통신 실패!!");
			} 
		});
	}
	function newId(){
		var idOverlapValue = document.getElementById("idOverlapValue");
		idOverlapValue.value = "N";
	}
</script>
<!-- 주소 -->
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
        function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            document.getElementById("sample6_detailAddress").focus();
            }
            }).open();
        }
    </script>
</head>
<body>
	<!-- 이미 로그인 되어있으면 메인으로 이동 -->
		<script>
		if(self.name != 'reload'){
			self.name = 'reload';
			self.location.reload(true);
		} else {
			self.name = '';
		}
		</script>
		<c:if test="${sessionScope.loginId ne null}">
			<script>
			location.href="goMain";
			</script>
		</c:if>
	<!-- Logo -->
	<div class="header-logo" style="text-align:center;">
		<a class="logo" href="goMain">
			<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
		</a>
	</div>
	<!-- /Logo -->
	<table style="margin:auto;">
	<form action="memberJoin" method="post" id="memberJoinForm" onsubmit="return doubleCheck()"	enctype="multipart/form-data">
			<c:choose>
				<c:when test="${kakaoId ne null}">
					<tr>
						<td>이메일 : <input type="text" name="id" id="id" value="${kakaoEmail}" readonly>
							<button type="button" onclick="idOverlap()">아이디중복확인</button>
							<input type="hidden" id="idOverlapValue" value="N">
							<input type="hidden" name="kakaoId" id="kakaoId" value="${kakaoId}">
							<input type="hidden" id="password" name=password value="asdfASDF1!">
							<input type="hidden" id="passwordCheck" value="asdfASDF1!">
						</td>
					</tr>
					<tr>
						<td>이름 : <input type="text" name="name" id="name" value="${nickName}"></td>
					</tr>
				</c:when>
				<c:when test="${naverId ne null}">
					<tr>
						<td>이메일 : <input type="text" name="id" id="id" value="${naverEmail}" readonly>
							<button type="button" onclick="idOverlap()">아이디중복확인</button>
							<input type="hidden" id="idOverlapValue" value="N">
							<input type="hidden" name="naverId" id="naverId" value="${naverId}">
							<input type="hidden" id="password" name=password value="asdfASDF1!">
							<input type="hidden" id="passwordCheck" value="asdfASDF1!">
						</td>
					</tr>
					<tr>
						<td>이름 : <input type="text" name="name" id="name" value="${naverName}"></td>
					</tr>
				</c:when>
				<c:when test="${googleId ne null}">
					<tr>
						<td>이메일 : <input type="text" name="id" id="id" value="${googleEmail}" readonly>
							<button type="button" onclick="idOverlap()">아이디중복확인</button>
							<input type="hidden" id="idOverlapValue" value="N">
							<input type="hidden" name="googleId" id="googleId" value="${googleId}">
							<input type="hidden" id="password" name=password value="asdfASDF1!">
							<input type="hidden" id="passwordCheck" value="asdfASDF1!">
						</td>
					</tr>
					<tr>
						<td>이름 : <input type="text" name="name" id="name" value="${googleName}"></td>
					</tr>
				</c:when>
				<c:when test="${facebookId ne null}">
					<tr>
						<td>이메일 : <input type="text" name="id" id="id" value="${facebookEmail}" readonly>
							<button type="button" onclick="idOverlap()">아이디중복확인</button>
							<input type="hidden" id="idOverlapValue" value="N">
							<input type="hidden" name="facebookId" id="facebookId" value="${facebookId}">
							<input type="hidden" id="password" name=password value="asdfASDF1!">
							<input type="hidden" id="passwordCheck" value="asdfASDF1!">
						</td>
					</tr>
					<tr>
						<td>이름 : <input type="text" name="name" id="name" value="${facebookName}"></td>
					</tr>
				</c:when>
				<c:otherwise>
					<tr>
						<td>이메일 : <input type="text" id="id" name="id" onkeydown="newId()">
							<button type="button" onclick="idOverlap()">아이디중복확인</button>
							<input type="hidden" id="idOverlapValue" value="N">
						</td>
					</tr>
					<tr>
						<td>비밀번호 : <input type="password" id="password" name=password placeholder="6~15자리 숫자 혹은 특수문자 조합"></td>
					</tr>
					<tr>
						<td>비밀번호 확인 : <input type="password" id="passwordCheck"></td>
					</tr>
					<tr>
						<td>이름 : <input type="text" id="name" name="name" maxlength="4"></td>
					</tr>
				</c:otherwise>
			</c:choose>
			<tr>
				<td>생년월일 : <input type="date" id="birth" name="birth"></td>
			</tr>
			<tr>
				<td>주소 : <input type="text" id="sample6_postcode"
					name="address1" placeholder="우편번호">&nbsp;<input
					type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
			</tr>
			<tr>
				<td><input type="text" id="sample6_address" name="address2"
					placeholder="주소"> <input type="text"
					id="sample6_detailAddress" name="address3" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" name="address4"
					placeholder="참고항목"></td>
			</tr>
			<tr>
				<td>휴대폰 : <input id="phone" name="phone" type="text"></td>
			</tr>
			<tr>
				<td>프로필사진 : <input type="file" name="file"></td>
			</tr>
			<tr>
				<td style="text-align:center;"><input type="submit" name="submit" value="회원가입">
					<input type="reset" value="다시작성">
				</td>
			</tr>
	</form>
	</table>
</body>
</html>