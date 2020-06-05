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
function pay(){
	$('#airpayment').submit(function(){
		window.open('','payviewer','width=1000,height=800,resizeable,scrollbars');
		this.action = 'airpayment';
		this.method = 'post';
		this.target = 'payviewer';
	})
}
</script>
</head>
<body>
	<div>
		<table>
			<tr>
				<th>도착지</th> <th>출발날짜</th> <th>도착날짜</th> <th>항공사</th>
			</tr>
			<tr>
				<td>${airlreser.endarea}</td><td>${airlreser.starttime}</td>
				<td>${airlreser.endtime}</td><td>${airlreser.airname}</td>
			</tr>
		</table>
	</div>
	<form id="airpayment">
		<div>
		<table>
			<tr>
				<th>예약번호</th><th>예약자</th><th>전화번호</th><th>긴급연락처</th><th>이메일</th>
				<th>예약 인원</th><th>총 금액</th>
			</tr>
			<tr>
				<td>${reservationDesion.reservationnum}</td>
				<td>${reservationDesion.name}</td>
				<td>${reservationDesion.phone}</td>
				<td>${reservationDesion.phone1}</td>
				<td>${reservationDesion.email}</td>
				<td>${reservationDesion.airuser}</td>
				<td>${reservationDesion.resultprice}</td>
			</tr>
		</table>
			<input type="submit" value="결제">
		</div>
	</form>
</body>
</html>