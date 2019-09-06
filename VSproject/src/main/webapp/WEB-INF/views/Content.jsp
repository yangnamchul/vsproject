<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="Header.jsp"%> 
<link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="resources/js/summernote-ko-KR.js"></script>

</head>

<body>

<%-- 	<%@ include file="t_Header.jsp"%> --%>
		


	<div id="content-area">
		<div class="container" id="main">
			<div class="row col-12 col-sm-12 col-lg-12 col-xl-12" id="contentDiv">
				<div class="" id="content-title">Title 제목 ex)아이폰 Vs 갤럭시</div>

				<!-- 				모바일 화면에서 바꿀것 @media-->
				<div class="" id="content-info">
					<%-- 					<td>${vo.b_seq }보드시퀀스</td> --%>
					<%-- 					<td>${vo.u_id }유저아이디</td> --%>
					<%-- 					<td>${vo.b_date }보드작성일</td> --%>
					<ul>
						<li>번호_${vo.b_seq}</li>
						<li>별명_${u_id}</li>
						<li>날짜_${vo.b_date}</li>
						<li>조회_${vo.b_cnt}</li>
						<li>추천_{}</li>
					</ul>
				</div>


				
				<div class="col-12" id="content-vs">
					<div class="col-5" id="vs-left">
						${vo.b_left }
					</div>
					<div class="col-2" id="vs-vs">
						<img src="resources/css/test/versus.png" alt="" />
					</div>
					<div class="col-5" id="vs-right">
						${vo.b_right }
					</div>
				</div>
				<div class="col-12" id="content-vote">
					<div id="vote-title">
						<div style="clear: both">
							<ul>
								<li style="float: left;">갤럭시</li>
								<li style="float: right;">아이폰</li>
							</ul>
						</div>
						<div style="clear: both">
							<ul>
								<li style="float: left;"><button type="button" id="vsLeft" onclick="vsVote(this.id)">전자+ ${uv.u_id}</button></li>
								<li style="float: right;"><button type="button" id="vsRight" onclick="vsVote(this.id)">후자</button></li>
							</ul>
						</div>
						<div style="clear: both">
							<ul>
								<li style="float: left;">${LeftCnt }</li>
								<li style="float: right;">${RightCnt }</li>
							</ul>
							<!-- 	한개 bar에 style width % 직접 값을 가져오는거 같음 -->
						</div>

					</div>
				</div>
				<div id="content-content">${vo.b_content}</div>
                <a href="ip.do"> ip확인하기</a>

			</div>
			<!-- 			댓글입력창 (임시) -->
			<%-- <div class="row col-12 col-sm-12 col-lg-12 col-xl-12"
				id="contentReply">
				<form id="replyform">
					<textarea id="r_reply" name="re_content"></textarea>
					<button type="button" onclick="reply()">댓글등록</button>
				</form>
			</div>
			 
			 <!-- 			댓글 (임시) -->
			 <div class="reply-css">
			<table border="2" id="replytable">
			<c:forEach var="vo" items="${ReplyList}">
								<tr id="reply_list">
									<td>${vo.re_content}</td>
									<td>${vo.re_seq}</td>
									<td><button type="button" onclick="re_create()">대댓달기</button></td>
								</tr>	                     
			</c:forEach>					   
			</table> 	 
      	</div> --%>
				 <!-- 			댓글 ( test) -->
				<div class="row col-12 col-sm-12 col-lg-12 col-xl-12"
				id="contentReply">
				<form id="replyform">
					<textarea id="r_reply" name="re_content"></textarea>
					<button type="button" onclick="reply()">댓글등록</button>
				</form>
			</div>
			 
			 <!-- 			댓글 (임시) -->
			 <div class="reply-css">
			<table border="2" id="replytable">
			<%int cnt=1; %>
			<c:forEach var="vo" items="${ReplyList}">
			
								<tr id="reply_list">
									<td>${vo.re_content}</td>
									<td>${vo.re_seq}</td>
									<td><button type="button" class="rere" id="bt<%=cnt%>">대댓달기</button></td>
								</tr>	 
							 <tr><td><form id="bbt<%=cnt%>" style="display:none">
					<textarea id="r_reply" name="re_content"></textarea>
					<button type="button" onclick="reply()">댓글등록</button>
				</form></td></tr>
			
					                    
				
			<%cnt++; %>
			</c:forEach>	
				                   
			<!-- <tr><td><form id="replyform1" style="display:none">
					<textarea id="r_reply" name="re_content"></textarea>
					<button type="button" onclick="reply()">댓글등록</button>
				</form></td></tr>
			 -->
			
							   
			</table> 	 
      	</div> 
				
		</div>
	</div>
<script>
	$(document).ready(function() {
		$('#r_reply').summernote({
			height : 100,
			minHeight : 100,
			maxHeight : 100,
			focus : true,
			airmode : true,
			lang : 'ko-KR',
			toolbar : false
		});
	});

	
	function reply() {
		if ($("#r_reply").val() == "") {
			alertify.alert("내용을 입력해주세요");
			return;
		};		
		$.ajax({
			type: 'GET',
			url: 'Reply.do?b_seq=${vo.b_seq}',
	        async: false,
	        data : $("#replyform").serialize(),
	        dataType: 'json',//동기 비동기 설정
			 error : function(){
	             alert("통신실패!!!!");
	         },
	         success : function(data){   
	             var objRow = $("#reply_list").clone();  // 복사
	          	 objRow.html('<td>' +data['re_content']+ '</td><td>'+data['re_seq']+'</td><td><button type="button" onclick="re_create()">대댓달기</button></td>');       
	          	$("#replytable").append(objRow);
	          
	         }
		});
		
	}
	
	
	$('.rere').click(function(){
	    var bt_id = $(this).attr("id");
	   $( "#b"+bt_id ).toggle();
		       
	});
	


	       /*  var re_index=$("#reply_list1").lenghth;
	        
	        if(re_index>0){
	        	       $("reply_list1").eq(-2).after('<tr><td><form id="replyform1" style="display:none"><textarea id="r_reply" name="re_content"></textarea><button type="button" onclick="reply()">댓글등록</button></form></td></tr> ')
	        } */
	       /*  else if(re_index==0){
	        	
	        	var re_index2=$("#reply_list2").lenghth;
	        	if(re_index2>0){
	        		if(re_index2>0){
	    	        	$("#reply_list2").eq(-1).after('<tr><td><form id="replyform1" style="display:none"><textarea id="r_reply" name="re_content"></textarea><button type="button" onclick="reply()">댓글등록</button></form></td></tr> ')
	    	        }
	        		else{
	        	        $("#reply_list3").eq(-1).after('<tr><td><form id="replyform1" style="display:none"><textarea id="r_reply" name="re_content"></textarea><button type="button" onclick="reply()">댓글등록</button></form></td></tr> ')   
	        		}
	        	}
	        }//else if */
	        
	    
	
	
	
</script>

<script>
	function vsVote(button_id) {
		var vdata = {
			"button_id" : button_id   //전자를 선택할경우 voteleft가 옴
		};
		jQuery.ajax({
			type : "POST",
			url : "Vote.do?b_seq=${vo.b_seq}",
			data : vdata,
			async : false,
			success : function(data) {
				if (data == "a") {
					alertify.alert("투표 실패");
				} 
				else if(data == "c"){
					alertify.alert("이미 투표하셨습니다.");
				}
				else {
					location.reload();
				}
			},
			error : function(req, status, error) {
				alertify.alert(req.status + "\nmessege" + req.responseTest);
			}
		});
	}
</script>

</body>

</html>