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
	<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>	
<script type="text/javascript">
// Add contents for max height
function productPrice(categoryno){
	location.href="ProductPriceList?categoryno="+categoryno;
}
function productHit(categoryno){
	location.href="ProductHitList?categoryno="+categoryno;
}
function comma(num){
	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  }
	  
$(document).ready(function () {
	var page=1;
	$(document).scroll(function() {
	maxHeight = $(document).height();
	currentScroll = $(window).scrollTop() + $(window).height();
	if (maxHeight <= currentScroll) {
	console.log("yes");
	var categoryno = $('#categoryno').val();
	console.log(categoryno);
	page++;
	console.log(page);
	 $.ajax({
	 		url:'PriceScrollPage',
	 		type:'get',
	 		data:{page:page,
	 			  categoryno:categoryno},
	 		success:function(result){
	 			console.log(result);
	 			$.each(result, function(i, item){
	 				console.log(item.trade_name);
	 				var price = comma(item.price);
	 				var content = "<div class='col-md-3 col-sm-6 col-xs-6' style='height: 460px;'>";
	 				content += "<div class='product product-single'>";
	 				content += "<div class='product-thumb'>";
					content += "<button class='main-btn quick-view' onclick="+"location.href='"+"productView?number="+item.productno+"'"+"><i class='fa fa-search-plus'></i> 상세보기</button>"
	 				content += "<img src='${pageContext.request.contextPath}/resources/fileupload/"+item.photo1+"'+style='width:270px; height: 270px;'>";
 		 			content += "</div>";
		 			content += "<div class='product-body'>";
			 		content += "<h3 class='product-price'>"+price+"원</h3>";
				 	content += "<h2 class='product-name'><a href='#'>"+item.trade_name+"</a></h2>";
				 	content += "<h5 style='color:#999'>조회수 : "+item.hit+"</h5>";
					content += "<div class='product-btns'>";
					content += "<button class='main-btn icon-btn'><i class='fa fa-heart'></i></button>";
					content += "<button class='main-btn icon-btn'><i class='fa fa-exchange'></i></button>";
					content += "<button class='primary-btn add-to-cart'><i class='fa fa-shopping-cart'></i> 장바구니 담기</button>";
					content += "</div>";
					content += "</div>";
					content += "</div>";
					content += "</div>";							
	 				console.log(content);
	 				$('#contend').append(content);
	 			})
	 			}
	 	});

	}
	});
	
	})
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
				<li><a href="#">일반 상품</a></li>
				<li class="active">일반상품(카테고리별)</li>
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
						<h2 class="title">상품 목록</h2>
						<c:if test="${sessionScope.loginIdDivision eq 2}">
						<button class="primary-btn" onclick="productpage()" style="margin-left: 5px;float: right;">글쓰기</button>
						</c:if>
						<c:if test="${sessionScope.loginIdDivision eq 1}">
						<button class="primary-btn" onclick="productPrice('${categoryno }')" style="margin-left: 5px;float: right;">가격순 정렬</button>
						<button class="primary-btn" onclick="productHit('${categoryno }')" style="float:right;">조회순정렬</button>
						</c:if>
						<input type="hidden" value=${categoryno } id="categoryno">
					</div>
				</div>
				<!-- section title -->
				<!-- Product Single -->
				<div id="contend">
				<c:forEach var="productBuy" items="${productList}">
				<div class="col-md-3 col-sm-6 col-xs-6" style=" height: 460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='productView?number=${productBuy.productno}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${pageContext.request.contextPath}/resources/fileupload/${productBuy.photo1}" alt="" style="width:270px; height: 270px;">
						</div>
						<div class="product-body">
							<h3 class="product-price"><fmt:formatNumber value="${productBuy.price}" pattern="#,###.##"/>원</h3>
							<h2 class="product-name"><a href="#">${productBuy.trade_name}</a></h2>
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
				</div>
			</div>
	</div>
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
