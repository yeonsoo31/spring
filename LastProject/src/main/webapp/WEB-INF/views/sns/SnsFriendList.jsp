<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/style.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/layer-pop.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/dropdown.css">
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/summernote-lite.css">
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<title>Insert title here</title>
<script>
	function friendStatus(index){
		var f_id = document.getElementById("f_id"+index).value;
		$.ajax({
			type : "post",
			url : "friendStatus",
			data : {
				"f_id" : f_id
			},
			dataType : "json",
			success : function(result){
				for(var i in result[0]){
					var output = '<input type="hidden" id="f_id0" value="'+result[0][i].id+'">';
					output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>'; // 회색줄
					output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
						output += '<div class="col-md-1">';
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[0][i].profile+'">';
						output += '</div>';
						output += '<div class="col-md-6">이름 : '+result[0][i].name+'</div>';
						output += '<div class="col-md-6">주소 : '+result[2][0]+result[2][1]+'</div>';
						output += '<div class="col-md-6">가입날짜 : '+result[0][i].sys_date+'</div>';
					output += '</div>'
					output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>'; // 회색줄
					for(var j in result[1]){
						output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
						output += '<div class="col-md-1">';
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[1][j].profile+'">';
						output += '</div>';
						output += '<div class="col-md-6">'+result[1][j].id+'</div>';
						output += '<div class="col-md-6">'+result[1][j].s_date+'</div>';
						output += '<div class="col-md-12">'+result[1][j].s_contents+'</div>';
						output += '</div>';
						output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>';
					}
				}
				$(".here").html(output);
			},
			error : function(){
				console.log("통오");
			},
		});
	}
</script>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	
	<div class="friendPage">
	<div class="friendPage1">
	<div class="friendPage2">
	<div class="friendList">
		<div class="friendListBox">
			<div class="friendListTop">
				<h2>친구</h2>
			</div>
			<div class="friendLine"></div>
			<div class="none">
			<div>
			
			<c:choose>
			<c:when test="${fn:length(friendList) == 0}">
				<div class="friendListMain">
					<ul class="realFriendList">
						<li class="oneFriend">
						<div class="friend">
							<div style="padding-left:8px; padding-right:8px">
								<div class="friend1">
									<div class="friend2">
										<div class="friend3">
											<div class="friend5">
												<div class="friend6">
													<div class="friend7">
														<div class="friend8">
															<div class="friend9">
																<span class="s_friend" dir="auto">
																<a class="friend10" href="">친구가 아직 없어요<br>
																친구를 추가해 보세요.</a>
																</span>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						</li>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
			<!-- 반복 -->
			<c:forEach var="friendList" items="${friendList}" varStatus="status">
			<input type="hidden" id="friendList${status.index}" value="${friendList.f_name}">
			<div class="friendListMain">
				<ul class="realFriendList">
					<li class="oneFriend">
						<div>
							<div class="friend">
								<div style="padding-left:8px; padding-right:8px">
									<div class="friend1">
										<div class="friend2">
											<div class="friend3">
												<a class="a_friend" href="">
													<div class="friend4">
														<img height="100%" width="100%" src="${pageContext.request.contextPath}/resources/profilepic/${friendList.f_profile}" style="height:60px;width:60px">
													</div>
												</a>
											</div>
											<div class="friend5">
												<div class="friend6">
													<div class="friend7">
														<div class="friend8">
															<div class="friend9">
																<span class="s_friend" dir="auto">
																<input type="hidden" id="f_id${status.index}" value="${friendList.f_id}">
																<a class="friend10" href="#" onclick="friendStatus(${status.index}); return false;">${friendList.f_name }</a>
																</span>
															</div>
															<button onclick="friendDelete()">삭제</button>
														</div>
													</div>													
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</li>
				</ul>
			</div>
			</c:forEach>
			<!-- 반복끝 -->
			</c:otherwise>
			</c:choose>
			<div class="listScroll1" data-novc="1" data-thumb="1" style="display:block;right:0px;height:1000px;"></div>
			<div class="listScroll2" data-novc="1" data-thumb="1" style="display:block;right:0px;height:673.688px;transform:matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-1) scale(1.33296) translateZ(-0.332962px) translateZ(-2px);">
				<div class="listScroll3"></div>
			</div>
			<div class="listScroll"></div>
			</div>
			</div>
		</div>
	</div>
	
		<div class="container">
			<div class="row">
<!-- 				<div class="white-line"></div>
				<div class="white-line"></div>
				<div class="white-line"></div>
				<div class="white-line"></div>
				<div class="white-line"></div> -->
				<div class="md-col-12">
				<div class="here">
				
				</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
</body>
</html>