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
						가이드 신고 내역
					</div>
				</div>
				<c:choose>
				<c:when test="${map.guideReportDto.guide_report_status eq '미처리'}">
				<div class="row d-flex justify-content-center mt-5">
					<div class="col">
						<div class="row">
						  <div class="col-sm-2">
						  	신고된 가이드
						  </div>
						  <div class="col-sm-10 b">
						  	${map.guideUserDto.user_email}
						  </div>
						</div>
						<div class="row mt-2"> 
						  <div class="col-sm-2">
						  	가이드 플랜 번호
						  </div>
						  <div class="col-sm-10 b">
						  	${map.guidePlanningDto.guide_planning_id}
						  </div>
						</div>
						<div class="row mt-2">
							<div class="col-sm-2">
						  	신고 유형
						    </div>
						  <div class="col-sm-10 b">
						    ${map.guideReportDto.guide_report_type}
						  </div>
						</div>
						<div class="row mt-2">  
						  <div class="col-sm-2">
						  	상세 설명
						  </div>
						  <div class="col-sm-10 b">
						    ${map.guideReportDto.guide_report_desc}
						  </div>
						</div>
						<div class="row mt-2">  
						  <div class="col-sm-2">
						  	첨부 파일
						  </div>
						  <div class="col-sm-10 b">
						  <c:choose>
  						  <c:when test="${empty map.guideReportDto.guide_report_attached}">
						  	없음
						  </c:when>
						  <c:otherwise>
						    ${map.guideReportDto.guide_report_attached}
						  </c:otherwise>
						  </c:choose>
						  </div>
						</div>	
					  </div>				
				</div>
				<form method="post" action="restrictGuideProcess">
				<div class="row mt-3">
					<div class="col mb-3">					 
					  <textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="guide_restrict_reason" placeholder="제한 사유"></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col mb-3">
						플랜 생성 제한
					</div>
				</div>				
				<div class="row ms-1">
					<div class="col">
						<div class="row">
							<div class="col form-check">
							  <input class="form-check-input" type="radio" name="guide_restrict_duration" id="flexRadioDefault1" value="3">
							  <label class="form-check-label" for="flexRadioDefault1">
							    3
							  </label>
							  일
							</div>
						</div>
						<div class="row">
							<div class="col form-check">
							  <input class="form-check-input" type="radio" name="guide_restrict_duration" id="flexRadioDefault2" value="7" >
							  <label class="form-check-label" for="flexRadioDefault2">
							    7
							  </label>
							  일
							</div>
						</div>
						<div class="row">
							<div class="col form-check">
							  <input class="form-check-input" type="radio" name="guide_restrict_duration" id="flexRadioDefault2" value="15">
							  <label class="form-check-label" for="flexRadioDefault2">
							    15
							  </label>
							  일
							</div>
						</div>
						<div class="row">
							<div class="col form-check">
							  <input class="form-check-input" type="radio" name="guide_restrict_duration" id="flexRadioDefault2" value="30">
							  <label class="form-check-label" for="flexRadioDefault2">
							    30
							  </label>
							  일
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col mt-3 text-center">
						<input type="hidden" value="${map.guidePlanningDto.guide_planning_id}" name="guide_planning_id">
						<input type="hidden" value="${map.guideReportDto.guide_report_id}" name="guide_report_id">
						<input type="hidden" value="${map.guideDto.guide_id}" name="guide_id">
						<input type="hidden" value="플랜 생성 제한" name="guide_report_status">
						<span>
							<button class="btn btn-secondary" type="submit">제한</button>
						</span>
						<span>
							<button type="button" class="btn btn-secondary" onclick = "location.href='./guideReportPage'">뒤로가기</button>
						</span>
					</div>
				</div>
				</form>
				</c:when>
				
				<c:otherwise>
					<div class="row ps-1">
						<div class="col">
							${map.guideUserDto.user_email}님의 제한 상세정보
						</div>
				</div>
				<div class="row d-flex justify-content-center mt-5">
					<div class="col">
						<div class="row">
						  <div class="col-sm-2">
						  	제한 방식
						  </div>
						  <div class="col-sm-10 b">
						  	${map.guideReportDto.guide_report_status}
						  </div>
						</div>
						<div class="row mt-2">
						  <div class="col-sm-2">
						  	총 제한일
						  </div>
						  <div class="col-sm-10 b">
						    <p>${map.guideRestrictDto.guide_restrict_duration}</p>
						  </div>
						</div>
						<div class="row mt-2">  
						  <div class="col-sm-2">
						  	제한 일자
						  </div>
						  <div class="col-sm-10 b">
						    <fmt:formatDate value="${map.guideRestrictDto.guide_restrict_start_date}" pattern="yyyy-MM-dd" />
						  </div>
						</div>
						<div class="row mt-2">  
						  <div class="col-sm-2">
						  	해제 예정일
						  </div>
						  <div class="col-sm-10 b">
						    <fmt:formatDate value="${map.guideRestrictDto.guide_restrict_end_date}" pattern="yyyy-MM-dd" />
						  </div>
						</div>
						<div class="row mt-2">  
							<div class="col-sm-2">
								제한 이유
							</div>
						    <div class="col-sm-10 b">
						    ${map.guideRestrictDto.guide_restrict_reason}
						    </div>						  						
						</div>
						<div class="row mt-5">
							<div class="col text-center">
								<span>
									<button type="button" class="btn btn-secondary" onclick = "location.href='./guideReportPage'">뒤로가기</button>
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