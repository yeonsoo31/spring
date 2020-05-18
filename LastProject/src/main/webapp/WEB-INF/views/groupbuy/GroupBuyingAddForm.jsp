<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	response.setContentType("text/html; charset=UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<%-- <jsp:include page="Main.jsp" /> --%>

<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/locale/ko.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

<script>
$(function () {
	 $('#g_deadline').datetimepicker({
		 locale : 'ko',
		 format: 'YYYY-MM-DD HH:mm:ss',
		 //최소 3시간 후 부터 날짜 선택 가능
		 defaultDate : moment().add(3, 'hours').format('YYYY-MM-DD HH:mm:ss'),
		 minDate: moment().add(3, 'hours').format('YYYY-MM-DD HH:mm:ss')

	 });

});
</script>
</head>
<body>

<form action="groupBuyingAdd" id="gorupbuy" method="post" enctype="multipart/form-data">

<!-- <div class="inputArea">
 <label>상품 분류</label>
 <select class="category1">
  <option value="">전체</option>
 </select>
 </div> -->






 				<!-- 	<input type="text" name="g_number"> 상품번호 -->
 				<!-- 	<input type="hidden" name="id" value="${MemberSalesDTO.id}"> 아이디 -->
 				<div class="inputArea">
 					<label for="id">아이디</label>
 					<input type="text" id="id" name="id">
 				</div>
 				<div class="inputArea">
 					<label for="g_price">가격</label>
 					<input type="text" id="g_price" name="g_price">
 				</div>
 				<div class="inputArea">
 					<label for="g_name">상품명</label>
 					<input type="text" id="g_name" name="g_name">
 				</div>
 				<div class="inputArea">
 					<label for="photo1">메인 이미지</label>
					<input type="file" id="photo1" name="photo1">
				</div>
				<div class="inputArea">
					<label for="photo2">상세 이미지1</label>
					<input type="file" id="photo2" name="photo2">
				</div>
				<div class="inputArea">
					<label for="photo3">상세 이미지2</label>
					<input type="file" id="photo3" name="photo3">
				</div>
				<div class="inputArea">
					<label for="g_person">최대 인원</label>
					<input type="number" id="g_person" name="g_person">
				</div>
				<div class="inputArea">
					<label for="g_deadline">마감 일시</label>
<!-- 					<input type="datetime-local" id="g_deadline" name="g_deadline"> -->
					 <div class='input-group date' id='g_deadline'>
                    <input type='text' name="g_deadline" class="form-control" />
                    <span class="input-group-addon">
                        <span class="glyphicon glyphicon-calendar"></span>
                    </span>
                </div>

					<!-- type="datetime-local" -->
				</div>
				<div class="inputArea">
					<label for="g_explanation">제품설명</label>
							<textarea name="g_explanation" id="smartEditor" rows="10" cols="100"
			style="width: 766px; height: 412px;">
    </textarea></div>
 				<!-- 	<textarea cols="50" rows="10" name="g_explanation"></textarea> 내용 -->
 				<!-- 	<input type="date" name="g_deadline"> 마감일시 -->

		 <div class="inputArea">
		 	<button type="button" id="register_Btn">등록</button>
		 </div>

	<!-- 	<button onclick="onSubmit()">등록하기</button> -->
	</form>
<%--
	${pageContext.request.contextPath}
	<form action="/send.jsp" method="post" id="frm">

		<textarea name="smartEditor" id="smartEditor" rows="10" cols="100"
			style="width: 766px; height: 412px;">
    </textarea>

		<input type="button" id="savebutton" value="서버" />


	</form> --%>



</body>
<script type="text/javascript">

	var oEditors = [];

	nhn.husky.EZCreator
			.createInIFrame({

				oAppRef : oEditors,

				elPlaceHolder : "smartEditor",

				//SmartEditor2Skin.html 파일이 존재하는 경로

				sSkinURI : "${pageContext.request.contextPath}/resources/se2/SmartEditor2Skin.html",

				htParams : {

					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)

					bUseToolbar : true,

					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)

					bUseVerticalResizer : true,

					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)

					bUseModeChanger : true,

					fOnBeforeUnload : function() {

					}

				},

				fOnAppLoad : function() {

					//기존 저장된 내용의 text 내용을 에디터상에 뿌려주고자 할때 사용

					oEditors.getById["smartEditor"].exec("PASTE_HTML", [ "" ]);

				},

				fCreator : "createSEditor2"

			});

	$("#register_Btn").click(function() {

		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#gorupbuy").submit();

	});

</script>
</html>
