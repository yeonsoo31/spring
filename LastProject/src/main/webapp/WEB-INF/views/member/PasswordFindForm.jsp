<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	function emailCheck(){
		var id = document.getElementById("id").value;
		$.ajax({
			type : "post",
			url : "emailCheck",
			data : {"id" : id},
			dataType : "text",
			success : function(result){
				if(result=="OK"){
					passwordFindForm.submit();
				} else {
					alert("존재하지 않는 아이디 입니다");
				}
			},
			error : function(){
				alert("통신오류");
			}
		});
	}
</script>
</head>
<body>
<table border="1" width="300" height="300" align= "center">
<center>
<span style="color: green; font-weight: bold;">이메일 인증 (이메일을 인증 받아야 다음 단계로 넘어갈 수 있습니다.)</span><br><br><br><br>
        <div style="text-align:center;">
            <tr>        
                <td>
                	<center>
                    	<form action="auth.do" method="post" id="passwordFindForm">
                    		<center><br>
                        	<div>
                            	이메일 : <input type="email" id="id" name="id" placeholder="이메일주소를 입력하세요.">
                        	</div><br><br>
                        	</center>
                        <button type="button" onclick="emailCheck()">이메일 인증받기 (이메일 보내기)</button>
                        </form>
					</center>
                </td>
            </tr>
        </div>
</center>
</table>
</body>
</html>