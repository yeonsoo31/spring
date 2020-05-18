<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>나중에 기능 다 구현하면 이 페이지는 띄워주는 게 메인 이미지 뿐.</title>
	<script>
	$( document ).ready(function() {
		// jQuery 일반 메서드
		$(".deadline").each(function(index, item){
			var that = $(this);
			var dateString = $(this).next().text();
			var countDownDate = new Date(dateString).getTime();

			var x = setInterval(function() {
				var now = new Date().getTime();
				var distance = countDownDate - now;
				var days = Math.floor(distance / (1000 * 60 * 60 * 24));
				var hours = Math.floor((distance % (1000 * 60 * 60 * 24))
						/ (1000 * 60 * 60));
				var minutes = Math.floor((distance % (1000 * 60 * 60))
						/ (1000 * 60));
				var seconds = Math.floor((distance % (1000 * 60)) / 1000);

				that.text(days + "일 " + hours + "시간 " + minutes + "분 " + seconds + "초 ");

				if (distance < 0) {
					clearInterval(x);
					that.text("마감")


				}

			}, 1000);

		});

	});




	</script>

<style>
	#hi{
		Display:none;
	}
</style>
</head>
<body>
	<form action="groupbuylistpaging" method="post">
		<div class="container">
			<div class = "row">
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">상품번호</th>
							<th style="background-color: #eeeeee; text-align: center;">아이디</th>
							<th style="background-color: #eeeeee;
							text-align: center;">가격</th>
							<th style="background-color: #eeeeee; text-align: center;">상품명</th>
							<th style="background-color: #eeeeee; text-align: center;">메인 이미지</th>
							<th style="background-color: #eeeeee; text-align: center;">최소인원</th>
							<th style="background-color: #eeeeee; text-align: center;">마감일시</th>
						</tr>
					</thead>
					<c:forEach var="groupBuy" items="${groupBuyListPaging}">
					<tbody>
						<tr>
							<td>${groupBuy.g_number}</td>
							<td>${groupBuy.id}</td>
							<td>${groupBuy.g_price}</td>
							<td> <a href="groupBuyView?g_number=${groupBuy.g_number}">${groupBuy.g_name}</a></td>
							<td class="w100"><img class="img-responsive mw40 ib mr10" src="${pageContext.request.contextPath}/resources/gfileuplode/${groupBuy.g_photo1name}"></td>
							<td>${groupBuy.g_person}</td>
							<td><p class="deadline"></p>
							<p id="hi">${groupBuy.g_deadline}</p></td>

						</tr>
					</tbody>
					</c:forEach>
				</table>


		<!-- 페이징 처리 -->
							<!-- 현재 페이지 값보다 1보다 작거나  같으면 텍스트만 주고 1보다 큰 값이면 링크값을 줌 -->
							<div class="row">
								<div class="col-md-6 col-centered">
									<c:if test="${paging.page<=1}">
	[이전]&nbsp;
	</c:if>
									<!-- 이전으로 -->
									<c:if test="${paging.page>1}">
										<a href="groupbuylistpaging?page=${paging.page-1}">[이전]</a>&nbsp;
	</c:if>

									<!-- if, else if -->
									<c:forEach begin="${paging.startpage}" end="${paging.endpage}"
										var="i" step="1">
										<c:choose>
											<c:when test="${i eq paging.page}">
												<!-- 페이지 값 텍스트로 주고 나머지값은 링크로 -->
			${i}
			</c:when>
											<c:otherwise>
												<a href="groupbuylistpaging?page=${i}">${i}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<!-- 다음 버튼을 링크로 줄지 말지 -->
									<c:if test="${paging.page>=paging.maxpage}">
		[다음]
	</c:if>

									<c:if test="${paging.page<paging.maxpage}">
										<a href="groupbuylistpaging?page=${paging.page+1}">[다음]</a>
									</c:if>
								</div>
							</div>
						</div>
					</div>
	</form>

</body>
</html>