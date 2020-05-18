<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%> 
<% response.setContentType("text/html; charset=UTF-8");%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
<title>Insert title here</title>

 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>	
 <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<!-- Place favicon.ico in the root directory -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/images/favicon.ico">
    <link rel="apple-touch-icon" href="apple-touch-icon.png">
    <!-- All css files are included here. -->
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
</head>
<script>

 function SelectOption(){

 	 var SelectValue = $('#productChoice option:selected').text();
	 console.log(SelectValue);  
	 $('#productVal').html(SelectValue);
	 var number = $('#productChoice').val();
	 console.log(number);
	 $.ajax({
 		url:'ProductPriceAjax',
 		type:'get',
 		data:{number:number},
 		success:function(result){
 			console.log(result);
 			var price = comma(result);
 			console.log(price);
 			$('#productInfo').show();
 			$('#productPrice').html(price);
 			}
 	});
      };
 
      function comma(num){
    	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    	  }
      
      function change(num){
    	  var x = document.form;
    	  var y = Number(count.value)+num;
    	  if(y < 1) y = 1 ;
    	  x.count.value = y;
    	  }
      function countPlus(){
    		var cur = document.getElementById("payValue").value;
    		cur++;
    		document.getElementById("payValue").value = cur
    		var number = cur;
    		var commaPrice = $('#productPrice').html();
    		var price = removeComma(commaPrice);
    			 $.ajax({
    				url:'PricePlusAjax',
    				type:'get',
    				data:{number:number,
    					  price:price},
    				success:function(result){
    					var PlusPrice = comma(result);
    					$('#productPrice').html(PlusPrice);
    					}
    			}); 
    	}
    	function countMinus(){
    		var cur = document.getElementById("payValue").value;
    		if(cur<=1){
    			alert('수량은 1개 이상이여야합니다.');
    		}else{
    		cur--;
    		document.getElementById("payValue").value = cur
    		var number = cur;
    		var commaPrice = $('#productPrice').html();
    		console.log(commaPrice);
    		var price = removeComma(commaPrice);
    			$.ajax({
    				url:'PriceMinusAjax',
    				type:'get',
    				data:{number:number,
    					  price:price},
    				success:function(result){
    					console.log(result);
    					var MinusPrice =comma(result);
    					$('#productPrice').html(MinusPrice);
    					}
    			});
    		}
    	}
    	
    	function removeComma(str)
    	{
    		n = parseInt(str.replace(/,/g,""));
    		return n;
    	}

    	function off(){
    		document.getElementById("overlay").style.display = "none";
    		$('#all-background-color').hide();
    	}
    	function on(){
    		var listno = $('#productChoice').val();
    		var productno = ${product.productno};
    		var cur = $('#payValue').val();
    		console.log(listno, productno, cur);
     		$.ajax({
     	    		url:'CartInsert',
     	    		type:'get',
     	    		data:{listno:listno,
     	    			  productno:productno,	
     	    			  cur:cur},
     	    		success:function(result){
     	    			console.log(result);
     	       		$('#overlay').show();
     	    		$('#all-background-color').show();
     	    			}
     	    	});
    	}
    	function BasketList(){
    		location.href="CartView";
    	}
    	
    	function deleteCheck(no){
    		var confirmCheck = confirm("해당 게시글을 삭제하시겠습니까?")
    		if(confirmCheck  ==true){
    			location.href="productDelete?productno="+no;
    		}
    	}
</script>
<body >
<div class="all-background-color" id="all-background-color">
</div>
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
</div>
<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">현재 페이지 목록(대메뉴)</a></li>
				<li class="active">현재 페이지 목록(소메뉴)</li>
				<button class="primary-btn" onclick="location.href='productModifyForm?productno=${product.productno}'">수정하기</button>
				<button class="primary-btn" onclick="deleteCheck(${product.productno})" >삭제하기</button>
			</ul>
		</div>
	</div>
        <div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!--  Product Details -->
				<div class="product product-details clearfix">
					<div class="col-md-6" style="width:120%;">
						<div id="product-main-view" class="slick-initialized slick-slider" style="width:600px;float:left;">
							<div class="slick-list draggable">
								<div class="slick-track" style="opacity: 1; width: 2220px;">
									<img src="${pageContext.request.contextPath}/resources/fileupload/${product.photo2}" alt="" style="width:600px;height:500px;"> 
								</div>
							</div>
					</div>
					<div class="col-md-6" style="float:left;">
						<div class="product-body">
							<div class="product-label">
								<span>New</span>
							</div>
							<h2 class="product-name">${product.trade_name }</h2>
							<h3 class="product-price">${product.price }원  <del class="product-old-price">59,000원</del></h3>
							<p><strong>Brand:</strong> 현대백화점</p>
							<strong>제품설명 :</strong>
							<p>${product.explanation}</p>
							<div class="col-md-12" style="margin-top:30px; padding:0;">
							<h2 class="product-name">옵션 선택 </h2>
								<select class="input search-categories" style="height:50px; width:100%;" name="categoryno" id="productChoice" onChange="SelectOption(this)">
                  					<option value="" >옵션 선택</option>
									  <c:forEach var="result" items="${productList }">
									<option value="${result.listno }" data-sub="${result.option1 }">${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</option>
										</c:forEach>
								</select>
							</div>
							<div class="product-btns" style="margin-top:180px; ">
								<div id="productInfo" style="border:1px ;height:120px; display:none; background-color:#EEEEEE;">
									<div class="qty-input" style="margin-top: 17px;">
										<h4><span id="productVal" style="margin-top:10px;"></span></h4>
										<span class="text-uppercase">수량 : </span>										
										<input  class="input" type="text" name="count" value="1" id ="payValue">
										<a href="#" onclick="countPlus()" id="plus"> ▲ </a>
										<a href="#" onclick="countMinus()" id="minus"> ▼ </a>
									</div>
									<div class="pull-right" style="width:170px;margin-top:17px;" >
										<h2><strong >상품 가격 </strong></h2>
										<h2><span id="productPrice"> </span>원</h2>
									</div>
								</div>
							</div>
							<div class="product-btns" style="margin-top:20px;">
							<button class="primary-btn" style="width:49%;" onclick="on()"> 장바구니 </button>
							<button class="primary-btn" style="width:49%;"> 구매하기 </button>
							</div>
							<div id="overlay" style="display:none;" >
								 <div class="popup-layout" onclick="off()" >
									 <img src="${pageContext.request.contextPath}/resources/img/basketimg.JPG" style="width: 20%;height: 20%;margin-top: 50px;">
									 <p class="popup-font">장바구니에 상품을 담았습니다.</p>
									 <button class="primary-btn"onclick="off()" >
										<em >계속 쇼핑하기</em >
									 </button>
									 <button class="primary-btn" onclick="BasketList()">
										<em>장바구니로 이동</em>
									 </button>
								 </div>
							 </div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">제품설명</a></li>
								<li><a data-toggle="tab" href="#tab2">리뷰</a></li>
								<li><a data-toggle="tab" href="#tab3">문의사항</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active">
									<div class="section-title">
										<h2 class="title">제품 설명 이미지</h2>
									</div>
									<img src="${pageContext.request.contextPath}/resources/fileupload/${product.photo3}" alt="" style="width:auto;height:auto;margin-left: auto; margin-right: auto; display: block; ">
								</div>
								<div id="tab2" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-6">
											<div class="product-reviews">
											
											<!-- 리뷰 댓글 표출 영역 -->
												<div class="single-review">
													<div class="review-heading">
														<div><a ><i class="fa fa-user-o"></i> John</a></div>
														<div><a ><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>
											<!-- 리뷰 댓글 표출 영역 끝 -->	
												
												<ul class="reviews-pages">
													<li class="active">1</li>
													<li><a href="#">2</a></li>
													<li><a href="#">3</a></li>
													<li><a href="#"><i class="fa fa-caret-right"></i></a></li>
												</ul>
											</div>
										</div>
										<div class="col-md-6">
											<h4 class="text-uppercase">리뷰작성</h4>
											<form class="review-form">
												<div class="form-group">
													작성자 <input class="input" type="text" placeholder="Your Name" value="${userid }" readonly>
												</div>
												<div class="form-group">
													리뷰작성 <textarea class="input" placeholder="리뷰를 작성해주세요."></textarea>
												</div>
												<div class="form-group">
													<div class="input-rating">
														<strong class="text-uppercase">Your Rating: </strong>
														<div class="stars">
															<input type="radio" id="star5" name="rating" value="5"><label for="star5"></label>
															<input type="radio" id="star4" name="rating" value="4"><label for="star4"></label>
															<input type="radio" id="star3" name="rating" value="3"><label for="star3"></label>
															<input type="radio" id="star2" name="rating" value="2"><label for="star2"></label>
															<input type="radio" id="star1" name="rating" value="1"><label for="star1"></label>
														</div>
													</div>
												</div>
												<button class="primary-btn">Submit</button>
											</form>
										</div>
									</div>
								</div>
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								
								<div id="tab3" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-6">
											<div class="product-reviews">
												<div class="single-review">
													<div class="review-heading">
														<div><a href="#"><i class="fa fa-user-o"></i> John</a></div>
														<div><a href="#"><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>

												<div class="single-review">
													<div class="review-heading">
														<div><a href="#"><i class="fa fa-user-o"></i> John</a></div>
														<div><a href="#"><i class="fa fa-clock-o"></i> 27 DEC 2017 / 8:0 PM</a></div>
														<div class="review-rating pull-right">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</div>
													</div>
													<div class="review-body">
														<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Duis aute
															irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
													</div>
												</div>

												<ul class="reviews-pages">
													<li class="active">1</li>
													<li><a href="#">2</a></li>
													<li><a href="#">3</a></li>
													<li><a href="#"><i class="fa fa-caret-right"></i></a></li>
												</ul>
											</div>
										</div>
										<div class="col-md-6">
											<h4 class="text-uppercase">Write Your Review</h4>
											<p>Your email address will not be published.</p>
											<form class="review-form" action="Review" >
												<div class="form-group">
													<input class="input" type="text" placeholder="Your Name">
												</div>
												<div class="form-group">
													<input class="input" type="email" placeholder="Email Address">
												</div>
												<div class="form-group">
													<textarea class="input" placeholder="Your review"></textarea>
												</div>
												<div class="form-group">
													<div class="input-rating">
														<strong class="text-uppercase">리뷰 별점: </strong>
														<div class="stars">
															<input type="radio" id="star5" name="rating" value="5"><label for="star5"></label>
															<input type="radio" id="star4" name="rating" value="4"><label for="star4"></label>
															<input type="radio" id="star3" name="rating" value="3"><label for="star3"></label>
															<input type="radio" id="star2" name="rating" value="2"><label for="star2"></label>
															<input type="radio" id="star1" name="rating" value="1"><label for="star1"></label>
														</div>
													</div>
												</div>
												<button class="primary-btn">Submit</button>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- /Product Details -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
</div>
<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->
</body>

</html>

