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

<!-- 애니매이션 담당 JQUERY -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<title>나중에 기능 다 구현하면 이 페이지는 띄워주는 게 메인 이미지 뿐.</title>
	<script>
	$( document ).ready(function() {
		// jQuery 일반 메서드
		$(".deadline").each(function(index, item){
			var that = $(this);
			var dateString = $(this).next().text();
			var reggie = /(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})/;
			var dateArray = reggie.exec(dateString);
			var dateObject = new Date((+dateArray[1]), (+dateArray[2]) - 1, // Careful, month starts at 0!
			(+dateArray[3]), (+dateArray[4]), (+dateArray[5]), (+dateArray[6]));

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
					document.getElementById("btnd").disabled = true;
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
<div class="container">
	<div class = "row">
		<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
			<tr>
				<th style="background-color: #eeeeee; text-align: center;">상품명/판매자명(판매자 멤버테이블 아이디)</th>
				<th style="background-color: #eeeeee; text-align: center;">가격</th>
				<th style="background-color: #eeeeee; text-align: center;">메인이미지</th>
				<th style="background-color: #eeeeee; text-align: center;">최소인원/현재 구매인원</th>
				<th style="background-color: #eeeeee; text-align: center;">마감시간</th>
				<th style="background-color: #eeeeee; text-align: center;">조회수</th>
				<th style="background-color: #eeeeee; text-align: center;">상세설명</th>
				<th style="background-color: #eeeeee; text-align: center;">상품리뷰(댓글처럼)</th>
				<th style="background-color: #eeeeee; text-align: center;">상품문의(댓글처럼)</th>
			</tr>
			<tr>
				<td>${groupBuyView.g_name}</td>
				<td>${groupBuyView.g_price}</td>
				<td class="w100"><img class="img-responsive mw40 ib mr10" src="${pageContext.request.contextPath}/resources/gfileuplode/${groupBuyView.g_photo1name}"></td>
				<td>${groupBuyView.g_person}</td>
				<td><p class="deadline"></p>
							<p id="hi">${groupBuyView.g_deadline}</p></td>
				<td>${groupBuyView.g_hit}</td>
				<td>${groupBuyView.g_explanation}</td>
				<td>상품리뷰(다른테이블)</td>
				<td>상품문의(다른테이블)</td>
			</tr>
		</table>


		<button type="button" class="btn btn-rounded btn-dark btn-block" id="btnd"
		onClick="location.href='OrdersAdd?id=${cartList[0].id}'">구매요청</button>
	</div>
</div>
