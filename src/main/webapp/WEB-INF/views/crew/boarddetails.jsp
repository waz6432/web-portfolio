<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="<c:url value="/resources/css/crew/boarddetails.css" />">


<title>메인 페이지</title>
<script src="/travel/resources/js/crew/boarddetails.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container m-5 p-5">
	<div class="card">
		<div class="row ms-1 mt-2">
			<a href="#" onclick="window.history.back()" class="link">
				<i class="bi bi-arrow-left goback">뒤로가기</i>
			</a>
		</div>
		<div class="row mx-5 px-5 mt-5 pt-5 title">
			<strong>${crewBoardDto.crew_board_title }</strong>
		</div>
		<div class="row mx-5 px-5 mt-2">
			<div class="col">
			작성자
				<Strong>${userDto.user_nickname }</Strong>
			</div>
			<div class="col text-end">
				작성일자
				<strong>
					<fmt:formatDate value="${crewBoardDto.crew_board_reg_date }" pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
					${formattedDate }
				</strong>
			</div>
		</div>
		<div class="row mx-5 px-5 text-end">
			<c:choose>
				<c:when test="${userDto.user_id == sessionuser.user_id }">
				    <div class="col">
				        <div class="row justify-content-end">
				            <div class="col-auto">
				                <i class="bi bi-pencil icon-button" onclick="modifyboard()" title="modify"></i>
				            </div>
				            <div class="col-auto">
				                <i class="bi bi-trash3 icon-button" onclick="deleteboard('${crewBoardDto.crew_board_id}')" title="remove"></i>
				            </div>
				        </div>
				    </div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="row mx-5 px-5 mb-3">
			<div class="card my-3 py-3">
				<div class="content m-4">
					${crewBoardDto.crew_board_content }
				</div>
			</div>
		</div>
		<div class="row mx-5 px-5 title2">
			<strong>댓글</strong>
		</div>
		<div class="row mx-5 px-5 mt-3">
			<div class="card mb-5">
				<div class="row m-2 mt-3">
					<textarea placeholder="댓글 내용을 입력하세요." class="textarea_input input_txt form-control" style="height: 100px;" name="board_comment_content" id="comment"></textarea>
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
		
			<div class="row mx-5 px-5">
				<div class="col commentWriter">
					<Strong>${comment.commentWriter.user_nickname }</Strong>
				</div>
				<div class="col text-end">
					<c:choose>
						<c:when test="${comment.commentWriter.user_id == sessionuser.user_id }">
							<div class="row justify-content-end">
				            	<div class="col-auto">
									<i class="bi bi-pencil icon-button" onclick="modifyboard('${comment.crewBoardCommentDto.board_comment_id}')" title="modify"></i>
								</div>
				            	<div class="col-auto">
									<i class="bi bi-trash3 icon-button" title="remove" onclick="deletecomment('${comment.crewBoardCommentDto.board_comment_id}')"></i>
								</div>
				        	</div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>

				</div>
			</div>
			<div class="row mx-5 px-5 mt-3">
				<div class="comment">${comment.crewBoardCommentDto.crew_comment }</div>
			</div>
			<div class="row mx-5 px-5 mt-3">
				<div class="col">
					<Strong>
						<fmt:formatDate value="${comment.crewBoardCommentDto.crew_comment_date }" pattern="yyyy-MM-dd HH:mm" var="formattedDate" />
						${formattedDate }
					</Strong>
				</div>
				<div class="col text-end">
					
				</div>
			</div>
			<div class="row mx-5 px-5 mt-3">
				<hr>
			</div>
			
		</c:forEach>
		</div>
	</div>
</div>
<input type="hidden" value="${sessionuser.user_id }" id="user_id">
<input type="hidden" value="${crewBoardDto.crew_board_id }" id="crew_board_id">

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>
