<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
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
		<div class="row">
			<div class="col"></div>
			<div class="col-4">
				<form action="./hotelRegisterProcess" method="post" enctype="multipart/form-data">
					<div class="row mt-5">
						<div class="col">
							<h3>#나만의 숙소를 등록하세요</h3>
						</div>
					</div>
					<div class="row mt-5">
						<div class="col">
							<select class="form-select" name="hotel_category_id" aria-label="Default select example">
								<option selected>카테고리를 선택하세요</option>
								<c:forEach items="${hotelCategoryList}" var="hotelCategoryList">
									<option value="${hotelCategoryList.hotelCategoryDto.hotel_category_id}">${hotelCategoryList.hotelCategoryDto.hotel_category_title}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<span class="btn btn-outline-dark">대표사진등록</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark" type="file" name="mainImage"
								placeholder="썸네일 이미지">
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_title"
								placeholder="1.숙소 이름을 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_content"
								placeholder="3.숙소 정보를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_address"
								placeholder="3.숙소 주소를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_price"
								placeholder="4.가격을 입력해주세요(1박기준)">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_bedRoom"
								placeholder="5.침실 갯수를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_bed"
								placeholder="6.침대 갯수를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_bathRoom"
								placeholder="7.욕실 갯수를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark form-control" type="text" name="hotel_limit_number"
								placeholder="8.숙소 제한 인원을 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<select class="form-control" name="hotel_check_in_time">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div>
						<div class="col">
							<select class="form-control" name="hotel_check_out_time">
								<option value="1">1</option>
								<option value="2">2</option>
								<option value="3">3</option>
								<option value="4">4</option>
								<option value="5">5</option>
								<option value="6">6</option>
								<option value="7">7</option>
								<option value="8">8</option>
								<option value="9">9</option>
								<option value="10">10</option>
								<option value="11">11</option>
								<option value="12">12</option>
							</select>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<span class="btn btn-outline-dark">오픈 및 마감일 등록</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input type="date" name="hotel_reserve_start_date">
						</div>
						<div class="col">
							<input type="date" name="hotel_reserve_end_date">
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<span class="btn btn-outline-dark">상세사진등록</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col">
							<input class="btn btn-outline-dark" type="file" multiple accept="image/*" name="detailImages"
								placeholder="상세 이미지">
						</div>
					</div>
					<div class="row mt-3">
						<div class="col">
							<a href="./hotelPage" class="btn btn-outline-dark form-control">취소</a>
						</div>
						<div class="col">
							<button class="btn btn-dark form-control">등록</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col"></div>
		</div>
	</div>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>