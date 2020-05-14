<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>MemberJoinForm</title>
<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<style>
	table {
		margin: auto;
		text-align: center;
		}
</style>
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
			location.href="goMain";
			</script>
		</c:if>
<script>
<!-- 구글 OAuth -->
	var googleId;
	var googleEmail;
	var googleName;
	function onSignIn(googleUser){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
		var profile = googleUser.getBasicProfile();
		googleId = profile.getId();
		googleEmail = profile.getEmail();
		googleName = profile.getName();
			if(googleId != undefined){
				location.href="googleJoinForm?googleId="+googleId+"&googleEmail="+googleEmail+"&googleName="+googleName;
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
  	var facebookName;
  	var facebookEmail;
	function testAPI() {
  		FB.api(
    		'/me',
    		{"fields":"id,name,email"},
    			function(response) {
      				facebookId = response.id;
      				facebookName = response.name;
      				facebookEmail = response.email;
      				location.href="facebookJoinForm?facebookId="+facebookId+"&facebookName="+facebookName+"&facebookEmail="+facebookEmail;
    			}
  		);
	}
</script>
	<!-- Logo -->
	<div class="header-logo" style="text-align:center;">
		<a class="logo" href="goMain">
			<img src="${pageContext.request.contextPath}/resources/img/logo.png" alt="">
		</a>
	</div>
	<!-- /Logo -->
<div class="container">
<div class="col-md-12">　</div>
<div class="col-md-12">　</div>
<div class="col-md-12">　</div>
<div class="col-md-3 col-md-offset-2">
<table>
	<tr>
		<td><h2>일반회원</h2></td>
	</tr>
	<tr>
		<td>
		<!-- 이메일 버튼 -->
		<a href="memberJoinForm2"><img width="250" height="40" src="${pageContext.request.contextPath}/resources/oauthicon/Sign_in_with_email.JPG"></a>
		<!-- 구글 버튼 -->
		<div class="g-signin2" data-onsuccess="onSignIn" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div>
		<!-- 페이스북 버튼 스크립트  
		<script async defer crossorigin="anonymous" src="https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script>
		-->
		<!-- 페이스북 버튼 -->
		<!-- <div id="fb-root"></div> -->
		<div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"
  		onlogin="checkLoginState()"></div><br>
  		<!-- <a href="#" onclick=""; return false;"><img width="250" height="40" src="${pageContext.request.contextPath}/resources/oauthicon/log-in-with-facebook.JPG"></a> -->
		<!-- 카카오톡 -->
		<a href="kakaojoin">
		<img width="250" height="40" src="${pageContext.request.contextPath}/resources/oauthicon/kakao_account_login_btn_large_narrow.png">
		</a><br>
		<!-- 네이버 -->
		<a href="naverjoin">
		<img width="250" height="40" src="${pageContext.request.contextPath}/resources/oauthicon/Log in with NAVER_Official_Green.PNG">
		</a>
		</td>
	</tr>
</table>
</div>
<div class="col-md-3 col-md-offset-2">
<table>
	<tr>
		<td><h2>기업회원</h2></td>
	</tr>
	<td>
		<input type="button" style="width: 200px; height: 200px" onclick="location.href='sellerJoinForm'" value="사업자 등록증으로 회원가입"/>
	</td>
</table>
</div>
<div class="col-md-12">　</div>
<div class="col-md-12">　</div>
<div class="col-md-12">　</div>
</div>
</body>
</html>