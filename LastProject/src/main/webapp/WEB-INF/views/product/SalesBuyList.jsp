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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b2a4de6709c30e17be681e159b1b9437&libraries=services"></script>	
	<script src="https://kit.fontawesome.com/d928ba27e6.js" crossorigin="anonymous"></script>
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>	
<script>

$(document).ready(function() {
	 var table = $('#table tr').length;
	 console.log(table);
	 var startcount=1;
	 var endcount=1;
	 for(var j=1 ; j<table ; j++){
		 start = $('#address1'+j).val();
		 end = $('#address2'+j).val();
		 console.log(start,end);
		 var st = start;
			var geocoder = new kakao.maps.services.Geocoder();
			// 주소로 좌표를 검색합니다
			 geocoder.addressSearch(st, function(result, status) {
				  f = startcount;
				  console.log(f);
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			        startadd1 = coords.Ga;
			        startadd2 = coords.Ha;
			        console.log(startadd1,startadd2);
			        $('#a1'+f).val(startadd2);
			        $('#a2'+f).val(startadd1);
			    } 	     
			    startcount++;
			});
			 var end = end;
					var geocoder = new kakao.maps.services.Geocoder();
					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(end, function(result, status) {
						x = endcount;
						console.log(x);
					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {
					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					        endadd1 = coords.Ga;
					        endadd2 = coords.Ha;
					        $('#b1'+x).val(endadd2);
					        $('#b2'+x).val(endadd1);
					        console.log(endadd1,endadd2);
					    } 
					    endcount++;
					});   	
	 }
	 
	});
	
	function delivery(a,e,c){
		console.log(a,e,c);
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 9 // 지도의 확대 레벨
	    };
	 
	var add1 = a;
	var add2 = e;
	var map = new daum.maps.Map(mapContainer, mapOption); 

	var geocoder = new daum.maps.services.Geocoder();
	var listData = [
	    {add:add1,title:'배송도착지'}, 
	    {add:add2,title:'배송출발지'} 
	];
	var linePath = new Array();
	var a1,a2,b1,b2  = "";
	var bounds = new kakao.maps.LatLngBounds(); 
	listData.forEach(function(addr, index) {
	    geocoder.addressSearch(addr.add, function(result, status) {
	        if (status === daum.maps.services.Status.OK) {
	            var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	            linePath[index] = new daum.maps.LatLng(result[0].y, result[0].x);
	            if(index == 0){
	            	a1 = coords.Ha;
	            	a2 = coords.Ga;
/* 	            	$('#a1').val(a1);
	            	$('#a2').val(a2); */
	            } else if(index == 1){
	            	b1 = coords.Ha;
	            	b2 = coords.Ga;
/* 	            	$('#b1').val(b1);
	            	$('#b2').val(b2); */
	            }
	            
	            var marker = new daum.maps.Marker({
	                map: map,
	                position: coords
	            });
	             marker.setMap(map);
	            bounds.extend(coords);
	            var infowindow = new daum.maps.InfoWindow({
	                content: '<div style="width:150px;text-align:center;padding:6px 0;">' + listData[index].title + '</div>',
	                disableAutoPan: true
	            });
	            infowindow.open(map, marker);
	            map.setBounds(bounds);
	            /*  */      
	        } 
	    });
	});

	var startHa = $('#a1'+c).val();
	var startGa = $('#a2'+c).val();
	var endHa = $('#b1'+c).val();
	var endGa = $('#b2'+c).val();
	console.log(startHa,startGa,endHa,endGa);
	var polyline = new daum.maps.Polyline({
		 path : [
				new daum.maps.LatLng(endHa,endGa),
				new daum.maps.LatLng(startHa,startGa)
				], // 선을 구성하는 좌표배열 입니다
	    strokeWeight: 5, // 선의 두께 입니다
	    strokeColor: 'red', // 선의 색깔입니다
	    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid' // 선의 스타일입니다
	});

	polyline.setMap(map);
	var distance = polyline.getLength();
	console.log(distance);
	var content = getTimeHTML(distance);
	document.getElementById('distance').innerHTML = content;
	function getTimeHTML(distance) {

	    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
	    var walkkTime = distance / 67 | 0;
	    console.log(walkkTime);
	    var walkHour = '', walkMin = ''; walkday = '';

	    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
	    if (walkkTime > 60) {
	        walkday = '<span class="number">' +Math.floor((walkkTime / 60) / 24) + '</span>일'
	        temp = Math.floor((walkkTime / 60) / 24) *24;
	        walkHour = '<span class="number">' + Math.floor((walkkTime / 60)-temp) + '</span>시간 '
	    }
	    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

	    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
	    var bycicleTime = distance / 227 | 0;
	    var bycicleHour = '', bycicleMin = '';

	    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
	    if (bycicleTime > 60) {
	        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
	    }
	    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

	    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
	    var content = '<div style="margin-left:20px;">';
	    content += '	<img src="/lastproject/resources/img/배송이미지.png" alt="" style="width:550px; height: 200px; ">';
	    content += '    <div style="margin-top:20px;">';
	    content += '        <h4>총거리▼</h4> <h2 style="color:blue;">'+ Math.round(distance/1000) + 'km</h2><p style="magin:0;magrin-top:15px;">떨어진 거리에 상품이 있습니다.</p>';
	    content += '    </div>';
	    content += '    <div style="margin-top:20px">';
	    content += '       <h4>배송 소요 시간 ▼ <h2 style="color:blue;">' + walkday + walkHour +'</h2>뒤에상품이 도착합니다.</h4>';
	    content += '    </div>';
	    content += '	</div>'

	    return content;
	}
	$('#deliver').css('visibility','');
	}
	
	function salesOrder(no){
		var choice = confirm('상품을 발송하시겠습니까?');
		if(choice ==true){
		location.href="ProductSalesOrder?no="+no;
		}
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
				<li class="active">구매내역</li>
			</ul>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">구매내역 목록</h2>
				</div>
			</div>
			<div class="cont" style="padding:0 15px; width:100%;">
				<div class="contLeft" style=" ">
					<div >
                          <table class="table" id="table">
							    <tr>
								    <th style="width:10%;">날짜</th>
								    <th>상품정보</th>
								    <th style="width:20%;">상태</th>
								    <th style="width:10%;">확인/신청</th>
							    </tr>
							    <c:forEach var="result" items="${SalesbuyList }" varStatus="status">
								 <tr>
								    <td>
								    	<p style="margin:0;"><strong>${result.sys_date }</strong></p> 
								    	<button style="font-size: 12px;padding:0; ">주문내역삭제</button></td>
								   
								    <td>
								    <div style="width:20%;float:left; ">
								    	<img src="${pageContext.request.contextPath}/resources/fileupload/${result.photo1}" style="width:100px;">
								    </div>
								    <div style="width:80%;float:left; margin:0; ">
								    	<div style="border-bottom:1px dashed">
								    		<p style="margin:0;"><i class="fas fa-home" style="color:blue"></i>${result.saleid }</p>
								    		<p style="margin:0;"><strong>${result.trade_name }</strong></p>
								    		<p style="margin:0;">수량 : ${result.num }개</p>
								    	</div>
								    	<div style="margin-top:10px;">
								    		<p style="margin:0;">${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</p>
								    		<p style="margin:0;">배송요청사항 : ${result.request }</p>
								    		<p style="margin:0;"><strong><fmt:formatNumber value="${result.price}" pattern="#,###.##"/>원</strong></p>
								    	</div>
								    </div>
								    </td>
								    <td style="text-align:center;">
								    <c:if test="${result.result==1}">
								    	<h4>상품 준비중</h4>

								    </c:if>
								    <c:if test="${result.result==2}">
								    	<h4 style="color:blue">배송 시작</h4>
								    	<button style="font-size: 12px;padding:0; " onclick="delivery('${result.address}','${result.sales_address}','${status.count}')">배송추적</button>
								    </c:if>
								    <c:if test="${result.result==3}">
								    	<h4>배송완료</h4>
								    	<button style="font-size: 12px;padding:0; " >배송추적</button>
								    </c:if>
								    </td>
								    <td>
								    <c:if test="${result.result==1}">
								    	<button style="font-size: 12px;padding:0; " onclick="salesOrder('${result.orderno}')">상품 발송</button>
								    </c:if>
								    <c:if test="${result.result==2}">
								    	<button style="font-size: 12px;padding:0; ">리뷰 확인</button>
								    	<button style="font-size: 12px;padding:0; ">반품신청 확인</button>
								    </c:if>
								    <c:if test="${result.result==3}">
								   		<button style="font-size: 12px;">리뷰쓰기</button>
								    </c:if>
								    </td>
							    </tr>
								   	<input type="hidden" id="address1${status.count}" value="${result.address }">
							    	<input type="hidden" id="address2${status.count}" value="${result.sales_address }">	
							    	<input type="hidden" id="a1${status.count}">
									<input type="hidden" id="a2${status.count}">
									<input type="hidden" id="b1${status.count}">
									<input type="hidden" id="b2${status.count}">
							    </c:forEach>	
								    				    
						  </table>
						 <div style="width:100%; visibility:hidden;" id="deliver">
						 <div>
							<div class="section-title">
								<h2 class="title">배송현황</h2>
							</div>
						</div>   
						<div id="map" style="width:500px;height:400px;width:50%; float:left;"></div>
						<div id="distance" style="width:50%;float:right; color:black;" >
						</div>
						</div>
                    </div>
				</div>
			</div>
		
			<!-- 목록끄트ㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
			 
		</div>
	</div>
	<!-- FOOTER -->
	<div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->
</body>

</html>
