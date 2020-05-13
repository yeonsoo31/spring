<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
    crossorigin="anonymous"></script>
<script>
	function divhide(){
		$('#divsellerList').hide();
		$('#divmemberBlackList').hide();
		$('#divsellerBlackList').hide();
	}
	function memberList(){
		if($('input:radio[id=memberList]').is(':checked')){
	        $('#divmemberList').show();
	        $('#divsellerList').hide();
	        $('#divmemberBlackList').hide();
	        $('#divsellerBlackList').hide();
	    }
	}
	function sellerList(){
		if($('input:radio[id=sellerList]').is(':checked')){
			$('#divmemberList').hide();
			$('#divsellerList').show();
	        $('#divmemberBlackList').hide();
	        $('#divsellerBlackList').hide();
	    }
	}
	
	function memberBlackList(){
		if($('input:radio[id=memberBlackList]').is(':checked')){
			$('#divmemberList').hide();
			$('#divsellerList').hide();
	        $('#divmemberBlackList').show();
	        $('#divsellerBlackList').hide();
	    }
	}
	function sellerBlackList(){
		if($('input:radio[id=sellerBlackList]').is(':checked')){
			$('#divmemberList').hide();
			$('#divsellerList').hide();
	        $('#divmemberBlackList').hide();
	        $('#divsellerBlackList').show();
		}
	}
	function adminMemberDelete(index){
		var memberId = document.getElementById("memberId"+index).value;
		if(confirm("해당 회원을 탈퇴시키겠습니까?")){
			alert("탈퇴처리 완료");
			location.href="adminMemberDelete?id="+memberId;
		}
	}
	function adminSellerDelete(index){
		var sellerId = document.getElementById("sellerId"+index).value;
		if(confirm("해당 기업회원을 탈퇴시키겠습니까?")){
			alert("탈퇴처리 완료");
			location.href="adminSellerDelete?id="+sellerId;
		}
	}
</script>
</head>
<title>회원상세조회</title>
<body onload="divhide()">
<jsp:include page="/WEB-INF/views/top.jsp"/>
	<div class="container">
	<div class="col-md-offset-12">　</div>
	<div><h3 style="text-align:center">회원목록</h3></div>
	<div class="col-md-4">　</div>
	<input type="radio" id="memberList" name="memberList" value="1" onchange="memberList()" checked>일반회원
	<input type="radio" id="sellerList" name="memberList" value="2" onchange="sellerList()">기업회원
	<input type="radio" id="memberBlackList" name="memberList" value="3" onchange="memberBlackList()">일반회원 블랙리스트
	<input type="radio" id="sellerBlackList" name="memberList" value="4" onchange="sellerBlackList()">기업회원 블랙리스트
	<div class="col-md-offset-12">　</div>
	<div id="divmemberList">
	<table class="col-md-offset-4" border="1">
		<tr>
			<th>ID</th>
			<th>NAME</th>
			<th>상세조회</th>
			<th>회원탈퇴</th>
		</tr>
	<c:forEach var="memberList" items="${memberList}" varStatus="memberStatus">
	<input type="hidden" id="memberId${memberStatus.index}" value="${memberList.id}">
		<tr>	
			<td>${memberList.id}</td>
			<td>${memberList.name}</td>
			<td><a href="memberView?id=${memberList.id}">조회</a></td>
			<td><a href="#" onclick="adminMemberDelete(${memberStatus.index})">탈퇴</a></td>
		</tr>
	</c:forEach>
	</table>
	</div>
	
	<div id="divsellerList">
	<table class="col-md-offset-4" border="1">
		<tr>
			<th>ID</th>
			<th>NAME</th>
			<th>상세조회</th>
			<th>회원탈퇴</th>
		</tr>
	<c:forEach var="sellerList" items="${sellerList}" varStatus="sellerStatus">
	<input type="hidden" id="sellerId${sellerStatus.index}" value="${sellerList.id}">
		<tr>	
			<td>${sellerList.id}</td>
			<td>${sellerList.name}</td>
			<td><a href="memberView?id=${sellerList.id}">조회</a></td>
			<!-- <td><a href="memberDelete?id=${sellerList.id}">탈퇴</a></td> -->
			<td><a href="#" onclick="adminSellerDelete(${sellerStatus.index})">탈퇴</a></td>
		</tr>
	</c:forEach>
	</table>
	</div>
	<div id="divmemberBlackList">
	<table class="col-md-offset-4" border="1">
					<tr>
						<th>ID</th>
						<th>NAME</th>
						<th>상세조회</th>
						<th>회원탈퇴</th>
					</tr>
					<c:forEach var="memberBlackList" items="${memberBlackList}">
					<c:choose>
					<c:when test="${memberBlackList ne null}">
					<tr>	
						<td>${memberBlackList.id}</td>
						<td>${memberBlackList.name}</td>
						<td><a href="memberView?id=${memberBlackList.id}">조회</a></td>
						<td><a href="memberDelete?id=${memberBlackList.id}">탈퇴</a></td>
					</tr>
					</c:when>
			</c:choose>
	</c:forEach>
	</table>
	</div>
	<div id="divsellerBlackList">
	<table class="col-md-offset-4" border="1">
					<tr>
						<th>ID</th>
						<th>NAME</th>
						<th>상세조회</th>
						<th>회원탈퇴</th>
					</tr>
					<c:forEach var="sellerBlackList" items="${sellerBlackList}">
					<c:choose>
					<c:when test="${sellerBlackList ne null}">
					<tr>	
						<td>${sellerBlackList.id}</td>
						<td>${sellerBlackList.name}</td>
						<td><a href="memberView?id=${sellerBlackList.id}">조회</a></td>
						<td><a href="memberDelete?id=${sellerBlackList.id}">탈퇴</a></td>
					</tr>
				</c:when>
			</c:choose>
		</c:forEach>
	</table>
	</div>
	<button type="button" onclick="location.href='myPage'">이전으로</button>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	<!-- jQuery Plugins -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>