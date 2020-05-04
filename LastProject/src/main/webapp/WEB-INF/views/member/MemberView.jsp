<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>회원상세정보</title>
<script>
	function memberBlackListAdd(){
		var id = "${memberView.id}";
		$.ajax({
			type : "post",
			url : "memberBlackListAdd",
			data : {"id" : id},
			dataType : "text",
			success : function(result){
				alert("해당 회원을 블랙리스트에 추가하였습니다");
				location.href="memberView?id="+id;
			},
			error : function(){
				console.log("통신실패");
			}
		});
	}
</script>
</head>
<body>
	<table border="1">
		<tr>
			<th>아이디</th>
			<c:if test="${memberView.password ne null}"><th>비밀번호</th></c:if>
			<th>이름</th>
			<th>생년월일</th>
			<th>주소</th>
			<th>휴대폰번호</th>
			<th>프로필사진</th>
			<c:choose>
				<c:when test="${memberView.kakaoId ne null}">
				<th>카카오 고유번호</th>
				</c:when>
				<c:when test="${memberView.naverId ne null}">
				<th>네이버 고유번호</th>
				</c:when>
				<c:when test="${memberView.facebookId ne null}">
				<th>페이스북 고유번호</th>
				</c:when>
				<c:when test="${memberView.googleId ne null}">
				<th>구글 고유번호</th>
				</c:when>
			</c:choose>
			<th>적립금</th>
			<th>구분(1-회원 2-판매자 3-블랙리스트 4-관리자)</th>
			<th>비밀번호 변경일자</th>
		</tr>
		<tr>
			<td>${memberView.id}</td>
			<c:if test="${memberView.password ne null}">
			<td>${memberView.password}</td>
			</c:if>
			<td>${memberView.name}</td>
			<td>${memberView.birth}</td>
			<td>${memberView.address}</td>
			<td>${memberView.phone}</td>
			<td><img src="${pageContext.request.contextPath}/resources/profilepic/${memberView.profile}" width="100" height="100">${memberView.profile}</td>
			<c:choose>
				<c:when test="${memberView.kakaoId ne null}">
				<td>${memberView.kakaoId}</td>
				</c:when>
				<c:when test="${memberView.naverId ne null}">
				<td>${memberView.naverId}</td>
				</c:when>
				<c:when test="${memberView.facebookId ne null}">
				<td>${memberView.facebookId}</td>
				</c:when>
				<c:when test="${memberView.googleId ne null}">
				<td>${memberView.googleId}</td>
				</c:when>
			</c:choose>
			<td>${memberView.savemoney}</td>
			<td>${memberView.division}</td>
			<th>${memberView.passworddate}</th>
	</table>
	<button onclick="location.href='memberList'">이전으로</button>
	<c:choose>
	<c:when test="${memberView.division ne 3}">
	<button onclick="memberBlackListAdd()">블랙리스트 등록</button>
	</c:when>
	<c:otherwise>
	<button onclick="memberBlackListDelete()">블랙리스트 해제</button>
	</c:otherwise>
	</c:choose>
</body>
</html>