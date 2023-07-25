<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>Insert title here</title>

<script>
	document.addEventListener("DOMContentLoaded",function() {
	document.getElementById("sendchat").addEventListener("click",function() {
		var crew_chat_text = document.getElementById("chatcontent").value;
		
		var formData = new FormData();
		formData.append('crew_chat_text', crew_chat_text);
		
		// AJAX 요청 보내기
		const xhr = new XMLHttpRequest();
	
		xhr.onreadystatechange = function()  {
			if (xhr.readyState == 4 && xhr.status == 200) {
				location.reload();
				
				console.log(xhr.responseText);
				}
			};
		  
		  xhr.open('POST', '/travel/crew/sendchat', true);
		  xhr.send(formData);
	})
	})
</script>

<script>
	function boardwrite() {
		var crew_board_title = document.getElementById("crew_board_title").value;
		var crew_board_content = document.getElementById("crew_board_content").value;
		var crew_board_visibility = document.getElementById("crew_board_visibility").value;
		
		if(crew_board_title == "") {
			alert("제목을 입력하세요");return
		}
		if(crew_board_content == "") {
			alert("내용을 입력하세요");return
		}
		
		crew_board_notice = 'N';

		
		$.ajax({
			url : "/travel/crew/crewboard/write",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
				"crew_board_title" : crew_board_title,
				"crew_board_content" : crew_board_content,
				"crew_board_visibility" : crew_board_visibility,
				"crew_board_notice" : crew_board_notice
				}),
				success : function() {
					if( document.getElementById("image-upload").value != null) {
						console.log("사진있음")
						uploadPhotos();
					}
					else {
						console.log("사진없음")
						alert("작성이 완료되었어요!");
					      location.reload();
					}
					},
					error : function(err) {
						console.error("삭제 실패",err);
						}
					});
		}

</script>

<script>
function uploadPhotos() {
	var formData = new FormData();
	var files = document.getElementById("image-upload").files;
	for(var i = 0; i<files.length;i++) {
		formData.append('files', files[i]);
	}

	// AJAX 요청 보내기
	  const xhr = new XMLHttpRequest();
	  xhr.open('POST', '/travel/crew/crewboard/uploadfiles', true);

	  xhr.onreadystatechange = function() {
	    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
	      // 요청이 성공적으로 완료되었을 때 처리할 로직
	      alert("작성이 완료되었습니다.");
	      location.reload();
	      
	      console.log(xhr.responseText);
	    }
	  };

	  xhr.send(formData);

	}

</script>

<script>
	document.addEventListener("DOMContentLoaded",function() {
		var openBoardWrite = document.getElementById("openBoardWrite");
		openBoardWrite.addEventListener("click",function() {

											//    	if(crew_member_grade_default_id <=2) {
											//			document.getElementById("checknoticesetting").innerHTML += `
											//			<div class="form-check position-absolute top-0 end-10">
											//		<input class="form-check-input " type="checkbox"
			//		name="crew_board_notice" value="Y" id="noticesetting">
											//	<label class="form-check-label" for="flexCheckDefault">공지
											//		</label>
											//	</div>
											//	`;
											//		}

											var boardwrite = bootstrap.Modal
													.getOrCreateInstance("#boardWriteModal");
											boardwrite.show();

										})
					})
</script>

<script>
function likeboard(crew_member_id, crew_board_id, board_writer_id) {
	$.ajax({
		url : "/travel/crew/likeboard",
		type : "POST",
		contentType : "application/json",
		data : JSON.stringify({
			"crew_member_id" : crew_member_id,
			"crew_board_id" : crew_board_id
		}),
		success : function(res) {
			location.reload();
		},
		error : function(err) {
			console.error("삭제 실패", err);
		}
	});
}

function dislikeboard(crew_member_id, crew_board_id, board_writer_id) {
		$.ajax({
			url : "/travel/crew/dislikeboard",
			type : "POST",
			contentType : "application/json",
			data : JSON.stringify({
				"crew_member_id" : crew_member_id,
				"crew_board_id" : crew_board_id
			}),
			success : function(res) {
				location.reload();
			},
			error : function(err) {
				console.error("삭제 실패", err);
			}
		});


}
</script>

<script>
function deleteboard(crew_board_id) {
	console.log(crew_board_id)
	    // AJAX 요청 보내기
	    if (confirm("정말 게시글을 삭제하시겠습니까?")) {
	            $.ajax({
	        url: "/travel/crew/deleteboard",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({
	        	"crew_board_id": crew_board_id
	        }),
	        success: function(res) {
	            alert("삭제되었습니다.");
	            window.location.href = res
	        },
	        error: function(err) {
	            console.error("삭제 실패", err);
	        }
	    });

	    }
	}
</script>

<script>
function getcommentlist() {
	  var commentlist = $('.commentlist');

	  // 현재 display 속성값 확인
	  var currentDisplay = commentlist.css('display');

	  // display 속성 toggle
	  if (currentDisplay === 'block') {
	    commentlist.css('display', 'none');
	  } else if (currentDisplay === 'none') {
	    commentlist.css('display', 'block');
	  }
}

</script>

<script>
function writecomment(crew_board_id, index) {
    var crew_comment = document.getElementById('comment-' + index).value;
    console.log(crew_comment);
    
    // AJAX 요청 보내기
    $.ajax({
        url: "/travel/crew/createcomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            "crew_comment": crew_comment,
            "crew_board_id": crew_board_id
        }),
        success: function(res) {
        alert("작성이 완료되었어요!");
        location.reload();
        },
        error: function(err) {
            console.error("댓글 작성 실패", err);
        }
    });
}
        
</script>

<script>
function commentdelete(board_comment_id) {
    // AJAX 요청 보내기
    if (confirm("댓글을 삭제하시겠습니까?")) {
            $.ajax({
        url: "/travel/crew/deletecomment",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
        	"board_comment_id": board_comment_id
        }),
        success: function(res) {
            alert("댓글이 삭제되었습니다.");
            location.reload();
        },
        error: function(err) {
            console.error("댓글 삭제 실패", err);
        }
    });

    }
}
</script>
<script>
document.addEventListener("DOMContentLoaded", function (event) {
    var joincrew = document.getElementById("cancelapply");
    joincrew.addEventListener("click", function () {
    	bootstrap.Modal.getOrCreateInstance("#cancelapplymodal").show();
    })
    document.getElementById("cancelmycrewapply").addEventListener("click", function () {
    	var crew_domain = "${crewDto.crew_domain}";
        var formData = new FormData();
        formData.append("crew_domain",crew_domain);
        
        // AJAX 요청 보내기
        const xhr = new XMLHttpRequest();
        xhr.open('POST', '/travel/crew/cancelrequest', true);

        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
            // 요청이 성공적으로 완료되었을 때 처리할 로직
            alert("신청이 취소되었습니다.");
            bootstrap.Modal.getOrCreateInstance("#cancelapply").hide();
            location.reload();
            console.log(xhr.responseText);
            }
        };

        xhr.send(formData);
    })
})
</script>
    <script>
        document.addEventListener("DOMContentLoaded", function (event) {
            var joincrew = document.getElementById("joincrew");
            joincrew.addEventListener("click", function () {
                bootstrap.Modal.getOrCreateInstance("#joincrewmodal").show();
            });
            
            
            document.getElementById("joincrewrequest").addEventListener("click", function () {
                if(!document.getElementById("flexCheckDefault").checked) {
                    alert("크루 개인정보보호정책에 동의해주세요.");return;
                }
                if(document.getElementById("crew_join_request_intro").value == null) {
                    alert("소개를 작성해주세요");return;
                }
                var crew_domain = "${crewDto.crew_domain}";
                var crew_desc = document.getElementById("crew_join_request_intro").value;

				console.log(crew_domain);
				console.log(crew_desc);
                
                var formData = new FormData();
                formData.append("crew_domain",crew_domain);
                formData.append("crew_join_request_intro", crew_desc);

                // AJAX 요청 보내기
                const xhr = new XMLHttpRequest();
                xhr.open('POST', '/travel/crew/requestcrew', true);

                xhr.onreadystatechange = function() {
                    if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                    // 요청이 성공적으로 완료되었을 때 처리할 로직
                    alert("가입 신청이 완료되었습니다.<br>리더가 승인하면 크루에 가입됩니다.");
                    bootstrap.Modal.getOrCreateInstance("#joincrewmodal").hide();
                    location.reload();
                    console.log(xhr.responseText);
                    }
                };

                xhr.send(formData);

            });

            
            
            
            
        });



    </script>
<style>
body {
	background-color: #f2f2f2;
	overflow-x: hidden;
}

.sidebar {
	position: fixed;
}

.commentwritedate {
	font-size: 12px;
}

.sidebar {
	width: 19vw;
}

.margin-left-col {
	margin-left: 5vw;
	/* Adjust this value to match the width of the fixed sidebar */
}

.icon {
	height: 30px;
	/* Adjust the height value as needed */
}

strong#Createnewpost {
	font-size: 17px;
}

.postwriter {
	font-size: 17px;
}

.postregdate {
	font-size: 13px;
	color: grey;
}

.bi {
	font-style: normal;
}

.card {
	border-style: hidden;
}

.nonboarder {
	border: none;
}

.postwritearea {
	background-color: #f5f5f5;
	font-size: 14px;
}

.nav-pills .nav-link.active {
	background-color: #BB2649;
}

.sideend {
	margin: 20px;
}

.imageContainer {
	display: flex;
	overflow-x: auto;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.imageItem {
	position: relative;
	flex: 0 0 auto;
	margin-right: 10px;
}

.imageItem img {
	width: 150px;
	height: 150px;
	object-fit: cover;
	border-radius: 5px;
}

.deleteButton {
	position: absolute;
	top: 5px;
	right: 5px;
	background-color: rgba(255, 255, 255, 0.8);
	border: none;
	border-radius: 50%;
	padding: 5px;
	font-size: 12px;
	cursor: pointer;
}

.preview-item {
	position: relative;
	display: inline-block;
}

.preview-image {
	max-width: 200px;
	max-height: 200px;
	margin: 5px;
}

.delete-button {
	position: absolute;
	top: 5px;
	right: 5px;
	padding: 2px 5px;
	background-color: red;
	color: white;
	border: none;
	border-radius: 50%;
	cursor: pointer;
}

.commentwriter {
	font-size: 14px;
	font-weight: bold;
}

.text88 {
	color: #888888;
}
.textwhite {
	color: white;
}

/* Scrollbar 커스터마이징 */
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-track {
	background-color: #f1f1f1;
}

::-webkit-scrollbar-thumb {
	background-color: #888;
	border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
	background-color: #555;
}

.commentlist {
	display: none;
}

.nocomment {
	font-size: 15px;
}

.commentcard {
	background-color: gainsboro;
}

.textcolourdefault {
	color: #888888;
}

#crewmain {
	background-color: #17b75e;
		color:white;
}

.vs {
	font-size: 14px;
}

.maintopnavi {
	background-color: #f2f2f2;
}

.aa {
	margin-top: 75px;
	overflow: scroll;
}

.crewsidenavi {
	position:fixed;
	width: 208px;
    padding-bottom: 20px;
    margin-right: 18px;
}

.crewsidebar {
	background-color : white; 
	border-radius: 5px;
}


.calendarcard {
	position: fixed;
	background-color: white;
	width: 350px;
	height:  500px;
}

.chatcard {
	background-color: grey;
}

.writercard {
	background-color: green;
}

.chatarea {
	height: 80%;
	overflow-x: hidden;
	overflow-y: auto;
}
</style>




</head>

<body>

	<div class="container-fluid ">
		<div class="container fixed-top top-navi maintopnavi">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		<div class="container aa">
			<div class="row">
				<div class="col-3">
					<aside id="info" style="transform: none;">
						<div id="infoInner" data-viewname="DBandCoverItemView" class="infoInner -sticky" style="position: relative; overflow: visible;">
							<jsp:include page="../common/crewHomeNavi.jsp"></jsp:include>
						</div>
					</aside>
				</div>
			
				<div class="col-6">

					<div class="container main px-4">
						<div class="row mb-2">
							<div class="col px-0">
								<input type="text" class="form-control nonboarder"
									placeholder="Search">
							</div>
						</div>
						<div class="row">
						<c:if test="${!empty crewMemberDto }">
							<div class="card boardwrite" id="openBoardWrite">
								<div class="row mx-2 mt-3">
									<div class="col-auto">
										<Strong id="Createnewpost">게시글 작성하기</Strong>
									</div>
									<div class="col text-end">
										<i class="bi bi-three-dots"></i>
									</div>
								</div>
								<div class="row m-3" id="postwriteform">
									<textarea class="form-control postwritearea nonboarder"
										placeholder="Type a text" id="boardcontent"
										style="height: 100px"></textarea>
								</div>
								<div class="row mx-3 mb-3">
									<div class="col-auto">
										<i class="bi bi-images"></i>
									</div>
									<div class="col-auto">
										<i class="bi bi-folder-plus"></i>
									</div>
									<div class="col text-end">
										<button class="btn btn-success btn-sm">Publish</button>
									</div>
								</div>
							</div>
							</c:if>
						</div>
						

						<div class="row">
							<c:choose>
								<c:when test="${!empty list }">
									<c:forEach var="list" items="${list}" varStatus="status">
										<div class="card boardlist mt-3 p-2 pb-3">
											<div class="row mx-2 ">
												<div
													class="col-auto d-flex justify-content-center align-items-center">
													<img
														src="/uploadFiles/profileImage/${list.userDto.user_image }"
														alt="" width="45" height="45" class="rounded-circle">
												</div>
												<div class="col-auto">
													<div class="row mt-3">
														<div class="col-auto">
															<Strong class="postwriter">${list.userDto.user_nickname }</Strong>
														</div>
													</div>
													<div class="row">
														<div class="col-auto pt-1">
															<p class="postregdate">
																<fmt:formatDate value="${list.c.crew_board_reg_date }"
																	pattern="yyyy-MM-dd HH:mm" var="regdate" />
																${regdate }
															</p>
														</div>
														<div class="col ps-0 pb-3">
															<c:choose>
																<c:when
																	test="${list.c.crew_board_visibility == 'public' }">
																	<i class="bi bi-globe-americas vs"></i>
																</c:when>
																<c:otherwise>
																	<i class="bi bi-people-fill vs"></i>
																</c:otherwise>
															</c:choose>
														</div>
													</div>
												</div>
												<div class="col text-end mt-3">
													<i class="bi bi-three-dots" data-bs-toggle="dropdown"></i>
													<ul class="dropdown-menu">
														<li class="dropdown-item" id="commentmodify">수정2</li>
														<li class="dropdown-item"
															onclick="deleteboard('${list.c.crew_board_id}')">삭제</li>
													</ul>
												</div>
											</div>
											<div class="row m-2" id="getboarddetails">
												<h5>${list.c.crew_board_title }</h5>
												<p class="postcontent">${list.c.crew_board_content }</p>
											</div>

											<div class="row mx-2 mb-3">
												<c:if test="${!empty list.files }">
													<div id="carouselExample" class="carousel slide">
														<div class="carousel-inner">
															<c:forEach var="photos" items="${list.files}"
																varStatus="status">
																<c:if test="${status.index == 0}">
																	<div class="carousel-item active">
																		<img
																			src="/uploadFiles/crewFiles/crewboard/${photos.crew_board_id}/${photos.crew_board_attached}"
																			class="d-block w-100"
																			alt="${photos.crew_board_original_attached}">
																	</div>
																</c:if>
																<c:if test="${status.index != 0}">
																	<div class="carousel-item">
																		<img
																			src="/uploadFiles/crewFiles/crewboard/${photos.crew_board_id}/${photos.crew_board_attached}"
																			class="d-block w-100"
																			alt="${photos.crew_board_original_attached}">
																	</div>
																</c:if>
															</c:forEach>
														</div>
														<button class="carousel-control-prev" type="button"
															data-bs-target="#carouselExample" data-bs-slide="prev">
															<span class="carousel-control-prev-icon"
																aria-hidden="true"></span> <span class="visually-hidden">Previous</span>
														</button>
														<button class="carousel-control-next" type="button"
															data-bs-target="#carouselExample" data-bs-slide="next">
															<span class="carousel-control-next-icon"
																aria-hidden="true"></span> <span class="visually-hidden">Next</span>
														</button>
													</div>
												</c:if>

											</div>

											<div class="row mx-2">
												<div class="col-auto">
													<c:choose>
														<c:when test="${empty list.liked }">
															<i class="bi bi-suit-heart"
																onclick="likeboard('${crewMemberDto.crew_member_id}', '${list.c.crew_board_id }', '${list.c.crew_member_id }')">
																${list.boardlikecount }</i>
														</c:when>
														<c:otherwise>
															<i class="bi bi-suit-heart-fill"
																onclick="dislikeboard('${crewMemberDto.crew_member_id}', '${list.c.crew_board_id }', '${list.c.crew_member_id }')">
																${list.boardlikecount }</i>
														</c:otherwise>
													</c:choose>

												</div>
												<div class="col-auto">
													<i class="bi bi-chat-left-text"
														onclick="getcommentlist('${list.c.crew_board_content}')">
														${list.boardcommentcount }</i>
												</div>
												<div class="col text-end">
													<i class="bi bi-bookmark-plus"></i>
												</div>
											</div>
										</div>
										<div class="commentlist card p-2" style="display: block;">
											<div class="row p-2">
												<div class="col pe-0">
													<input placeholder="댓글 내용을 입력하세요."
														class="postwritearea nonboarder form-control"
														name="board_comment_content" id="comment-${status.index}">
												</div>
												<div class="col-auto px-3 pt-1">
													<i class="bi bi-send "
														onclick="writecomment('${list.c.crew_board_id}', '${status.index}')"></i>
												</div>
											</div>
											<c:choose>
												<c:when test="${list.boardcommentcount != 0 }">
													<c:forEach var="comment" items="${list.commentlist}">
														<div class="row m-2">
															<div class="col-auto px-0">
																<img
																	src="/uploadFiles/profileImage/${comment.commentWriter.user_image }"
																	width="35" height="35" class="rounded-circle ">
															</div>
															<div class="col me-4">
																<div class="card commentcard  p-2 ">
																	<div class="row ">
																		<div class="col commentwriter">
																			${comment.commentWriter.user_nickname }</div>
																	</div>
																	<div class="row ">
																		<div class="col commentcontent">
																			${comment.crewBoardCommentDto.crew_comment }</div>
																	</div>

																</div>
																<div class="row">
																	<div class="col commentwritedate mt-1">
																		<fmt:formatDate
																			value="${comment.crewBoardCommentDto.crew_comment_date }"
																			pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
																		${formattedDate }
																	</div>
																	<div class="col text-end">
																		<c:if
																			test="${comment.crewBoardCommentDto.crew_member_id == crewMemberDto.crew_member_id }">
																			<i class="bi bi-three-dots" data-bs-toggle="dropdown"></i>
																			<ul class="dropdown-menu">
																				<li class="dropdown-item" id="commentmodify">수정</li>
																				<li class="dropdown-item"
																					onclick="commentdelete('${comment.crewBoardCommentDto.board_comment_id}')">삭제</li>
																			</ul>
																		</c:if>
																	</div>
																</div>
															</div>
														</div>

													</c:forEach>
												</c:when>
												<c:otherwise>
													<div class="row py-5">
														<div class="col text-center nocomment">등록된 댓글이 없습니다.
														</div>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<div class="row mt-5">
										<div class="col text-center mt-5">등록된 게시글이 없습니다.</div>
									</div>
								</c:otherwise>
							</c:choose>

							<!--반복 끝-->

						</div>
					</div>
				</div>
				<div class="col-3 ps-4">
					<div class="card calendarcard">
						<div class="row mx-1 sticky-header">
							<div class="col p-2">
								크루 전체 채팅
							</div>
						</div>
						<div class="card chatarea">
							<c:forEach var="chat" items="${chatlist}">
								<c:choose>
									<c:when test="${chat.sender.user_id != userDto.user_id }">
										<div class="row">
											<div class="col-auto pt-3 ps-4 pe-1">
												<img src="/uploadFiles/profileImage/${chat.sender.user_image }" width="40px" height="40px" class="rounded-circle">
											</div>
											<div class="col">
												<div class="row">
													<div class="col">
														${chat.sender.user_nickname }
													</div>
												</div>
												<div class="row">
													<div class="col-auto">
														<div class="card chatcard p-1">
															${chat.chatDto.crew_chat_text }
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col">
														<fmt:formatDate value="${chat.chatDto.crew_chat_date }" pattern="MM.dd HH:mm" var="crew_chat_date" />
															${crew_chat_date }
													</div>
												</div>
											</div>
										</div>
									</c:when>
									<c:otherwise>
										<div class="row">
											<div class="col me-2">
												<div class="row">
													<div class="col">
													</div>
													<div class="col-auto text-end">
														<div class="card writercard p-1">
															${chat.chatDto.crew_chat_text }
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col text-end">
														<fmt:formatDate value="${chat.chatDto.crew_chat_date }" pattern="MM.dd HH:mm" var="crew_chat_date" />
															${crew_chat_date }
													</div>
												</div>
											</div>
										</div>
		
									</c:otherwise>
								</c:choose>
	
							</c:forEach>
						</div>
						<div class="chatwrittingarea">
							<div class="row sticky-header">
								<div class="col-9 ms-4 px-0">
									<input type="text" class="form-control" id="chatcontent">
								</div>
								<div class="col-auto ps-0">
									<button class="btn btn-sm btn-success-outline" id="sendchat">send</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	
	<div class="container-fluid aa"></div>
	<!-- Modal -->

	<div class="modal fade" id="boardWriteModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">게시글 작성</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">

					<div class="row profile">
						<div
							class="col-auto d-flex justify-content-center align-items-center">
							<img src="/uploadFiles/profileImage/${userDto.user_image }"
								alt="" width="45" height="45" class="rounded-circle">
						</div>
						<div class="col-auto">
							<div class="row">
								<div class="col-auto">
									<Strong class="postwriter">${userDto.user_nickname }</Strong>
								</div>
							</div>
							<div class="row">
								<div class="col-auto">
									<select class="form-select form-select-sm"
										id="crew_board_visibility">
										<option selected value="public">전체공개</option>
										<option value="crewonly">크루공개</option>
									</select>
								</div>
							</div>
						</div>
					</div>

					<div class="row writeform">
						<div class="col">
							<div class="form-check form-switch"></div>
						</div>
						<div class="col-3" id="checknoticesetting"></div>
					</div>
					<div>
						<input type="text" class="form-control" name="crew_board_title"
							id="crew_board_title" placeholder="제목을 입력해주세요"> <br>
						<textarea class="form-control" placeholder="오늘도 힘찬 하루를!"
							name="crew_board_content" id="crew_board_content"
							style="height: 150px" required></textarea>
					</div>
					<hr>
					<form id="uploadForm" enctype="multipart/form-data">
						<input type="file" name="image-upload" id="image-upload" multiple>
					</form>
					<div id="preview-container" class="sortable-container"></div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button type="submit" class="btn btn-success"
						onclick="boardwrite()">작성</button>
				</div>
			</div>
		</div>
	</div>

	<!-- modal end -->

	<!--Modify Detail Modal -->

	<div class="modal fade" id="boardDetailModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div
			class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header">

					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body mx-5">

					<div class="row  mt-5 pt-5 title" id="boardDetailTitle">
						<strong>제목입니당</strong>
					</div>
					<div class="row  mt-5">
						<div class="col" id="boardDetailWriter">
							작성자 <strong> 작성자입니당 </strong>
						</div>
						<div class="col text-end">
							작성일자 <strong> 날짜입니당 </strong>
						</div>
					</div>
					<div class="row text-end">
						<c:choose>
							<c:when test="${userDto.user_id == sessionuser.user_id }">
								<div class="col">
									<div class="row justify-content-end">
										<div class="col-auto">
											<i class="bi bi-pencil icon-button" onclick="modifyboard()"
												title="modify"></i>
										</div>
										<div class="col-auto">
											<i class="bi bi-trash3 icon-button"
												onclick="deleteboard('${crewBoardDto.crew_board_id}')"
												title="remove"></i>
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
							</c:otherwise>
						</c:choose>
					</div>
					<div class="row mb-3">
						<div class="card my-3 py-3">
							<div class="content m-4">${crewBoardDto.crew_board_content }
							</div>
						</div>
					</div>
					<div class="row title2">
						<strong>댓글</strong>
					</div>
					<div class="row  mt-3">
						<div class="card mb-5">
							<div class="row m-2 mt-3">
								<textarea placeholder="댓글 내용을 입력하세요."
									class="textarea_input input_txt form-control"
									style="height: 100px;" name="board_comment_content"
									id="comment"></textarea>
							</div>
							<div class="row m-2">
								<div class="col text-end">
									<button id="writecomment" class="btn btn-success writecomment">작성하기</button>
								</div>
							</div>
						</div>
					</div>
					<div id="commentlist">
						<c:forEach var="comment" items="${commentlist}">

							<div class="row ">
								<div class="col commentWriter">
									<Strong>${comment.commentWriter.user_nickname }</Strong>
								</div>
								<div class="col text-end">
									<c:choose>
										<c:when
											test="${comment.commentWriter.user_id == sessionuser.user_id }">
											<div class="row justify-content-end">
												<div class="col-auto">
													<i class="bi bi-pencil icon-button"
														onclick="modifyboard('${comment.crewBoardCommentDto.board_comment_id}')"
														title="modify"></i>
												</div>
												<div class="col-auto">
													<i class="bi bi-trash3 icon-button" title="remove"
														onclick="deletecomment('${comment.crewBoardCommentDto.board_comment_id}')"></i>
												</div>
											</div>
										</c:when>
										<c:otherwise>
										</c:otherwise>
									</c:choose>

								</div>
							</div>
							<div class="row mt-3">
								<div class="comment">${comment.crewBoardCommentDto.crew_comment }</div>
							</div>
							<div class="row mt-3">
								<div class="col">
									<Strong> <fmt:formatDate
											value="${comment.crewBoardCommentDto.crew_comment_date }"
											pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
										${formattedDate }
									</Strong>
								</div>
								<div class="col text-end"></div>
							</div>
							<div class="row mt-3">
								<hr>
							</div>

						</c:forEach>
					</div>


				</div>
			</div>
		</div>
	</div>
	<!-- modal end -->



<!-- Modal -->
<div class="modal fade" id="cancelapplymodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">가입신청 중인 상태입니다.</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        신청을 취소하시겠습니까?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">돌아가기</button>
        <button type="button" class="btn btn-success" id="cancelmycrewapply">신청취소</button>
      </div>
    </div>
  </div>
</div>




    <!-- Modal -->

	<div class="modal fade" id="joincrewmodal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal modal-dialog-centered modal-dialog-scrollable">
			<div class="modal-content">
				<div class="modal-header" style="display: block;">
					<div class="row">
						<div class="col-auto">
							<div class="row">
								<div class="col">
									<h1 class="modal-title fs-5" id="joincrewmodal_crewname">${crewDto.crew_name}</h1>
								</div>
							</div>
							<div class="row">
								<div class="col">
									<div class="text-secondary"> 크루 가입을 위한 정보를 입력해주세요.</div>
								</div>
							</div>
						</div>
						<div class="col text-end">
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
					</div>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="col" id="joincrewmodal_crewdesc">
							${crewDto.crew_desc}
						</div>
					</div>
					<div class="row">
						<div class="col">
					        <div class="input-group">
                                <textarea placeholder="크루에게 본인을 소개하세요!" class="textarea_input input_txt form-control" style="height: 60px;" id="crew_join_request_intro"></textarea>
					        </div>
                            <p class="txt">
                                입력한 내용이 크루 운영진에게 전달됩니다.
                            </p>
					    </div>
					</div>
					<div class="row">
					    <div class="col-auto">
					        <div class="input_title mt-1">
					            <strong class="tit">정책 동의<span class="mandatory">*</span></strong>
					        </div>
					    </div>
					    <div class="col text-end">
					    	<a href="#" class="ms-auto">자세히보기</a>
					    </div>
					</div>
					<div class="row">
                        <div class="col">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="flexCheckDefault">
                                <label class="form-check-label" for="flexCheckDefault">
                                    크루 개인정보보호정책에 동의합니다.
                                </label>
                            </div>
                        </div>					
					</div>

				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">취소</button>
					<button class="btn btn-success" id="joincrewrequest">신청</button>
				</div>
			</div>
		</div>
	</div>

	<!-- modal end -->




	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Sortable/1.13.0/Sortable.min.js"></script>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>

</html>