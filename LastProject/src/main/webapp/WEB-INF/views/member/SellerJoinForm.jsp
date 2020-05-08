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
		var re_password = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
		var re_name = /^[가-힝a-zA-Z]{2,}$/;
		var re_phone = /^\d{3}-\d{3,4}-\d{4}$/;
		var s_name = document.getElementById("s_name");
		var s_number = document.getElementById("s_number");
		var checkId = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
		var tmpBizId, i, chkSum=0, c2, remander;
		var s_numberOverlapValue = document.getElementById("s_numberOverlapValue");
		var id = document.getElementById("id");
		var idOverlapValue = document.getElementById("idOverlapValue");
		var password = document.getElementById("password");
		var passwordCheck = document.getElementById("passwordCheck");
		var name = document.getElementById("name");
		var address1 = document.getElementById("sample6_postcode");
		var address2 = document.getElementById("sample6_address");
		var address3 = document.getElementById("sample6_detailAddress");
		var phone = document.getElementById("phone");
		// 상호명 유효성
		if((s_name.value) == "") {
			alert("상호명(단체명)을 입력하지 않았습니다");
			s_name.focus();
			return false;
		}
		// 사업자등록번호  유효성
		if((s_number.value) == "") {
			alert("사업자등록번호를 입력하지 않았습니다");
			s_number.focus();
			return false;
		}
		if((s_numberOverlapValue.value) == "N") {
			alert("사업자등록번호 확인을 해주세요");
			return false;
		}
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
			alert("8~16자리 영문,숫자,특수문자의 조합으로 만들어주세요");
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
			alert("대표자 성명을 입력해 주세요");
			name.focus();
			return false;
		}
		if(!re_name.test(name.value)) {
			alert("정확한 이름을 입력해 주세요");
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
	function s_numberOverlap() {
		var bisNo = document.getElementById("s_number").value;
		var sum = 0, key = [1, 3, 7, 1, 3, 7, 1, 3, 5];
		var chkSum = 0;
		if(bisNo==""){
			alert("사업자등록번호를 입력해주세요")
			s_number.focus();
			return false;
		}
		if ((bisNo = (bisNo+"").match(/\d{1}/g)).length != 10) {
        	alert("정확한 사업자등록번호를 입력해주세요");
        	return false;
        }
        for (var i = 0 ; i < 9 ; i++) { sum += (key[i] * Number(bisNo[i])); }
        chkSum = Math.floor(key[8] * Number(bisNo[8]) / 10);
        sum +=chkSum;
        var reminder = (10 - (sum % 10)) % 10;
        if(reminder!=Number(bisNo[9])){
        	alert("정확한 사업자등록번호를 입력해주세요");
        	return false;
        } else {
        	alert("확인되었습니다");
        	s_numberOverlapValue.value = "Y";
        	id.focus();
        }
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
<jsp:include page="/WEB-INF/views/top.jsp"/>
<div class="container">
	<div class="col-md-offset-12">　</div>
	<form class="col-md-offset-4" action="sellerJoin" method="post" id="sellerJoinForm" onsubmit="return doubleCheck()"	enctype="multipart/form-data">
		<table>
			<tr>
				<td>상호명(단체명) : <input type="text" id="s_name" name="s_name"></td>
			</tr>
			<tr>
				<td>사업자등록번호 : <input type="text" id="s_number" name="s_number" maxlength="12" placeholder="000-00-00000">
					<button type="button" onclick="s_numberOverlap()">사업자등록번호 확인</button>
					<input type="hidden" id="s_numberOverlapValue" value="N">
				</td>
			</tr>
			<tr>
				<td>이메일 : <input type="text" id="id" name="id" onkeydown="newId()">
					<button type="button" onclick="idOverlap()">아이디중복확인</button>
					<input type="hidden" id="idOverlapValue" value="N">
				</td>
			</tr>
			<tr>
				<td>비밀번호 : <input type="password" id="password" name=password placeholder="8~16,숫자,대소문자,특문"></td>
			</tr>
			<tr>
				<td>비밀번호 확인 : <input type="password" id="passwordCheck"></td>
			</tr>
			<tr>
				<td>성명(대표자) : <input type="text" id="name" name="name" maxlength="4"></td>
			</tr>
			<tr>
				<td>회사주소 : <input type="text" id="sample6_postcode"
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
		</table>
		<input type="submit" name="submit" value="회원가입">
		<input type="reset" value="다시작성">
		<button type="button" onclick="location.href='goMain'">이전으로</button>
	</form>
	<div class="col-md-offset-12">　</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
</html>