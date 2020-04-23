<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://kit.fontawesome.com/62dd7438ee.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.4.1.js"
    integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
<title>MemberJoin</title>
<script>
	function idOverlap(){
		var inputId = document.getElementById("id").value;
		var idCheckResult = document.getElementById("idCheckResult");
		$.ajax({
			type : "post",
			url : "idOverlap",
			data : {"mid" : inputId},
			dataType : "text",
			success : function(result){
				console.log("통신 성공!!");
				console.log("서버리턴값"+result);
				if(result=="OK"){
					alert("중복되지 않은 아이디입니다.");
				} else {
					alert("이미 사용중인 ID 입니다!");
				}
			},
			error : function(){
				console.log("통신 실패!!")
				alert("통신 실패!!");
			} 
		});
	}
	function idCheck(){
		var exp = /^[A-za-z]{5,15}/g;
        var id = document.getElementById("id");
        if(id.value.match(exp)){
            document.getElementById("idCheckResult").innerHTML="";
            } else if(id.value.length==0){
                document.getElementById("idCheckResult").style.color="red";
                document.getElementById("idCheckResult").innerHTML="아이디는 필수입니다";
            } else if(id.value.length<5){
                document.getElementById("idCheckResult").style.color="red";
                document.getElementById("idCheckResult").innerHTML="영문+숫자 5~15 이내로 만들어주세요.";
            }
	}
	function passwordCheck(){
		var exp = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$/;
        var password = document.getElementById("password");
        if(password.value==""){
        	document.getElementById("passwordResult").innerHTML="";
        } else if(password.value.match(exp)){
        	document.getElementById("passwordResult").style.color="green";
            document.getElementById("passwordResult").innerHTML="<i class='fas fa-check fa' style='color:green;'></i>";
       	} else {
	       	document.getElementById("passwordResult").style.color="red";
			document.getElementById("passwordResult").innerHTML="사용불가 (8~16자리로 대소문자,숫자,특수문자를 포함해서 만들어주세요)";
		}
	}
	
	function passwordDoubleCheck(){
		var password = document.getElementById("password").value;
		var passwordDouble = document.getElementById("passwordDouble").value;
		if(passwordDouble==""){
			document.getElementById("passwordDoubleCheckResult").innerHTML = "";
		} else if(password==passwordDouble){
			document.getElementById("passwordDoubleCheckResult").style.color="green";
			document.getElementById("passwordDoubleCheckResult").innerHTML = "<i class='fas fa-check fa' style='color:green;'></i>";
		} else {
			document.getElementById("passwordDoubleCheckResult").style.color="red";
			document.getElementById("passwordDoubleCheckResult").innerHTML = "비밀번호와 일치하지 않습니다!";
		}
	}
	function nameCheck(){
		var name = document.getElementById("name");
		var nameCheck = document.getElementById("nameCheck")
		if(name.value.length==0){
			nameCheck.innerHTML = "";
		} else if(name.value.length>=2){
			nameCheck.innerHTML = "<i class='fas fa-check fa' style='color:green;'></i>";
		} else {
			nameCheck.innerHTML = "<i class='fas fa-times fa' style='color:red;'></i>";
		}
	}
	function birthCheck(){
		var birth = document.getElementById("birth");
		var birthCheck = document.getElementById("birthCheck")
		if(birth.value.length==10){
			birthCheck.innerHTML = "<i class='fas fa-check fa' style='color:green;'></i>";
		} else {
			birthCheck.innerHTML = "<i class='fas fa-times fa' style='color:red;'></i>";
		}
	}
	function phoneCheck(){
		var exp = /^\d{3}-\d{3,4}-\d{4}$/;
		var phone = document.getElementById("phone");
		if(phone.value.match(exp)){
			document.getElementById("phoneCheck").innerHTML="<i class='fas fa-check fa' style='color:green;'></i>";
		} else if(phone.value.length==0){
			document.getElementById("phoneCheck").innerHTML="";
		} else {
			document.getElementById("phoneCheck").innerHTML="<i class='fas fa-times fa' style='color:red;'></i>";
		}
	}
</script>
    <!-- 주소 -->
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
	<form action="memberJoin" method="post" id="memberJoinForm"
	enctype="multipart/form-data">
	<table>
		<c:choose>
        	<c:when test="${kakaoId ne null}">
       	 		<tr>
        			<td>아이디 : <input type="text" name="mid" id="id" value="${kakaoEmail}" readonly></td> 
        			<td><input type="hidden" name="kakaoId" id="kakaoId" value="${kakaoId}"></td>
        			<td><input type="hidden" name=mpassword value=""></td>
        		</tr>
       	 		<tr>
        			<td>이름 : <input type="text" name="mname" id="name" value="${nickName}" readonly></td>
        		</tr>
        	</c:when>
    	    <c:when test="${naverId ne null}">
	        	<tr>
        			<td>아이디 : <input type="text" name="mid" id="id" value="${naverEmail}" readonly></td> 
        			<td><input type="hidden" name="naverId" id="naverId" value="${naverId}"></td>
        			<td><input type="hidden" name=mpassword value=""></td>
        		</tr>
       	 		<tr>
        			<td>이름 : <input type="text" name="mname" id="name" value="${naverName}" readonly></td>
        		</tr>
        	</c:when>
        	<c:when test="${Gid ne null}">
	        	<tr>
        			<td>아이디 : <input type="text" name="mid" id="id" value="${Gmail}" readonly></td> 
        			<td><input type="hidden" name="googleId" id="googleId" value="${Gid}"></td>
        			<td><input type="hidden" name=mpassword value=""></td>
        		</tr>
        		<tr>
					<td>이름 : <input type="text" name="mname" id="name" value="${Gname}"></td>
				</tr>
				<tr>
					<td>생년월일 : <input id="birth" type="date" name="mbirth" onkeyup="birthCheck()">&nbsp;&nbsp;<span id="birthCheck"></span></td>
				</tr>
				<tr>
					<td>주소 : <input type="text" id="sample6_postcode" name="maddress1" placeholder="우편번호">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
				</tr>
				<tr>
					<td><input type="text" id="sample6_address" name="maddress2" placeholder="주소">
					<input type="text" id="sample6_detailAddress" name="maddress3" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" name="maddress4" placeholder="참고항목"></td>
				</tr>
				<tr>
					<td>핸드폰 : <input id="phone" name="mphone" type="text" onkeyup="phoneCheck()">&nbsp;&nbsp;<span id="phoneCheck"></span></td>
				</tr>
				<tr>
					<td>프로필사진 : <input type="file" name="mprofilepic"></td>
				</tr>
        	</c:when>
        	<c:when test="${Fid ne null}">
	        	<tr>
        			<td>아이디 : <input type="text" name="mid" id="id" value="${Femail}" readonly></td> 
        			<td><input type="hidden" name="facebookId" id="facebookId" value="${Fid}"></td>
        			<td><input type="hidden" name=mpassword value=""></td>
        		</tr>
        		<tr>
					<td>이름 : <input type="text" name="mname" id="name" value="${Fname}"></td>
				</tr>
				<tr>
					<td>생년월일 : <input id="birth" type="date" name="mbirth" onkeyup="birthCheck()">&nbsp;&nbsp;<span id="birthCheck"></span></td>
				</tr>
				<tr>
					<td>주소 : <input type="text" id="sample6_postcode" name="maddress1" placeholder="우편번호">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
				</tr>
				<tr>
					<td><input type="text" id="sample6_address" name="maddress2" placeholder="주소">
					<input type="text" id="sample6_detailAddress" name="maddress3" placeholder="상세주소">
					<input type="text" id="sample6_extraAddress" name="maddress4" placeholder="참고항목"></td>
				</tr>
				<tr>
					<td>핸드폰 : <input id="phone" name="mphone" type="text" onkeyup="phoneCheck()">&nbsp;&nbsp;<span id="phoneCheck"></span></td>
				</tr>
				<tr>
					<td>프로필사진 : <input type="file" name="mprofilepic"></td>
				</tr>
        	</c:when>
        	<c:otherwise>
			<tr>
				<td>아이디 : <input type="text" name="mid" id="id" onkeyup="idCheck()"><button type="button" onclick="idOverlap()">아이디중복확인</button>&nbsp;&nbsp;<span id="idCheckResult"></span></td>
			</tr>
			<tr>
				<td>비밀번호 : <input type="password" name=mpassword id="password" placeholder="8~16,숫자,대소문자,특문" onkeyup="passwordCheck()">&nbsp;&nbsp;<span id="passwordResult"></span></td>
			</tr>
			<tr>
				<td>비밀번호 확인 : <input type="password" id="passwordDouble" onkeyup="passwordDoubleCheck()">&nbsp;&nbsp;<span id="passwordDoubleCheckResult"></span></td>
			</tr>
			<tr>
				<td>이름 : <input id="name" type="text" name="mname" onkeyup="nameCheck()" maxlength="4">&nbsp;&nbsp;<span id="nameCheck"></span></td>
			</tr>
			<tr>
				<td>생년월일 : <input id="birth" type="date" name="mbirth" onkeyup="birthCheck()">&nbsp;&nbsp;<span id="birthCheck"></span></td>
			</tr>
			<tr>
				<td>주소 : <input type="text" id="sample6_postcode" name="maddress1" placeholder="우편번호">&nbsp;<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br></td>
			</tr>
			<tr>
				<td><input type="text" id="sample6_address" name="maddress2" placeholder="주소">
				<input type="text" id="sample6_detailAddress" name="maddress3" placeholder="상세주소">
				<input type="text" id="sample6_extraAddress" name="maddress4" placeholder="참고항목"></td>
			</tr>
			<tr>
				<td>핸드폰 : <input id="phone" name="mphone" type="text" onkeyup="phoneCheck()">&nbsp;&nbsp;<span id="phoneCheck"></span></td>
			</tr>
			<tr>
				<td>이메일 : <input id="email" name="memail" type="text" onkeyup="emailCheck()">&nbsp;&nbsp;<span id="emailCheck"></span></td>
			<tr>
			<tr>
				<td>프로필사진 : <input type="file" name="mprofilepic"></td>
			</tr>
			</c:otherwise>
		</c:choose>
		</table>
		<input type="submit" value="회원가입">
		<input type="reset" value="다시작성">
		<button type="button" onclick="location.href='main'">이전으로</button>
	</form>
		
</body>
</html>