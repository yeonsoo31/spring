<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
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
$(document).ready(function() {
	$(window).bind('mousewheel', function(event) { //마우스휠 감지
	    if (event.originalEvent.wheelDelta >= 0) { //마우스휠 위로 돌릴때 이벤트
	        var wheel =event.originalEvent.wheelDelta;
	    	console.log(wheel);
	    	console.log('Scroll up');
	    }
	    else {  //마우스휠 아래로 돌릴때 이벤트
	    	 var wheel =event.originalEvent.wheelDelta;
		    	console.log(wheel);
	    	console.log('Scroll down');
	    }
});

});

</script>
<script>
	if(self.name != 'reload'){
		self.name = 'reload';
		self.location.reload(true);
	} else {
		self.name = '';
	}
</script>
</head>


<body>
	<!-- HEADER -->
	<header>
		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="goMain">
							<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
						</a>
					</div>
					<!-- /Logo -->

					<!-- Search -->
					<div class="header-search">
						<form>
							<input class="input search-input" type="text" placeholder="검색창">
							<button class="search-btn"><i class="fa fa-search"></i></button>
						</form>
					</div>
					<!-- /Search -->
				</div>
				<div class="pull-right">
					<ul class="header-btns">
						<!-- Account -->
						<c:choose>
							<c:when test="${sessionScope.loginId eq null}">
								<li class="header-account dropdown default-dropdown">
							<a href="memberLoginForm" class="text-uppercase">로그인</a> / <a href="termsOfService" class="text-uppercase">회원가입</a>
						</li>
							</c:when>
							<c:when test="${sessionScope.loginIdDivision eq 5}">
								<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">${sessionScope.name}님 환영합니다 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="memberLogout" class="text-uppercase">로그아웃</a>
							<ul class="custom-menu">
								<li><a href="myPage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
								<li><a href="cartList"><i class="fa fa-heart-o"></i> 장바구니</a></li>
								<li><a href="#"><i class="fa fa-exchange"></i> 최근본상품</a></li>
								<li><a href="memberList"><i class="fa fa-user-o"></i> 회원목록</a></li>
								<li><a href="memberLogout"><i class="fa fa-check"></i> 로그아웃</a></li>
							</ul>
								</li>	
							</c:when>
							<c:otherwise>
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">${name}님 환영합니다 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="memberLogout" class="text-uppercase">로그아웃</a>
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> 마이페이지</a></li>
								<li><a href="#"><i class="fa fa-heart-o"></i> 장바구니</a></li>
								<li><a href="#"><i class="fa fa-exchange"></i> 최근본상품</a></li>
								<li><a href="memberLogout"><i class="fa fa-check"></i> 로그아웃</a></li>
							</ul>
						</li>	
							</c:otherwise>
						</c:choose>
						<!-- Mobile nav toggle-->
						<li class="nav-toggle">
							<button class="nav-toggle-btn main-btn icon-btn"><i class="fa fa-bars"></i></button>
						</li>
						<!-- / Mobile nav toggle -->
					</ul>
				</div>
			</div>
		<!-- container -->
		</div>
		<!-- header -->
	</header>
	<!-- /HEADER -->

	<!-- NAVIGATION -->
	<div id="navigation">
		<!-- container -->
		<div class="container">
			<div id="responsive-nav">
				<!-- menu nav -->
				<div class="menu-nav">
					<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
					<ul class="menu-list">
						<li><a href="productlistpage">일반상품</a></li>
						<li><a href="auctionList">경매</a></li>
						<li><a href="#">공구</a></li>
						<li><a href="#">SNS</a></li>
						<li><a href="#">항공</a></li>
						<li><a href="#">호텔</a></li>
					</ul>
				</div>
				<!-- menu nav -->
			</div>

		</div>
		<!-- /container -->
	</div>
	<!-- /NAVIGATION -->
	<!-- 현재 페이지 목록 쓰면될거같습니당 -->
<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">현재 페이지 목록(대메뉴)</a></li>
				<li class="active">현재 페이지 목록(소메뉴)</li>
			</ul>
		</div>
	</div>
	<!-- 가운데 영역 -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<div >
				
				</div>
			</div>
		</div>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
</body>
</html>