<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>회원정보수정</title>
<script>
function memberDelete(){
	var popupX = (document.body.offsetWidth / 2) - (500 / 2);
	//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (300 / 2);
	//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	window.open('memberDeleteForm', '회원탈퇴', 'status=no, width=500, height=300, left='+ popupX + ', top='+ popupY);
}
function sellerDelete(){
	var popupX = (document.body.offsetWidth / 2) - (500 / 2);
	//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (300 / 2);
	//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	window.open('memberDeleteForm', '회원탈퇴', 'status=no, width=500, height=300, left='+ popupX + ', top='+ popupY);
}
function oauthDelete(){
	var id = "${sessionScope.loginId}";
	if(confirm("정말 탈퇴하시겠습니까?")){
		alert("탈퇴처리가 완료되었습니다");
		location.href="memberDelete?id="+id
	} else {
		alert("탈퇴처리가 취소되었습니다");
	}
}
function memberPasswordModifyForm(){
	var popupX = (document.body.offsetWidth / 2) - (460 / 2);
	//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (200 / 2);
	//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	var password = ""
	window.open('memberPasswordModifyForm', '회원 비밀번호 변경', 'status=no, width=550, height=400, left='+ popupX + ', top='+ popupY);
}
function sellerPasswordModifyForm(){
	var popupX = (document.body.offsetWidth / 2) - (460 / 2);
	//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
	var popupY= (window.screen.height / 2) - (200 / 2);
	//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
	window.open('sellerPasswordModifyForm', '기업회원 비밀번호 변경', 'status=no, width=460, height=200, left='+ popupX + ', top='+ popupY);
}
	function memberMain() {
		location.href="memberMain";
	}
	function doubleCheck() {
		var re_name = /^[가-힝a-zA-Z]{2,}$/;
		var re_phone = /^\d{3}-\d{3,4}-\d{4}$/;
		var name = document.getElementById("name");
		var phone = document.getElementById("phone");
		var address1 = document.getElementById("sample6_postcode");
		var address2 = document.getElementById("sample6_address");
		var address3 = document.getElementById("sample6_detailAddress");
		// 이름 유효성
		if((name.value) == "") {
			alert("성명을 입력해 주세요");
			name.focus();
			return false;
		}
		if(!re_name.test(name.value)) {
			alert("정확한 이름을 입력해 주세요");
			return false;
		}
		// 주소 유효성
		if((address1.value.length) < 5) {
			alert("우편번호를 입력해 주세요");
			address1.focus();
			return false;
		}
		if((address2.value) == "") {
			alert("주소를 입력해 주세요");
			address2.focus();
			return false;
		}
		if((address3.value) == "") {
			alert("상세주소를 입력해 주세요");
			address3.focus();
			return false;
		}
		// 휴대폰 유효성
		if((phone.value) == "") {
			alert("휴대폰 번호를 입력해 주세요");
			phone.focus();
			return false;
		}
		if(!re_phone.test(phone.value)) {
			alert("정확한 휴대폰 번호를 입력해 주세요");
			phone.focus();
			return false;
		}
	}
</script>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            document.getElementById("sample6_detailAddress").focus();
            }
            }).open();
        }
    </script>
    <script>
    	function myPage(){
    		location.href="myPage";
    	}
    </script>
</head>
<body>
	<div>
	<jsp:include page="/WEB-INF/views/top.jsp"/>
	</div>
	<div class="category-nav" style="width:330px; margin-top:10px;">
		<span class="category-header">마이페이지 정보<i class="fa fa-list"></i></span>
			<div class="left-menu-ch">
				<c:if test="${sessionScope.loginIdDivision eq 1}">
					<ul  class="category-list" style="width:330px;">
						<li><a href="buyList">구매내역</a></li>
						<li><a href="myReservation">항공예약조회</a></li>
						<li><a href="product_recentlist">최근 본 상품</a></li>
						<li><a href="CartView">장바구니</a></li>
						<li><a href="memberModifyForm">회원정보(수정)</a></li>
						<li><a onclick="javascript: memberPasswordModifyForm(); return false;">비밀번호 변경</a></li>
						<li><a onclick="memberDelete()">회원탈퇴</a></li>
					</ul>
				</c:if>	
				<c:if test="${sessionScope.loginIdDivision eq 2}">
						<li><a href="buyList">구매내역</a></li>
						<li><a href="sellerModifyForm">회원정보(수정)</a></li>
						<li><a onclick="javascript: memberPasswordModifyForm(); return false;">비밀번호 변경</a></li>
						<li><a onclick="memberDelete()">회원탈퇴</a></li>
				</c:if>
				<c:if test="${sessionScope.loginIdDivision eq 5}">
						<li><a href="buyList">회원목록조회</a></li>
						<li><a href="reportList">신고자 목록</a></li>
						<li><a href="noticeList">공지사항</a></li>
						<li><a href="statistic">통계</a></li>
				</c:if>
				<c:if test="${sessionScope.googleId ne null}">
						<li><a href="product_recentlist">최근 본 상품</a></li>
						<li><a href="CartView">장바구니</a></li>
						<li><a href="buyList">구매내역</a></li>
						<li><a href="memberModifyForm">회원정보(수정)</a></li>
						<li><a href="oauthDelete()">계정탈퇴</a></li>
				</c:if>
				<c:if test="${sessionScope.facebookId ne null}">
						<li><a href="product_recentlist">최근 본 상품</a></li>
						<li><a href="CartView">장바구니</a></li>
						<li><a href="buyList">구매내역</a></li>
						<li><a href="memberModifyForm">회원정보(수정)</a></li>
						<li><a href="oauthDelete()">계정탈퇴</a></li>
				</c:if>
				<c:if test="${sessionScope.kakaoId ne null}">
						<li><a href="product_recentlist">최근 본 상품</a></li>
						<li><a href="CartView">장바구니</a></li>
						<li><a href="buyList">구매내역</a></li>
						<li><a href="memberModifyForm">회원정보(수정)</a></li>
						<li><a href="oauthDelete()">계정탈퇴</a></li>
				</c:if>
				<c:if test="${sessionScope.naverId ne null}">
						<li><a href="product_recentlist">최근 본 상품</a></li>
						<li><a href="CartView">장바구니</a></li>
						<li><a href="buyList">구매내역</a></li>
						<li><a href="memberModifyForm">회원정보(수정)</a></li>
						<li><a href="oauthDelete()">계정탈퇴</a></li>
				</c:if>
			</div>
	</div>
	<div class="container">
	<form class="col-md-offset-4" action="memberModify" method="post" id=memberModifyForm onsubmit="return doubleCheck()" enctype="multipart/form-data" style="margin-left:0;">
		<input type="hidden" value="${memberModify.profile}" name="profile">
					<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">회원정보(수정)</h2>
				</div>
			</div>
			<div class="cont" style="padding:0 15px; float:left; width:100%;">
				<div class="contLeft" style="background:white; float:left; width:80%;margin-left: 20%;">
					<div class="product-tab">
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
									<div style="margin-top:20px;">
										<a>아이디 :</a>
										<input class="input" type="text" name="id" id="id" value="${memberModify.id}" readonly style="width: 30%;margin-left: 110px;" >
									</div>
									<div style="margin-top:20px;">
										<a>이름 :</a>
										<input class="input" type="text" name="name" id="name" value="${memberModify.name}" style="width: 30%;margin-left: 124px;" >
									</div>
									<div style="margin-top:20px;">
										<a>주소 :</a>
										<input type="text" id="sample6_postcode" name="address1" placeholder="우편번호" class="input"style="width: 30%;margin-left: 125px;" value="${memberModify.address1}" >
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="primary-btn"style="width: 15%;">
										<input type="text" id="sample6_address" name="address2" placeholder="주소" class="input"style="width: 30%;margin-left: 163px;" value="${memberModify.address2}"> <br>
										<input type="text" id="sample6_detailAddress" name="address3" placeholder="상세주소" class="input"style="width: 30%;margin-left: 163px;" value="${memberModify.address3}"><br>
										<input type="text" id="sample6_extraAddress" name="address4" placeholder="참고항목" class="input"style="width: 30%;margin-left: 163px;" value="${memberModify.address4}">
									</div>

									<div style="margin-top:20px;">
										<a>휴대폰 :</a>
										 <input id="phone" name="phone" type="text" class="input" style="width: 30%;margin-left: 110px;" value="${memberModify.phone}">
									</div>
									
									<div style="margin-top:20px;">
										<a>프로필사진 :</a>
										<input type="file" name="file" class="input" style="width:30%;margin-left: 160px;">
									</div>
								</div>
								</div>
						</div>
					</div>
			</div>
				<input type="submit" value="수정" class="primary-btn" style="margin-left: 500px;margin-top:80px;">
			<button type="button" onclick="myPage()" class="primary-btn">돌아가기</button>
		</form>
		</div>
	<div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
<script>
	 function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#profileimg").attr("src",e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	} 
	
	$("#profileinput").change(function(){
		readURL(this);
	});
</script>
</html>