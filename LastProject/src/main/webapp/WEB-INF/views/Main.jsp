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
   <script type="text/javascript">
        window.onload = function () {
            var elm = ".box";
            $(elm).each(function (index) {
                // 개별적으로 Wheel 이벤트 적용
                $(this).on("mousewheel DOMMouseScroll", function (e) {
                    e.preventDefault();
                    var delta = 0;
                    if (!event) event = window.event;
                    if (event.wheelDelta) {
                        delta = event.wheelDelta / 120;
                        if (window.opera) delta = -delta;
                    } 
                    else if (event.detail)
                        delta = -event.detail / 3;
                    var moveTop = $(window).scrollTop();
                    var elmSelecter = $(elm).eq(index);
                    // 마우스휠을 위에서 아래로
                    if (delta < 0) {
                        if ($(elmSelecter).next() != undefined) {
                            try{
                                moveTop = $(elmSelecter).next().offset().top;
                                $(elmSelecter).next().addClass('move'); //  휠 내렸을시 애니메이션 이벤트
                            }catch(e){}
                        }
                    // 마우스휠을 아래에서 위로
                    } else {
                        if ($(elmSelecter).prev() != undefined) {
                            try{
                                moveTop = $(elmSelecter).prev().offset().top;
                                
                            }catch(e){}
                        }
                    }
                     
                    // 화면 이동 0.8초(800)
                    $("html,body").stop().animate({
                        scrollTop: moveTop + 'px'
                    }, {
                        duration: 800, complete: function () {
                        }
                    });
                });
            });
        }
        
        function imgArea1over(){
            document.getElementById("imgArea1").style.backgroundImage = "url('/lastproject/resources/img/banner04.jpg')";        		
        }
        function imgArea1out(){
        	document.getElementById("imgArea1").style.backgroundImage = "";
        }
        function imgArea2over(){
            document.getElementById("imgArea2").style.backgroundImage = "url('/lastproject/resources/img/banner02.jpg')";        		
        }
        function imgArea2out(){
        	document.getElementById("imgArea2").style.backgroundImage = "";
        }
        function imgArea3over(){
            document.getElementById("imgArea3").style.backgroundImage = "url('/lastproject/resources/img/banner04.jpg')";        		
        }
        function imgArea3out(){
        	document.getElementById("imgArea3").style.backgroundImage = "";
        }
        function imgArea4over(){
            document.getElementById("imgArea4").style.backgroundImage = "url('/lastproject/resources/img/sns1.jpg')";        		
        }
        function imgArea4out(){
        	document.getElementById("imgArea4").style.backgroundImage = "";
        }
        function imgArea5over(){
            document.getElementById("imgArea5").style.backgroundImage = "url('/lastproject/resources/img/hotel2.jpg')";        		
        }
        function imgArea5out(){
        	document.getElementById("imgArea5").style.backgroundImage = "";
        }
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


<body style="overflow-y:hidden;">
	<!-- HEADER -->
	<header>
		<!-- header -->
		<div id="header">
			<div class="container">
				<div class="pull-left">
					<!-- Logo -->
					<div class="header-logo">
						<a class="logo" href="#">
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
								<strong class="text-uppercase">${name}님 환영합니다 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="memberLogout" class="text-uppercase">로그아웃</a>
							<ul class="custom-menu">
								<li><a href="myPage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
								<li><a href="#"><i class="fa fa-heart-o"></i> 장바구니</a></li>
								<li><a href="#"><i class="fa fa-exchange"></i> 최근본상품</a></li>
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
								<strong class="text-uppercase">${sessionScope.name}님 환영합니다 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="memberLogout" class="text-uppercase">로그아웃</a>
							<ul class="custom-menu">
								<li><a href="myPage"><i class="fa fa-user-o"></i> 마이페이지</a></li>
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
			<!-- header -->
		</div>
		<!-- container -->
	</header>
	<!-- /HEADER -->

<!-- NAVIGATION -->
	<div id="MainImg1" class="box">
		<div id="navigation-ch" style="background-image: url('${pageContext.request.contextPath}/resources/img/상품.png');" >
			<div id="navigation">
			<!-- container -->
				<div class="container">
					<div id="responsive-nav">
						<!-- menu nav -->
						<div class="menu-nav">
							<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
							<ul class="menu-list">
								<li><a href="productlistpage">일반상품</a></li>
								<li><a href="auctionList">경매상품</a></li>
								<li><a href="chat/room">채팅</a></li>
							</ul>
						</div>
						<!-- menu nav -->
					</div>
		
				</div>
			<!-- /container -->
			</div>
			
			<div class="Main-img-area-1" onMouseOver="imgArea1over()" id="imgArea1" onMouseOut="imgArea1out()">
				<div class="Main-text-area">
					<h1>일반 상품</h1> <br>
					<a href="productlistpage">일반 상품 보러가기</a>
				</div>
			</div>
			<div class="Main-img-area-2" onMouseOver="imgArea2over()" id="imgArea2" onMouseOut="imgArea2out()">
				<div class="Main-text-area">
					<h1>경매 상품</h1> <br>
					<a href="#">경매상품 보러가기</a>
				</div>
			</div>
			<div class="Main-img-area-3" onMouseOver="imgArea3over()" id="imgArea3" onMouseOut="imgArea3out()">
				<div class="Main-text-area">
					<h1>인기 상품</h1> <br>
					<a href="#">인기상품 보러가기</a>
				</div>
			</div>
		</div>
	</div>		
	
	<div id="MainImg2"class="box">
		<div id="navigation-ch" style="background-image: url('${pageContext.request.contextPath}/resources/img/비행기1.jpg');" >
		
			<div id="navigation">
			<!-- container -->
				<div class="container">
					<div id="responsive-nav">
						<!-- menu nav -->
						<div class="menu-nav">
							<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
							<ul class="menu-list">
								<li><a href="#">항공 예약 관리 정보</a></li>
							</ul>
						</div>
						<!-- menu nav -->
					</div>
				</div>
			<!-- /container -->

			</div>
			<!-- ★★★★항공 조회 텍스트 영역 시작 ★★★★ -->
			<div class="Main-img2">
				<div class="Main-img2-area">
					<a>검색, 예약 로직 첨부!</a>
				</div>
			</div>
			<!-- ★★★★항공 조회 텍스트 영역 끝 ★★★★ -->
		</div>
	</div>		
	
	<div id="MainImg3" class="box">
		<div id="navigation-ch" style="background-image: url('${pageContext.request.contextPath}/resources/img/hub.jpg');" >
			<div id="navigation">
			<!-- container -->
				<div class="container">
					<div id="responsive-nav">
						<!-- menu nav -->
						<div class="menu-nav">
							<span class="menu-header">Menu <i class="fa fa-bars"></i></span>
							<ul class="menu-list">
								<li><a href="#">SNS</a></li>
								<li><a href="#">호텔</a></li>
							</ul>
						</div>
						<!-- menu nav -->
					</div>
		
				</div>
			<!-- /container -->
			</div>
			<div class="Main-img-area-4" onMouseOver="imgArea4over()" id="imgArea4" onMouseOut="imgArea4out()">
				<div class="Main-text-area">
					<h1>SNS 채팅</h1> <br>
					<a href="#">SNS 바로가기</a>
				</div>
			</div>
			<div class="Main-img-area-5" onMouseOver="imgArea5over()" id="imgArea5" onMouseOut="imgArea5out()">
				<div class="Main-text-area">
					<h1>호텔 조회</h1> <br>
					<a href="#">호텔조회 바로가기</a>
				</div>
			</div>
		</div>
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
