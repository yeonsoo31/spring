<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="crossorigin="anonymous"></script>
<title>Insert title here</title>
<script type="text/javascript">
        $(function () {
           // $('#lblDisplay').empty();
            //동적 태그 추가
            var strHtml = $('<a href="http://www.naver.com">네이버</a><hr />');
            $('#lblDisplay').append(strHtml);
            $('#btnCreate').click(function () {
                $('#lblTable').empty();
                var row = $('#Text2').val();
                var col = $('#Text1').val();
                var strTable = "<table border = '1px'>";
				
                for (var i = 0; i < row; i++) {
                    strTable += "<tr>";
                    for (var j = 0; j < col; j++) {
                        strTable += "<td>" + (i+1) + "행, " + (j + 1) + "열" + "</td>";
                    }
                    strTable += "</tr>";
                }
                strTable += "</table>";
     
                $('#lblTable').append(strTable);
            });
        });
    </script>
</head>
<body>
	<!-- 동적으로 태그 추가 -->
    <span id="lblDisplay"><b>여기에 태그 추가</b></span>
    <!-- 동적 테이블 추가 -->
    행 : <input id="Text1" type="text" />열 : <input id="Text2" type="text" />
    <input id="btnCreate" type="button" value="테이블 동적 생성" /><br />
    <table border='1px'>
    	<tr>
    		<td>구분</td>
    		<td>이름</td>
    		<td>성별</td>
    		<td>생년월일</td>
    		<td>국적</td>
    		<td>구간/총 운임 선택</td>
    	</tr>
    </table>
    <div id="lblTable">
    </div>
</body>
</html>