<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script>
	function memberMain(){
		location.href="memberMain";
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
	<form action="memberModify" method="post" id=memberModifyForm>
		<table>
			<tr>
				<td>아이디 : <input type="text" name="mid" value="${memberModify.mid}" readonly></td>
			</tr>
			<tr>
				<td>이름 : <input type="text" name="mname" value="${memberModify.mname}"></td>
			</tr>
			<tr>
				<td>생년월일 : <input type="date" name="mbirth" value="${memberModify.mbirth}"></td>
			</tr>
			<tr>
				<td>주소 : <input type="text" name="maddress1" id="sample6_postcode" value="${memberModify.maddress1}">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
			</tr>
			<tr>
				<td><input type="text" name="maddress2" id="sample6_address" value="${memberModify.maddress2}"><br></td>
				<td><input type="text" name="maddress3" id="sample6_detailAddress" value="${memberModify.maddress3}"></td>
				<td><input type="text" name="maddress4" id="sample6_extraAddress" value="${memberModify.maddress4}"></td>
			</tr>
			<tr>
				<td>핸드폰 : <input type="text" name="mphone" id="phone" value="${memberModify.mphone}"></td>
			</tr>
		</table>
			<input type="submit" value="수정">
			<button type="button" onclick="memberMain()">돌아가기</button>
	</form>
</body>
</html>