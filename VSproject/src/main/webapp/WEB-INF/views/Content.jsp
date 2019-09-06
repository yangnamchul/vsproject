<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="Header.jsp"%>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.css"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-lite.js"></script>
<script src="resources/js/summernote-ko-KR.js"></script>

</head>

<body>

	<%-- 	<%@ include file="t_Header.jsp"%> --%>

	<div id="content-area">
		<div class="container" id="main">
			<div class="row col-12 col-sm-12 col-lg-12 col-xl-12" id="contentDiv">
				<div class="" id="content-title">${vo.b_title }</div>

				<!-- 				모바일 화면에서 바꿀것 @media-->
				<div class="" id="content-info">
					<%-- 					<td>${vo.b_seq }보드시퀀스</td> --%>
					<%-- 					<td>${vo.u_id }유저아이디</td> --%>
					<%-- 					<td>${vo.b_date }보드작성일</td> --%>
					<ul>
						<li>번호_${vo.b_seq}</li>
						<li>별명_${u_id}</li>
						<li>날짜_<fmt:formatDate value="${vo.b_date}" pattern="MM-dd" />
						<li>조회_${vo.b_cnt}</li>
						<li>추천_{}</li>
					</ul>
				</div>


	
				<div class="col-12" id="content-vs">
					<div class="col-5" id="vs-left">${vo.b_left }</div>
					<div class="col-2" id="vs-vs">
						<img src="resources/css/test/versus.png" alt="" />
					</div>
					<div class="col-5" id="vs-right">${vo.b_right }</div>
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
								<li style="float: left;"><button type="button" id="vsLeft"
										onclick="vsVote(this.id)">전자</button></li>
								<li style="float: right;"><button type="button"
										id="vsRight" onclick="vsVote(this.id)">후자</button></li>
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


			</div>
			<!-- 			댓글입력창 (임시) -->

			<div class="row">
				<div class="col-12" id="replyDiv">
					<div class=replyTitle>전체 댓글  <span id="reply-cnt">${ReplyCnt}</span>개</div>


					<ul class="replyUlist">
						<!-- 						list 반복 -->
						<c:forEach var="vo" items="${ReplyList}">
							<li id="" class="comment_li">
								<div class="reply-grid">
									<div class="reply-info">
										<span class="reply-writer"> <span id="vss_u_id">${vo.u_id}</span></span>
										<span class="reply-date"><fmt:formatDate
												value="${vo.re_date}" pattern="MM.dd HH:mm" /></span> 
									    <span class="reply-vss"> <span id="vss">부스럭</span>
									    
<!-- 									    이 댓글이 내가쓴글이면  hidden  or inline-->
									    <span id="reply_hidden" style="display: hidden;">
									    <button type="button" id="reply_del" value="삭제" > <span> 삭제 </span></button>
									    <button type="button" id="reply_edit" > <span>수정</span> </button>
									    </span>  
										</span>

									</div>
									<div>${vo.re_content}</div>
								</div>
							</li>

						</c:forEach>

						<!-- 						<li id="" class="commnet_li"> -->
						<!-- 							<div class="reply-grid"> -->
						<!-- 								<div class="reply-info"> -->
						<!-- 									<span class="reply-writer"> <span id="vss_u_id">작성자2222</span></span> -->
						<!-- 									<span class="reply-date">19.08.20 21:52</span> <span -->
						<!-- 										class="reply-vss"> <span id="vss">부스러기</span> -->
						<!-- 									</span> -->

						<!-- 								</div> -->
						<!-- 								<div>댓글내용 아무말 아무말아무말 아무말아무말 아무말아무말 아무말아무말 아무말아무말 아무말아무말 -->
						<!-- 									아무말아무말 아무말아무말 아무말?</div> -->
						<!-- 							</div> -->
						<!-- 						</li> -->


					</ul>
					<div id="reply-form">
						<form id="replyform">
							<textarea id="r_reply" name="re_content" maxlength="250"></textarea>
							<div id="reply-submit">
								<button type="button" onclick="reply()" id="reply-btn">등록</button>
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : 댓글 작성
작성자 : 남철
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
		$(document).ready(function() {
			$('#r_reply').summernote({
				height : 100,
				minHeight : 100,
				maxHeight : 100,				
				airmode : true,
				placeholder : ' 댓글 쓰기.. ',
				lang : 'ko-KR',
				toolbar : false
			});
		});

		function reply() {
			if ($("#r_reply").val() == "") {
				alertify.alert("내용을 입력해주세요");
				return;
			}
			;
			$
					.ajax({
						type : 'GET',
						url : 'Reply.do?b_seq=${vo.b_seq}',
						async : false,
						data : $("#replyform").serialize(),
						dataType : 'json',//동기 비동기 설정
						error : function() {
							alert("통신실패!!!!");
						},
						success : function(data) {						
							location.reload();
						}
					});

		}
	</script>


	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : 투표 하기
작성자 : 동언
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
		function vsVote(button_id) {
				var vdata = {
					"button_id" : button_id
				//전자를 선택할경우 voteleft가 옴
				};
				jQuery.ajax({
					type : "POST",
					url : "Vote.do?b_seq=${vo.b_seq}",
					data : vdata,
					async : false,
					success : function(data) {
						if (data == "a") {
							alertify.alert("투표 실패");
						} else if (data == "c") {
							alertify.alert("이미 투표하셨습니다.");
						} else {
							location.reload();
						}
					},
					error : function(req, status, error) {
						alertify.alert(req.status + "\nmessege"
								+ req.responseTest);
					}
				});
			}
		
	</script>

</body>

</html>