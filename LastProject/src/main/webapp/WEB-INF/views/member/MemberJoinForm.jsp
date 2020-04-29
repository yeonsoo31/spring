<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>MemberJoinForm</title>
<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
</head>
<body>
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
<!-- 페이스북 버튼 스크립트 -->
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script>
<!-- 메인화면 -->
<input type="button" onclick="location.href='memberJoinForm2'" value="이메일로 회원가입">
<!-- 구글 버튼 -->
<h2>구글로 간편가입</h2>
<div class="g-signin2" data-onsuccess="onSignIn" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div>
<!-- 페이스북 버튼 -->
<h2>페이스북으로 간편가입</h2>
<div id="fb-root"></div>
<div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"
  onlogin="checkLoginState();"></div><br>
<!-- 카카오톡 -->
<h2>카카오톡으로 간편가입</h2>
<a href="kakaojoin">
	<img width="250" height="40" src="${pageContext.request.contextPath}/resources/img/kakao_account_login_btn_large_narrow.png">
</a><br>
<!-- 네이버 -->
<h2>네이버로 간편가입</h2>
<a href="naverjoin">
	<img width="250" height="40" src="${pageContext.request.contextPath}/resources/img/Log in with NAVER_Official_Green.PNG">
</a>
</body>
</html>