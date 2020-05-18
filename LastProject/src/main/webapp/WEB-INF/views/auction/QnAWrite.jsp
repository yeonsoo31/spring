<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/style.css">
<title>Insert title here</title>
</head>
<body>
		<div class="popup-layout">
		<div class="section-title">
			<h3>상품문의</h3>
		</div>

		<div class="row">
			<form class="review-form">
			<div class="form-group">
				<div class="col-md-1"> 아이디</div>
				<div class="col-md-1"><input type="text" value="${id }" name="id" readonly></div>
			</div>
			</form>
		</div>
		</div>

</body>
</html>