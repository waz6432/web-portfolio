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
			<div class="col">
			</div>
		</div>
		<div class="row mt-4">
			<div class="col"></div>
			<div class="col-4 text-center">
				<form action="./registerPlaceProcess" method="post"
					enctype="multipart/form-data">
					<div class="row mt-5">
						<div class="col d-flex">
							<h3>#나만의 명소를 등록하세요</h3>
						</div>
					</div>
					<div class="row mt-4">
						<div class="col-md-auto">
							<select class="form-select" name="plan_city_id"
								aria-label="Default select example">
								<option selected>도시를 선택하세요</option>
								<c:forEach items="${cityCategoryList}" var="list">
									<option value="${list.planCityDto.plan_city_id}">${list.planCityDto.plan_city_name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="row mt-3">
						<div class="col-12 col-md-auto">
							<span class="btn btn-outline-dark">대표사진등록</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-12 col-md-auto">
							<input type="file" name="mainImage" class="btn btn-outline-dark">
						</div>
					</div>
					<div class="row mt-4">
						<div class="col d-grid">
							<input type="text" name="plan_place_name"
								class="btn btn-outline-dark" placeholder="1.장소를 입력해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col d-grid">
							<input type="text" name="plan_place_content"
								class="btn btn-outline-dark" placeholder="2.장소를 설명해주세요">
						</div>
					</div>
					<div class="row mt-2">
						<div class="col d-grid">
							<input type="text" name="plan_place_address"
								class="btn btn-outline-dark" placeholder="3.주소를 입력해주세요">
						</div>
					</div>
					<div class="row mt-4">
						<div class="col-12 col-md-auto">
							<span class="btn btn-outline-dark">상세사진등록</span>
						</div>
					</div>
					<div class="row mt-2">
						<div class="col-12 col-md-auto">
							<input type="file" name="detailImages" multiple accept="image/*"
								class="btn btn-outline-dark">
						</div>
					</div>
					<div class="row text-center mt-5 ">
						<div class="col">
							<div class="d-grid gap-2">
								<a href="./planPage" class="btn btn-outline-dark form-control">취소</a>
							</div>
						</div>
						<div class="col">
							<div class="d-grid gap-2">
								<button class="btn btn-dark">등록</button>
							</div>
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