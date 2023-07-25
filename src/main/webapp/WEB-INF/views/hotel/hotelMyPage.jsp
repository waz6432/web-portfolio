<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>

		<div class="row mt-5">
			<div class="col-11">
				<div class="row">
					<div class="col p-0">
						<span class="fs-3 fw-bold">${sessionuser.user_nickname} 님, 안녕하세요!</span>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col p-0">
						<span class="fs-4 fw-bold">예약정보</span>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col" style="background-color: #f5f5f5;">
						<c:forEach items="${hotelDtoList}" var="hotelDtoList">
							<div class="row my-3">
								<div class="col">
									<div class="row">
										<div class="col-auto d-flex align-items-center">
											<span class="fw-bold">예약번호 : </span> 
											<span>${hotelDtoList.hotelReservationDto.hotel_reservation_id}</span>
										</div>
										<div class="col-auto d-flex align-items-center">
											<span class="fw-bold">숙소명 : </span> 
											<span>${hotelDtoList.hotelDto.hotel_title}</span>
										</div>
										<div class="col-auto d-flex align-items-center">
											<span class="fw-bold">예약일 : </span> 
											<span><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${hotelDtoList.hotelReservationDto.hotel_reservation_reg_date}" /></span>
										</div>
										<div class="col-auto d-flex align-items-center">
											<span class="fw-bold">체크인 : </span> 
											<span><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${hotelDtoList.hotelReservationDto.hotel_reservation_check_in}" /></span>
										</div>
										<div class="col-auto d-flex align-items-center">
											<span class="fw-bold">체크아웃 : </span> 
											<span><fmt:formatDate pattern="yyyy년 MM월 dd일" value="${hotelDtoList.hotelReservationDto.hotel_reservation_check_out}" /></span>
										</div>
										<c:set var="currentDate" value="<%=new java.util.Date()%>" />
										<c:if test="${hotelDtoList.hotelReservationDto.hotel_reservation_check_out <= currentDate}">
											<div class="col-auto">
												<c:choose>
													<c:when test="${empty hotelDtoList.hotelReviewDto}">
														<a href="./insertHotelReviewPage?hotel_reservation_id=${hotelDtoList.hotelReservationDto.hotel_reservation_id}">리뷰
															작성하기
														</a>
													</c:when>
													<c:otherwise>
														<span>리뷰작성완료</span>
													</c:otherwise>
												</c:choose>
											</div>
										</c:if>
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>


	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>