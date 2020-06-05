<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>	
<script>
	function pay(no){
		var number = no;
		console.log(number)
		 $.ajax({
			url:'paymentUpdate',
			type:'get',
			data:{no:number
				},
			success:function(result){
				console.log(result);
	
			}
			}); 
   	 window.open('airpayment','payviewer','width=1000,height=800,resizeable,scrollbars');
	}
</script>
<script>
function myPage(){
	location.href="myPage"
}
</script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-c3ow{border-color:inherit;text-align:center;vertical-align:top}
.tg .tg-0lax{text-align:center;vertical-align:top}
</style>


</head>
<body>
	<div>
    	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
    </div>
	
	<div>
	<div style='width :100%; height:50px; text-align:center; margin : 20px;'>
	<h2>결제 대기중</h2>
	</div>    
    <table class="tg" style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto;'>
	<thead>
	  <tr>
	    <th class="tg-c3ow">예약번호</th>
	    <th class="tg-c3ow">항공번호</th>
	    <th class="tg-c3ow">이름</th>
	    <th class="tg-c3ow">핸드폰번호</th>
	    <th class="tg-c3ow">예약가격</th>
	    <th class="tg-0lax">결제상태</th>
	  </tr>
	</thead>
	<tbody>
	  <c:forEach var="myreser" items="${myreser}">
		<tr>
		<c:if test="${myreser.payment == 0}">
	    <td class="tg-c3ow">${myreser.reservationnum}</td>
	    <td class="tg-c3ow">${myreser.endnum}</td>
	    <td class="tg-c3ow">${myreser.name}</td>
	    <td class="tg-c3ow">${myreser.phone}</td>
	    <td class="tg-c3ow">${myreser.resultprice}</td>
	    <td class="tg-0lax"><button onclick="pay('${myreser.reservationnum}')">결제하기</td>
	  </tr>
	</c:if>
	</c:forEach>
	</tbody>
	</table>
    </div>
    
    <div>
	<div style='width :100%; height:50px; text-align:center; margin : 20px;'>
	<h2>결제 완료</h2>
	</div>    
    <table class="tg" style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto;'>
	<thead>
	  <tr>
	    <th class="tg-c3ow">예약번호</th>
	    <th class="tg-c3ow">항공번호</th>
	    <th class="tg-c3ow">이름</th>
	    <th class="tg-c3ow">핸드폰번호</th>
	    <th class="tg-c3ow">예약가격</th>
	    <th class="tg-0lax">결제상태</th>
	  </tr>
	</thead>
	<tbody>
	  <c:forEach var="myreser" items="${myreser}">
		<tr>
		<c:if test="${myreser.payment eq 1}">
	    <td class="tg-c3ow">${myreser.reservationnum}</td>
	    <td class="tg-c3ow">${myreser.endnum}</td>
	    <td class="tg-c3ow">${myreser.name}</td>
	    <td class="tg-c3ow">${myreser.phone}</td>
	    <td class="tg-c3ow">${myreser.resultprice}</td>
	    <td class="tg-0lax"><a href="reservationResult?reservationnum=${myreser.reservationnum}&endnum=${myreser.endnum}">예약결과보기</a></td>
	  </tr>
	</c:if>
	</c:forEach>
	</tbody>
	</table>
    </div>
   
	 <div>
	<div style='width :100%; height:50px; text-align:center; margin : 20px;'>
	<h2>결제 취소</h2>
	</div>    
    <table class="tg" style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto;'>
	<thead>
	  <tr>
	    <th class="tg-c3ow">예약번호</th>
	    <th class="tg-c3ow">항공번호</th>
	    <th class="tg-c3ow">이름</th>
	    <th class="tg-c3ow">핸드폰번호</th>
	    <th class="tg-c3ow">예약가격</th>
	    <th class="tg-0lax">결제상태</th>
	  </tr>
	</thead>
	<tbody>
	  <c:forEach var="myreser" items="${myreser}">
		<tr>
	<c:if test="${myreser.payment eq 2}">
	    <td class="tg-c3ow">${myreser.reservationnum}</td>
	    <td class="tg-c3ow">${myreser.endnum}</td>
	    <td class="tg-c3ow">${myreser.name}</td>
	    <td class="tg-c3ow">${myreser.phone}</td>
	    <td class="tg-c3ow">${myreser.resultprice}</td>
	    <td class="tg-0lax">취소된예약</td>
	  </tr>
	</c:if>
	</c:forEach>
	</tbody>
	</table>
    </div>
   <div>
   <button onclick="myPage()"></button>
   </div>
      
      <div>
         <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
      </div>
      
</body>
</html>