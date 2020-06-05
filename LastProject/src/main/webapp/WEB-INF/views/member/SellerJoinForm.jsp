<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/62dd7438ee.js"	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
<title>MemberJoinForm2</title>
<script language="javascript">
	function doubleCheck() {
		var re_id = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
		var re_password = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{6,15}$/;
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
	function newSnumber(){
		var s_numberOverlapValue = document.getElementById("s_numberOverlapValue");
		s_numberOverlapValue.value = "N";
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
	<form class="col-md-offset-4" action="sellerJoin" method="post" id="sellerJoinForm" onsubmit="return doubleCheck()"	enctype="multipart/form-data" style="margin-left:0;">
		<div class="cont" style="padding:0 15px; float:left; width:100%;">
				<div class="contLeft" style="background:white; float:left; width:80%;margin-left: 20%;">
					<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">사업자 회원가입</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
									<div>
										<a>상호명(단체명) :</a>
										<input type="text" id="s_name" name="s_name" class="input" style="width: 30%; margin-left: 61px;">
									</div>
									<div style="margin-top:20px;">
										<a>사업자등록번호 :  </a>
										<input class="input" type="text" id="s_number" name="s_number" onkeydown="newSnumber()" maxlength="12" placeholder="000-00-00000" style="width: 30%; margin-left: 54px;">
										<button class="primary-btn" type="button" onclick="s_numberOverlap()" style="width: 15%;">사업자등록번호 확인</button>
										<input type="hidden" id="s_numberOverlapValue" value="N">
									</div>
									
									<div style="margin-top:20px;">
										<a>이메일 :</a>
										<input class="input" type="text" id="id" name="id" onkeydown="newId()"style="width: 30%;margin-left: 110px;" >
										<button class="primary-btn" type="button" onclick="idOverlap()" style="width: 15%;">아이디중복확인</button>
										<input type="hidden" id="idOverlapValue" value="N">
									</div>
									<div style="margin-top:20px;">
										<a>비밀번호 :</a>
										<input class="input" type="password" id="password" name=password placeholder="8~16,숫자,대소문자,특문" style="width: 30%;margin-left: 97px;">
									</div>
									<div style="margin-top:20px;">
										<a>비밀번호 확인 :</a>
										<input class="input" type="password" id="passwordCheck"style="width: 30%;margin-left: 66px;">
									</div>
									
									<div style="margin-top:20px;">
										<a>성명(대표자) :</a>
										<input class="input" type="text" id="name" name="name" maxlength="4" style="width: 30%;margin-left: 75px;">
									</div>
									
									<div style="margin-top:20px;">
										<a>회사주소 :</a>
										<input type="text" id="sample6_postcode" name="address1" placeholder="우편번호" class="input"style="width: 30%;margin-left: 97px;" >
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="primary-btn"style="width: 15%;">
										<input type="text" id="sample6_address" name="address2" placeholder="주소" class="input"style="width: 30%;margin-left: 163px;"> <br>
										<input type="text" id="sample6_detailAddress" name="address3" placeholder="상세주소" class="input"style="width: 30%;margin-left: 163px;"><br>
										<input type="text" id="sample6_extraAddress" name="address4" placeholder="참고항목" class="input"style="width: 30%;margin-left: 163px;">
									</div>
									
									<div style="margin-top:20px;">
										<a>휴대폰 :</a>
										 <input id="phone" name="phone" type="text" class="input" style="width: 30%;margin-left: 110px;">
									</div>
									
									<div style="margin-top:20px;">
										<a>프로필사진 :</a>
										<input type="file" name="file" class="input" style="width:30%;margin-left: 160px;">
									</div>
								</div>
								</div>
						</div>
					</div>
			</div>	
		<input type="submit" name="submit" value="회원가입" class="primary-btn" style="margin-left: 500px;margin-top:80px;">
		<input type="reset" value="다시작성" class="primary-btn">
		<button type="button" onclick="location.href='goMain'" class="primary-btn">이전으로</button>
	</form>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>
		