<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>

	body {
		font-family: 'Nanum Gothic', sans-serif;
		font-family: 'Noto Sans KR', sans-serif;		
	}
	
	#naviBack {
		background-color:black;
		color:white;
		height: 100vh;
	}
	
	#naviTS {
		font-size : 150%;		
	}
	
	.icon1 {
		font-size : 150%;
		cursor: pointer;
		color: white;
	}
	
	.naviIcon {
		font-size : 150%;		
		color:#ebebeb;
	}
	
	.naviIconText {
		font-size : 150%;
		font-weight: bold;
		color:#ebebeb;
				
	}	
	
	.smallCategory:hover {
		background-color:#303030;
	}
	
	.smallCategory {
		font-size : 120%;
		color:#ebebeb;
	}
	
	.pageTitle {
		font-weight:bold;
		font-size: 25px;
	}
	
	.email {
		font-size: 15px;	
	}
	
	.b {
		font-weight:bold;
		font-size: 17px;
	}
</style>
</head>
<body>
<div class="container-fluid">
		<div class="row">
			<div class="col-2" id="naviBack">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-8 mx-auto">
				<div class="row mt-5 pageTitle border-dark-subtle border-bottom border-2">
					<div class="col">
						가이드 프로필
					</div>	
				</div>
				<c:choose>
				<c:when test="${map.guideApplyDto.guide_apply_state eq '미승인' && empty map.guideApplyDto.guide_apply_message}">
				
				<div class="row">
					<div class="col">
						<div class="row">
							<div class="col email mt-1 ms-1">
							${map.userDto.user_email}님의 프로필
							</div>
						</div>
						<div class="row d-flex justify-content-center mt-5">
							<div class="col">
								<div class="row">
								  <div class="col-sm-2 b">
								  	닉네임
								  </div>
								  <div class="col-sm-10">
								  	${map.guideApplyDto.guide_apply_name}
								  </div>
								</div>
								<div class="row mt-3">
								  <div class="col-sm-2 b">
								  	프로필
								  </div>
								  <div class="col-sm-10">
								    ${map.guideApplyDto.guide_apply_profile}
								  </div>
								</div>  
								<div class="row mt-3">
								  <div class="col-sm-2 b">
								  	신청 일자
								  </div>
								  <div class="col-sm-10">
								    <fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" />
								  </div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row mt-5">
				<form  method="post">
					<div class="col mb-3">					  
					  <textarea class="form-control" id="exampleFormControlTextarea1" placeholder="승인/거절 메시지를 입력하세요" rows="8" name="guide_apply_message"></textarea>
					</div>
				<div class="row text-center">
						<input type="hidden" value="${map.guideApplyDto.guide_apply_id}" name="guide_apply_id">
						<input type="hidden" value="${map.guideApplyDto.user_id}" name="user_id">
						<input type="hidden" value="<fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" />"  name="guide_apply_date">
						<input type="hidden" value="${map.guideApplyDto.guide_apply_profile}" name="guide_apply_profile">
						<input type="hidden" value="${map.guideApplyDto.guide_apply_name}" name="guide_apply_name">
						<div class="col">
							<span>
								<input type="submit" class="btn btn-sm btn-secondary" value="승인" formaction="../admin/applyGuideProcess">
							</span>
							<span>
							<input type="submit" class="btn btn-sm btn-secondary" value="거절" formaction="../admin/rejectGuidePorcess">
							</span>
							<span>
							<button type="button" class="btn btn-sm btn-secondary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
							</span>
						</div>
				</div>
				</form>
				</div>
				</c:when>
				
				<c:when test="${map.guideApplyDto.guide_apply_state eq '거절' && !empty map.guideApplyDto.guide_apply_message }">
				<div class="row mt-1">
					<div class="col email ms-1">
					${map.userDto.user_email}님의 프로필
					</div>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<div class="col">
						<div class="row">
						  <div class="col-sm-2 b">
						  	닉네임
						  </div>
						  <div class="col-sm-10">
						  	${map.guideApplyDto.guide_apply_name}
						  </div>
						</div>
						<div class="row mt-3">
						  <div class="col-sm-2 b">
						  	프로필
						  </div>
						  <div class="col-sm-10">
						    ${map.guideApplyDto.guide_apply_profile}
						  </div>
						</div>  
						<div class="row mt-3">
						  <div class="col-sm-2 b">
						  	신청 일자
						  </div>
						  <div class="col-sm-10">
						    <fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" />
						  </div>
						</div>
						<div class="row mt-3">
							<div class="col-sm-2 b">
								거절 사유
							</div>
							<div class="col-sm-10">
								${map.guideApplyDto.guide_apply_message}
							</div>
						</div>
						<div class="row mt-3">
							<div class="col text-center">
								<span>
									<button type="button" class="btn btn-secondary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
								</span>							
							</div>
						</div>
					</div>
				</div>
				</c:when>
				
				<c:otherwise>
				<div class="row mt-1">
					<div class="col email ms-1">
					${map.userDto.user_email}님의 프로필
					</div>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<div class="col">
						<div class="row">
						  <div class="col-sm-2 b">
						  	닉네임
						  </div>
						  <div class="col-sm-10">
						  	${map.guideApplyDto.guide_apply_name}
						  </div>
						</div>
						<div class="row mt-3">
						  <div class="col-sm-2 b">
						  	프로필
						  </div>
						  <div class="col-sm-10">
						    ${map.guideApplyDto.guide_apply_profile}
						  </div>
						</div>  
						<div class="row mt-3">
						  <div class="col-sm-2 b">
						  	신청 일자
						  </div>
						  <div class="col-sm-10">
						  	<fmt:formatDate value="${map.guideApplyDto.guide_apply_date}" pattern="yyyy-MM-dd" />
						  </div>
					  	</div>
					  	<div class="row mt-3">
					  		<div class="col-sm-2 b">
					  			승인일자
					  		</div>
					  		<div class="col-sm-10">
					    		<fmt:formatDate value="${map.guideDto.guide_reg_date}" pattern="yyyy-MM-dd" />					  		
					  		</div>
					  	</div>
						<div class="row mt-3">
							<div class="col-sm-2 b">
								응답내용
							</div>
							<div class="col-sm-10">
								${map.guideApplyDto.guide_apply_message}
							</div>
						</div>
						<div class="row mt-5">
							<div class="col text-center">
								<span>
									<button type="button" class="btn btn-secondary" onclick = "location.href='./guideApplyPage'">뒤로가기</button>
								</span>									
							</div>
						</div>
					</div>
				</div>
				</c:otherwise>
				</c:choose>
			</div>
			</c:if>
	</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>