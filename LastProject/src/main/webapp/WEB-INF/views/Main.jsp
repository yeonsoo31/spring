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
        
       /*  function imgArea1over(){
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
        } */
        /* function imgArea4over(){
            document.getElementById("imgArea4").style.backgroundImage = "url('/lastproject/resources/img/sns1.jpg')";        		
        }
        function imgArea4out(){
        	document.getElementById("imgArea4").style.backgroundImage = "";
        } */
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
							<img style="width:200px; height:200px;" src="${pageContext.request.contextPath}/resources/img/aaaa1234.png" alt="">
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
								<li><a href="buyList"><i class="fa fa-user-o"></i> 마이페이지</a></li>
								<li><a href="#"><i class="fa fa-heart-o"></i> 장바구니</a></li>
								<li><a href="#"><i class="fa fa-exchange"></i> 최근본상품</a></li>
								<li><a href="memberLogout"><i class="fa fa-check"></i> 로그아웃</a></li>
							</ul>
						</li>	
							</c:when>
							<c:when test="${sessionScope.loginIdDivision eq 2}">
							<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">${name}님 환영합니다 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="memberLogout" class="text-uppercase">로그아웃</a>
							<ul class="custom-menu">
								<li><a href="SalesBuyList"><i class="fa fa-user-o"></i> 마이페이지</a></li>
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
								<li><a href="buyList"><i class="fa fa-user-o"></i> 마이페이지</a></li>
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
							</ul>
						</div>
						<!-- menu nav -->
					</div>
		
				</div>
			<!-- /container -->
			</div>
			
			<div class="Main-img-area-1" onMouseOver="imgArea1over()" id="imgArea1" onMouseOut="imgArea1out()">
				<div class="Main-text-area">
					<h1 style="color: #f3d60a;">일반 상품</h1> <br>
					<a href="productlistpage" style="color: #f3d60a;">일반 상품 보러가기</a>
				</div>
			</div>
			<div class="Main-img-area-2" onMouseOver="imgArea2over()" id="imgArea2" onMouseOut="imgArea2out()">
				<div class="Main-text-area">
					<h1 style="color: #f3d60a;">경매 상품</h1> <br>
					<a href="#" style="color: #f3d60a;">경매상품 보러가기</a>
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
								<li><a href="airLine">항공 예약 관리 정보</a></li>
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
					<form action="airsearch" method="post">
		<span style="float:left; margin-right:20px;">
			<label for="start">출발지</label>
			<select id="start" name="startarea">
				<option value="">선택하세요</option>
				<option value="서울/인천">서울/인천</option>
			</select>
		</span>
		<span>	
		<label for="end" >도착지</label>
			<select id="end" name="endarea">
				<option value="">선택하세요</option>
				<option value="가고시마">가고시마</option>
				<option value="가오슝">가오슝</option>
				<option value="고마쓰">고마쓰</option>
				<option value="괌">괌</option>
				<option value="광저우">광저우</option>
				<option value="구마모토">구마모토</option>
				<option value="구이린(계림)">구이린(계림)</option>
				<option value="나고야">나고야</option>
				<option value="나트랑">나트랑</option>
				<option value="난징">난징</option>
				<option value="난통">난통</option>
				<option value="노보시비르스크">노보시비르스크</option>
				<option value="누르술탄">누르술탄</option>
				<option value="뉴욕/존에프케네디">뉴욕/존에프케네디</option>
				<option value="니가타">니가타</option>
				<option value="닝보">닝보</option>
				<option value="다낭">다낭</option>
				<option value="다렌">다렌</option>
				<option value="다카">다카</option>
				<option value="다카마쓰">다카마쓰</option>
				<option value="달랏">달랏</option>
				<option value="대구">대구</option>
				<option value="댈러스/댈러스포트워스">댈러스/댈러스포트워스</option>
				<option value="덴파사르">덴파사르</option>
				<option value="델리">델리</option>
				<option value="도쿄/나리타">도쿄/나리타</option>
				<option value="도쿄/하네다">도쿄/하네다</option>
				<option value="도하">도하</option>
				<option value="두바이">두바이</option>
				<option value="도옹 당(푸꿕)">도옹 당(푸꿕)</option>
				<option value="디트로이트">디트로이트</option>
				<option value="라스베이거스">라스베이거스</option>
				<option value="런던/히드로">런던/히드로</option>
				<option value="로마">로마</option>
				<option value="로스엔젤레스">로스엔젤레스</option>
				<option value="리스본">리스본</option>
				<option value="린이">린이</option>
				<option value="마닐라">마닐라</option>
				<option value="마드리드">마드리드</option>
				<option value="마쓰야마">마쓰야마</option>
				<option value="마카오">마카오</option>
				<option value="말레">말레</option>
				<option value="멕시코시티">멕시코시티</option>
				<option value="멜버른">멜버른</option>
				<option value="모스크바">모스크바</option>
				<option value="무단장">무단장</option>
				<option value="뭄바이">뭄바이</option>
				<option value="뮌헨">뮌헨</option>
				<option value="미니애폴리스">미니애폴리스</option>
				<option value="미야자키">미야자키</option>
				<option value="밀라노">밀라노</option>
				<option value="바르샤바">바르샤바</option>
				<option value="바르셀로나">바르셀로나</option>
				<option value="반다르스리브가완">반다르스리브가완</option>
				<option value="방콕/돈므앙">방콕/돈므앙</option>
				<option value="방콕/수완나폼">방콕/수완나폼</option>
				<option value="벤쿠버">벤쿠버</option>
				<option value="베니스">베니스</option>
				<option value="베이징">베이징</option>
				<option value="보스턴">보스턴</option>
				<option value="보홀(탁빌라란)">보홀(탁빌라란)</option>
				<option value="볼레(아디스아바바)">볼레(아디스아바바)</option>
				<option value="부다페스트">부다페스트</option>
				<option value="부산">부산</option>
				<option value="브리즈번">브리즈번</option>
				<option value="블라디보스토크">블라디보스토크</option>
				<option value="비엔나">비엔나</option>
				<option value="비엔티안">비엔티안</option>
				<option value="사가">사가</option>
				<option value="사이판">사이판</option>
				<option value="사할린">사할린</option>
				<option value="산티아고">산티아고</option>
				<option value="삿포르">삿포르</option>
				<option value="상트페테르부르크">상트페테르부르크</option>
				<option value="상하이/푸동">상하이/푸동</option>
				<option value="샌프란시스코">샌프란시스코</option>
				<option value="샤먼">샤먼</option>
				<option value="선양">선양</option>
			</select>
		</span>
		<label for="from">출발일</label>
		<input type="text" id="from" name="from">
		<label for="to">도착일</label>
		<input type="text" id="to" name="to">
			<label for="user">인원수</label>
			<select id="user" name="airuser">
				<option value="">선택하세요</option>
				<option value="1">1명</option>
				<option value="2">2명</option>
				<option value="3">3명</option>
				<option value="4">4명</option>
				<option value="5">5명</option>
				<option value="6">6명</option>
				<option value="7">7명</option>
				<option value="8">8명</option>
				<option value="9">9명</option>
			</select>
		<button onclick="airsearch()">조회하기</button>
		</form>
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
								<li><a href="snsMain">SNS</a></li>
								<li><a href="hotelCrawling">호텔</a></li>
							</ul>
						</div>
						<!-- menu nav -->
					</div>
		
				</div>
			<!-- /container -->
			</div>
			<div class="Main-img-area-4" id="imgArea4">
				<div class="Main-text-area">
					<h1 style="color:white">SNS 채팅</h1> <br>
					<a href="snsMain" style="color:white">SNS 바로가기</a>
				</div>
			</div>
			<div class="Main-img-area-5" id="imgArea5" style="background-image:url('/lastproject/resources/img/hotel2.jpg')" >
				<div class="Main-text-area">
					<h1 style="color:white">호텔 조회</h1> <br>
					<a href="hotelCrawling" style="color:white">호텔조회 바로가기</a>
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
