<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/sockjs.min.js"></script>
	
	<script>
		$(document).ready(function(){
			var lastIndex = document.getElementById("listIndex").value;
			for(var i = 0; i<lastIndex;i++){
				var count = 0;
				var id = document.getElementById("f_id"+i).value;
				var f_id = "${sessionScope.loginId}";
				console.log("에이작스 시작전 "+i);
				(function(i){
				$.ajax({
					type:"post",
					url:"friendMessageCount",
					data:{"id":id,
						  "f_id":f_id},
					dataType:"text",
					success:function(result){
						count = result
						console.log("에이작스 성공후"+i);
						if(result != 0){
						$("#messageCount"+i).text(count);
						}
					},
					error:function(){
						console.log("통오");
					}
				});
				})(i);
				console.log("에이작스 끝나고"+i)
				console.log("에이작스 끝나고 카운트"+count);
			}
		});
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
				<h2>채팅</h2>
			</div>
			<div class="friendLine"></div>
			<div class="none" id="app" v-cloak>
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
			<c:forEach var="friendList" items="${friendList }" varStatus="status">
			<button style="width:350px;" class="messenger">
			<input type="hidden" id="f_id${status.index }" value="${friendList.f_id }">
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
																${friendList.f_name }
																</span>
																<div id="messageCount${status.index}" style="text-align:right">
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
						</div>
					</li>
				</ul>
			</div>
			</button>
			</c:forEach>
			<!-- 반복끝 -->
			</c:otherwise>
			</c:choose>
			<input type="hidden" value="${fn:length(friendList)}" id="listIndex">
			<div class="listScroll1" data-novc="1" data-thumb="1" style="display:block;right:0px;height:1000px;"></div>
			<div class="listScroll2" data-novc="1" data-thumb="1" style="display:block;right:0px;height:673.688px;transform:matrix3d(1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,-1) scale(1.33296) translateZ(-0.332962px) translateZ(-2px);">
				<div class="listScroll3"></div>
			</div>
			<div class="listScroll"></div>
			</div>
			</div>
		</div>
	</div>
	<div class="friendContents">
	
	</div>
	</div>
	</div>
	</div>
</body>
<script>
	$(document).on("click",".messenger",function(){
		var idx = $(".messenger").index(this);
		var f_id = document.getElementById("f_id"+idx).value;
		var id = "${sessionScope.loginId}";
		$.ajax({
			type:"post",
			url:"goChat",
			data:{"id":id,
				  "f_id":f_id},
			dataType:"json",
			success:function(result){
				$("#messageCount"+idx).remove();
				var output = '<div class="container">';
				output += '<div class="row">';
				output += '<div class="col-md-12">';
				output += '<div id="msgArea" style="border:1px solid black; width:400px; height:400px; overflow:auto;">';
				for(var i in result[0]){
					if(result[0][i].id == id){
						output+= '<div style="text-align:right;">';
						output+= result[0][i].message;
						output+= '</div>';
					}else{
						output += '<br>'+result[0][i].id+':';
						for(var j in result[1]){
							if(result[0][i].message == result[1][j].message){
								output += result[1][j].message;
							}
						}
					}
				}
				output += '</div>';
				output += '<br>';
				output += '<input type="text" id="chatMsg" onKeyDown="keyEvent();" name="chatInput">';
				output += '<input type="button" value="전송" id="sendBtn">';
				output += '<input type="hidden" value="'+f_id+'" id="f_id">';
				output += '</div>';
				output += '</div>';
				output += '</div>';
				$(".friendContents").html(output);
				$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
				connect();
			},
			error:function(){
				console.log("통오");
			}
		});
		
	});
	
	function keyEvent(){
		if(event.keyCode == 13){
			var chat = $("#msgArea").val();
			chat = '<div style="text-align:right">';
			chat += $("#chatMsg").val();
			chat += '</div>';
			$("#msgArea").append(chat);
			$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
			sendMsg();
			$("#chatMsg").val("");
		}
	}
	
	$(document).on("click","#sendBtn",function(){
		var chat = $("#msgArea").val();
		chat = '<div style="text-align:right">';
		chat += $("#chatMsg").val();
		chat += '</div>';
		$("#msgArea").append(chat);
		$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
		sendMsg();
		$("#chatMsg").val("");
	});
	
</script>
<script type="text/javascript">
	var ws;
	var userid = '${sessionScope.loginId}';
	
	function connect(){
		ws = new WebSocket('ws://192.168.0.231:8091/lastproject/echo');
		
		ws.onopen = function(){
			console.log('연결생성');
			register();
		}
		
		ws.onmessage = function(e){
			console.log('메세지받음');
			console.log(e.data);
			console.log(e);
			var data = e.data;
			addMsg(data);
		}
		
		ws.onclose = function(){
			console.log("연결끊김");
		}
	}
	
	function addMsg(msg){
		var chat = $('#msgArea').val();
		var f_id = $("#f_id").val();
		console.log(msg);
		chat = "<br>"+f_id +": "+ msg;
		$('#msgArea').append(chat);
		$("#msgArea").scrollTop($("#msgArea")[0].scrollHeight);
	}
	
	function register(){
		var msg = {
				type:"register",
				userid:"${sessionScope.loginId}"
		};
		ws.send(JSON.stringify(msg));
	}
	
	function sendMsg(){
		var msg = {
				type:"chat",
				id :"${sessionScope.loginId}",
				target:$("#f_id").val(),
				message:$("#chatMsg").val()
		};
		ws.send(JSON.stringify(msg));
	}
</script>

</html>