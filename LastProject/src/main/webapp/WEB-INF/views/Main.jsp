<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>Home</title>
</head>
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bootstrap-theme.css">
<link rel="stylesheet"
		href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<body>
<h1>
	메인 페이지.jsp
</h1>
	<div class="container">
      <div class="row">
        <div class="col">
          <h1> 메인페이지</h1> 
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a class="nav-link disabled" href="termsOfService">회원가입</a>
            </li>
            <li class="nav-item">
              <a class="nav-link disabled" href="memberLoginForm">로그인</a>
            </li>
            <li class="nav-item">
              <a class="nav-link active">일반상품</a>
            </li>
            <li class="nav-item">
              <a class="nav-link">공동구매</a>
            </li>
            <li class="nav-item">
             <a class="nav-link"> 경매</a>
            </li>
            <li class="nav-item">
              <a class="nav-link">에어비앤비</a>
            </li>
            <li class="nav-item">
              <a class="nav-link">SNS</a>
            </li>
            <li class="nav-item">
              	<a class="nav-link disabled">회원목록조회</a>
            </li>

          </ul>
        </div>
      </div>
    </div>

</body>
</html>
