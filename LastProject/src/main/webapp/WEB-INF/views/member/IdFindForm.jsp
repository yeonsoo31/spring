<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	function divhide(){
		$('#divsellerIdFind').hide();
	}
	function member(){
		if($('input:radio[id=member]').is(':checked')){
	        $('#divmemberIdFind').show();
	        $('#divsellerIdFind').hide();
	    }
	}
	function seller(){
		if($('input:radio[id=seller]').is(':checked')){
	        $('#divmemberIdFind').hide();
	        $('#divsellerIdFind').show();
	    }
	}
</script>
</head>
<body onload="divhide()">
	<h3 style="text-align:center;">아이디찾기</h3>
	<input type="radio" id="member" name="idFind" value="1" onchange="member()" checked>일반회원
	<input type="radio" id="seller" name="idFind" value="2" onchange="seller()">기업회원
	<div id="divmemberIdFind">
	<table>
		<form action="memberIdFind" method="post">
    		<tr>
    			<td>이름 : <input type="text" id="name" name="name"></td>
    		</tr>
    		<tr>
    			<td>생년월일 : <input type="date" id="birth" name="birth"></td>
    		</tr>
    		<tr>
    			<td>휴대폰 : <input type="text" id="phone" name="phone"></td>
    		</tr>
    		<tr>
    			<td><button type="submit">확인</button></td>
    		</tr>
		</form>
	</table>
	</div>
	<div id="divsellerIdFind">
	<table>
		<form action="sellerIdFind" method="post">
    		<tr>
    			<td>상호명(단체명) : <input type="text" id="s_number" name="s_number"></td>
    		</tr>
    		<tr>
    			<td>사업자등록번호 : <input type="text" id="s_name" name="s_name"></td>
    		</tr>
    		<tr>
    			<td>성명(대표자) : <input type="text" id="name" name="name"></td>
    		</tr>
    		<tr>
    			<td><button type="submit">확인</button></td>
    		</tr>
		</form>
	</table>
    </div>
</body>
</html>