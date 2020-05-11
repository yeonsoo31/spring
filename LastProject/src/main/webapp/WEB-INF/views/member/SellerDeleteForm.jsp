<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	function sellerDeleteProcess(){
		var password = document.getElementById("password").value;
		var id = "${sessionScope.loginId}";
		if(password==""){
			alert("비밀번호를 입력해주세요");
			return false;
		} else {
			$.ajax({
				type : "post",
				url : "sellerDeleteCheck",
				data : {
					"id" : id,
					"password" : password
				},
				dataType : "text",
				success: function(result){
					if(result=="OK"){
						alert("탈퇴처리가 완료되었습니다");
						location.href="sellerDelete";
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
<h3 style="text-align:center">회원탈퇴</h3>
아이디 : <input type="text" id="id" name="id" value="${sessionScope.loginId}" readonly><br>
비밀번호 : <input type="password" id="password" name="password"><br>
<button onclick="sellerDeleteProcess()">탈퇴하기</button>
<button onclick="window.close()">취소</button>
</body>
</html>