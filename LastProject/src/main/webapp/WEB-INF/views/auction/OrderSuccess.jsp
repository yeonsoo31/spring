<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script>
		function timeOut(){
			var theURL = "goMain";
			opener.window.location = theURL;
			window.close();
		}
	</script>
</head>
<body onload="timeOut('forwarding()',5000)">
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
		<h2>결제에 성공하였습니다.</h2>
	<div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
</body>
</html>