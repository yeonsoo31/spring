<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri = "http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script type="text/javascript">
function airLine(){
	location.href="airLine";
}
</script>
<script>
function airreservation(){
	location.href="airreservation?endnum=${airsList.endnum}&airuser=${airuser}"
}
</script>
<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  overflow:hidden;padding:10px 5px;word-break:normal;}
.tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
.tg .tg-lboi{border-color:inherit;text-align:left;vertical-align:middle}
.tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
</style>
</head>
<body>
	<div>
		<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
	</div>	
	<c:choose>
	<c:when test="${!empty airsList}">
	<div>
	<c:forEach var="airsList" items="${airsList}">
	<table class="tg" style='width:60%; height:40px; padding:20px; margin-left: auto; margin-right: auto;'>
		<thead>
		  <tr>
		    <th class="tg-c3ow">airname</th>
		    <th class="tg-c3ow">starttime</th>
		    <th class="tg-c3ow">endtime</th>
		    <th class="tg-c3ow">도착지</th>
		    <th class="tg-c3ow">가격</th>
		  </tr>
		</thead>
		<tbody>
		  <tr>
		    <td class="tg-c3ow">${airsList.airname}</td>
		    <td class="tg-c3ow">${airsList.starttime}</td>
		    <td class="tg-c3ow">${airsList.endtime}</td>
		    <td class="tg-c3ow">${airsList.endarea}</td>
		    <td class="tg-c3ow">${airsList.endprice}
		    <button onclick="airreservation()">예약하기</button>>
		    </td>
		  </tr>
		  <tr>
		    <td class="tg-9wq8" colspan="5"></td>
		  </tr>
		</tbody>
	</table>
	</c:forEach>
	</div>
	</c:when>
	<c:when test="${empty airsList}">
		<div>검색 결과가 없습니다.</div>
		<button onclick="airLine()">재검색 하기</button>
	</c:when>
	</c:choose>
	<div id="paging">
         <!-- 페이징 처리 -->
      <c:if test="${paging.page<=1}">
      [이전]&nbsp;
      </c:if>
      <c:if test="${paging.page>1}">
         <a href="airlistpaging?page=${paging.page-1}">[이전]</a>&nbsp;
      </c:if>
      <c:forEach begin="${paging.startpage}" end="${paging.endpage}" var="i" step="1">
         <c:choose>
            <c:when test="${i eq paging.page}">
            ${i}
            </c:when>
            <c:otherwise>
               <a href="airlistpaging?page=${i}">${i}</a>
            </c:otherwise>
         </c:choose>
      </c:forEach>
      <c:if test="${paging.page>=paging.maxpage}">
         &nbsp;[다음]
      </c:if>
      <c:if test="${paging.page<paging.maxpage}">
         &nbsp;<a href="airlistpaging?page=${paging.page+1}">[다음]</a>
      </c:if>
   </div>
	
	
		<div>
			<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
		</div>
</body>
</html>