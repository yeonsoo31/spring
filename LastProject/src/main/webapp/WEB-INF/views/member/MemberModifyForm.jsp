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
		var re_name = /^[가-힝a-zA-Z]{2,}$/;
		var re_phone = /^\d{3}-\d{3,4}-\d{4}$/;
		var name = document.getElementById("name");
		var phone = document.getElementById("phone");
		var address1 = document.getElementById("sample6_postcode");
		var address2 = document.getElementById("sample6_address");
		var address3 = document.getElementById("sample6_detailAddress");
		// 이름 유효성
		if((name.value) == "") {
			alert("성명을 입력해 주세요");
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
    <script>
    	function myPage(){
    		location.href="myPage";
    	}
    </script>
</head>
<body>
	<div>
	<jsp:include page="/WEB-INF/views/top.jsp"/>
	</div>
	<div class="container">
	<div class="col-md-offset-12">　</div>
	<div style="text-align:center"><h2>회원정보수정</h2></div><br>
	<form class="col-md-offset-3" action="memberModify" method="post" id=memberModifyForm onsubmit="return doubleCheck()" enctype="multipart/form-data">
	<input type="hidden" value="${memberModify.profile}" name="profile">
		<table>
			<tr>
				<td>아이디 : <input type="text" name="id" value="${memberModify.id}" readonly></td>
			</tr>
			<tr>
				<td>이름 : <input type="text" id="name" name="name" value="${memberModify.name}"></td>
			</tr>
			<tr>
				<td>주소 : <input type="text" name="address1" id="sample6_postcode" value="${memberModify.address1}">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
			</tr>
			<tr>
				<td><input type="text" name="address2" id="sample6_address" value="${memberModify.address2}">
				<input type="text" name="address3" id="sample6_detailAddress" value="${memberModify.address3}">
				<input type="text" name="address4" id="sample6_extraAddress" value="${memberModify.address4}"></td>
			</tr>
			<tr>
				<td>핸드폰 : <input type="text" name="phone" id="phone" value="${memberModify.phone}"></td>
			</tr>
			<tr>
				<td><img id="profileimg" src="${pageContext.request.contextPath}/resources/profilepic/${memberModify.profile}" width="100" height="100"></a></td>
			</tr>
			<tr>
				<td>프로필사진 : <input id="profileinput" type="file" name="file"></td>
			</tr>
		</table>
			<input type="submit" value="수정">
			<button type="button" onclick="myPage()">돌아가기</button>
	</form>
	</div>
	<div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
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