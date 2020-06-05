<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/layer-pop.css">
	<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote-lite.css">
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	
	<script>
		function accept(index){
			var f_id = document.getElementById("f_id"+index).value;
			var id = "${sessionScope.loginId}";
			$.ajax({
				type:"post",
				url:"requestAccept",
				data:{"id":id,
					  "f_id":f_id},
				dataType:"json",
				success:function(result){
					$(".requestList"+index).fadeOut(600);
				},
				error:function(){
					console.log("통오");
				}
			});
			
		}
		
		function reject(index){
			var f_id = document.getElementById("f_id"+index).value;
			var id="${sessionScope.loginId}";
			$.ajax({
				type:"post",
				url:"requestReject",
				data:{"id":id,
					  "f_id":f_id},
				dataType:"json",
				success:function(result){
					$(".requestList"+index).fadeOut(600);
				},
				error:function(){
					console.log("통오");
				}
			});
		}
	</script>
</head>
<body>
	
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	
	<div class="snsLine"></div>
	<div class="category-nav" style="width:330px; height:600px; margin-top:10px;">
		<div id="quick_menu" style="position: absolute;">
		<a href=""><span style="width:330px;" class="category-header"><img style="border: 3px solid gold; border-radius: 50%; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/${member.profile}">${member.name}</span></a>
			<div class="left-menu-ch">
				<ul  class="category-list" style="width:330px;">
					<li><input class="fas" style="width:270px; height:40px; border:0;" type="text" id="search" name="search" placeholder="&#xf002;검색">
					<span><button style="width:50px; height:40px;border:0;" onclick="goSearch()">검색</button></span></li>
					<li style="text-align:center;"><a href="snsFriendList">친구 리스트</a></li>
					<li style="text-align:center;"><a href="snsMessenger">Messenger</a></li>
					<li style="text-align:center;"><a href="">최신글</a></li>
					<li style="text-align:center;"><a href="friendRequest">친구 요청</a><p style="background-color:red;">${friendRequestCount}</p></li>
				</ul>
			</div>
			</div>

	</div>

	<div style="background-color:lightgray; height:100%;">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="snsline"></div>
				<div class="snsLine"></div>
				<div class="requestList">
				<c:choose>
				<c:when test="${fn:length(requestList) != 0}">
				<c:forEach var="requestList" items="${requestList }" varStatus="status">
				<div class="requestList${status.index}">
				<input type="hidden" id="f_id${status.index }" value="${requestList.f_id }">
				<div class="col-md-6" style="background-color:white; border-right:20px lightgray solid; border-bottom:10px lightgray solid">
					<div class="col-md-1">
						<img width="80px" height="100px" src="${pageContext.request.contextPath}/resources/profilepic/${requestList.f_profile}">
					</div>
					<div class="col-md-8 col-md-offset-1">
					<div class="col-md-12" style="background-color:white; height:35px;"></div>
						<h3>${requestList.f_name }</h3>
					</div>
					<div class="col-md-2">
					<div class="col-md-12" style="background-color:white; height:25px;"></div>
						<button onclick="accept(${status.index})">수락</button><button onclick="reject(${status.index})">거절</button>
					</div>
				</div>
				</div>
				</c:forEach>
				</c:when>
				<c:otherwise>
					<div class="col-md-12">
						<div class="col-md-4 col-md-offset-5">
							<h3>친구 요청이 없습니다.</h3>
						</div>
					</div>
				</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
	</div>
	
</div>
</body>

	<script type="text/javascript">
    (function($){
     var quick_menu = $('#quick_menu'); // 퀵매뉴의 id명
     var quick_top = 230; // 위에서부터 떨어져야 되는 거리
     var quick_left= -870; // 중앙에서 떨어져야 되는 거리
     var quick_speed = 500; // 이동속도
     $(document).ready(function(){
         quick_menu.css('top', quick_top + "px");
         quick_menu.css('left', (document.body.clientWidth / 2) + quick_left + "px" );
         quick_menu.css('display', '');
     
         $(window).resize(function(){
             quick_menu.css('left', (document.body.clientWidth / 2) + quick_left + "px" );
         });
     
         $(window).scroll(function(){
             quick_menu.stop();
             quick_menu.animate( { "top": $(document).scrollTop() + quick_top + "px" }, quick_speed );
         });
     });
    })(jQuery); 

    var slideIndex = 0;
    showSlides();

    function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {slideIndex = 1}    
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 2000); // Change image every 2 seconds
    }
     </script>
</html>