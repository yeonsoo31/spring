<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
<title>Main</title>
</head>
<body>
<script>
<!-- 구글 OAuth -->
	var Gid;
	var Gmail;
	var Gname;
	function onSignIn(googleUser){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
		var profile = googleUser.getBasicProfile();
		Gid = profile.getId();
		Gmail = profile.getEmail();
		Gname = profile.getName();
			if(Gid != undefined){
				location.href="googleJoinForm?Gid="+Gid+"&Gmail="+Gmail+"&Gname="+Gname;
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
  	var Fid;
  	var Fname;
  	var Femail;
	function testAPI() {
  		FB.api(
    		'/me',
    		{"fields":"id,name,email"},
    			function(response) {
      				Fid = response.id;
      				Fname = response.name;
      				Femail = response.email;
      				location.href="facebookJoinForm?Fid="+Fid+"&Fname="+Fname+"&Femail="+Femail;
    			}
  		);
	}
</script>
<!-- 페이스북 버튼 스크립트 -->
<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script>
<!-- 메인화면 -->
<form action="memberLogin" method="post">
	아이디 : <input type="text" id="mid" name="mid"><br>
	비밀번호 : <input type="password" id="mpassword" name="mpassword"><br>
	<input type="submit" value="로그인">
	<input type="button" onclick="location.href='memberJoinForm'" value="회원가입">
</form>
<h2>간편가입</h2>
<!-- 구글 버튼 -->
<div class="g-signin2" data-onsuccess="onSignIn" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div>
<!-- 페이스북 버튼 -->
<div id="fb-root"></div>
<div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"
  onlogin="checkLoginState();"></div><br>
<!-- 카카오톡 -->
<a href="kakaojoin">
	<img width="250" height="40" src="${pageContext.request.contextPath}/resources/img/kakao_account_login_btn_medium_narrow.png">
</a><br>
<!-- 네이버 -->
<a href="naverjoin">
	<img width="250" height="40" src="${pageContext.request.contextPath}/resources/img/Log in with NAVER_Official_Green.PNG">
</a>
</body>
</html>