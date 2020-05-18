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

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote-lite.css">	
	
    <script>
    $(document).ready(function(){
    	
     $("#submit").click(function(){
    	console.log("1");
    	var table1 = document.getElementById("example");
    	var leng = table1.rows.length;
    	//배열 선언
    	var data = new Array();
    	 for(var i=1; i <= table1.rows.length-1 ; i++){
    	//2차원 배열 선언 초기화	 
    		 data[i-1] = new Array();
    	//2차원 배열에서 값 뽑아오기
    		 for(var j=0 ; j<=3 ; j++){
    			 //배열에 데이터 넣기
    			 data[i-1][j] = $("#example tr:eq("+i+") td:eq("+j+") input").val();
    			 console.log(data[i-1][j]);
    		 };
    		 var color = data[i-1][0];
    		 var size = data[i-1][1];
    		 var saleprice = data[i-1][2];
    		 var stock = data[i-1][3];
    		 $.ajax({
    				type:"post",
    				url : "productlist",
    				data : {"color" : color,
    					 	"size" : size,
    					 	"saleprice" : saleprice,
    					 	"stock": stock},
    				dataType:"text",
    				success: function(resultMsg){
    					console.log(resultMsg);
    				},
    				error:function (){
    					console.log("통신실패");
    					alert('통신실패');
    				}
    			});
    		 
    	 };	
    	 alert("저장되었습니다.");
    });  
     
     function handleImgFileSelect(e) {
     	var idname = e.target.id;
         var files = e.target.files;
         var filesArr = Array.prototype.slice.call(files);
 		
         console.log(idname);
         filesArr.forEach(function(f) {
             if(!f.type.match("image.*")) {
                 alert("확장자는 이미지 확장자만 가능합니다.");
                 return;
             }
             sel_file = f;
             var reader = new FileReader();
             reader.onload = function(e) {
             	if(idname =="img1"){
                 $("#back-img-1").css({"background-image":"url("+e.target.result+")"});
             	} else if(idname =="img2"){
             	$("#back-img-2").css({"background-image":"url("+e.target.result+")"});	
             	} else if(idname =="img3"){
             	$("#back-img-3").css({"background-image":"url("+e.target.result+")"});	
             	}
             }
             reader.readAsDataURL(f);
         });
     }


    
    $(document).ready(function() {
        $("#img1").bind("change", handleImgFileSelect);
        $("#img2").bind("change", handleImgFileSelect);
        $("#img3").bind("change", handleImgFileSelect);
    }); 
    
    $(document).ready(function(){
        // 옵션추가 버튼 클릭시
        $("#addItemBtn").click(function(){
            // item 의 최대번호 구하기
            var lastItemNo = $("#example tr:last").attr("class").replace("item", "");

            var newitem = $("#example tr:eq(1)").clone();
            newitem.removeClass();
            newitem.find("input").val("");
            newitem.find("td:eq(0)").attr("rowspan", "1");
            newitem.addClass("item"+(parseInt(lastItemNo)+1));

            $("#example").append(newitem);
        });


        // 항목추가 버튼 클릭시
        	$("#example").on("click", ".addBtn", function(){
            var clickedRow = $(this).parent().parent();
            var cls = clickedRow.attr("class");

            // tr 복사해서 마지막에 추가
            var newrow = clickedRow.clone();
            newrow.find("td:eq(0)").remove();
            newrow.insertAfter($("#example ."+cls+":last"));

            // rowspan 조정
            resizeRowspan(cls);
        });
         
         
        // 삭제버튼 클릭시
        	$("#example").on("click", ".delBtn", function(){
            var clickedRow = $(this).parent().parent();
            var cls = clickedRow.attr("class");
             
            // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다.
            if( clickedRow.find("td:eq(0)").attr("rowspan") ){
                if( clickedRow.next().hasClass(cls) ){
                    clickedRow.next().prepend(clickedRow.find("td:eq(0)"));
                }
            }

            clickedRow.remove();

            // rowspan 조정
            resizeRowspan(cls);
        });

        // cls : rowspan 을 조정할 class ex) item1, item2, ...
        function resizeRowspan(cls){
            var rowspan = $("."+cls).length;
            $("."+cls+":first td:eq(0)").attr("rowspan", rowspan);
        }
    });
    });  
    </script>
</head>
<body>
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
</div>
<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">현재 페이지 목록(대메뉴)</a></li>
				<li class="active">현재 페이지 목록(소메뉴)</li>
			</ul>
		</div>
	</div>
         <!-- 옵션 영역 -->                                         
            <div class="container">
                <div class="row">
                <div class="col-md-12">
					<div class="section-title">
						<h2 class="title">상품 등록</h2>
					</div>
				</div>
				<div class="col-md-6">
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">상품 상세 정보 입력</h3>
							</div>
							<button id="addItemBtn" ><h4 class="title">상세옵션 추가</h4></button> 
										<!-- <button id="addItemBtn" >옵션추가</button> -->
                                       	<table id="example" border="1"  class="shopping-cart-table table" >
                                       		<thead>
									        <tr>
									            <th class="text-center" style="width:20%; padding:0px;">컬러</th>
									            <th class="text-center" style="width:20%; padding:0px;">사이즈</th>
									            <th class="text-center" style="width:20%; padding:0px;">할인가격</th>
									            <th class="text-center" style="width:20%; padding:0px;">재고</th>
									            <th class="text-center" style="width:20%; padding:0px;">옵션삭제</th>
									        </tr>
									    </thead>    
									    <tbody style="padding:0px;">
									        <tr class="item1">
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;"  /></td>
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;" /></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><button class="delBtn"><i class="fa fa-close"></i></button></td>
									        </tr>
									        <tr class="item2">
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;" /></td>
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;" /></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><button class="delBtn"><i class="fa fa-close"></i></button></td>
									        </tr>
									        <tr class="item3">
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;" /></td>
									            <td style="padding:0px;"><input type="text" class="input" style="height:40px;" /></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><input type="text"  class="input" style="height:40px;"/></td>
									            <td style="padding:0px;"><button class="delBtn"><i class="fa fa-close"></i></button></td>
									        </tr>
									    </tbody>    
									</table>
							<button id="submit">저장</button> 
							<button>수정</button>
						</div>
					</div>
			<form action="productAdd" method="post" enctype="multipart/form-data" id="productbuy" >
					<div class="col-md-6">
						<div class="billing-details">
							<div class="section-title">
								<h3 class="title">메인/상세이미지 등록</h3>
							</div>
							<!-- 메인이미지 영역 -->
						<div class="product-img-layout">	
							<div class="product-img-area1" style="background-size:cover;background-repeat:no-repeat; background-size: contain; background-position: center;" id="back-img-1"></div>
							<div class="product-img-area1-1" >
								<h4 class="section-title-3">메인 이미지</h4>
								<label> <a href="phone:+8801722889963"
									onclick="imgUpload('1')">+</a> <input type="file" name="photo4"
									style="display: none" id="img1">
								</label>
							</div>
						</div>
						<!-- 상세이미지 영역 -->
						<div class="product-img-layout">
							<div class="product-img-area1" style="background-size:cover;background-repeat:no-repeat; background-size: contain; background-position: center;" id="back-img-2"></div>
							<div class="product-img-area1-1" >
								<h4 class="section-title-3">상세 이미지</h4>
								<label> <a href="phone:+8801722889963" onclick="imgUpload('2')">+ </a> <input
									multiple="multiple" type="file" name="photo5" id="img2"
									style="display: none">
								</label>	
							</div>
						</div>
						<!-- 내용이미지 영역 -->
						<div class="product-img-layout">
							<div class="product-img-area1" style="background-size:cover;background-repeat:no-repeat; background-size: contain; background-position: center;" id="back-img-3"></div>
							<div class="product-img-area1-1" >
								<h4 class="section-title-3">상세내용 이미지</h4>
								<label> <a href="phone:+8801722889963" onclick="imgUpload('3')">+ </a> <input
									multiple="multiple" type="file" name="photo5" id="img3"
									style="display: none">
								</label>	
							</div>
						</div>
					</div>
					</div>
			<div class="col-md-12">
                     <div class="section-title">
								<h3 class="title">상품 등록 입력 정보</h3>
						</div>
                    
                    <div class="col-md-10" style="margin-left:80px;">
                    	<table class="shopping-cart-table table">
                    		<tr>
                    			<td>상품 분류</td>
                    			<td><select class="input search-categories" style="height:30px; width:200px;" name="categoryno">
                    					<option value="">상품분류*</option>
										<option value="01">패션/의류</option>
										<option value="02">전자/제품</option>
										<option value="03">식품/생필품</option>
										<option value="04">스포츠/건강</option>
									</select></td>
                    			<td>상품가격 : </td>
                    			<td><input type="text" class="input" style="height:30px; width:200px;" placeholder="상품가격*" name="price" /></td>
                    		</tr>
                    		<tr>
                    			<td>상품명 : </td>
                    			<td><input type="text" class="input" style="height:30px; width:200px;" placeholder="상품명*" name="trade_name" /></td>
                    			<td>상품가격 : </td>
                    			<td><input type="text" class="input" style="height:30px; width:200px;"  /></td>
                    		</tr>
                    	</table>
                    </div>
                    
                    <div class="col-md-10" style="margin-left:80px;">
                    	<textarea id="summernote" rows="5" name="explanation" style="width:100%; height:250px;"></textarea>
                    </div>
               </div>
					</form>
					<div class="col-md-10" style="height:100px; text-align:center;margin-top:40px;margin-left:80px;">
						<button id="submitBoardBtn" class="primary-btn" onclick="submit()">저장</button>
						<button id=""  class="primary-btn">돌아가기</button>
					</div>
                </div>
            </div>
            <!-- 옵션 영역 end -->

<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->
       
 	<script src="${pageContext.request.contextPath}/resources/js/summernote-lite.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/summernote-ko-KR.js"></script>
 <script>
 $('#summernote').summernote({
		height: 300,
		width : 1000,
		minHeight: null,
		maxHeight: null,
		focus: true,
		lang: "ko-KR",
		callbacks: {
			onImageUpload : function(files){
				sendFile(files[0],this);
			}
		}
			
	});
		
	function sendFile(file, editor){
		var data = new FormData();
		data.append("file", file);
		console.log(file);
		$.ajax({
			data : data,
			type : "POST",
			url : "SummerNoteImageFile",
			contentType : false,
			processData : false,
			success : function(data){
				console.log(data);
				console.log(editor);
				$(editor).summernote("insertImage",data.url);
			}
		});
	}
 function imgUpload(num){
	 if(num ==1){
	 	$("#img1").click();
	 } else if(num==2){
		$("#img2").click();	 
	 } else if(num==3){
		$("#img3").click();
	 }
 }
	function submit(){
		$('#productbuy').submit();
	}

</script>
</body>

</html>

