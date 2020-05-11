<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	}
</script>
</head>
<body>
<div>
<jsp:include page="/WEB-INF/views/top.jsp"/>
</div>
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
	<div class="container">
	<div class="col-md-offset-12">　</div>
	<form class="col-md-offset-4" action="memberLogin" method="post" id=loginForm>
	<table>
		<h3>로그인</h3>
        	<td><input type="radio" name="division" value="1" checked>일반회원
        		<input type="radio" name="division" value="2">기업회원
        	</td>
        </tr>
        <tr>
            <td><input type="text" name="id" id="id" placeholder="ID(이메일)를 입력해주세요." style="width: 250px; height:30px"></td>
        </tr>
        <tr>
        	<td><input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요." style="width: 250px; height:30px"></td>
        </tr>
    </table>
    <button type="button" onclick="login()" style="width: 250px; height: 30px">로그인</button>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br><br>
    <a href="#" onclick="javascript: idFind(); return false;">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" onclick="javascript: passwordFind(); return false;">비밀번호 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="termsOfService">회원가입</a>
    </form><br>
    <div class="col-md-offset-4">
	<h3>&nbsp;&nbsp;일반회원 간편로그인</h3>
	<!-- 구글 -->
	<div class="g-signin2" data-onsuccess="googleLogin" data-theme="light" data-width="250" data-height="40" data-longtitle="true"></div>
	<!-- 페이스북 -->
	<!-- <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v6.0&appId=1660742084088243&autoLogAppEvents=1"></script> -->
	<div id="fb-root"></div>
	<div class="fb-login-button" data-size="large" data-button-type="login_with" data-layout="default" data-auto-logout-link="false" data-use-continue-as="false" data-width="250" scope="public_profile,email"
  	onlogin="checkLoginState();"></div><br>
	<!-- 카카오톡 -->
	<a href="kakaoLogin">
		<img width="250" height="50" src="${pageContext.request.contextPath}/resources/oauthicon/kakao_account_login_btn_large_narrow.png">
	</a><br>
	<!-- 네이버 -->
	<a href="naverLogin">
		<img width="250" height="50" src="${pageContext.request.contextPath}/resources/oauthicon/Log in with NAVER_Official_Green.PNG">
	</a>
	</div>
	</div>
	<div>
	<jsp:include page="/WEB-INF/views/footer.jsp"/>
	</div>
</body>
</html>