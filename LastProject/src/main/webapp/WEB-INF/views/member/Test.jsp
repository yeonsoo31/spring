<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<style>
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
</style>
<title>Insert title here</title>
</head>
<body>
	<input type="hidden" id="memberX">
	<input type="hidden" id="memberY">
	<h2>야호</h2>
	<button onclick="location.href='memberLoginForm'">로그인하러가기</button>
	<p style="margin-top:-12px">
    <em class="link">
        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
        </a>
    </em>
</p>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1e2514d587f99f465dafc1102f0bc859&libraries=services"></script>
<script>
$(document).ready(function(){
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 10 // 지도의 확대 레벨
};  

//지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder1 = new kakao.maps.services.Geocoder();
var geocoder2 = new kakao.maps.services.Geocoder();
var memberX, memberY, sellerX, sellerY;

//주소로 좌표를 검색합니다
geocoder1.addressSearch('${sessionScope.memberAddress}', function(result, status) {

// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);
    memberX = result[0].y;
    memberY = result[0].x;
   

    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords1
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">배송지</div>'
    });
    infowindow.open(map, marker);

    // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
    map.setCenter(coords1);
} document.getElementById("memberX").value = memberX;
document.getElementById("memberY").value = memberY; 
});
geocoder2.addressSearch('서울 강동구 암사길 1', function(result, status) {

// 정상적으로 검색이 완료됐으면 
 if (status === kakao.maps.services.Status.OK) {

    var coords2 = new kakao.maps.LatLng(result[0].y, result[0].x);
	sellerX = result[0].y;
	sellerY = result[0].x;
	
	
    // 결과값으로 받은 위치를 마커로 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: coords2
    });

    // 인포윈도우로 장소에 대한 설명을 표시합니다
    var infowindow = new kakao.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:6px 0;">판매회사</div>'
    });
    infowindow.open(map, marker);
    memberX = document.getElementById("memberX").value;
	memberY = document.getElementById("memberY").value;
    var linePath = [
		new kakao.maps.LatLng(memberX, memberY),
		new kakao.maps.LatLng(sellerX, sellerY)
	];
	var Polyline = new kakao.maps.Polyline({
        map: map, // 선을 표시할 지도입니다 
        path: linePath, // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
        strokeWeight: 3, // 선의 두께입니다 
        strokeColor: '#db4040', // 선의 색깔입니다
        strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: 'solid' // 선의 스타일입니다
    });
	
	Polyline.setMap(map);
	var memberXY = new kakao.maps.LatLng(memberX, memberY);
	var sellerXY = new kakao.maps.LatLng(sellerX, sellerY);
	var memberLine =  new kakao.maps.Polyline({
	    map: map, // 선을 표시할 지도입니다 
	    path: memberXY, // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	    strokeWeight: 3, // 선의 두께입니다 
	    strokeColor: '#db4040', // 선의 색깔입니다
	    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid' // 선의 스타일입니다
	});
	var sellerLine =  new kakao.maps.Polyline({
	    map: map, // 선을 표시할 지도입니다 
	    path: sellerXY, // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
	    strokeWeight: 3, // 선의 두께입니다 
	    strokeColor: '#db4040', // 선의 색깔입니다
	    strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid' // 선의 스타일입니다
	});
	
	
	var distance = Math.round(memberLine.getLength() + sellerLine.getLength()), // 선의 총 거리를 계산합니다
    content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
// 거리정보를 지도에 표시합니다
showDistance(content);  
} 
});
});
</script>

</body>
</html>