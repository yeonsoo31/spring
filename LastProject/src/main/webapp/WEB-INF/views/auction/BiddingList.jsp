<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="http://code.jquery.com/jquery-1.11.1.min.js" type="text/javascript"></script>
	<script>
		function bid(index){
			var a_number = document.getElementById("a_number"+index).value;
			var id = $("#id"+index).text();
			var page = ${page};
			console.log(a_number);
			console.log(id);
			$.ajax({
				type : "post",
				url : "bidCheck",
				data : {"a_number":a_number},
				dataType : "text",
				success : function(result){
					if(result == "OK"){					
						var success = true;
						var theURL = "bidSuccess?a_number="+a_number+"&id="+id+"&page="+page;
						opener.window.location = theURL;
						close();
					} else{
						alert("이미 낙찰확인 하였습니다.");
					}
				},
				error : function(){
					console.log("통신오류");
				}
			});
			
		}
	</script>
</head>
<body>
	<h1>목록</h1>
	<input type="hidden" value="OK" id="cInput">
	<table border='1'>
		<tr>
			<td>아이디</td>
			<td>입찰금액</td>
			<td>입찰시간</td>
			<td>낙찰</td>
		</tr>
	<c:forEach var="biddingList" items="${biddingList}" varStatus="status">
			<input type="hidden" value="${biddingList.a_number}" id="a_number${status.index}">
		<tr>
			<td id="id${status.index}">${biddingList.id}</td>
			<td>${biddingList.am_price}</td>
			<td>${biddingList.am_date}</td>
			<c:choose>
				<c:when test="${status.index eq 0}">
					<td><button onclick="bid(${status.index})">낙찰확인</button></td>
				</c:when>
				<c:otherwise>
					<td style="text-align:center">..</td>
				</c:otherwise>
			</c:choose>
		</tr>
	</c:forEach>
	</table>
	<div style="text-align: center;">
		<c:if test="${paging.page<=1}">
			[이전]&nbsp;
		</c:if>
		<c:if test="${paging.page>1}">
			<a href="auctionList?page=${paging.page-1}">[이전]</a>&nbsp;
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
			<c:choose>
				<c:when test="${i eq paging.page}">
					${i}
				</c:when>
				<c:otherwise>
					<a href="auctionList?page=${i}">${i}</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<c:if test="${paging.page>=paging.maxPage}">
			[다음]
		</c:if>
		<c:if test="${paging.page<paging.maxPage}">
			<a href="auctionList?page=${paging.page+1}">[다음]</a>
		</c:if>
	</div>
</body>
</html>