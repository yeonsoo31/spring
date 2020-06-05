<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%> 
<% response.setContentType("text/html; charset=UTF-8");%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>
<!DOCTYPE html>
<html>
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
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>	
<script>
function productpage(){
	 location.href="product";
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
				<li><a>일반상품</a></li>
				<li class="active">일반상품(전체 카테고리)</li>
			</ul>
		</div>
	</div>
	<!-- 가운데 영역 -->
	<div class="category-nav" style="width:330px; margin-top:10px;">
		<span class="category-header">전체 카테고리<i class="fa fa-list"></i></span>
			<div class="left-menu-ch">
				<ul  class="category-list" style="width:330px;">
					<li><a href="ProductScroll?categoryno=1">패션 / 의류</a></li>
					<li><a href="ProductScroll?categoryno=2">전자기기 / 전자제품</a></li>
					<li><a href="ProductScroll?categoryno=3">식품 / 생필품</a></li>
					<li><a href="#">스포츠  / 건강</a></li>
					<li><a href="#">자동차 / 공구</a></li>
					<li><a href="#">컴퓨터 / 디지털</a></li>
					<li><a href="#">렌탈 / 도서</a></li>
				</ul>
			</div>
	</div>
<div class="container">
				<div class="row">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">전체 상품 목록</h3>
						<c:if test="${sessionScope.loginIdDivision eq 2}">
						<button class="primary-btn" onclick="productpage()" style="margin-left: 5px;float: right;">글쓰기</button>
						</c:if>
					</div>
				</div>
				<!-- section title -->
				<!-- Product Single -->
				<c:forEach var="productBuy" items="${productList}">
				<div class="col-md-3 col-sm-6 col-xs-6" style="height:460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='productView?number=${productBuy.productno}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${pageContext.request.contextPath}/resources/fileupload/${productBuy.photo1}" alt="" style="width:260px; height: 270px;">
						</div>
						<div class="product-body">
							<h3 class="product-price"><fmt:formatNumber value="${productBuy.price}" pattern="#,###.##"/>원</h3>
							<h2 class="product-name"><a>${productBuy.trade_name}</a></h2>
							<h5 style="color:#999">조회수 : ${productBuy.hit }</h5>
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i> 장바구니 담기</button>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">식품 목록</h3>
					</div>
				</div>
				<!-- section title -->
				<!-- Product Single -->
				<c:forEach var="productBuy3" items="${productList3}">
				<div class="col-md-3 col-sm-6 col-xs-6" style="height:460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='productView?number=${productBuy3.productno}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${pageContext.request.contextPath}/resources/fileupload/${productBuy3.photo1}" alt="" style="width:260px; height: 270px;">
						</div>
						<div class="product-body">
							<h3 class="product-price"><fmt:formatNumber value="${productBuy3.price}" pattern="#,###.##"/>원</h3>
							<h2 class="product-name"><a>${productBuy3.trade_name}</a></h2>
							<h5 style="color:#999">조회수 : ${productBuy3.hit }</h5>
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i> 장바구니 담기</button>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<!-- 가전제품 -->
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">전자제품 목록</h3>
					</div>
				</div>
				<!-- section title -->
				<!-- Product Single -->
				<c:forEach var="productBuy2" items="${productList2}">
				<div class="col-md-3 col-sm-6 col-xs-6" style="height:460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='productView?number=${productBuy2.productno}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${pageContext.request.contextPath}/resources/fileupload/${productBuy2.photo1}" alt="" style="width:260px; height: 270px;">
						</div>
						<div class="product-body">
							<h3 class="product-price"><fmt:formatNumber value="${productBuy2.price}" pattern="#,###.##"/>원</h3>
							<h2 class="product-name"><a>${productBuy2.trade_name}</a></h2>
							<h5 style="color:#999">조회수 : ${productBuy2.hit }</h5>
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i> 장바구니 담기</button>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
				
				<!--  의류상품 -->
				<div class="col-md-12">
					<div class="section-title">
						<h3 class="title">의류제품 목록</h3>
					</div>
				</div>
				<c:forEach var="productBuy1" items="${productList1}">
				<div class="col-md-3 col-sm-6 col-xs-6" style="height:460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='productView?number=${productBuy1.productno}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${pageContext.request.contextPath}/resources/fileupload/${productBuy1.photo1}" alt="" style="width:260px; height: 270px;">
						</div>
						<div class="product-body">
							<h3 class="product-price"><fmt:formatNumber value="${productBuy1.price}" pattern="#,###.##"/>원</h3>
							<h2 class="product-name"><a>${productBuy1.trade_name}</a></h2>
							<h5 style="color:#999">조회수 : ${productBuy1.hit }</h5>
							<div class="product-btns">
								<button class="main-btn icon-btn"><i class="fa fa-heart"></i></button>
								<button class="main-btn icon-btn"><i class="fa fa-exchange"></i></button>
								<button class="primary-btn add-to-cart"><i class="fa fa-shopping-cart"></i> 장바구니 담기</button>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
	</div>
	
	<!-- 퀵메뉴 -->		
	<div>
		<jsp:include page="/WEB-INF/views/quick.jsp"></jsp:include>
	</div>	
	
	<!-- FOOTER -->
	<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->



</body>

</html>
