<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 퀵메뉴 -->
	<div id="quick_menu" style="position: absolute;">
		<div class="quick-icon" style="border-top: 1px solid #d5d5d5; width:100px; height:80px;">
			<a href="#" class="quick-m">
			<img src="${pageContext.request.contextPath}/resources/img/sangfum.svg" width="40px" height="40px"> <br> 최근본상품</a><br>
		</div>
		<div class="quick-icon" style="border-top: 1px solid #d5d5d5; width:100px; height:80px;">
			<a href="CartView" class="quick-m"><img src="${pageContext.request.contextPath}/resources/img/baguni.png" 
			width="40px" height="40px"> <br> 장바구니</a>
		</div>
		<div class="quick-icon" style="border-top: 1px solid #d5d5d5; width:100px; height:80px;">
			<a href="" class="quick-m"><img src="${pageContext.request.contextPath}/resources/img/serach.png"
				width="40px" height="40px">
				<input type="text" class="search" style="width: 60px; height: 20px; margin-top:6px;"> </a>
		</div>
		<div class="quick-icon-top" style="border-top: 1px solid #d5d5d5; width:100px; height:35px;">
			<a href="#" class="quick-top">TOP</a>
		</div>
	</div>

</body>
    <script ttopype="ttopext/javascript" src="http://code.jquery.com/jquery-1.4.2.min.js"></script>

    <script type="text/javascript">
    (function($){
     var quick_menu = $('#quick_menu'); // 퀵매뉴의 id명
     var quick_top = 230; // 위에서부터 떨어져야 되는 거리
     var quick_left= 670; // 중앙에서 떨어져야 되는 거리
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