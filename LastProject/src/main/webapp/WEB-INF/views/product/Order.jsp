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
<script>
function productpage(){
	 location.href="product"
};
function ProductView(no){
	var number = no;
	console.log(number);
	location.href="productView?number=number";
}

function comma(num){
	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  }

function change(num){
	  var x = document.form;
	  var y = Number(count.value)+num;
	  if(y < 1) y = 1 ;
	  x.count.value = y;
	  }
function countPlus(e){
		var commaPrice = $('#productPrice'+e).html();
		var price = removeComma(commaPrice);
		var cur = document.getElementById("payValue"+e).value;
		price = price/cur;
		console.log(price);
		cur++;
		document.getElementById("payValue"+e).value = cur;
		var ww = cur*price;
		var check = $("input:checkbox[name=check"+e+"]").is(":checked");
			if(check==true){
			var ff = $('#totalPrice').html();
			var gg = removeComma(ff);
			var dd = parseInt(gg)+parseInt(price);
			var PlusTotalPrice = comma(ww);
			var PlusPrice =comma(dd);
			$('#totalPrice').html(PlusPrice);
			$('#productPrice'+e).html(PlusTotalPrice);
			}else{
			var PlusTotalPrice = comma(ww);
			$('#productPrice'+e).html(PlusTotalPrice);
			}
		}
	function countMinus(e){
		var cur = document.getElementById("payValue"+e).value;
		if(cur<=1){
			alert('수량은 1개 이상이여야합니다.');
		}else{
		var commaPrice = $('#productPrice'+e).html();
		console.log(commaPrice);
		var price = removeComma(commaPrice);
		price = price/cur;
		console.log(price);
		var number = cur;
			$.ajax({
				url:'PriceMinusAjax',
				type:'get',
				data:{number:number,
					  price:price},
				success:function(result){
					cur--;
					document.getElementById("payValue"+e).value = cur;
					var check = $("input:checkbox[name=check"+e+"]").is(":checked");
					if(check==true){
						var ww = cur*price;
						var ff = $('#totalPrice').html();
						var gg = removeComma(ff);
						var dd = parseInt(gg)-parseInt(price);
						var MinusTotalPrice = comma(ww);
						var MinusPrice =comma(dd);
						$('#totalPrice').html(MinusPrice);
						$('#productPrice'+e).html(MinusTotalPrice);
					}else if(check==false){
						cur--;
						document.getElementById("payValue"+e).value = cur;
					var rrrr =comma(result);
					$('#productPrice'+e).html(rrrr);
					}
					}
			});
		}
	}
	
	function removeComma(str)
	{
		n = parseInt(str.replace(/,/g,""));
		return n;
	}
	
    var count=0;
    var arr=[];
	 function checkBox(e){
		 		var cartno = $('#cart'+e).val();
				var check="";
				var price=0;
				var totalprice=0;
				check = $("input:checkbox[name=check"+e+"]").is(":checked"); 
				price= $("input[name=check"+e+"]").val();
				totalprice = $('#totalPrice').html();
				var priceSum = removeComma(totalprice);
			 	if(check==true){
			 		arr.push(cartno);
			 		console.log(arr);
			 		count= count+1;
			 		$('#productCount').html(count);
			 		var s = $('#productPrice'+e).html();
			 		console.log(s);
			 		var a = removeComma(s);
					var checkprice = parseInt(priceSum)+parseInt(a);
					var total =comma(checkprice);
					$('#totalPrice').html(total);
				} else if(check==false){
					arr.splice(arr.indexOf(cartno),1);
			 		console.log(arr);
					count--;
					$('#productCount').html(count);
			 		var s = $('#productPrice'+e).html();
			 		console.log(s);
			 		var a = removeComma(s);
					var checkprice = parseInt(priceSum) - parseInt(a);
					var total =comma(checkprice);
					$('#totalPrice').html(total);
				}
		}
	 function order(){
		 console.log(arr);
		 location.href="Order?arr="+arr;
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
				<li class="active">장바구니</li>
			</ul>
		</div>
	</div>
	<!-- 가운데 영역 -->
	<div class="background-color" style="background-color:#eee; height:70%;">
		<div class="col-md-2" style="float: right; background-color: white; height: 50%; margin-top: 3.9%; margin-right: 1%;">
			<div class="cartArea">
				<div style="text-align:left; margin-top:5px;border-bottom:1px solid;" >
					<h4><strong>전체 합계</strong></h4>
				</div>
				<div style="margin-top: 20px;border-bottom: 1px solid; height: 90px;">
					<div style="width:100%;float:left;">
						<p style="float:left;color: #7F8590;">상품수</p>
						<span style="float:right;">개</span><span style="float:right;" id="productCount">0</span>
					</div>
					<div style="width:100%;float:left;">
						<p style="float:left;color: #7F8590;">배송비</p>
						<span style="float:right; color:#067dfd;">무료배송</span>
					</div>
				</div>
				<div style="width:100%;float:left;margin-top:15px;">
					<h4 style="float:left;color: #7F8590;">전체 상품금액</h4>
					<h2><span style="float:right;">원</span><span style="float:right;" id="totalPrice">0</span></h2>
				</div>
				<button class="primary-btn" style="margin-top: 20px; width: 100%; height: 70px;font-size: 25px;" onclick="order()"> 구매하기</button>
			</div>
		</div>
	<div class="container">
		<div class="row">
			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">장바구니 목록</h2>
				</div>
			</div>
			<div class="col-md-4" style="float:right; display:block;">
			 <c:forEach var="result" items="${cart }" varStatus="status">
				<div class="col-md-4" style="height:120px; background-color:white;" id="count${status.index}">
					<div class="col-md-4">
						<img src="${pageContext.request.contextPath}/resources/fileupload/${result.photo1}" alt="" style="width:130px; height: 100px; float:left; margin-top:5px;">
							<div style="margin-top:20px;margin-left: 20px">
								<h4 class="product-name" style="width:400px;">${result.trade_name}</h4>
								<p style="width:400px;">${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</p>
								<h4 style="width:400px;"><span id="productPrice${status.index}"><fmt:formatNumber value="${result.price}" pattern="#,###.##"/></span>원</h4>
							</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>


	<!-- FOOTER -->
	<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->

</body>

</html>
