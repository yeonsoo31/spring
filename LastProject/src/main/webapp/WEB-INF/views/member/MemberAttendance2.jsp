<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출석체크</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fullcalendar/main.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fullcalendar/daygrid.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/fullcalendar/timegrid.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/main.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/daygrid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/timegrid.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/fullcalendar/interaction.js"></script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
		plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
		defaultView: 'dayGridMonth',
		defaultDate: new Date(),
		header: {
			left: 'prev,next today',
			center: 'title',
			right: ''
			},
		});
		calendar.render();
	});
</script>
<script>
	$(document).ready(function(){
		$('#calendar').fullCalendar({
			customButtons: {
				custom2:{
					text: '출석체크하기',
					id: 'memberAttendance',
					click: function(){
						url: "memberAttendanceCheck",
						type: "POST",
						data : {id: id},
						dataType: "text",
						success: function (date) {
						$(".fc-custom2-button").prop('disabled', true);
						$(".fc-custom2-button").html('출석완료');
					}
				}
			},
			eventSources:[
				{
					url: 'memberAttendance',
					type: 'GET',
					dataType: "JSON",
					success: function (data) { },
					error: function() {
						alert('there was an error while fetching events!');
					},
					color: 'purple',   
					textColor: 'white' 
					}
			]
		});
	});
</script>
</head>
<body>
<div id="calendar"></div>
<button id="custom2"></button>
</body>
</html>