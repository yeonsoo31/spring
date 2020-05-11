<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script>
	function memberDelete(){
		var popupX = (document.body.offsetWidth / 2) - (400 / 2);
		//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (300 / 2);
		//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		window.open('memberDeleteForm', '회원탈퇴', 'status=no, width=400, height=300, left='+ popupX + ', top='+ popupY);
	}
	function sellerDelete(){
		var popupX = (document.body.offsetWidth / 2) - (400 / 2);
		//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (300 / 2);
		//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		window.open('memberDeleteForm', '회원탈퇴', 'status=no, width=400, height=300, left='+ popupX + ', top='+ popupY);
	}
</script>
</head>
<body>
<div>
<jsp:include page="/WEB-INF/views/top.jsp"/>
</div>
<div class="container">
	<div class="col-md-offset-12">　</div>
	<div><h3 style="text-align:center">마이페이지</h3></div>
	<div class="row">
	<div class="col-md-offset-5">
	<div>
		<c:if test="${sessionScope.loginIdDivision eq 1}">
		<button>최근 본 상품</button>
		<button>장바구니</button>
		<button>구매내역</button>
		<button onclick="location.href='memberModifyForm'">회원정보(수정)</button>
		<button onclick="memberDelete()">회원탈퇴</button>
		</c:if>
		<c:if test="${sessionScope.loginIdDivision eq 2}">
		<button>상품조회</button>
		<button>주문내역</button>
		<button onclick="location.href='sellerModifyForm'">회원정보(수정)</button>
		<button onclick="sellerDelete()">회원탈퇴</button>
		</c:if>
		<c:if test="${sessionScope.loginIdDivision eq 5}">
		<button onclick="location.href='memberList'">회원목록조회</button>
		<button onclick="location.href='noticeList'">공지사항</button>
		<button onclick="location.href='chart'">통계</button>
		</c:if>
	</div>
	</div>
	<div class="col-md-offset-12">　</div>
</div>
</div>
<div>
<jsp:include page="/WEB-INF/views/footer.jsp"/>
</div>
</body>
</html>