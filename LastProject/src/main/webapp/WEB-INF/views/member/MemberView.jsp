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
	function memberBlackListDelete(){
		var id = "${memberView.id}";
		$.ajax({
			type : "post",
			url : "memberBlackListDelete",
			data : {"id" : id},
			dataType : "text",
			success : function(result){
				alert("해당 회원은 더이상 블랙리스트가 아닙니다");
				location.href="memberView?id="+id;
			},
			error : function(){
				console.log("통신실패");
			}
		});
	}
	function sellerBlackListAdd(){
		var id = "${sellerView.id}";
		$.ajax({
			type : "post",
			url : "sellerBlackListAdd",
			data : {"id" : id},
			dataType : "text",
			success : function(result){
				alert("해당 판매자를 블랙리스트에 추가하였습니다");
				location.href="memberView?id="+id;
			},
			error : function(){
				console.log("통신실패");
			}
		});
	}
	function sellerBlackListDelete(){
		var id = "${sellerView.id}";
		$.ajax({
			type : "post",
			url : "sellerBlackListDelete",
			data : {"id" : id},
			dataType : "text",
			success : function(result){
				alert("해당 판매자는 더이상 블랙리스트가 아닙니다");
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
<!-- 로그인이 안되어있으면 메인으로 이동 -->
		<c:if test="${sessionScope.loginId eq null}">
			<script>
			location.href="goMain";
			</script>
		</c:if>
<jsp:include page="/WEB-INF/views/top.jsp"/>
	<div class="container">
	<table border="1">
	<c:if test="${memberView ne null}">
		<tr>
			<th>아이디</th>
			<c:if test="${memberView.password ne null}"><th>비밀번호</th></c:if>
			<th>이름</th>
			<th>주소</th>
			<th>휴대폰번호</th>
			<th>생년월일</th>
			<th>구분(1-회원 2-판매자 3-회원 블랙리스트 4-판매자 블랙리스트 5-관리자)</th>
			<th>적립금</th>
			<th>가입일</th>
			<th>비밀번호 변경요구일자</th>
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
			<th>프로필사진</th>
			
		</tr>
		<tr>
			<td>${memberView.id}</td>
			<c:if test="${memberView.password ne null}">
			<td>${memberView.password}</td>
			</c:if>
			<td>${memberView.name}</td>
			<td>${memberView.address}</td>
			<td>${memberView.phone}</td>
			<td>${memberView.birth}</td>
			<td>${memberView.division}</td>
			<td>${memberView.savemoney}</td>
			<th>${memberView.sys_date}</th>
			<th>${memberView.change_date}</th>
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
			<td><img src="${pageContext.request.contextPath}/resources/profilepic/${memberView.profile}" width="100" height="100">${memberView.profile}</td>
		</tr>
		</c:if>
		<c:if test="${sellerView ne null}">
		<tr>
			<th>사업자등록번호</th>
			<th>회사명</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>대표자명</th>
			<th>회사주소</th>
			<th>휴대폰번호</th>
			<th>회사로고</th>
			<th>구분(1-회원 2-판매자 3-회원 블랙리스트 4-판매자 블랙리스트 5-관리자)</th>
			<th>가입날짜</th>
			<th>비밀번호 변경 기준 90일</th>
		</tr>
		<tr>
			<td>${sellerView.s_number}</td>
			<td>${sellerView.s_name}</td>
			<td>${sellerView.id}</td>
			<td>${sellerView.password}</td>
			<td>${sellerView.name}</td>
			<td>${sellerView.address}</td>
			<td>${sellerView.phone}</td>
			<td><img src="${pageContext.request.contextPath}/resources/profilepic/${sellerView.profile}" width="100" height="100">${sellerView.profile}</td>
			<td>${sellerView.division}</td>
			<td>${sellerView.sys_date}</td>
			<td>${sellerView.change_date}</td>
		</tr>
		</c:if>
	</table>
	<button onclick="location.href='memberList'">이전으로</button>
	<c:choose>
	<c:when test="${memberView.division eq 1}">
	<button onclick="memberBlackListAdd()">회원 블랙리스트 등록</button>
	</c:when>
	<c:when test="${sellerView.division eq 2}">
	<button onclick="sellerBlackListAdd()">판매자 블랙리스트 등록</button>
	</c:when>
	<c:when test="${memberView.division eq 3}">
	<button onclick="memberBlackListDelete()">회원 블랙리스트 해제</button>
	</c:when>
	<c:when test="${sellerView.division eq 4}">
	<button onclick="sellerBlackListDelete()">판매자 블랙리스트 해제</button>
	</c:when>
	</c:choose>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>