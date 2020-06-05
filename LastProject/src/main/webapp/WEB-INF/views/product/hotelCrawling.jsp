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
	 		url:'ScrollPage',
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
	 				content += "<img src='${pageContext.request.contextPath}/resources/fileupload/"+item.photo1+"'+style='width:260px; height: 270px;'>";
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
				<li><a href="#">호텔</a></li>
				<li class="active">호텔(크롤링)</li>
			</ul>
		</div>
	</div>
	<!-- 가운데 영역 -->
<div class="container">
				<div class="row">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h2 class="title">호텔/숙소 목록</h2>
					</div>
				</div>
				<!-- section title -->
				<!-- Product Single -->
				<div id="contend">
				<c:forEach var="list" items="${list}" varStatus="status">
				<div class="col-md-3 col-sm-6 col-xs-6" style=" height: 460px;">
					<div class="product product-single">
						<div class="product-thumb" >
							<button class="main-btn quick-view" onclick="location.href='${list.link}'"><i class="fa fa-search-plus"></i> 상세보기</button>
							<img src="${list.src}"alt="" style="width:270px; height: 270px;">
						</div>
						<div class="product-body">
							<h4 class="product-price"><a href="#">${list.price}</a></h4>
							<h5 class="product-name"><a href="#">${list.text}</a></h5>
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
