<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
	<script src="${pageContext.request.contextPath}/resources/js/summernote-lite.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote-lite.css">
	
	<script>
	$(document).ready(function(){
		$('#summernote').summernote({
			height: 300,
			width : 1000,
			minHeight: null,
			maxHeight: null,
			focus: true,
			lang: "ko-KR",
			callback: {
					onImageUpload : function(files){
						uploadSummernoteImageFile(files[0],this);
					}
			}
		});
		$("#input_img2").on("change", handleImgFileSelect);
	});
		
		function uploadSummernoteImageFile(file, editor){
			data = new FormData();
			data.append("file", file);
			$.ajax({
					data : data,
					type : "POST",
					url : "uploadSummernoteImageFile",
					contentType : false,
					processData : false,
					success : function(data){
						$(editor).summernote('insertImage', data.url);
					}
			});
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
							<img style="width:200px;height:200px;" src="${pageContext.request.contextPath}/resources/img/aaaa1234.png" alt="">
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
						<li class="header-account dropdown default-dropdown">
							<div class="dropdown-toggle" role="button" data-toggle="dropdown" aria-expanded="true">
								<div class="header-btns-icon">
									<i class="fa fa-user-o"></i>
								</div>
								<strong class="text-uppercase">내 정보 <i class="fa fa-caret-down"></i></strong>
							</div>
							<a href="#" class="text-uppercase">로그인</a> / <a href="#" class="text-uppercase">회원가입</a>
							<ul class="custom-menu">
								<li><a href="#"><i class="fa fa-user-o"></i> 마이페이지</a></li>
								<li><a href="#"><i class="fa fa-heart-o"></i> 장바구니</a></li>
								<li><a href="#"><i class="fa fa-exchange"></i> 최근본상품</a></li>
								<li><a href="#"><i class="fa fa-check"></i> 로그아웃</a></li>
								<li><a href="#"><i class="fa fa-unlock-alt"></i> 로그인</a></li>
							</ul>
						</li>
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
	<div class="container">
		<div class="row">
			<div>
				<h1>
		경매상품수정
	</h1>
	<div class="auctionForm" id="fileDrop">
	<form action="auctionModify" method="post" enctype="multipart/form-data">
	<input type="hidden" value="${auction.a_number}" name="a_number">
	<input type="hidden" value="${auction.a_photo}" name="a_photo5">
	<c:if test="${auction.a_photo1 ne null}">
		<input type="hidden" value="${auction.a_photo1}" name="a_photo6">
	</c:if>
	<c:if test="${auction.a_photo2 ne null}">
		<input type="hidden" value="${auction.a_photo2}" name="a_photo7">
	</c:if>
	
	
	<table border='1'>
		<tr>
			<td>작성자</td>
			<td colspan="3"><input type="text" name="id" value="${auction.id}" readonly></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td colspan="3"><input type="text" name="a_name" style="width:1000px" value="${auction.a_name }"></td>
		</tr>
<!-- 		<tr>
			<td>경매기간</td>
			<td>
				<input type="radio" name="a_date" value="5/(24*60)">5분
				<input type="radio" name="a_date" value="12/24">12시간
				<input type="radio" name="a_date" value="1">1일
				<input type="radio" name="a_date" value="2">2일
				<input type="radio" name="a_date" value="3">3일
			</td>
		</tr> 
		<tr>
			<td>시작가격</td>
			<td><input type="text" name="a_price" value="${auction.a_price }">
		</tr> -->
		<tr>
			<td>상세내용</td>
			<td colspan="3"><textarea name="a_information" id="summernote">${auction.a_information}</textarea></td>
		</tr>
		<tr>
			<td>메인 이미지 미리보기</td>
			<td width="200"><img id="img" width="200px" height="200px" src="${pageContext.request.contextPath}/resources/fileupload/${auction.a_photo}" alt=""></td>
			<td width="150">상세 이미지 미리보기</td>
			<td id="img_wrap" width="400">
				<img id="img2" width="200px" height="200px" src="${pageContext.request.contextPath}/resources/fileupload/${auction.a_photo1}" alt="">
				<img width="200px" height="200px" src="${pageContext.request.contextPath}/resources/fileupload/${auction.a_photo2}" alt="">
			</td> 
		</tr>
		<tr>
			<td>메인이미지</td>
			<td colspan="3"><input type="file" name="a_photo3" id="input_img"></td>
		</tr>
		<tr>
			<td>상세이미지</td>
			<td colspan="3"><input multiple="multiple" type="file" name="a_photo4" id="input_img2"></td>
		</tr>
	</table>	
	<input type="submit" value="등록">
	</form>
	</div>
			</div>
		</div>
	</div>
	<!-- FOOTER -->
	<footer id="footer" class="section section-grey">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!-- footer widget -->
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<!-- footer logo -->
						<div class="footer-logo">
							<a class="logo" href="#">
		            <img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
		          </a>
						</div>
						<!-- /footer logo -->
						<!-- footer social -->
						<ul class="footer-social">
							<li><a href="#"><i class="fa fa-facebook"></i></a></li>
							<li><a href="#"><i class="fa fa-twitter"></i></a></li>
							<li><a href="#"><i class="fa fa-instagram"></i></a></li>
							<li><a href="#"><i class="fa fa-google-plus"></i></a></li>
							<li><a href="#"><i class="fa fa-pinterest"></i></a></li>
						</ul>
						<!-- /footer social -->
					</div>
				</div>
				<!-- /footer widget -->

				<!-- footer widget -->
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">My Account</h3>
						<ul class="list-links">
							<li><a href="#">My Account</a></li>
							<li><a href="#">My Wishlist</a></li>
							<li><a href="#">Compare</a></li>
							<li><a href="#">Checkout</a></li>
							<li><a href="#">Login</a></li>
						</ul>
					</div>
				</div>
				<!-- /footer widget -->

				<div class="clearfix visible-sm visible-xs"></div>

				<!-- footer widget -->
				<div class="col-md-3 col-sm-6 col-xs-6">
					<div class="footer">
						<h3 class="footer-header">Customer Service</h3>
						<ul class="list-links">
							<li><a href="#">About Us</a></li>
							<li><a href="#">Shiping & Return</a></li>
							<li><a href="#">Shiping Guide</a></li>
							<li><a href="#">FAQ</a></li>
						</ul>
					</div>
				</div>
				<!-- /footer widget -->
			</div>
			<!-- /row -->
			<hr>
			<!-- row -->
			<div class="row">
				<div class="col-md-8 col-md-offset-2 text-center">
					<!-- footer copyright -->
					<div class="footer-copyright">
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
						Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="fa fa-heart-o" aria-hidden="true"></i> by <a href="https://colorlib.com" target="_blank">Colorlib</a>
						<!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
					</div>
					<!-- /footer copyright -->
				</div>
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</footer>
	<!-- /FOOTER -->
	
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/slick.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/nouislider.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery.zoom.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
	
</body>
	<script>
	function readURL(input){
		if(input.files && input.files[0]){
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src",e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	$("#input_img").change(function(){
		readURL(this);
	});
	
	var sel_files= [];
	
	function handleImgFileSelect(e){
		sel_files = [];
		$("#img_wrap").empty();
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		filesArr.forEach(function(f){
			if(!f.type.match("image.*")){
				alert("이미지확장자만");
				return;
			}
			sel_files.push(f);
			
			var reader = new FileReader();
			reader.onload = function(e){
				var html = "<img width='200' height='200' src=\""+e.target.result+"\"/>";
				$("#img_wrap").append(html);
				
			}
			reader.readAsDataURL(f);
		});
	}
	</script>

</html>