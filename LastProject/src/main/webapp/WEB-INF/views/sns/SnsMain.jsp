<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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

	<style>
		#snsWrite{width:90%; height:40px; border: 1px solid gray; background-color: rgba(0,0,0,0); color:gray; border-radius:10px;}
	</style>

	<script>
		$(document).ready(function(){
			$(".dropdown-content").hide();
		});
		function wrapWindowByMask(){
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();
			$('#mask').css({
				'width':maskWidth,
				'height':maskHeight
			});
		
			$('#mask').fadeTo('slow',0.5);
		}
		
		function popupOpen(){
			$('.layerpop').css("position","absolute");
			$('.layerpop').css("top",(($(window).height() - $('.layerpop').outerHeight())/2) + $(window).scrollTop());
			$('.layerpop').css("left",(($(window).width() - $('.layerpop').outerWidth())/2) + $(window).scrollLeft());
			$('#layerbox').show();
		}
		
		function popupClose(){
			$('#layerbox').hide();
			$('#mask').hide();
		}
		
		$(document).on("click","#snsWrite",function(){
			popupOpen();
			wrapWindowByMask();
		});
		
		function writeBtn(){
			var id = "${sessionScope.loginId}";
			var profile = "${member.profile}";
			var s_contents = document.getElementById("summernote").value;
			var select = document.getElementById("s_division");
			var s_division = select.options[select.selectedIndex].value;
			var page = "${paging.page}";
			console.log(page);
			console.log(id);
			console.log(profile);
			console.log(s_contents);
			console.log(s_division);
			$.ajax({
				type : "post",
				url : "snsWrite",
				data : {"id":id,
						"profile":profile,
						"s_contents":s_contents,
						"s_division":s_division,
						"page":page},
				dataType : "json",
				success : function(data){
					alert("등록완료");
					popupClose();
					var output = '<input type="hidden" id="s_number0" value="'+data.s_number+'">';
					output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>';
					output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
					output += '<div class="col-md-1">';
					output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+data.profile+'">';
					output += '</div>';
					output += '<div class="col-md-6">'+data.name+'</div>';
					output += '<div class="col-md-1 col-md-offset-4 dropdown"><button style="border:0px;outline:0; background-color:white;"class="addbtn"><i style="color:gray;font-size:20px;margin-top:5px; margin-left:15px;"class="fas fa-ellipsis-v"></i></button>';
					output += '<div id="addsnsDropdown" class="dropdown-content">';
					if(data.id == id){
						output += '<button style="border:0;outline:0;"onclick="">수정</button>';
						output += '<button style="border:0;outline:0;"onclick="deleteSnsPost(0)">삭제</button>';
					}
					output += '<button style="border:0;outline:0;"onclick="">신고</button>';
					output += '</div>';
					output += '</div>';
					output += '<div class="col-md-6">'+data.s_date+'</div>';
					output += '<div class="col-md-12">'+data.s_contents+'</div>';
					output += '</div>';
					$(".write").prepend(output);
				},
				error : function(){
					console.log("통신오류");
				}
			});
		}
		
		function goSearch(){
			var search = document.getElementById("search").value;
			console.log(search);
			$.ajax({
				type : "post",
				url : "snsSearch",
				data : {"search":search},
				dataType : "json",
				success : function(result){

					console.log(result[3]);
					var output = '<div class="snsLine"></div>';
					output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
					output += '<h3><Strong>사람</Strong></h3><br>';
					for(var i in result[0]){
						var exist = true;
						output += '<div class="col-md-10">';
						output += '<input type="hidden" id="id'+i+'" value="'+result[0][i].id+'">';
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[0][i].profile+'">';
						output += result[0][i].name;
						output += '</div>';
						output += '<div class="addFriendBtn'+i+'">';
							for(var l in result[3]){
								if(result[0][i].id == result[3][l].id && result[3][l].f_division == 2){
									console.log("1111111111111111111111");
									output += '<div class="col-md-2"><button class="divisionFriend">요청취소</button></div>';
									exist = false;
									break;
								} else if(result[0][i].id == result[3][l].id && result[3][l].f_division == 1){
									console.log("22222222222222222222222");
									output += '<div class="col-md-2"><button class="divisionFriend">친구삭제</button></div>';
									exist=false;
									break;
								} 
							}
							if(exist==true){
								output += '<div class="col-md-2"><button class="divisionFriend">친구요청</button></div>';
							}
						output += '</div>';
					}
					output += '</div>';
					output += '<div class="col-md-12 snsLine"></div>';
					output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
					output += '<h3><Strong>기업</Strong></h3><br>';
					for(var j in result[1]){
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[1][j].profile+'">';
						output += result[1][j].s_name;
					}
					output += '</div>';
					output += '<div class="col-md-12 snsLine"></div>';
					for(var k in result[2]){
						output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>';
						output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
						output += '<div class="col-md-1">';
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[2][k].profile+'">';
						output += '</div>';
						output += '<div class="col-md-6">'+result[2][k].id+'</div>';
						output += '<div class="col-md-6">'+result[2][k].s_date+'</div>';
						output += '<div class="col-md-12">'+result[2][k].s_contents+'</div>';
						output += '</div>';
					}
					output += '</div>';
					output += '</div>';
					$("#aabb").html(output);
				},
				error : function(){
					console.log("통오");
				}
			});
		}
		
		$(document).on("click",".divisionFriend",function(){
			var idx = $(".divisionFriend").index(this);
			console.log(idx);
			var id = document.getElementById("id"+idx).value;
			console.log(id);
			var f_id = "${sessionScope.loginId}";
			$.ajax({
				type:"post",
				url:"addFriend",
				data:{"id":id,
					  "f_id":f_id},
				dataType:"text",
				success:function(result){
					if(result=="add"){
						var output = '<div class="col-md-2"><button class="divisionFriend">요청취소</button></div>';
						$(".addFriendBtn"+idx).html(output);
					}else{
						var output = '<div class="col-md-2"><button class="divisionFriend">친구요청</button></div>';
						$(".addFriendBtn"+idx).html(output);
					}
				},
				error:function(){
					console.log("통오");
				}
			});
		});
		
		function deleteSnsPost(index){
			var deleteResult = confirm("정말로 삭제하시겠습니까?");
			if(deleteResult){
				var s_number = document.getElementById("s_number"+index).value;
				$.ajax({
					type:"post",
					url:"deleteSnsPost",
					data:{"s_number":s_number},
					dataType:"text",
					success:function(result){
						if(result=="OK"){
							$("#snsBoardList"+index).fadeOut(600);
						}
					},
					error:function(){
						console.log("통오");
					}
				});
			}
		}
	</script>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>
	
	<div style="background-color:lightgray;">
	<div class="snsLine"></div>
	<div class="category-nav" style="width:330px; height:600px; margin-top:10px;">
		<c:choose>
		<c:when test="${member.id ne null }">
		<div id="quick_menu" style="position: absolute;">
		<a href=""><span style="width:330px;"class="category-header"><img style="border: 3px solid gold; border-radius: 50%; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/${member.profile}">${member.name}</span></a>
			<div class="left-menu-ch">
				<ul  class="category-list" style="width:330px;">
					<li><input class="fas" style="width:270px; height:40px; border:0;" type="text" id="search" name="search" placeholder="&#xf002;검색">
					<span><button style="width:50px; height:40px;border:0;" onclick="goSearch()">검색</button></span></li>
					<li style="text-align:center;"><a href="snsFriendList">친구 리스트</a></li>
					<li style="text-align:center;"><a href="snsMessenger">Messenger</a>
					<c:if test="${messageCount ne 0 }">
						<p style="background-color:red;">${messageCount }</p>
					</c:if>
					</li>
					<li style="text-align:center;"><a href="">최신글</a></li>
					<li style="text-align:center;"><a href="friendRequest">친구 요청</a>
					<c:if test="${friendRequestCount ne 0 }">
					<p style="background-color:red;">${friendRequestCount}</p>
					</c:if>
					</li>
				</ul>
			</div>
			</div>
		</c:when>
		<c:otherwise>
			<a href="memberLoginForm"><span class="category-header">로그인이 필요합니다.</span></a>
		</c:otherwise>
		</c:choose>
	</div>
	<!-- 내용 -->
	<div class="container">
		<div class="row">
		<div id="aabb">
		<div class="snsLine"></div>
		<c:if test="${member.id ne null }">
			<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">
				<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/${member.profile}">
				<span><input type="button" id="snsWrite" value="${member.name}님, 무슨생각을 하고 계신가요?"></span>
			</div>
		</c:if>
			<!-- 반복 -->
			<div class="write">
			
			</div>
			<c:forEach var="snsList" items="${snsList}" varStatus="status">
			<div id="snsBoardList${status.index }">
			<input type="hidden" id="s_number${status.index }" value="${snsList.s_number }">
			<div class="col-md-8 col-md-offset-2 snsLine"></div>
			<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">
				<div class="col-md-1">
					<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/${snsList.profile}">
				</div>
				<div class="col-md-6">${snsList.name }</div>
				<div class="col-md-1 col-md-offset-4 dropdown">
				<button style="border:0px;outline:0; background-color:white;"class="dropbtn">
				<i style="color:gray;font-size:20px;margin-top:5px; margin-left:15px;"class="fas fa-ellipsis-v"></i>
				</button>
				<div id="snsDropdown${status.index}" class="dropdown-content">
					<c:if test="${snsList.id eq sessionScope.loginId }">
					<button style="border:0;outline:0;"onclick="">수정</button>
					<button style="border:0;outline:0;"onclick="deleteSnsPost(${status.index})">삭제</button>
					</c:if>
					<button style="border:0;outline:0;"onclick="">신고</button>
				</div>
				</div>
				<div class="col-md-6">${snsList.s_date }</div>
				<div class="col-md-12">${snsList.s_contents }</div>
			</div>
			</div>
			</c:forEach>
			<!-- 반복끝 -->
			<div id="snsMoreList">
			</div>
			<div id="nextPage">
				<input type="hidden" value="${paging.page }" id="realPage">
			</div>
			</div>
		</div>
		</div>
	<!-- 내용끝 -->
	<!-- SNS글쓰기 -->
	<div id="mask"></div>
	<div id="layerbox" class="layerpop container" style="width:550px; height:600px;">
		<article class="layerpop_area">
			<div class="row">
				<div class="col-md-12">
				<div class="white-line"></div>
					<div style="text-align:center;">
						<h3>게시물 만들기</h3>
					</div>
					<a href="javascript:popupClose();" class="layerpop_close" id="layerbox_close">
					<img style="width:25px; height:25px; display:block; position:absolute;" src="${pageContext.request.contextPath}/resources/img/close-button_icon-icons.com_72803.png">
					</a>
				<div class="line"></div>
				</div>
				<div class="col-md-12">
				<div class="col-md-2">
					<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/${member.profile}">
				</div>
				<div class="col-md-10"><strong>${member.name }</strong></div>
				<div class="col-md-10">
					<select name="s_division" id="s_division">
						<option value="1">전체공개</option>
						<option value="2">친구만</option>
					</select>
				</div>
				</div>
				<div class="col-md-12">
					<textarea style="resize: none;" name="s_contents" id="summernote"></textarea>
				</div>
				<div class="col-md-12" style="text-align:right;">
					<button onclick="writeBtn()">등록</button>
				</div>
			</div>
		</article>
	</div>
	<!-- SNS글쓰기끝 -->
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/summernote-lite.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/summernote-ko-KR.js"></script>
	<script src="https://kit.fontawesome.com/d928ba27e6.js" crossorigin="anonymous"></script>
	
	<script>
		$('#summernote').summernote({
			height: 300,
			width :	520,
			minHeight: 300,
			maxHeight: 300,
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
					url : "uploadSummernoteImageFile",
					contentType : false,
					processData : false,
					success : function(data){
						console.log("데이터"+data);
						$(editor).summernote("insertImage",data);
						},
						error:function(data,status,error){
							console.log(data);
						    console.log("code:"+data.status+"\n"+"message:"+data.responseText+"\n"+"error:"+error);
						}
					
			});
		}
		</script>
		</div>
</body>
	<script type="text/javascript">
		let isEnd = false;
		var bool_sw = true;
		
		$(function(){
			$(window).scroll(function(){
				var $window = $(this);
				var scrollTop = $window.scrollTop();
				var windowHeight = $window.height();
				var documentHeight = $(document).height();
				console.log("documentHeight:"+documentHeight+"windowHeight:"+windowHeight+"scrollTop:"+scrollTop);
				if(scrollTop + windowHeight + 30 > documentHeight){
					if(bool_sw){
					moreList();
					}
				}
			});
		});
		
		function moreList(){
			bool_sw = false;
			if(isEnd == true){
				return;
			}
			var page = document.getElementById("realPage").value;
			console.log(page);
			$.ajax({
				type : "post",
				url : "snsMoreList",
				data : {"page":page},
				dataType : "json",
				success : function(result){
					var length = result[0].length;
					if(length < 8){
						isEnd = true;
					}
					var output = '<div>';
					for(var i in result[0]){
						output += '<div class="col-md-8 col-md-offset-2 snsLine"></div>';
						output += '<div class="col-md-8 col-md-offset-2" style="background-color:white; border-radius:10px;">';
						output += '<div class="col-md-1">';
						output += '<img style="border: 3px solid white; border-radius: 7px; -moz-border-radius: 7px; -khtml-border-radius: 7px; -webkit-border-radius: 7px;" width="50px" height="50px" src="${pageContext.request.contextPath}/resources/profilepic/'+result[0][i].profile+'">';
						output += '</div>';
						output += '<div class="col-md-6">'+result[0][i].id+'</div>';
						output += '<div class="col-md-6">'+result[0][i].s_date+'</div>';
						output += '<div class="col-md-12">'+result[0][i].s_contents+'</div>';
						output += '</div>';
					}
					output += '</div>';
					
					var nextPage = '<input type="hidden" value="'+result[1].page+'" id="realPage">';
					$("#nextPage").html(nextPage);
					$("#snsMoreList").append(output);
					setTimeout(function(){bool_sw = true;},500);
				},
				error : function(){
					
				}
			});
		}
		
		$(document).on("click",".dropbtn",function(event){
			var idx = $(".dropbtn").index(this);
			event.stopPropagation();
			$("#snsDropdown"+idx).toggle();
			console.log(idx);
		})
		
		$(document).click(function(){
			$(".dropdown-content").hide();
		})
		
	</script>

    <script type="text/javascript">
    (function($){
     var quick_menu = $('#quick_menu'); // 퀵매뉴의 id명
     var quick_top = 230; // 위에서부터 떨어져야 되는 거리
     var quick_left= -870; // 중앙에서 떨어져야 되는 거리
     var quick_speed = 500; // 이동속도
     $(document).ready(function(){
         quick_menu.css('top', quick_top + "px");
         quick_menu.css('left', (document.body.clientWidth / 2) + quick_left + "px" );
         quick_menu.css('display', '');
     
         $(window).resize(function(){
             quick_menu.css('left', (document.body.clientWidth / 2) + quick_left + "px" );
         });
     
         $(window).scroll(function(){
             quick_menu.stop();
             quick_menu.animate( { "top": $(document).scrollTop() + quick_top + "px" }, quick_speed );
         });
     });
    })(jQuery); 

    var slideIndex = 0;
    showSlides();

    function showSlides() {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";  
    }
    slideIndex++;
    if (slideIndex > slides.length) {slideIndex = 1}    
    for (i = 0; i < dots.length; i++) {
        dots[i].className = dots[i].className.replace(" active", "");
    }
    slides[slideIndex-1].style.display = "block";  
    dots[slideIndex-1].className += " active";
    setTimeout(showSlides, 2000); // Change image every 2 seconds
    }
     </script>
</html>