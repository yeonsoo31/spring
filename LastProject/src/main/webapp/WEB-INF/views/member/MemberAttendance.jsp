<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js"
    integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
<title>출석체크</title>
<style>
	table {
		border-collapse: collapse;
		margin: auto;
	}
	table, th, td {
		border: 1px solid black;
		color: #333333;
	}
</style>
<script>
	// today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
	var day = document.getElementById("day");
	var today = new Date();
	var id = ${sessionScope.loginId};
	
	console.log(id);
    today = today.getDate();
    console.log(today);
	function attendance(index) {
		var attStatus = document.getElementById("attStatus"+index).innerHTML;
		console.log(attStatus);
	}
//		if(today==(attStatus1)){
//			alert("출석완료");
//			attStatus1.src = "${pageContext.request.contextPath}/resources/img/smile.jpg"
//			location.href="memberAttendanceCheck?att_date="+today;
//		} else {
//			alert("아직 출석할 수 있는 날짜가 아닙니다");
//		}
	
	
//	function attendance2() {
//		var attStatus2 = document.getElementById("attStatus2"+index).innerHTML;
//		if(today==attStatus2){
//			alert("출석완료");
//			attStatus2.src = "${pageContext.request.contextPath}/resources/img/smile.jpg"
//			location.href="attendanceCheck?att_date="+today;
//		} else {
//			alert("아직 출석할 수 있는 날짜가 아닙니다");
//		}
//	}
</script>
</head>
<body>
	<table width="490" height="400">
	<tr>
		<th>일요일</th>
		<th>월요일</th>
		<th>화요일</th>
		<th>수요일</th>
		<th>목요일</th>
		<th>금요일</th>
		<th>토요일</th>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td><p id="attStatus1">1</p><a onclick="attendance('1')"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus2">2</p><a onclick="attendance(2)"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
	</tr>
	<tr>
		<td><p id="attStatus3">3</p><a onclick="attendance3()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus4">4</p><a onclick="attendance4()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus5">5</p><a onclick="attendance5()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus6">6</p><a onclick="attendance6()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus7">7</p><a onclick="attendance7()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus8">8</p><a onclick="attendance8()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
		<td><p id="attStatus9">9</p><a onclick="attendance9()"><img width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></a></td>
	</tr>
	<tr>
		<td id="day">10<br>&nbsp;&nbsp;<img id="attStatus10" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">11<br>&nbsp;&nbsp;<img id="attStatus11" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">12<br>&nbsp;&nbsp;<img id="attStatus12" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">13<br>&nbsp;&nbsp;<img id="attStatus13" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">14<br>&nbsp;&nbsp;<img id="attStatus14" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">15<br>&nbsp;&nbsp;<img id="attStatus15" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">16<br>&nbsp;&nbsp;<img id="attStatus16" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
	</tr>
	<tr>
		<td id="day">17<br>&nbsp;&nbsp;<img id="attStatus17" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">18<br>&nbsp;&nbsp;<img id="attStatus18" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">19<br>&nbsp;&nbsp;<img id="attStatus19" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">20<br>&nbsp;&nbsp;<img id="attStatus20" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">21<br>&nbsp;&nbsp;<img id="attStatus21" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">22<br>&nbsp;&nbsp;<img id="attStatus22" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">23<br>&nbsp;&nbsp;<img id="attStatus23" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
	</tr>
	<tr>
		<td id="day">24<br>&nbsp;&nbsp;<img id="attStatus24" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">25<br>&nbsp;&nbsp;<img id="attStatus25" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">26<br>&nbsp;&nbsp;<img id="attStatus26" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">27<br>&nbsp;&nbsp;<img id="attStatus27" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">28<br>&nbsp;&nbsp;<img id="attStatus28" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">29<br>&nbsp;&nbsp;<img id="attStatus29" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day">30<br>&nbsp;&nbsp;<img id="attStatus30" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
	</tr>
	<tr>
		<td id="day">31<br>&nbsp;&nbsp;<img id="attStatus31" width="50" height="50" src="${pageContext.request.contextPath}/resources/img/sad.png"></td>
		<td id="day"></td>
		<td id="day"></td>
		<td id="day"></td>
		<td id="day"></td>
		<td id="day"></td>
		<td id="day"></td>
	</tr>
	</table>
</body>
</html>