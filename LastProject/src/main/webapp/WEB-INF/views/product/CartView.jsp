<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%> 
<% response.setContentType("text/html; charset=UTF-8");%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!DOCTYPE html>

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

	<title>E-SHOP HTML Template</title>

	<!-- Google font -->
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">
	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick-theme.css" />
	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nouislider.min.css" />
	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
		  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
		  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>	
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
function productpage(){
	 location.href="product"
};
function ProductView(no){
	var number = no;
	console.log(number);
	location.href="productView?number=number";
}

function comma(num){
	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  }

function change(num){
	  var x = document.form;
	  var y = Number(count.value)+num;
	  if(y < 1) y = 1 ;
	  x.count.value = y;
	  }
function countPlus(e){
		var commaPrice = $('#productPrice'+e).html();
		var price = removeComma(commaPrice);
		var cur = document.getElementById("payValue"+e).value;
		price = price/cur;
		console.log(price);
		cur++;
		document.getElementById("payValue"+e).value = cur;
		var ww = cur*price;
		var check = $("input:checkbox[name=check"+e+"]").is(":checked");
			if(check==true){
			var ff = $('#totalPrice').html();
			var gg = removeComma(ff);
			var dd = parseInt(gg)+parseInt(price);
			var PlusTotalPrice = comma(ww);
			var PlusPrice =comma(dd);
			$('#totalPrice').html(PlusPrice);
			$('#productPrice'+e).html(PlusTotalPrice);
			}else{
			var PlusTotalPrice = comma(ww);
			$('#productPrice'+e).html(PlusTotalPrice);
			}
		}
	function countMinus(e){
		var cur = document.getElementById("payValue"+e).value;
		if(cur<=1){
			alert('수량은 1개 이상이여야합니다.');
		}else{
		var commaPrice = $('#productPrice'+e).html();
		console.log(commaPrice);
		var price = removeComma(commaPrice);
		price = price/cur;
		console.log(price);
		var number = cur;
			$.ajax({
				url:'PriceMinusAjax',
				type:'get',
				data:{number:number,
					  price:price},
				success:function(result){
					cur--;
					document.getElementById("payValue"+e).value = cur;
					var check = $("input:checkbox[name=check"+e+"]").is(":checked");
					if(check==true){
						var ww = cur*price;
						var ff = $('#totalPrice').html();
						var gg = removeComma(ff);
						var dd = parseInt(gg)-parseInt(price);
						var MinusTotalPrice = comma(ww);
						var MinusPrice =comma(dd);
						$('#totalPrice').html(MinusPrice);
						$('#productPrice'+e).html(MinusTotalPrice);
					}else if(check==false){
						cur--;
						document.getElementById("payValue"+e).value = cur;
					var rrrr =comma(result);
					$('#productPrice'+e).html(rrrr);
					}
					}
			});
		}
	}
	
	function removeComma(str)
	{
		n = parseInt(str.replace(/,/g,""));
		return n;
	}
	
    var count=0;
    var arr=[];
	 function checkBox(e){
		 		var cartno = $('#cart'+e).val();
				var check="";
				var price=0;
				var totalprice=0;
				check = $("input:checkbox[name=check"+e+"]").is(":checked"); 
				price= $("input[name=check"+e+"]").val();
				totalprice = $('#totalPrice').html();
				var priceSum = removeComma(totalprice);
			 	if(check==true){
			 		arr.push(cartno);
			 		console.log(arr);
			 		count= count+1;
			 		$('#productCount').html(count);
			 		var s = $('#productPrice'+e).html();
			 		console.log(s);
			 		var a = removeComma(s);
					var checkprice = parseInt(priceSum)+parseInt(a);
					var total =comma(checkprice);
					$('#totalPrice').html(total);
				} else if(check==false){
					arr.splice(arr.indexOf(cartno),1);
			 		console.log(arr);
					count--;
					$('#productCount').html(count);
			 		var s = $('#productPrice'+e).html();
			 		console.log(s);
			 		var a = removeComma(s);
					var checkprice = parseInt(priceSum) - parseInt(a);
					var total =comma(checkprice);
					$('#totalPrice').html(total);
				}
		}
	 function order(){
		 console.log(arr);
		 location.href="Order?arr="+arr;
	 }
	 function delCart(e){
		 location.href="CartDel?cartno="+e;
	 }
</script>
</head>

<body>
	<!-- HEADER -->
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">마이페이지</a></li>
				<li class="active">장바구니</li>
			</ul>
		</div>
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
	<!-- 가운데 영역 -->
	<div class="background-color" style="background-color:#eee; padding-bottom:50px;">
		<div class="col-md-2" style="float: right; background-color: white; height: 50%; margin-top: 3.9%; margin-right: 1%;">
			<div class="cartArea" style="padding:15px;">
				<div style="text-align:left; margin-top:5px;border-bottom:1px solid;" >
					<h4><strong>전체 합계</strong></h4>
				</div>
				<div style="margin-top: 20px;border-bottom: 1px solid; height: 90px;">
					<div style="width:100%;float:left;">
						<p style="float:left;color: #7F8590;">상품수</p>
						<span style="float:right;">개</span><span style="float:right;" id="productCount">0</span>
					</div>
					<div style="width:100%;float:left;">
						<p style="float:left;color: #7F8590;">배송비</p>
						<span style="float:right; color:#067dfd;">무료배송</span>
					</div>
				</div>
				<div style="width:100%;float:left;margin-top:15px;">
					<h4 style="float:left;color: #7F8590;">전체 상품금액</h4>
					<h2><span style="float:right;">원</span><span style="float:right;" id="totalPrice">0</span></h2>
				</div>
				<button class="primary-btn" style="margin-top: 20px; width: 100%; height: 70px;font-size: 25px;" onclick="order()"> 구매하기</button>
			</div>
		</div>
	<div class="container">
		<div class="row">
			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">장바구니 목록</h2>
				</div>
			</div>
			 <c:forEach var="result" items="${cart }" varStatus="status">
			 <input type="hidden" value="${result.cartno}" id="cart${status.index }">
			<div class="col-md-12" style="background-color:white; margin-bottom:30px; padding:30px 15px;" id="count${status.index}">
				<div style="float:right;margin-top: 7%; margin-right: 6%;">
					<button class="delBtn" onclick="delCart('${result.cartno}')"><i class="fa fa-close"></i></button>
				</div>
				
				<div class="col-md-10" style="padding-bottom:10px; border-bottom:1px solid #dddddd;">
					<div class="checks etrans">
					  <input type="checkbox" id="ex_chk3${status.index}" name="check${status.index}" onclick="checkBox('${status.index}')" class="chBox" value="${result.price }"> 
					 	 <label for="ex_chk3${status.index}"></label> 
					  <h3 class="product-name" style="display:inline-block;" >${result.saleid }</h3>
					 </div>
				</div>
				<div class="col-md-10" style="margin-top:20px;">
					<img src="${pageContext.request.contextPath}/resources/fileupload/${result.photo1}" alt="" style="width:150px; height: 120px; float:left;">
						<div style="float:left;margin-top:20px;margin-left: 20px">
							<h4 class="product-name" style="width:400px;">${result.trade_name}</h4>
							<p>${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</p>
						</div>
						<div style="float:left; margin-top:20px; margin-left:80px;">
							<input  class="input" type="text" name="count" value="${result.num }" id ="payValue${status.index}" style="width:50px;">
							<a href="#" onclick="countPlus(${status.index})" id="plus"> ▲ </a>
							<a href="#" onclick="countMinus(${status.index})" id="minus"> ▼ </a>
						</div >
						<div style="float:left;margin-top:20px;margin-left:70px;">
							<h3><span id="productPrice${status.index}"><fmt:formatNumber value="${result.price}" pattern="#,###.##"/></span>원</h3>
						</div>

				</div>
			</div>
			</c:forEach>
		</div>
	</div>
</div>


	<!-- FOOTER -->
	<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->

	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>

</body>

</html>
