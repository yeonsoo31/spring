<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script>
  $( function() {
    var dateFormat = "yyyy/mm/dd",
      from = $( "#from" )
        .datepicker({
          defaultDate: "+1w",
          changeMonth: true,
          numberOfMonths: 3
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3
      })
      .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
      });
 
    function getDate( element ) {
      var date;
      try {
        date = $.datepicker.parseDate( dateFormat, element.value );
      } catch( error ) {
        date = null;
      }
 
      return date;
    }
  } );
  
  
  </script>
</head>
<body>
		<div>
			<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
		</div>

		
	<div id="MainImg2"class="box" style="width: 100%; height: 100%;">
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
		<div>
			<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		</div>
		
</body>

</html>