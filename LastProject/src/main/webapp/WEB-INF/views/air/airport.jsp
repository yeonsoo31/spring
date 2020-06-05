<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function myReservation(){
	location.href="myReservation";
}
</script>
<script>
function reservationdelete(){
	location.href="reservationdelete?reservationnum=${reservationResult.reservationnum}";
}
</script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-c3ow{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-0pky{border-color:inherit;text-align:center;vertical-align:top}
</style>
</head>
<body>
	<div>
    	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
    </div>
    <div style='width:100%;  height:100%;'>
    <div style='width :100%; height:50px; text-align:center;' >
    <h2>예약 결과</h2>
    </div>
    
    <div style='align:center;'>
    <table class="tg" style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto;'>
		<thead>
		  <tr>
		    <th class="tg-c3ow">airportname</th>
		    <th class="tg-c3ow" colspan="2">${airlreser.airportname}</th>
		    <th class="tg-c3ow">airname</th>
		    <th class="tg-c3ow" colspan="2">${airlreser.airname}</th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td class="tg-c3ow">starttime</td>
		    <td class="tg-c3ow" colspan="2">${airlreser.starttime}</td>
		    <td class="tg-c3ow">endtime</td>
		    <td class="tg-c3ow" colspan="2">${airlreser.endtime}</td>
		  </tr>
		  <tr>
		    <td class="tg-0pky">endarea</td>
		    <td class="tg-0pky" colspan="2">${airlreser.endarea}</td>
		    <td class="tg-0pky">이용객수</td>
		    <td class="tg-0pky">${reservationResult.airuser}</td>
		    <td class="tg-0pky"><a href="airportform?reservationnum=${reservationResult.reservationnum}">여권등록</a></td>
		  </tr>
		  <tr>
		    <td class="tg-c3ow" colspan="3"></td>
		    <td class="tg-c3ow">총가격</td>
		    <td class="tg-c3ow" colspan="2">${reservationResult.resultprice}</td>
		  </tr>
		</tbody>
	</table>
	<div style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto; text-align:center;'>
	
	<button onclick="reservationdelete()">취소하기</button>
	<button onclick="myReservation()">되돌아가기</button>
	</div>
	</div>
   	</div>
    
    <div>
         <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
    </div>
</body>
</html>