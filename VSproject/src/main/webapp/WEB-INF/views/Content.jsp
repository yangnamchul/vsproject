<%@page import="com.vs.my.User.DAOVO.UserVO"%>
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
				<div class="" id="content-title">
				${vo.b_title }				
				<div id="content-vss" style="display: inline">
						<a href="VSSBoard.do?pg=1&vss_seq=${vo.vss_seq}">
						<span id="vss" style="float: right">${vo.vssName } </span></a>
					</div>
				</div>
				
				

				<!-- 				모바일 화면에서 바꿀것 @media-->
				<div class="col-12" id="content-info">
					<%-- 					<td>${vo.b_seq }보드시퀀스</td> --%>
					<%-- 					<td>${vo.u_id }유저아이디</td> --%>
					<%-- 					<td>${vo.b_date }보드작성일</td> --%>
					<ul>
						<li>번호_${vo.b_seq}</li>
						<li>별명_<span id="vss_u_id">${u_id }</span></li>
						<li>날짜_<span id="vss_date"><fmt:formatDate
									value="${vo.b_date}" pattern="MM-dd HH:mm" /></span>
						<li>조회_${vo.b_cnt}</li>
						<li>추천_<span id="vss_like">${LikeCnt }</span>
						</li>
						<li>비추_<span id="vss_dislike">${UnlikeCnt }</span>
						</li>

					</ul>
				</div>

				<div class=col-12 id="content-info-mb">
					<span id="vss_u_id">${u_id }</span> | <span>조회_${vo.b_cnt }</span>
					| <span id="vss_date"><fmt:formatDate value="${vo.b_date}"
							pattern="MM-dd" /> </span> | 추천_<span id="vss_like">${LikeCnt}</span> |
					비추_<span id="vss_dislike">${UnlikeCnt}</span>
				</div>
			

				<!-- 	이 게시물(b_seq)이 vs_seq를 가지고 있는가? -->
				<div class="col-12" id="content-vs" style="display: inline-flex;">
					<div class="col-5" id="vs-left">${vo.b_left }</div>
					<div class="col-2" id="vs-vs">
						<img src="resources/css/test/versus.png" alt="" />
					</div>
					<div class="col-5" id="vs-right">${vo.b_right }</div>
				</div>
				<div class="col-12" id="content-vote" style="display: inline;">
					<div id="vote-title">
						<!-- 						<div style="clear: both"> -->
						<!-- 							<ul> -->
						<!-- 								<li style="float: left;">갤럭시</li> -->
						<!-- 								<li style="float: right;">아이폰</li> -->
						<!-- 							</ul> -->
						<!-- 						</div> -->
						<div style="clear: both">
							<ul>
								<li style="float: left;"><button type="button" id="vsLeft"
										onclick="vsVote(this.id)">전</button></li>
								<li style="float: right;"><button type="button"
										id="vsRight" onclick="vsVote(this.id)">후</button></li>
							</ul>
						</div>
						<div style="clear: both" id="vs-count">
							<ul>
								<li id="cnt_left" style="float: left;">${LeftCnt }</li>
								<li id="cnt_right" style="float: right;">${RightCnt }</li>
							</ul>
							<!-- 	한개 bar에 style width % 직접 값을 가져오는거 같음 -->
						</div>

						<div class="vs-bar" style="height: 30px;">
							<div id="left-bar" class="progress-bar" role="progressbar"></div>
							<div id="right-bar" class="progress-bar" role="progressbar"></div>
						</div>

					</div>
				</div>


				<div class="col-12" id="content-content">${vo.b_content}</div>



				<div
					class="offset-4 col-4 offset-lg-5 offset-sm-5 col-sm-2 col-lg-2 offset-xl-5 col-xl-2"
					id="content-like">
					<button type="button" id="btn_like" onclick="like(this.id)">
						추천</button>
					<button type="button" id="btn_dislike" onclick="like(this.id)">
						비추</button>
				</div>


				<div class="col-12" id="content-del">
					<button type="button" id="btn_del" onclick="delCon()" style="display:none">글삭제</button>
				</div>
				
			</div>
		

			<div class="row">
				<div class="col-12" id="replyDiv">
					<div class=replyTitle>
						전체 댓글 <span id="reply-cnt">${ReplyCnt}</span>개
					</div>


					<ul id ="replyUlist" class="replyUlist">
						<!-- 						list 반복 -->
						<c:forEach var="vo" items="${ReplyList}" varStatus="status">
						  <c:if test="${not loop_flag }">
                          
						
							<li id="comment_li" class="comment_li">
								<div class="reply-grid">
									<div class="reply-info">
										<span class="reply-writer"> <span id="vss_u_id" class="${vo.u_id}"> ${vo.u_id}</span></span>
										<span class="reply-date"><fmt:formatDate
												value="${vo.re_date}" pattern="MM-dd HH:mm" /></span> 
<!-- 												<span class="reply-vss" > <span id="vss">부스럭</span> 이 댓글이 내가쓴글이면  hidden  or inline -->
<!-- 											<span id="reply_hidden"> -->
												<button type="button" id="reply_del"  class="${vo.re_seq }" onclick="delReply(this.className)">
													<span> 삭제 </span>
												</button>
<!-- 										</span> -->
<!-- 										</span> -->

									</div>
									<div id="reply_content_1">${vo.re_content}</div>
								</div>
							</li>
	                                   <c:if test="${status.count==5}">  <!-- 맨처음 보이는 댓글갯수 -->
                                        <c:set var="loop_flag" value="true" />
                                        </c:if>
                                          </c:if>
	                       
						</c:forEach>



					</ul>
				<!-- 	댓글더보기 -->
						<div class="col-12" id="content-del">
					<button type="button" id="re_plus">더보기</button>
				</div>
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
내 용 : 투표 하기
작성자 : 동언
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
		function vsVote(button_id) {
			var vdata = {
				"button_id" : button_id
			//전자를 선택할경우 voteleft가 옴
			};
			jQuery
					.ajax({
						type : "POST",
						url : "Vote.do?b_seq=${vo.b_seq}",
						data : vdata,
						async : false,
						success : function(data) {
							if (data == "a") {
								alertify.error("투표 실패");
							} else if (data == "c") {
								alertify.error("이미 투표하셨습니다.");
							} else {
								alertify.success('투표 하셨습니다.');
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
	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : 추천 하기
작성자 : 동언
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
		function like(button_id) {
			var vdata = {
					"button_id" : button_id			
				};
				jQuery
						.ajax({
							type : "POST",
							url : "Like.do?b_seq=${vo.b_seq}",
							data : vdata,
							async : false,
							success : function(data) {
								if (data == 0) {
									alertify.error("추천 실패");
								} else if (data == 1) {
									alertify.error("이미 추천하셨습니다.");
								} else {
									alertify.success('추천 하셨습니다.');									
								}
							},
							error : function(req, status, error) {
								alertify.alert(req.status + "\nmessege"
										+ req.responseTest);
							}
						});
		}
	</script>

	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : 댓글 작성
작성자 : 남철
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
	
// 	$('.note-editable').eq(0).attr('id', 're_content');
		$(document).ready(function() {		
			
			$.ajax({
				  url: 'getAllVSS.do',
				  async: false ,
				  dataType : 'json'
				}).then(function(data) {
					window.vss1 = data[0];
					window.vss = Object.keys(vss1);
					window.vss2 = data[1]; 
					console.log(vss);
			});
			
			$('#r_reply').summernote({
				height : 100,
				minHeight : 100,
				maxHeight : 100,
				airmode : false,
				toolbar : false,
				disableDragAndDrop : true,
				shortcuts : false,

				placeholder : ' 댓글 쓰기.. ',
				lang : 'ko-KR',
				hint: {
					    match: /:([a-z|A-Z|\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]*)$/,
					    search: function (keyword, callback) {
					      callback($.grep(vss, function (item) {
					        return item.indexOf(keyword)  === 0;
					      }));
					    },
					    template: function (item) {
					    	var name1 = vss1[item];
					    	var content1 = vss2[item];
//						     	return item + " : " + content1;
					     	return "<span id=vss>" + item + "</span>" + ": " + content1;
					     											     	
					    },
					    content: function (item) {
					    	
					    	var seq = vss1[item];
					    	if (seq) {
//						    		document.getElementsByClassName('note-editable')[2].innerHTML += '<a id="vss" href="VSSBoard.do?vss_seq=' + seq + '">' + item + '</a>';
					      		$('.note-editable').append('<a id="vss" href="VSSBoard.do?pg=1&vss_seq=' + seq + '">' + item + '</a>');
					      		
					    	}
//						    	return $('.note-editable').focus().val("") ;
					    	return '' ;
					    }
					    
					    
					  }

			});
		});

		function reply() {
			if ($("#r_reply").val() == "") {
				alertify.error("내용을 입력해주세요");
				return;
			}
			;
			$.ajax({
				type : 'GET',
				url : 'Reply.do?b_seq=${vo.b_seq}',
				async : false,
				data : $("#replyform").serialize(),
				dataType : 'json',//동기 비동기 설정
				error : function() {
					alertify.error('먼저 로그인 하세요.');
				},
				success : function(data) {
					location.reload();
				}
			});

		}
	</script>

	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : 글 삭제 하기
작성자 : 동언 
수정 :건영
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
	function delCon() {
	if (confirm('글을 삭제 하시겠습니까?')) {		
			jQuery
			.ajax({
				type : "POST",
				url : "delCon.do?b_seq=${vo.b_seq}",
				async : false,
				success : function(data) {
					if (data == 0) {
						alertify.error("삭제 실패");
					} else {
						location.href="Board.do?pg=1";
					}
				},
				error : function(req, status, error) {
					alertify.alert(req.status + "\nmessege"
							+ req.responseTest);
				}
			});
		} else {
			alertify.error("글 삭제 취소") ;
		}
		}
		
		
	</script>


	<!-- ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
내 용 : VS 그래프
■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■ -->
	<script>
$( document ).ready(function() {
	var left = ${LeftCnt} ;
	var right = ${RightCnt} ;
var tot =  ${LeftCnt} + ${RightCnt} ;
var vLeft = (left/tot)*100 ;
var vRight = (right/tot)*100 ;

if(vLeft==0) {
$("#left-bar").css("width",vLeft+"%");
$("#left-bar").text('');
$("#right-bar").css("width",vRight+"%");
$("#right-bar").text(vRight+" %");
}
else if(vRight==0) {
$("#left-bar").css("width",vLeft+"%");
$("#left-bar").text(vLeft+" %");
$("#right-bar").css("width",vRight+"%");
$("#right-bar").text('');
}
else {
$("#left-bar").css("width",vLeft+"%");
$("#left-bar").text(vLeft+" %");
$("#right-bar").css("width",vRight+"%");
$("#right-bar").text(vRight+" %");
}


// if(vLeft != null){	
// 	$("#left-bar").css("width",vLeft+"%");
// 	$("#left-bar").text(vLeft+"%");
// }else{
// 	$("#left-bar").css("width","0%");
// 	$("#left-bar").text("0%");  
// }
// if(vRight != null){	
// 	$("#right-bar").css("width",vRight+"%");
// 	$("#right-bar").text(vRight+"%");
// }else{
// 	$("#right-bar").css("width","0%");
// 	$("#right-bar").text("0%");  
// }
});
	</script>
	
<script>
	$(document).ready(function() {
		var u_id = '<%=u_id%>' ;
		if (u_id == '${ u_id }') {
			$('#btn_del').css('display','block');
		} else if (u_id == ${u_id}) {
			$('#btn_del').css('display','block');
		} else {
			$('#btn_del').css('display','none');
		}
		
	});
</script>
<script>
	$(document).ready(function() {
		var data = ${data};
		if (data != 0) {
			$('#content-vs').css('display','inline-flex');
			$('#content-vote').css('display','inline');
		} else {
			$('#content-vs').css('display','none');
			$('#content-vote').css('display','none');
		}
	});
</script>
<script>

Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
 
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
     
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
 
String.prototype.string = function(len){var s = '', i = 0; while (i++ < len) { s += this; } return s;};
String.prototype.zf = function(len){return "0".string(len - this.length) + this;};
Number.prototype.zf = function(len){return this.toString().zf(len);};


var cnt=0;   //re_plus클릭시마다 증가(댓글5개씩 순차적으로 가져오기위함.)
$("#re_plus").click(function() { 
	cnt++;
	$.ajax({
		type: 'GET',
		url: 'Reply1.do?b_seq=${vo.b_seq}',
        async: false,
		error : function(){
         },
         success : function(data){
          var date=new Date();
          console.log(date.format('MM-dd HH:mm')); /*  테스트 */
          for(var i=(cnt*5)+1; i<(cnt+1)*5  ;i++){	
        	 console.log( data[i]['re_seq'] );
        	/*   if(data[i]==null){		 
         		 alert("더이상 댓글이 존재하지 않습니다.");
         	 }; */
             date = new Date(data[i]['re_date']);
             var objRow = $("#comment_li").clone();  //li 복사
          	 /* objRow.html('<li id="comment_li" class="comment_li">' */
          	 objRow.html('<div class="reply-grid">'
						+'<div class="reply-info">'
						+'<span class="reply-writer"> <span id="vss_u_id" class="'+ data[i]['u_id'] +'">' +data[i]['u_id']+'</span> </span>'
						+'<span class="reply-date">'+date.format('MM-dd HH:mm')+'</span> '
								+'	<button type="button" id="reply_del" class="' + data[i]['re_seq'] + '" onclick="delReply(this.className)">'
								+'		<span> 삭제 </span>'
								+'	</button>'
								+'</div>'
								+'	<div id="reply_content_1">'+data[i]['re_content']+'</div>'
								+'	</div>'
								+'</li>');
          	 
          	$("#replyUlist").append(objRow);
          
          }
         }
         
	});
	
});
</script>

<script>
	function delReply(button_class) {
		var re_seq = button_class;
		if (confirm('댓글을 삭제 하시겠습니까?')) {		
			jQuery
			.ajax({
				type : "POST",
				url : "delReply.do?re_seq="+re_seq,
				async : false,
				success : function(data) {
					if (data == 0) {
						alertify.error("삭제 실패");
					} else if (data == 1) {
						alertify.error("본인만 삭제 가능합니다.");
					} else {
						location.href="Content.do?b_seq=${vo.b_seq}";
					}
				},
				error : function(req, status, error) {
					alertify.alert(req.status + "\nmessege"
							+ req.responseTest);
				}
			});
		} else {
			alertify.error("댓글 삭제 취소") ;
		}
	}
</script>

</body>

</html>