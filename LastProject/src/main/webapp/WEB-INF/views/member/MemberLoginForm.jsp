<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
<title>MemberLoginForm</title>
<script>
	function login() {
		var id = document.getElementById("id").value;
		var password = document.getElementById("password").value;
		var division = $(':radio[name="division"]:checked').val();
		if(division==1){
		$.ajax({
			type : "post",
			url : "memberLoginCheck",
			data : {
				"id" : id,
				"password" : password,
				"division" : division
			},
			dataType : "text",
			success: function(result){
				if(result=="OK"){
					loginForm.submit();
				} else {
					alert("아이디 혹은 비밀번호가 틀렸습니다");
					return false;
				}
			},
			error: function(){
				alert("통신오류");
			}
		});
	} else if(division==2){
		$.ajax({
			type : "post",
			url : "sellerLoginCheck",
			data : {
				"id" : id,
				"password" : password,
				"division" : division
			},
			dataType : "text",
			success: function(result){
				if(result=="OK"){
					loginForm.submit();
				} else {
					alert("아이디 혹은 비밀번호가 틀렸습니다");
					return false;
				}
			},
			error: function(){
				alert("통신오류");
			}
		});
	}
	}
	function idFind(){
		var popupX = (document.body.offsetWidth / 2) - (500 / 2);
		//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
		var popupY= (window.screen.height / 2) - (400 / 2);
		//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
		window.open('idFindForm', '아이디찾기', 'status=no, width=500, height=400, left='+ popupX + ', top='+ popupY);
	}
	function passwordFind(){
			var popupX = (document.body.offsetWidth / 2) - (600 / 2);
			//만들 팝업창 좌우 크기의 1/2 만큼 보정값으로 빼주었음
			var popupY= (window.screen.height / 2) - (500 / 2);
			//만들 팝업창 상하 크기의 1/2 만큼 보정값으로 빼주었음
			window.open('passwordFindForm', '비밀번호찾기', 'status=no, width=600, height=500, left='+ popupX + ', top='+ popupY);
	}
</script>
</head>
<body>
<!-- 이미 로그인 되어있으면 메인으로 이동 -->
		<script>
		if(self.name != 'reload'){
			self.name = 'reload';
			self.location.reload(true);
		} else {
			self.name = '';
		}
		</script>
		<c:if test="${sessionScope.loginId ne null}">
			<script>
				history.go(-1);
			</script>
		</c:if>
		<script>
<!-- 구글 OAuth -->
	var googleId;
	var googleEmail;
	var url;
	function googleLogin(googleUser){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
		var profile = googleUser.getBasicProfile();
		googleId = profile.getId();
		googleEmail = profile.getEmail();
		url = document.getElementById("url").value;
			if(googleId == undefined){
				alert("회원이 아닙니다.")
			} else {
				location.href="googleLogin?googleId="+googleId+"&googleEmail="+googleEmail+"&url="+url;
			}	
	}
<!-- 페이스북 OAuth -->
	window.fbAsyncInit = function() {
		FB.init({
			appId : '2543885372552103',
			cookie : true,
			xfbml : true,
			version : 'v6.0'
		});
    	FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
		});
	};
	(function(d, s, id){
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {return;}
			js = d.createElement(s); js.id = id;
			js.src = "https://connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
	function statusChangeCallback(response) { 
      	if (response.status === 'connected') {
        	testAPI();
      	}
 	}
	function checkLoginState() {
		FB.getLoginStatus(function(response) {
		statusChangeCallback(response);
		});
	}
  	var facebookId;
  	var facebookEmail;
  	var url;
	function testAPI() {
  		FB.api(
    		'/me',
    		{"fields":"id,name,email"},
    			function(response) {
      				facebookId = response.id;
      				facebookEmail = response.email;
      				url = document.getElementById("url").value;
      				location.href="facebookLogin?facebookId="+facebookId+"&facebookEmail="+facebookEmail+"&url="+url;
    			}
  		);
	}
</script>
	<!-- Logo -->
		<div class="header-logo" style="text-align:center;">
			<a class="logo" href="goMain">
				<img style="width:200px;height:200px;" src="${pageContext.request.contextPath}/resources/img/aaaa1234.png" alt="">
			</a>
		</div>
	<!-- /Logo -->
	<form action="memberLogin" method="post" id=loginForm>
	<input type="hidden" value="${url}" id="url" name="url">
	<table style="margin: auto;">
		<tr>
        	<td style="text-align:center;"><input type="radio" name="division" value="1" checked>일반회원
        		<input type="radio" name="division" value="2">기업회원
        	</td>
        </tr>
        <tr>
            <td><input type="text" name="id" id="id" placeholder="ID(이메일)를 입력해주세요." style="width: 250px; height:30px"></td>
        </tr>
        <tr>
        	<td><input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." style="width: 250px; height:30px"></td>
        </tr>
    	<tr>
     		<td><button type="button" onclick="login()" style="width: 254px; height: 30px">로그인</button></td>
    	</tr>
    	<tr>
    		<td><button type="button" onclick="location.href='termsOfService'" style="width: 254px; height: 30px">회원가입</button></td>
    	</tr>
    	<tr>
	    	<td style="text-align:center;"><a href="#" onclick="javascript: idFind(); return false;">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" onclick="javascript: passwordFind(); return false;">비밀번호 찾기</a></td>
	    </tr>
	    <tr>
	    	<td style="text-align:center;">───────────────</td>
	    </tr>
	    <tr>
		<!-- 구글 -->
		<td><div class="g-signin2" data-onsuccess="googleLogin" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div></td>
		</tr>
		<tr>
		<!-- 페이스북 -->
		<!-- <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script> -->
			<td><div id="fb-root"></div><div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"	onlogin="checkLoginState();"></div></td>
		</tr>
		<tr>
		<!-- 카카오톡 -->
			<td><a href="kakaoLogin?url=${url}"><img width="250" height="50" src="${pageContext.request.contextPath}/resources/oauthicon/kakao_account_login_btn_large_narrow.png"></a></td>
		</tr>
		<tr>
		<!-- 네이버 -->
			<td><a href="naverLogin?url=${url}"><img width="250" height="50" src="${pageContext.request.contextPath}/resources/oauthicon/Log in with NAVER_Official_Green.PNG"></a></td>
		</tr>
	</table>
	</form>
</body>
</html>