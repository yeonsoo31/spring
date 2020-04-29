<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="google-signin-scope" content="profile email">
    <meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
    <script src="https://apis.google.com/js/platform.js" async defer></script>
<title>MemberLoginForm</title>
</head>
<body>
<script>
<!-- 구글 OAuth -->
	var googleId;
	var googleEmail;
	function googleLogin(googleUser){
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.disconnect();
		var profile = googleUser.getBasicProfile();
		googleId = profile.getId();
		googleEmail = profile.getEmail();
			if(googleId == undefined){
				alert("회원이 아닙니다.")
			} else {
				location.href="googleLogin?googleId="+googleId+"&googleEmail="+googleEmail;
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
	function testAPI() {
  		FB.api(
    		'/me',
    		{"fields":"id,name,email"},
    			function(response) {
      				facebookId = response.id;
      				facebookEmail = response.email;
      				location.href="facebookLogin?facebookId="+facebookId+"&facebookEmail="+facebookEmail;
    			}
  		);
	}
</script>
	<form action="memberLogin" method="post" id=loginForm>
	<table>
        <tr>
            <td>아이디 : <input type="text" name="id" id="id"></td>
        </tr>
        <tr>
        	<td>비밀번호 : <input type="password" name="password" id="password"></td>
        </tr>
    </table>
    <button onclick="submit">로그인</button>
    </form>
    <button onclick="location.href='goMain'">메인</button>
	<h3>간편로그인</h3>
	<!-- 구글 -->
	<h3>구글로 로그인</h3>
	<div class="g-signin2" data-onsuccess="googleLogin" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div>
	<!-- 페이스북 -->
	<h3>페이스북으로 로그인</h3>
	<script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script>
	<div id="fb-root"></div>
	<div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"
  	onlogin="checkLoginState();"></div><br>
	<!-- 카카오톡 -->
	<h3>카카오로 로그인</h3>
	<a href="kakaoLogin">
		<img width="250" height="50" src="${pageContext.request.contextPath}/resources/img/kakao_account_login_btn_large_narrow.png">
	</a><br>
	<!-- 네이버 -->
	<h3>네이버로 로그인</h3>
	<a href="naverLogin">
		<img width="250" height="50" src="${pageContext.request.contextPath}/resources/img/Log in with NAVER_Official_Green.PNG">
	</a>
</body>
</html>