<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.js"></script>

<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.bundle.min.js"></script>

<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.js"></script>

<script src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.1/Chart.min.js"></script>

  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javasctipt src="${pageContext.request.contextPath}/resources/css/bootstrap.css"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
	var densityCanvas = document.getElementById("densityChart");

	Chart.defaults.global.defaultFontFamily = "Lato";
	Chart.defaults.global.defaultFontSize = 15;

	var densityData = {
	  label: '총 판매량',
	  data: [5427, 5243, 5514,7152,6452,],
	  backgroundColor: [
	    'rgba(0, 99, 132, 0.6)',
	    'rgba(30, 99, 132, 0.6)',
	    'rgba(60, 99, 132, 0.6)',
	    'rgba(90, 99, 132, 0.6)',
	    'rgba(120, 99, 132, 0.6)'
	  ],
	  borderColor: [
	    'rgba(0, 99, 132, 1)',
	    'rgba(30, 99, 132, 1)',
	    'rgba(60, 99, 132, 1)',
	    'rgba(90, 99, 132, 1)',
	    'rgba(120, 99, 132, 1)'
	  ],
	  borderWidth: 2,
	  hoverBorderWidth: 1
	};

	var chartOptions = {
	  scales: {
	    yAxes: [{
	      barPercentage: 1,
	      gridLines: {
	        display: false
	      }
	    }],
	    xAxes: [{
	      gridLines: {
	        zeroLineColor: "black",
	        zeroLineWidth: 2
	      },
	      ticks: {
	        min: 0,
	        max: 8000,
	        stepSize: 1000
	      },
	      scaleLabel: {
	        display: true,
	        labelString: "월별 판매량"
	      }
	    }]
	  },
	  elements: {
	    rectangle: {
	      borderSkipped: 'left',
	    }
	  }
	};

	var barChart = new Chart(densityCanvas, {
	  type: 'horizontalBar',
	  data: {
	    labels: ["1월", "2월", "3월", "4월", "5월"],
	    datasets: [densityData],
	  },
	  options: chartOptions
	});
	
	
	//2번째 차트
	
	new Chart(document.getElementById("canvas"), {
	    type: 'line',
	    data: {
	        labels: ["1월", "2월", "3월", "4월", "5월"],
	        datasets: [{
	            label: '홈페이지 방문자 그래프',
	            data: [
	            	5890,
	                6001,
	                6321,
	                6823,
	                7931
	            ],
	            borderColor: "rgba(255, 201, 14, 1)",
	            backgroundColor: "rgba(255, 201, 14, 0.5)",
	            fill: true,
	            lineTension: 0
	        }]
	    },
	    options: {
	        responsive: true,
	        title: {
	            display: true,
	            text: '홈페이지 방문자 수 '
	        },
	        tooltips: {
	            mode: 'index',
	            intersect: false,
	        },
	        hover: {
	            mode: 'nearest',
	            intersect: true
	        },
	        scales: {
	            xAxes: [{
	                display: true,
	                scaleLabel: {
	                    display: true,
	                    labelString: '방문자 수'
	                }
	            }],
	            yAxes: [{
	                display: true,
	                ticks: {
	                    suggestedMin: 0,
	                },
	                scaleLabel: {
	                    display: true,
	                    labelString: '월병 통계'
	                }
	            }]
	        }
	    }
	});
	
	//3번째 차트
	
	var ctx = document.getElementById("myChart");
	var myChart = new Chart(ctx, {
	  type: 'pie',
	  data: {
	    labels: ['경매상품', '일반상품', '항공권', '호텔권'],
	    datasets: [{
	      label: '# of Tomatoes',
	      data: [120, 190, 30, 50],
	      backgroundColor: [
	        'rgba(255, 99, 132, 0.1)',
	        'rgba(54, 162, 235, 0.1)',
	        'rgba(255, 206, 86, 0.1)',
	        'rgba(75, 192, 192, 0.1)'
	      ],
	      borderColor: [
	        'rgba(255,99,132,1)',
	        'rgba(54, 162, 235, 1)',
	        'rgba(255, 206, 86, 1)',
	        'rgba(75, 192, 192, 1)'
	      ],
	      borderWidth: 2
	    }]
	  },
	  options: {
	   	//cutoutPercentage: 40,
	    responsive: false,
	    title: {
            display: true,
            text: '카테고리별 판매비율'
        },

	  }
	});
	
});
  </script>
</head>
<body>

	<div class="background-color" style="padding-bottom: 50px;">
		<div class="container">
			<div class="row">
				<!-- section title -->
				<div class="col-md-12">
					<div class="section-title">
						<h2 class="title">판매 통계</h2>
					</div>
				</div>
				<div class="cont" style="padding: 0 15px; float: left; width: 100%;">
					<div class="contLeft" style="float: left; width: 50%;">
						<canvas id="densityChart" height="250"></canvas>
					</div>

					<div class="contRight"
						style="width: 50%; float: right; height: 500px;">
						<canvas id="canvas" height="250"></canvas>
					</div>
					<div style="width: 100%; margin-bottom:50px;">
						<canvas id="myChart"
							style="width: 600px; height: 600px; margin: auto;"></canvas>

					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>