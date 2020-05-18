<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
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
        $(document).ready(function(){
        	$('#pay').submit(function(){
        		window.open('','payviewer','width=1000,height=800,resizeable,scrollbars');
        		this.action = 'payment';
        		this.method = 'post';
        		this.target = 'payviewer';
        	})
        })
      </script>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	<div class="container">
	<h2>주문화면</h2>
	<table border='1'>
		<tr>
			<td>
				<img width="200px" height="200px" src="${pageContext.request.contextPath}/resources/fileupload/${auction.a_photo}" alt="">
			</td>
			<td width="300px" style="text-align:center;">
				${auction.a_name}
			</td>
			<td width="300px" style="text-align:center;">
				${auction.a_price} 원
			</td>
		</tr>
	</table>
	<h2>정보 기입</h2>
	<form id="pay">
	<input type="hidden" value="${auction.a_number}" name="a_number">
	<input type="hidden" value="${member.id}" name="id">
	<table>
		<tr>
			<td>받는이</td>
			<td><input type="text" value="${member.name}" name="o_name"></td>
		</tr>
		<tr>
			<td>핸드폰번호</td>
			<td><input type="tel" value="${member.phone}" name="o_phone"></td>
		</tr>
		<tr>
			<td>주소 </td>
			<td>
				<input type="text" id="sample6_postcode"
					name="o_address1" value="${member.address1}">&nbsp;<input
					type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample6_address" name="o_address2" value="${member.address2}"> 
					<input type="text" id="sample6_detailAddress" name="o_address3" value="${member.address3}">
					<input type="text" id="sample6_extraAddress" name="o_address4" value="${member.address4}">
			<td>
		</tr>
	</table>
	<div style="text-align:center;">
	<input type="submit" value="결제">
	</div>
	</form>
	</div>
	<div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
</body>
</html>