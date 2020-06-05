<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
<script>
$(document).ready(function() {
var i = "${airuser}";
var p = "${result.endprice}";
var resultprice =parseInt(i)*parseInt(p);
$('#rprice').html(resultprice);
console.log(resultprice);
console.log(i);
$('#user').html(content);
})

</script>
<script>
	function reservation(){
		var endnum = ${result.endnum};
		var name = $('#name').val();
		var email = $('#email').val();
		var phone = $('#phone').val();
		var phone1 = $('#phone1').val();
		var airuser = "${airuser}";
		var rprice = $('#rprice').html();
		console.log(endnum,name,email,phone,phone1,rprice);
		
		$.ajax({
	         type :"post",
	         url :"userreservation",
	         dataType: "text",
	         data : {
	        	   "endnum" : endnum,
	               "name": name,
	               "email" : email,
	               "phone" : phone,
	               "phone1" : phone1,
	               "airuser" : airuser,
	               "rprice" : rprice
	       		},
	         success: function(commentList){
	         	console.log("됐냐");
	         	location.href="reservationresult";
	         },
	         error : function(){
	            console.log("예약 실패");
	         }   
	         });
		
	}
</script>


</head>
<body>
      <div>
         <jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
      </div>
<table class="tg">
<thead>
  <tr>
    <th class="tg-0pky">여정</th>
    <th class="tg-0pky">항공편</th>
    <th class="tg-0pky">출발</th>
    <th class="tg-0pky">도착</th>
  </tr>
</thead>
<tbody>
  <tr>
    <td class="tg-0pky"><div>
   	서울/인천 -> ${result.endarea}
    </div></td>
    <td class="tg-0pky"><h2>
    ${result.airname}
    </h2></td>
    <td class="tg-0pky"><div>
    ${result.starttime}
    </div>
    </td>
    <td class="tg-0pky"><div>
    ${result.endtime}
    </div></td>
  </tr>
  <tr>
    <td class="tg-0pky"><div>
    ${result.endarea} -> 서울/인천
    </div></td>
    <td class="tg-0pky"><h2>
    ${result.airname}
    </h2></td>
    <td class="tg-0pky"><div>
    ${result.starttime}
    </div></td>
    <td class="tg-0pky"><div>
    ${result.endtime}
    </div></td>
  </tr>
  <tr>
    <td class="tg-0pky" colspan="6"><h2>합계 : </h2><h2 id="rprice"></h2></td>
  </tr>
</tbody>
</table>
   
   <form action="reservation">
		<div id="userreservation">
		<table>
		<tr>
		<th>예약자이름</th>
		<td><span><input name="reservationname" type="text" id="name"></span></td>
		<th>이메일</th>
		<td><span><input name="reservationemail" type="text" id="email"></span></td>
		</tr>
		<tr>
		<th>휴대폰</th>
		<td><span><input name="reservationphone" type="text" id="phone"></span></td>
		<th>긴급연락처</th>
		<td><span><input name="reservationphone1" type="text" id="phone1"></span></td>
		</tr>
		</table>
		</div>   		
   </form> 
      		<button onclick="reservation()">예약하기</button>
      
      <div>
         <jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
      </div>
      
</body>

</html>