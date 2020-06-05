<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%> 
<% response.setContentType("text/html; charset=UTF-8");%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id" content="565794567467-1e0j5ii6huph37ua8rfkoc94bqj83ivs.apps.googleusercontent.com">
<title>Insert title here</title>

 <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>	
 <script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Hind:400,700" rel="stylesheet">
	<!-- Bootstrap -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
	<!-- Slick -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick.css" />
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slick-theme.css" />
	<!-- nouislider -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/nouislider.min.css" />
	<!-- Font Awesome Icon -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.min.css">
	<!-- Custom stlylesheet -->
	<link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
	<script src="https://kit.fontawesome.com/d928ba27e6.js" crossorigin="anonymous"></script>
</head>
<script>

 function SelectOption(){

 	 var SelectValue = $('#productChoice option:selected').text();
	 console.log(SelectValue);  
	 $('#productVal').html(SelectValue);
	 var number = $('#productChoice').val();
	 console.log(number);
	 $.ajax({
 		url:'ProductPriceAjax',
 		type:'get',
 		data:{number:number},
 		success:function(result){
 			console.log(result);
 			var price = comma(result);
 			console.log(price);
 			$('#productInfo').show();
 			$('#productPrice').html(price);
 			}
 	});
      };
 
      function comma(num){
    	  return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    	  }
      
      function change(num){
    	  var x = document.form;
    	  var y = Number(count.value)+num;
    	  if(y < 1) y = 1 ;
    	  x.count.value = y;
    	  }
      function countPlus(){
    		var cur = document.getElementById("payValue").value;
    		cur++;
    		document.getElementById("payValue").value = cur
    		var number = cur;
    		var commaPrice = $('#productPrice').html();
    		var price = removeComma(commaPrice);
    			 $.ajax({
    				url:'PricePlusAjax',
    				type:'get',
    				data:{number:number,
    					  price:price},
    				success:function(result){
    					var PlusPrice = comma(result);
    					$('#productPrice').html(PlusPrice);
    					}
    			}); 
    	}
    	function countMinus(){
    		var cur = document.getElementById("payValue").value;
    		if(cur<=1){
    			alert('수량은 1개 이상이여야합니다.');
    		}else{
    		cur--;
    		document.getElementById("payValue").value = cur
    		var number = cur;
    		var commaPrice = $('#productPrice').html();
    		console.log(commaPrice);
    		var price = removeComma(commaPrice);
    			$.ajax({
    				url:'PriceMinusAjax',
    				type:'get',
    				data:{number:number,
    					  price:price},
    				success:function(result){
    					console.log(result);
    					var MinusPrice =comma(result);
    					$('#productPrice').html(MinusPrice);
    					}
    			});
    		}
    	}
    	
    	function removeComma(str)
    	{
    		n = parseInt(str.replace(/,/g,""));
    		return n;
    	}

    	function off(){
    		document.getElementById("overlay").style.display = "none";
    		$('#all-background-color').hide();
    	}
    	function on(){
    		$('#overlay').show();
	    		$('#all-background-color').show();
    		/* var listno = $('#productChoice').val();
    		var productno = ${product.productno};
    		var cur = $('#payValue').val();
    		console.log(listno, productno, cur);
     		$.ajax({
     	    		url:'CartInsert',
     	    		type:'get',
     	    		data:{listno:listno,
     	    			  productno:productno,	
     	    			  cur:cur},
     	    		success:function(result){
     	    			console.log(result);
     	       		$('#overlay').show();
     	    		$('#all-background-color').show();
     	    			}
     	    	}); */
    	}
    	function BasketList(){
    		location.href="CartView";
    	}
    	
    	function deleteCheck(no){
    		var confirmCheck = confirm("해당 게시글을 삭제하시겠습니까?")
    		if(confirmCheck  ==true){
    			location.href="productDelete?productno="+no;
    		}
    	}
    	
    	function Review(no){
    		var number = no;
    		var rating = $('#starVal').val();
    		var contents = $('#contents').val();
    		console.log(rating, contents, number);
    		$.ajax({
 	    		url:'Review',
 	    		type:'get',
 	    		data:{number:number,
 	    			rating:rating,
 	    			contents:contents
 	    			},
 	    		success:function(result){
 	    			var content="";
 		 			$.each(result, function(i, item){
 	    			content +="<div class='single-review'>";
 	    			content += "<div class='review-heading'>";
 	    			content += "<div><a ><i class='fa fa-user-o'></i>"+ item.id+"</a></div>";
 	    			content += "<div><a ><i class='fa fa-clock-o'></i>"+item.sys_date+"</a></div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			if(item.rating==1){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==2){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==3){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==4){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==5){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    			};
 	    			content += "</div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			content += "<div class='review-body'>";
 	    			content +="<p>"+item.contents+"</p>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			/* $('#reviewList').append(content); */
 	    			});
 	    			$('#reviewadd').html(content);
 	    	}
    	});
 		$('#contents').val("");
 		$('input[name="rating"]').removeAttr('checked');

 	   }
    	function ratingval(e){
    		$('#starVal').val(e); 
    	}
    	var page=1;
    	function pageplus(){
    		page ++;
    		var productno = ${product.productno};
    		console.log(page,productno);
    		$.ajax({
 	    		url:'ReviewAjax',
 	    		type:'get',
 	    		data:{page:page,
 	    			productno:productno},
 	    		success:function(result){
 	    			var leng = result.length;
 	    			console.log(leng);
 	    			if(leng ==0){
 	    				alert('마지막페이지입니다.')
 	    			} else{
 	    			var content="";
 		 			$.each(result, function(i, item){
 	    			content +="<div class='single-review'>";
 	    			content += "<div class='review-heading'>";
 	    			content += "<div><a ><i class='fa fa-user-o'></i>"+ item.id+"</a></div>";
 	    			content += "<div><a ><i class='fa fa-clock-o'></i>"+item.sys_date+"</a></div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			if(item.rating==1){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==2){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==3){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==4){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==5){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    			};
 	    			content += "</div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			content += "<div class='review-body'>";
 	    			content +="<p>"+item.contents+"</p>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			/* $('#reviewList').append(content); */
 	    			});
 		 			};
 	    			$('#reviewadd').html(content);
 	    		}
    	});
   	}
    	
    	function pageminus(){
    		page --;
    		var productno = ${product.productno};
    		console.log(page,productno);
    		$.ajax({
 	    		url:'ReviewAjax',
 	    		type:'get',
 	    		data:{page:page,
 	    			productno:productno},
 	    		success:function(result){
 	    			var leng = result.length;
 	    			console.log(leng);
 	    			if(leng ==0){
 	    				page=1;
 	    			} else{
 	    			var content="";
 		 			$.each(result, function(i, item){
 	    			content +="<div class='single-review'>";
 	    			content += "<div class='review-heading'>";
 	    			content += "<div><a ><i class='fa fa-user-o'></i>"+ item.id+"</a></div>";
 	    			content += "<div><a ><i class='fa fa-clock-o'></i>"+item.sys_date+"</a></div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			if(item.rating==1){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==2){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==3){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==4){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star-o empty'></i>";
 	    			} else if(item.rating==5){
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    				content += "<i class='fa fa-star'></i>";
 	    			};
 	    			content += "</div>";
 	    			content += "<div class='review-rating pull-right'>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			content += "<div class='review-body'>";
 	    			content +="<p>"+item.contents+"</p>";
 	    			content += "</div>";
 	    			content += "</div>";
 	    			/* $('#reviewList').append(content); */
 	    			});
 	    			};
 	    			$('#reviewadd').html(content);
 	    		}
    	});
    	}
    	
    	function ProductQna(no){
    		var check = $("input:checkbox[name=qnacheck]").is(":checked"); 
    		if(check ==true){
    			check=1;
    		} else{
    			check=2;
    		};
    		var number = no;
    		var qnacheck = check;
    		var password =$('#password').val();
    		var qnacontents = $('#qnacontents').val();
    		console.log(password, qnacheck,qnacontents, number);
    		$.ajax({
 	    		url:'ProductQna',
 	    		type:'get',
 	    		data:{number:number,
 	    			qnacheck:qnacheck,
 	    			password:password,
 	    			qnacontents:qnacontents
 	    			},
 	    		success:function(result){
 	    			var QnaContents="";
 	    			$.each(result, function(i, item){
 	    				if(item.qnacheck==2){
			   				    QnaContents += "<div class='single-review'>";
			   			        QnaContents += "<div class='review-heading'>";
			   			        QnaContents += "<div><a ><i class='fa fa-user-o'></i> "+item.id+"</a></div>";
			   			        QnaContents += "<div><a ><i class='fa fa-clock-o'></i> "+item.sys_date+"</a></div>";
			   			        QnaContents += "<div class='review-rating pull-right'>";
			   			        QnaContents += "</div>";
			   			        QnaContents += "</div>";
			   			        QnaContents += "<div class='review-body'>";
			   			        QnaContents += "<p>"+item.contents+"</p>";
		 	    			    QnaContents += "<div id='replyAdd"+i+"'>";
		 	    			    QnaContents += "</div>";
		 	    			    QnaContents += "<a style='text-align:right; float:right;' onclick='replayShow("+i+")'><i class='fa fa-commenting'> 답글달기</i></a>"
		 	    			    QnaContents += "<div style='display:none' id='replyArea"+i+"'>";
		 	    			    QnaContents += "<input style='width:90% ; margin-top:20px;' class='input' type='text' id='answer"+i+"'> ";
		 	    			    QnaContents += "<button class='primary-btn' onclick="+"qnaanswer('"+item.qnano+"','"+i+"'"+")>"+"저장</button>";
		  			            QnaContents += "</div>";
		 	    			    QnaContents += "</div>";
		 	    			    QnaContents += "</div>";
		 	    			   var test = rereply(item.qnano,i);
 	    				} else if(item.qnacheck==1){
 	    				      QnaContents += "<div class='single-review'>";
 	    				      QnaContents += "<div id='QnaviewList"+i+"'>";
 	    				      QnaContents += "<a onclick="+"qnaview('"+item.qnano+"','"+item.password+"','"+i+"'"+")>"+"<i class='fa fa-lock'></i> 비밀글입니다.</a>";
 	    				      QnaContents += "</div>";
 	    				      QnaContents += "</div>";
 	    				     var test = rereply(item.qnano,i);
 	    				} 	    						
    				});
 	    			$('#qnaadd').html(QnaContents);
 	    			$('#password').val("");
 	    			$('#qnacontents').val("");
 	    			$('input[name="qnacheck"]').removeAttr('checked');
    		}
    		});
    		}
    	
    	function qnaview(no,pw,index){
    		var qnano =no;
    		var inputString = prompt('비밀번호를입력하세요.');
    		console.log(index);
    		if(inputString == pw){
    			$.ajax({
     	    		url:'QnaView',
     	    		type:'get',
     	    		data:{qnano:qnano,
     	    			inputString:inputString
     	    			},
     	    		success:function(result){
     	    			var QnaContents = "<div class='review-heading'>";
     	 	    			QnaContents += "<div><a ><i class='fa fa-user-o'></i> "+result.id+"</a></div>";
     	 	    			QnaContents += "<div><a ><i class='fa fa-clock-o'></i> "+result.sys_date+"</a></div>";
     	 	    			QnaContents += "<div class='review-rating pull-right'>";
     	 	    			QnaContents += "</div>";
     	 	    			QnaContents += "</div>";
     	 	    			QnaContents += "<div class='review-body'>";
     	 	    			QnaContents += "<p>"+result.contents+"</p>";
							QnaContents += "<div id='replyAdd"+index+"'>";
							QnaContents += "</div>";
							QnaContents += "<a style='text-align:right; float:right;' onclick='replayShow("+index+")'><i class='fa fa-commenting'> 답글달기</i></a>"
							QnaContents += "<div style='display:none' id='replyArea"+index+"'>";
							QnaContents += "<input style='width:90% ; margin-top:20px;' class='input' type='text' id='answer"+index+"'> ";
							QnaContents += "<button class='primary-btn' onclick="+"qnaanswer('"+result.qnano+"','"+index+"'"+")>"+"저장</button>";
	     	 	    		QnaContents += "</div>";
     	 	    			QnaContents += "</div>";
     	 	    			console.log(QnaContents);
     	 	    			$('#QnaviewList'+index).html(QnaContents);
     	 	    			var test = rereply(result.qnano,index);
							console.log(test);
        				}
        		});
    		} else{
 				alert("비밀번호를 다시확인주세요.");
    		}
    		
    	}
    	
    	function qnaanswer(no,e){
    		var qnano = no;
    		var qnaanswer = $('#answer'+e).val();
    		console.log(qnaanswer);
    		$.ajax({
 	    		url:'Qnareply',
 	    		type:'get',
 	    		data:{qnano:qnano,
 	    			qnaanswer:qnaanswer
 	    			},
 	    		success:function(result){
 	    			var reply="";
 	    			console.log(result);
 	    			$.each(result, function(i, item){
 	    			reply += "<div class='single-review' style='margin-left:20px;'>";
 	    			reply += "<div class='review-heading'>";
 	    			reply +="<div><a ><i class='fa fa-user-o'></i>"+ item.id +"</a></div>";
 	    			reply +="<div><a ><i class='fa fa-clock-o'></i>"+ item.sys_date +"</a></div>";
 	    			reply +="<div class='review-rating pull-right'>";
 	    			reply += "</div>";
 	    			reply += "</div>";
 	    			reply += "<div class='review-body' style='margin-left:20px'>";	
 	    			reply += "<p><i class='fas fa-arrow-right'></i>"+item.contents+"</p>"; 
 	    			reply += "</div>";
 	    			reply += "</div>";
    				});
 	    			$('#replyAdd'+e).html(reply);
 	    			$('#answer'+e).val("");
 	    			$('#replyArea'+e).hide();
    		}
    	})
    	}
    	function replayShow(e){
    		$('#replyArea'+e).show();
    	}
    	function rereply(e,a){
 			var reply="";
			var qnano = e;
    		$.ajax({
 	    		url:'QnaRereply',
 	    		type:'get',
 	    		data:{qnano:qnano
 	    			},
 	    		success:function(result){
 	    			console.log(result);
 	    			$.each(result, function(i, item){
 	    			reply += "<div class='single-review' style='margin-left:20px;'>";
 	    			reply += "<div class='review-heading' >";
 	    			reply +="<div><a ><i class='fa fa-user-o'></i>"+ item.id +"</a></div>";
 	    			reply +="<div><a ><i class='fa fa-clock-o'></i>"+ item.sys_date +"</a></div>";
 	    			reply +="<div class='review-rating pull-right'>";
 	    			reply += "</div>";
 	    			reply += "</div>";
 	    			reply += "<div class='review-body' style='margin-left:20px'>";	
 	    			reply += "<p><i class='fas fa-arrow-right'></i>"+item.contents+"</p>"; 
 	    			reply += "</div>";
 	    			reply += "</div>";
 	    		})
	    	 		console.log(reply);
 		    		$('#replyAdd'+a).html(reply);
    		}

    	})

    	}
    	var qnapage=1;
    	function qnaplus(){
    		page ++;
    		var productno = ${product.productno};
    		console.log(page,productno);
    		$.ajax({
 	    		url:'QnaAjax',
 	    		type:'get',
 	    		data:{page:page,
 	    			productno:productno},
 	    		success:function(result){
 	    			var leng = result.length;
 	    			console.log(leng);
 	    			if(leng ==0){
 	    				alert('마지막페이지입니다.')
 	    			} else{
 	    				var QnaContents="";
 	    				$.each(result, function(i, item){
 	    					if(item.qnacheck==2){
 	    						QnaContents += "<div class='single-review'>";
 	    	    				QnaContents += "<div class='review-heading'>";
 	    	 	    			QnaContents += "<div><a ><i class='fa fa-user-o'></i> "+item.id+"</a></div>";
 	    	 	    			QnaContents += "<div><a ><i class='fa fa-clock-o'></i> "+item.sys_date+"</a></div>";
 	    	 	    			QnaContents += "<div class='review-rating pull-right'>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "<div class='review-body'>";
 	    	 	    			QnaContents += "<p>"+item.contents+"</p>";
	 	   						QnaContents += "<div id='replyAdd"+i+"'>";
	 	   						QnaContents += "</div>";
	 	   						QnaContents += "<a style='text-align:right; float:right;' onclick='replayShow("+i+")'><i class='fa fa-commenting'> 답글달기</i></a>"
	 	   						QnaContents += "<div style='display:none' id='replyArea"+i+"'>";
	 	   						QnaContents += "<input style='width:90% ; margin-top:20px;' class='input' type='text' id='answer"+i+"'> ";
	 	   						QnaContents += "<button class='primary-btn' onclick="+"qnaanswer('"+item.qnano+"','"+i+"'"+")>"+"저장</button>";
 	        	 	    		QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			var test = rereply(item.qnano,i);
 	 	    				} else if(item.qnacheck==1){
 	 	    					QnaContents += "<div class='single-review'>";
 	 	    					QnaContents += "<div id='QnaviewList"+i+"'>";
 	 	    					QnaContents += "<a onclick="+"qnaview('"+item.qnano+"','"+item.password+"','"+i+"'"+")>"+"<i class='fa fa-lock'></i> 비밀글입니다.</a>";
 	 	    					QnaContents += "</div>";
 	 	    					QnaContents += "</div>";
 	 	    				} 	    			
 	    				})
 	 	    			$('#qnaadd').html(QnaContents);
 	    			}
 	    		}
    		});
    	}
    	
    	function qnaminus(){
    		page --;
    		var productno = ${product.productno};
    		console.log(page,productno);
    		$.ajax({
 	    		url:'QnaAjax',
 	    		type:'get',
 	    		data:{page:page,
 	    			productno:productno},
 	    		success:function(result){
 	    			var leng = result.length;
 	    			console.log(leng);
 	    			console.log(result);
 	    			if(leng ==0){
 	    				page=1;
 	    			} else{
 	    				var QnaContents="";
 	    				$.each(result, function(i, item){
 	    					if(item.qnacheck==2){
 	    						QnaContents += "<div class='single-review'>";
 	    	    				QnaContents += "<div class='review-heading'>";
 	    	 	    			QnaContents += "<div><a ><i class='fa fa-user-o'></i> "+item.id+"</a></div>";
 	    	 	    			QnaContents += "<div><a ><i class='fa fa-clock-o'></i> "+item.sys_date+"</a></div>";
 	    	 	    			QnaContents += "<div class='review-rating pull-right'>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "<div class='review-body'>";
 	    	 	    			QnaContents += "<p>"+item.contents+"</p>";
	 	   						QnaContents += "<div id='replyAdd"+i+"'>";
	 	   						QnaContents += "</div>";
	 	   						QnaContents += "<a style='text-align:right; float:right;' onclick='replayShow("+i+")'><i class='fa fa-commenting'> 답글달기</i></a>"
	 	   						QnaContents += "<div style='display:none' id='replyArea"+i+"'>";
	 	   						QnaContents += "<input style='width:90% ; margin-top:20px;' class='input' type='text' id='answer"+i+"'> ";
	 	   						QnaContents += "<button class='primary-btn' onclick="+"qnaanswer('"+item.qnano+"','"+i+"'"+")>"+"저장</button>";
 	        	 	    		QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			QnaContents += "</div>";
 	    	 	    			var test = rereply(item.qnano,i);
 	 	    				} else if(item.qnacheck==1){
 	 	    					QnaContents += "<div class='single-review'>";
 	 	    					QnaContents += "<div id='QnaviewList"+i+"'>";
 	 	    					QnaContents += "<a onclick="+"qnaview('"+item.qnano+"','"+item.password+"','"+i+"'"+")>"+"<i class='fa fa-lock'></i> 비밀글입니다.</a>";
 	 	    					QnaContents += "</div>";
 	 	    					QnaContents += "</div>";
 	 	    				}
 	    				})
 	 	    			$('#qnaadd').html(QnaContents);
 	    			}
 	    		}
    		});
    	}
</script>
<body >
<div class="all-background-color" id="all-background-color">
</div>
<div>
	<jsp:include page="/WEB-INF/views/top.jsp"></jsp:include>
</div>
<div id="breadcrumb">
		<div class="container">
			<ul class="breadcrumb">
				<li><a href="#">일반상품 </a></li>
				<li class="active">일반상품(상세)</li>
				<c:if test="${sessionScope.loginIdDivision eq 2}">
				<button class="primary-btn" onclick="location.href='productModifyForm?productno=${product.productno}'" style="margin-left: 5px;float: right;">수정하기</button>
				<button class="primary-btn" onclick="deleteCheck(${product.productno})" style="margin-left: 5px;float: right;">삭제하기</button>
				</c:if>
			</ul>
		</div>
	</div>
       <div class="section">
		<!-- container -->
		<div class="container">
			<!-- row -->
			<div class="row">
				<!--  Product Details -->
				<div class="product product-details clearfix">
					<div class="col-md-6" style="width:120%;">
						<div id="product-main-view" class="slick-initialized slick-slider" style="width:600px;float:left;">
							<div class="slick-list draggable">
								<div class="slick-track" style="opacity: 1; width: 2220px;">
									<img src="${pageContext.request.contextPath}/resources/fileupload/${product.photo2}" alt="" style="width:600px;height:500px;"> 
								</div>
							</div>
					</div>
					<div class="col-md-6" style="float:left;">
						<div class="product-body">
							<div class="product-label">
								<span>New</span>
							</div>
							<h2 class="product-name">${product.trade_name }</h2>
							<h3 class="product-price">${product.price }원  <del class="product-old-price">59,000원</del></h3>
							<p><strong>Brand:</strong> 현대백화점</p>
							<strong>제품설명 :</strong>
							<p>${product.explanation}</p>
							<div class="col-md-12" style="margin-top:30px; padding:0;">
							<h2 class="product-name">옵션 선택 </h2>
								<select class="input search-categories" style="height:50px; width:100%;" name="categoryno" id="productChoice" onChange="SelectOption(this)">
                  					<option value="" >옵션 선택</option>
									  <c:forEach var="result" items="${productList }">
									<option value="${result.listno }" data-sub="${result.option1 }">${result.option1}-${result.option2}(${result.saleprice })원- 재고 : ${result.stock }</option>
										</c:forEach>
								</select>
							</div>
							<div class="product-btns" style="margin-top:180px; ">
								<div id="productInfo" style="border:1px ;height:120px; display:none; background-color:#EEEEEE;">
									<div class="qty-input" style="margin-top: 17px;">
										<h4><span id="productVal" style="margin-top:10px;"></span></h4>
										<span class="text-uppercase">수량 : </span>										
										<input  class="input" type="text" name="count" value="1" id ="payValue">
										<a href="#" onclick="countPlus()" id="plus"> ▲ </a>
										<a href="#" onclick="countMinus()" id="minus"> ▼ </a>
									</div>
									<div class="pull-right" style="width:170px;margin-top:17px;" >
										<h2><strong >상품 가격 </strong></h2>
										<h2><span id="productPrice"> </span>원</h2>
									</div>
								</div>
							</div>
							<div class="product-btns" style="margin-top:20px;">
							<button class="primary-btn" style="width:49%;" onclick="on()"> 장바구니 </button>
							<button class="primary-btn" style="width:49%;"> 구매하기 </button>
							</div>
							<div id="overlay" style="display:none;" >
								 <div class="popup-layout" onclick="off()" >
									 <img src="${pageContext.request.contextPath}/resources/img/basketimg.JPG" style="width: 20%;height: 20%;margin-top: 50px;">
									 <p class="popup-font">장바구니에 상품을 담았습니다.</p>
									 <button class="primary-btn"onclick="off()" >
										<em >계속 쇼핑하기</em >
									 </button>
									 <button class="primary-btn" onclick="BasketList()">
										<em>장바구니로 이동</em>
									 </button>
								 </div>
							 </div>
						</div>
					</div>
					<div class="col-md-12">
						<div class="product-tab">
							<ul class="tab-nav">
								<li class="active"><a data-toggle="tab" href="#tab1">제품설명</a></li>
								<li><a data-toggle="tab" href="#tab2">리뷰</a></li>
								<li><a data-toggle="tab" href="#tab3">문의사항</a></li>
							</ul>
							<div class="tab-content">
								<div id="tab1" class="tab-pane fade in active">
									<div class="section-title">
										<h2 class="title">제품 설명 이미지</h2>
									</div>
									<img src="${pageContext.request.contextPath}/resources/fileupload/${product.photo3}" alt="" style="width:auto;height:auto;margin-left: auto; margin-right: auto; display: block; ">
								</div>
								<div id="tab2" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-6">
											<div class="product-reviews" id="reviewList">

											<div id="reviewadd">
											<c:forEach var="review" items="${review }">
												<div class="single-review">
													<div class="review-heading">
														<div><a ><i class="fa fa-user-o"></i> ${review.id }</a></div>
														<div><a ><i class="fa fa-clock-o"></i> ${review.sys_date} </a></div>
														<div class="review-rating pull-right">
														<c:if test="${review.rating ==1}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
														</c:if>
														<c:if test="${review.rating ==2}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
														</c:if>
														<c:if test="${review.rating ==3}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
															<i class="fa fa-star-o empty"></i>
														</c:if>
														<c:if test="${review.rating ==4}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star-o empty"></i>
														</c:if>
														<c:if test="${review.rating ==5}">
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
															<i class="fa fa-star"></i>
														</c:if>
														</div>
													</div>
													<div class="review-body">
														<p>${review.contents }</p>
													</div>
												</div>
											</c:forEach>
											</div>
											<!-- ★리뷰 댓글 표출 영역 끝★ -->	
											<div style="text-align: center;">
												<button class="primary-btn" onclick="pageminus()">이전 페이지</button>
												<button class="primary-btn" onclick="pageplus()">다음 페이지</button>
											</div>
											</div>
										</div>
										<div class="col-md-6">
											<h4 class="text-uppercase">리뷰작성</h4>
											<div class="review-form">
												<div class="form-group">
													작성자 <input class="input" type="text" placeholder="Your Name" value="${userid }" readonly>
												</div>
												<div class="form-group">
													리뷰작성 <textarea class="input" placeholder="리뷰를 작성해주세요." id="contents"></textarea>
												</div>
												<div class="form-group">
													 <div class="input-rating">
														<strong class="text-uppercase">Your Rating: </strong>
														<div class="stars" >
															<input type="radio" id="star5" name="rating" value="5" onclick="ratingval(5)"><label for="star5"></label>
															<input type="radio" id="star4" name="rating" value="4" onclick="ratingval(4)"><label for="star4"></label>
															<input type="radio" id="star3" name="rating" value="3" onclick="ratingval(3)"><label for="star3"></label>
															<input type="radio" id="star2" name="rating" value="2" onclick="ratingval(2)"><label for="star2"></label>
															<input type="radio" id="star1" name="rating" value="1" onclick="ratingval(1)"><label for="star1"></label>
															<input type="hidden" id="starVal">
														</div>
													</div> 
												</div>
												<button class="primary-btn"  onclick="Review('${product.productno}')">Submit</button>
											</div>
										</div>
									</div>
								</div>
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								<!-- 문의사항 시작 -->
								
								<div id="tab3" class="tab-pane fade in">
									<div class="row">
										<div class="col-md-6">
											<div class="product-reviews">
												<div id="qnaadd">
													<c:forEach var="qna" items="${qna }" varStatus="status">
														<c:if test="${qna.qnacheck ==2 }">
														<div class="single-review">
															<div class="review-heading">
																<div><a ><i class="fa fa-user-o"></i> ${qna.id }</a></div>
																<div><a ><i class="fa fa-clock-o"></i> ${qna.sys_date} </a></div>
																<div class="review-rating pull-right">
																</div>
															</div>
															<div class="review-body" >
																<p>${qna.contents }</p>
																<div id="replyAdd${status.index }">
																	<c:forEach var="answer" items="${answer }" varStatus="status">
																		<c:if test="${qna.qnano==answer.qnano }">
																			<div class="single-review" style="margin-left:20px;">
																				<div class="review-heading">
																					<div><a ><i class="fa fa-user-o"></i> ${answer.id }</a></div>
																					<div><a ><i class="fa fa-clock-o"></i> ${answer.sys_date} </a></div>
																					<div class="review-rating pull-right">
																					</div>
																				</div>
																				<div class="review-body" style="margin-left:20px;">
																					<p><i class="fas fa-arrow-right"></i>${answer.contents }</p>
																					<div id="replyAdd${status.index}">
																					</div>
																					<div style="display:none" id="replyArea">
																						<input style="width:90% ; margin-top:20px;" class="input" type="text" id="answer"> 
																						<!-- <i class="fas fa-arrow-right" style="font-size:25px;"></i> -->
																						<button class="primary-btn" onclick="qnaanswer('${qna.qnano}','${status.index }')"> 저장</button>
																					</div>
																				</div>
																			</div>
																		</c:if>
																	</c:forEach>
																</div>
																<a style="text-align:right; float:right;" onclick="replayShow(${status.index })"><i class="fa fa-commenting"> 답글달기</i></a>
																<div style="display:none" id="replyArea${status.index }">
																<input style="width:90% ; margin-top:20px;" class="input" type="text" id="answer"> 
																	<!-- <i class="fas fa-arrow-right" style="font-size:25px;"></i> -->
																	<button class="primary-btn" onclick="qnaanswer('${qna.qnano}','${status.index }')"> 저장</button>
																</div>
															</div>
														</div>
								
														</c:if>
														<c:if test="${qna.qnacheck==1 }">	
															<div class="single-review">
																<div id="QnaviewList${status.index }">
																	<a onclick="qnaview('${qna.qnano}','${qna.password }','${status.index }')"> <i class="fa fa-lock"></i> 비밀글입니다.</a>
																</div>
															</div>
														</c:if>
													</c:forEach>
												</div>
													<div style="text-align: center;">
													<button class="primary-btn" onclick="qnaminus()">이전 페이지</button>
													<button class="primary-btn" onclick="qnaplus()">다음 페이지</button>
											</div>
											</div>
										</div>
										<div class="col-md-6">
											<h4 class="text-uppercase">문의사항 작성</h4>
											<div class="review-form" >
												<div class="form-group">
													<input class="input" type="text" placeholder="아이디" value="${userid }" readonly>
												</div>
												<div class="form-group">
													<input class="input" type="password" placeholder="비밀번호 4자리" id="password">
												</div>
												<div class="form-group">
													<textarea class="input" placeholder="문의사항 작성" id="qnacontents"></textarea>
												</div>
												<div class="form-group">
													<div class="input-rating">
														<strong class="text-uppercase">비밀글 : </strong>
														<div class="stars">
															<input type="checkbox" id="qnacheck" value="2" name="qnacheck" >
														</div>
													</div>
												</div>
												<button class="primary-btn"  onclick="ProductQna('${product.productno}')">작성</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- /Product Details -->
			</div>
			<!-- /row -->
		</div>
		<!-- /container -->
	</div>
</div>
<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
	<!-- /FOOTER -->
</body>

</html>

