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
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

function comma(num){
	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  }
	
	function removeComma(str)
	{
		n = parseInt(str.replace(/,/g,""));
		return n;
	}
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            var addr = '';
            var extraAddr = '';
            if (data.userSelectedType === 'R') {
                addr = data.roadAddress;
            } else {
                addr = data.jibunAddress;
            }
            if(data.userSelectedType === 'R'){
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                document.getElementById("sample6_extraAddress").value = extraAddr;
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            document.getElementById("sample6_detailAddress").focus();
            }
            }).open();
        }
  
		function infosame(){
			var name = $('#name').val();
			var phone = $('#phone').val();
			var postcode = $('#sample6_postcode').val();
			var address = $('#sample6_address').val();
			var extraAddress = $('#sample6_extraAddress').val();
			var detailAddress = $('#sample6_detailAddress').val();
			console.log(name, phone);
			$('#a_name').val(name);
			$('#a_phone').val(phone);
			$('#a_sample6_postcode').val(postcode);
			$('#a_sample6_address').val(address);
			$('#a_sample6_extraAddress').val(extraAddress);
			$('#a_sample6_detailAddress').val(detailAddress);
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
				<li><a href="#">일반상품</a></li>
				<li class="active">구매하기</li>
			</ul>
		</div>
	</div>
	<!-- 가운데 영역 -->
	<div class="background-color" style="background-color:#eee; padding-bottom:50px;">
	<div class="container">
		<div class="row">
			<!-- section title -->
			<div class="col-md-12">
				<div class="section-title">
					<h2 class="title">구매하기</h2>
				</div>
			</div>
			<div class="cont" style="padding:0 15px; float:left; width:100%;">
				<div class="contLeft" style="background:white; float:left; width:65%;">
					<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">주문자 정보</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
									<div>
										<a>이름:</a>
										<input class="input" type="text" value="${member.name }"  style="width: 30%; margin-left: 61px;" id="name">
									</div>
									<div style="margin-top:20px;">
										<a>핸드폰번호:  </a>
										<input class="input" type="text" value="${member.phone }" style="width: 30%; margin-left: 20px;" id="phone">
									</div>
									<div style="margin-top:20px;">
										<a>주소 :</a> 
										<input type="text" id="sample6_postcode" name="address1" placeholder="우편번호" class="input" style="width: 30%; margin-left:59px;" value="${member.address1 }">&nbsp;
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="input"style="width: 30%;">
										<input type="text" id="sample6_address" name="address2"	placeholder="주소" class="input" style="margin-left: 97px;width: 30%;" value="${member.address2 }"><br>
										<input type="text" id="sample6_extraAddress" name="address4"placeholder="참고항목" class="input" style="margin-left: 97px;width: 30%;" value="${member.address3 }"><br>
										<input type="text"id="sample6_detailAddress" name="address3" placeholder="상세주소" class="input" style="margin-left: 97px;width: 30%;" value="${member.address4 }">
									</div>	
									
								</div>
								</div>
						</div>
						<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">배송지 정보</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active" style="margin-left: 20px;">
									<div>
										<a>이름:</a>
										<input class="input" type="text" style="width: 30%; margin-left: 61px;" placeholder="이름"  id="a_name" >
										<button class="primary-btn" style="margin-left: 200px; height: 40px;" onclick="infosame()"> 주문자정보와 동일</button>
									</div>
									<div style="margin-top:20px;">
										<a>핸드폰번호:  </a>
										<input class="input" type="text"style="width: 30%; margin-left: 20px;"id="a_phone"  placeholder="핸드폰번호">
									</div>
									<div style="margin-top:20px;">
										<a>주소 :</a> 
										<input type="text" id="a_sample6_postcode" name="address1" placeholder="우편번호" class="input" style="width: 30%; margin-left:59px;">&nbsp;
										<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="input"style="width: 30%;">
										<input type="text" id="a_sample6_address" name="address2"	placeholder="주소" class="input" style="margin-left: 97px;width: 30%;"><br>
										<input type="text" id="a_sample6_extraAddress" name="address4"placeholder="참고항목" class="input" style="margin-left: 97px;width: 30%;"><br>
										<input type="text"id="a_sample6_detailAddress" name="address3" placeholder="상세주소" class="input" style="margin-left: 97px;width: 30%;">
									</div>
									<div style="margin-top:20px;">
										<a>배송요청 사항 :</a> 
										<select>
											<option value="" >배송시 요청사항(선택)</option>
											<option value="배송전, 연락바랍니다." >배송전, 연락바랍니다.</option>
											<option value="부재시, 전화또는 연락부탁드립니다." >부재시, 전화또는 연락부탁드립니다.</option>
											<option value="부재시, 경비실에 부탁드립니다." >부재시, 경비실에 부탁드립니다.</option>
										</select>
									</div>		
								</div>
							</div>
						</div>
					</div>
					
				<div class="contRight" style="width:33%; float:right;">
					<!-- 장바구니 목록 -->
					<div style="background-color:white;">
					 	<c:forEach var="result" items="${cart }" varStatus="status">
						<div class="bList" style="padding:15px; box-sizing: border-box; width:100%; height:120px; border-bottom:1px solid #cdcdcd; float:none" id="count${status.index}">
							<div class="bList2" style="width:100%;">
								<div style="float:left; width:25%; margin-right:3%;">
									<img src="${pageContext.request.contextPath}/resources/fileupload/${result.photo1}" alt="" style="width:100%;">
								</div>
								<div style="float:right; width:70%;">
									<h4 class="product-name" style="width:400px; letter-spacing: -1px; font-size: 16px;">${result.trade_name}</h4>
									<p style="width:400px;">${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</p>
									<h4 style="width:400px;"><span id="productPrice${status.index}"><fmt:formatNumber value="${result.price}" pattern="#,###.##"/></span>원</h4>
								</div>
							</div>
						</div>
					 	</c:forEach>
					</div>
					<!-- 장바구니 목록 -->
					<!-- 결제 -->
					<div style="width:100%; background-color: white; padding:15px; margin-top:20px;">
						<div class="cartArea">
							<div style="text-align:left; margin-top:5px;border-bottom:1px solid;" >
								<h4><strong>전체 합계</strong></h4>
							</div>
							<div style="margin-top: 20px;border-bottom: 1px solid; height: 90px;">
								<div style="width:100%;float:left;">
									<p style="float:left;color: #7F8590;">상품수</p>
									<span style="float:right;"> ${cartprice.count}개</span><span style="float:right;" id="productCount"></span>
								</div>
								<div style="width:100%;float:left;">
									<p style="float:left;color: #7F8590;">배송비</p>
									<span style="float:right; color:#067dfd;">무료배송</span>
								</div>
							</div>
							<div style="width:100%;float:left;margin-top:15px;">
								<h4 style="float:left;color: #7F8590;">전체 상품금액</h4>
								<h2><span style="float:right;"> <fmt:formatNumber value="${cartprice.price}" pattern="#,###.##"/>원</span><span style="float:right;" id="totalPrice"></span></h2>
							</div>
							<button class="primary-btn" style="margin-top: 20px; width: 100%; height: 70px;font-size: 25px;" onclick="order()"> 결제하기</button>
						</div>
					</div>	
					<!-- 결제 -->
				</div>
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
