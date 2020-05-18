<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

	<script>
	function timer(index){
		console.log(index);
		var a_date = document.getElementById("a_date"+index).value;
		var d_day = new Date(a_date);
		console.log(d_day);
		var today = new Date();
		console.log(today);
		days = (d_day - today) / 1000 / 60 / 60 / 24;
		daysRound = Math.floor(days);
		hours = (d_day - today) / 1000 / 60 / 60 - (24 * daysRound);
		hoursRound = Math.floor(hours);
		minutes = (d_day - today) / 1000 /60 - (24 * 60 * daysRound) - (60 * hoursRound);
		minutesRound = Math.floor(minutes);
		seconds = (d_day - today) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) -
		(60 * minutesRound);
		secondsRound = Math.round(seconds);
		sec = " 초"
		min = " 분 "
		hr = " 시간 "
		dy = " 일 "
		if(today >= d_day){
			document.getElementById("time"+index).value="경매종료";
			document.getElementById("btn"+index).disabled='disabled';
		}else{
		document.getElementById("time"+index).value = daysRound + 
		dy + hoursRound + hr + minutesRound + min + secondsRound + sec;
		window.setTimeout(function(){
			timer(index);
		},1000);
		}
	}	
	
		
	</script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
</div>
<div class="container">
		<!-- Product Single -->
			<c:forEach var="auctionList" items="${auctionList}" varStatus="status">
			<input type="hidden" id="id${status.index}" value="${auctionList.id}">
			<input type="hidden" id="a_date${status.index}" value="${auctionList.a_date}">
			<input type="hidden" onclick="timer(${status.index})">
			<div class="col-md-3 col-sm-6 col-xs-6" style="height:460px;">
				<div class="product product-single">
					<div class="product-thumb" id="imgColor${status.index}">
						<div class="product-label">
							<span>New</span>
							<span class="sale"><input type="text" id="time${status.index}" name="time" style="background-color: rgb(248,105,74); border:0px;"></span>
						</div>
						<button class="main-btn quick-view" id="btn${status.index }" onclick="location.href='auctionView?a_number=${auctionList.a_number}&page=${paging.page }'"><i class="fa fa-search-plus"></i> Quick view</button>
						<img src="${pageContext.request.contextPath}/resources/fileupload/${auctionList.a_photo}" alt="" width="50px" height="200px">				
					</div>
						<div class="product-body">
							<h3 class="product-price">시작가격:${auctionList.a_price}</h3>
							<h2 class="product-name"><a href="#">${auctionList.a_name}</a></h2>
								
						</div>
					</div>
				</div>
				<script>
					$(document).ready(timer(${status.index}));
				</script>
				</c:forEach>
				</div>
				<div class="container">
					<a href="auctionAddForm">상품등록</a>
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
				</div>
			
				
				<div>
				<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
				</div>
</body>
</html>