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
      <div>
         <jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
       </div>  
       	<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">마이페이지</a></li>
				<li class="active">판매 통계</li>
			</ul>
		</div>
	</div>
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
<div class="_1wz0grtk" style="margin-bottom:16px">
                           <a aria-label="제주 한달살기 숙소" data-check-info-section="true" href="/rooms/23157539?location=%EC%A0%9C%EC%A3%BC%EB%8F%84&amp;adults=2&amp;check_in=2020-06-02&amp;check_out=2020-07-03&amp;previous_page_section_name=1000&amp;federated_search_id=8e2a580e-651e-41f1-93b4-be230ae2747c" rel="noopener" target="listing_23157539" class="_1fqrihn"></a>
                           <div class="_mcb8gr">
                            <div class="_gjw2an" style="padding-top:66.6667%;background:#484848">
                             <div class="_1szwzht">
                              <div class="_hxt6u1e" style="padding-top:66.6667%;background-image:url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAECAIAAADJUWIXAAAAS0lEQVQIHQFAAL//Afn6+tzg39Ldy9TUnRwF+AF0e23q3+cGDf/779cJAAcBZUgxDwwM+P4F2+LaFSUPAWpBJuXw+/T79gcWEQUN85uhIO3GR1bvAAAAAElFTkSuQmCC');background-size:cover" role="img" aria-busy="false" aria-label="제주 한달살기 숙소">
                               <div class="_4626ulj">
                                <img class="_91slf2a" style="object-fit:cover" aria-hidden="true" alt="제주 한달살기 숙소" src="https://a0.muscache.com/im/pictures/6ad38573-f1dd-404a-90dd-608bdd33710a.jpg?aki_policy=large" data-original-uri="https://a0.muscache.com/im/pictures/6ad38573-f1dd-404a-90dd-608bdd33710a.jpg?aki_policy=large">
                                <div class="_10xjrv2u" style="background-image:url(https://a0.muscache.com/im/pictures/6ad38573-f1dd-404a-90dd-608bdd33710a.jpg?aki_policy=large);background-size:cover"></div>
                               </div>
                              </div>
                             </div>
                            </div>
                            <div class="_5ogqp7">
                             <div class="_euowq4c">
                              <div class="_uoldnbt">
                               <button aria-label="목록에 숙소 추가하기" type="button" class="_1li8g8e"><span class="_3hmsj">
                                 <div class="_1tsvpuw">
                                  <svg style="display:block;fill:none;height:16px;width:16px;stroke:#222222;stroke-width:2;overflow:visible" aria-hidden="true" role="presentation" viewbox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
                                   <path d="m16 28c7-4.733 14-10 14-17 0-1.792-.683-3.583-2.05-4.95-1.367-1.366-3.158-2.05-4.95-2.05-1.791 0-3.583.684-4.949 2.05l-2.051 2.051-2.05-2.051c-1.367-1.366-3.158-2.05-4.95-2.05-1.791 0-3.583.684-4.949 2.05-1.367 1.367-2.051 3.158-2.051 4.95 0 7 7 12.267 14 17z"></path>
                                  </svg>
                                 </div></span></button>
                              </div>
                             </div>
                             <div class="_l00xzmw">
                              <div class="_hd88sb">
                               <button aria-label="이전 이미지" type="button" class="_1li8g8e"><span class="_3hmsj">
                                 <svg viewbox="0 0 16 16" role="presentation" aria-hidden="true" focusable="false" style="height:10px;width:10px;display:block;fill:currentColor">
                                  <path d="m10.8 16c-.4 0-.7-.1-.9-.4l-6.8-6.7c-.5-.5-.5-1.3 0-1.8l6.8-6.7c.5-.5 1.2-.5 1.7 0s .5 1.2 0 1.7l-5.8 5.9 5.8 5.9c.5.5.5 1.2 0 1.7-.2.3-.5.4-.8.4"></path>
                                 </svg></span></button>
                              </div>
                              <div class="_l9kk1hc">
                               <button aria-label="다음 이미지" type="button" class="_1li8g8e"><span class="_3hmsj">
                                 <svg viewbox="0 0 16 16" role="presentation" aria-hidden="true" focusable="false" style="height:10px;width:10px;display:block;fill:currentColor">
                                  <path d="m5.3 16c .3 0 .6-.1.8-.4l6.8-6.7c.5-.5.5-1.3 0-1.8l-6.8-6.7c-.5-.5-1.2-.5-1.7 0s-.5 1.2 0 1.7l5.8 5.9-5.8 5.9c-.5.5-.5 1.2 0 1.7.2.3.5.4.9.4"></path>
                                 </svg></span></button>
                              </div>
                             </div>
                             <div class="_1ickhpd"></div>
                            </div>
                           </div>
                           <div class="_4ntfzh" style="margin-top:12px;margin-bottom:6px">
                            <span class="_v3a6xd"><span class="_lwunzw">슈퍼호스트</span></span>
                            <div class="_190542tw">
                             전원주택 전체
                             <span aria-hidden="true"> · </span>침대 1개
                            </div>
                            <span class="_13blcrbo"><span class="_60hvkx2" role="img" aria-label="평점 4.88/5"><span class="_1lzlk52">
                               <svg style="display:block;height:12px;width:12px;fill:currentColor" aria-hidden="true" role="presentation" viewbox="0 0 32 32" xmlns="http://www.w3.org/2000/svg">
                                <path d="M15.094 1.579l-4.124 8.885-9.86 1.27a1 1 0 0 0-.542 1.736l7.293 6.565-1.965 9.852a1 1 0 0 0 1.483 1.061L16 25.951l8.625 4.997a1 1 0 0 0 1.482-1.06l-1.965-9.853 7.293-6.565a1 1 0 0 0-.541-1.735l-9.86-1.271-4.127-8.885a1 1 0 0 0-1.814 0z" fill-rule="evenodd"></path>
                               </svg></span><span class="_3zgr580" aria-hidden="true">4.88</span></span></span>
                           </div>
                           <div class="_sh35u3h" style="line-height:20px;max-height:20px;overflow:hidden;text-overflow:ellipsis;display:-webkit-box;-webkit-line-clamp:1;-webkit-box-orient:vertical">
                            제주 한달살기 숙소
                           </div>
                           <div class="_e296pg" style="margin-top:4px;margin-bottom:0">
                            <div class="_o60r27k">
                             <span><span class="_1p7iugi"><span class="_krjbj">가격:</span>₩677,232</span>/월</span>
                            </div>
                           </div>
                          </div>
	</div>
		<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
	</div>
</body>

</html>