<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>회원정보수정</title>
<script>
	function memberMain() {
		location.href="memberMain";
	}
	function doubleCheck() {
		var s_name = document.getElementById("s_name");
		var s_number = document.getElementById("s_number");
		var checkId = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
		var tmpBizId, i, chkSum=0, c2, remander;
		var s_numberOverlapValue = document.getElementById("s_numberOverlapValue");
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
        }
    }
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"/>
	</div>
	<div class="container">
	<div class="col-md-offset-12">　</div>
	<div style="text-align:center"><h2>기업회원 정보수정</h2></div><br>
	<form class="col-md-offset-3" action="sellerModify" method="post" id=sellerModifyForm onsubmit="return doubleCheck()" enctype="multipart/form-data">
	<input type="hidden" value="${sellerModify.profile}" name="profile">
		<table>
			<tr>
				<td>상호명(단체명) : <input type="text" id="s_name" name="s_name" value="${sellerModify.s_name}"></td>
			</tr>
			<tr>
				<td>사업자등록번호 : <input type="text" id="s_number" name="s_number" maxlength="12" placeholder="000-00-00000" value="${sellerModify.s_number}">
					<button type="button" onclick="s_numberOverlap()">사업자등록번호 확인</button>
					<input type="hidden" id="s_numberOverlapValue" value="N">
				</td>
			</tr>
			<tr>
				<td>아이디 : <input type="text" name="id" value="${sellerModify.id}" readonly></td>
			</tr>
			<tr>
				<td>성명(대표자) : <input type="text" name="name" value="${sellerModify.name}"></td>
			</tr>
			<tr>
				<td>회사주소 : <input type="text" name="address1" id="sample6_postcode" value="${sellerModify.address1}">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
			</tr>
			<tr>
				<td><input type="text" name="address2" id="sample6_address" value="${sellerModify.address2}">
				<input type="text" name="address3" id="sample6_detailAddress" value="${sellerModify.address3}">
				<input type="text" name="address4" id="sample6_extraAddress" value="${sellerModify.address4}"></td>
			</tr>
			<tr>
				<td>핸드폰 : <input type="text" name="phone" id="phone" value="${sellerModify.phone}"></td>
			</tr>
			<tr>
				<td><img id="profileimg" src="${pageContext.request.contextPath}/resources/profilepic/${sellerModify.profile}" width="100" height="100"></a></td>
			</tr>
			<tr>
				<td>프로필사진 : <input id="profileinput" type="file" name="file"></td>
			</tr>
		</table>
			<input type="submit" value="수정">
			<button type="button" onclick="location.href='myPage'">돌아가기</button>
	</form>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
</body>
<script>
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#profileimg").attr("src",e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$("#profileinput").change(function(){
		readURL(this);
	});
</script>
</html>