<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>Insert title here</title>
<script>
	function reportSellerBlackListAdd(){
		var sellerId = document.getElementById("sellerId").value;
		console.log(sellerId);
		if(confirm("해당 판매자를 블랙리스트에 추가하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "reportSellerBlackListAdd",
				data : {
					"id" : sellerId
				},
				dataType : "text",
				success : function(result){
					if(result=="OK"){
						alert("블랙리스트에 추가되었습니다");
						location.href="reportList";
					} else {
						alert("이미 블랙리스트에 추가된 판매자입니다");
					}
				},
				error : function(){
					console.log("통신실패");
					alert("통신실패");
				}
			});
		}
	}
	function reportDelete(){
		var sellerId = document.getElementById("sellerId").value;
		var productno = document.getElementById("productno").value;
		var trade_name = document.getElementById("trade_name").value;
		var reporttype = document.getElementById("reporttype").value;
		if(confirm("신고내용을 삭제하시겠습니까?")){
			$.ajax({
				type : "POST",
				url : "reportDelete",
				data : {
					"sellerId" : sellerId,
					"productno" : productno,
					"trade_name" : trade_name,
					"reporttype" : reporttype
				},
				dataType : "text",
				success : function(result){
					if(result=="OK"){
						alert("해당 신고내용을 삭제했습니다");
						location.href="reportList";
					}
				},
				error : function(){
					console.log("통신실패");
					alert("통신실패");
				}
			});
		}
	}
</script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
</div>
<table class="col-md-offset-4" border="1">
		<tr>
			<th>신고대상</th>
			<th>신고유형</th>
			<th>상품번호</th>
			<th>상품명</th>
			<th>신고자</th>
			<th>해당상품</th>
			<th>블랙리스트</th>
			<th>신고삭제</th>
		</tr>
	<c:forEach var="reportList" items="${reportList}">
		<tr>	
			<td>${reportList.sellerId}<input type="hidden" id="sellerId" value="${reportList.sellerId}"></td>
			<td>${reportList.reporttype}<input type="hidden" id="reporttype" value="${reportList.reporttype}"></td>
			<td>${reportList.productno}<input type="hidden" id="productno" value="${reportList.productno}"></td>
			<td>${reportList.trade_name}<input type="hidden" id="trade_name" value="${reportList.trade_name}"></td>
			<td>${reportList.memberId}</td>
			<td><a href="productView?number=${reportList.productno}">상품보기</a></td>
			<td><a href="#" onclick="reportSellerBlackListAdd()">추가</a></td>
			<td><a href="#" onclick="reportDelete()">삭제</a></td>
		</tr>
	</c:forEach>
	<tr>
		<td><button type="button" onclick="location.href='myPage'">이전으로</button></td>
	</tr>
	</table>
<div>
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>