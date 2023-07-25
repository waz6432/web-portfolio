<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<title>플래너 시작하기 페이지</title>
</head>
<body>

<div class="container">
	<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>	
	
	<div class="row mt-4">
		<div class="col-4">
			<div class="card">
				<div class="card-header">플래너 등록하기</div>
				<div class="card-body">
					
				<form method="POST" action="./registerPlanProcess" enctype="multipart/form-data">
					
					
					<!-- 지도 선택 예시 -->
					
					<!-- <div class="row mt-1">
						<div class="col form-group">						
							<label for="plan_day">N일차</label>
						</div>
					</div>
					
					<div class="row mt-1">
						<div class="col form-group">
							<label for="plan_city_name">지역</label> 
							<select class="form-control" id="plan_day_city_name" name="plan_day_city_name" required>
								<option value="">전체</option>
								<option value="M">부산광역시</option>
								<option value="F">대구광역시</option>
								<option value="N">인천광역시</option>
							</select>
						</div>
					</div>
					
					<div class="row mt-1">
						<div class="col form-group">	
							<label for="plan_city_name">명소</label> <select class="form-control" id="plan_city_name" name="plan_city_name" required>
								<option value="">해운대</option>
								<option value="M">뭐뭐뭐</option>
								<option value="F">깡통 시장</option>
								<option value="N">통깡 시장</option>
							</select>
						</div>
					</div>
						
					<div class="row">
						<div class="col form-group">
							<label for="plan_city_name">명소</label> 
							<select class="form-control" id="plan_city_name" name="plan_city_name" required>
								<option value="">해운대</option>
								<option value="M">뭐뭐뭐</option>
								<option value="F">깡통 시장</option>
							</select>
						</div>
					</div> -->
					
					<div class="row mt-2">
						<div class="col">						
						<div class="form-group">
							<label for="plan_title">플래너 제목</label>
                            <input type="text" class="form-control" id="plan_title" name="plan_title"  required>
						</div>
						</div>
					</div>
					
					<div class="row mt-2">
						<div class="col">						
						<div class="form-group">
							<label for="plan_content">플래너 설명</label>
                            <input type="text" class="form-control" id="plan_content" name="plan_content"  required>
						</div>
						</div>
					</div>
					
					<div class="row mt-2">
						<div class="col">						
						<div class="form-group">
								<label for="plan_thumbnail">플래너 썸네일</label>
								<!-- <input type="text" class="form-control" id="plan_thumbnail" name="plan_thumbnail" required> -->
                            <input type="file" class="form-control" id="plan_thumbnail" name="img" accept="image/*" required>
						</div>
						</div>
					</div>
					
					<div class="row mt-2">
						<div class="col">
							<label for="plan_disclosure_status">공개 여부</label>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="plan_disclosure_status" id="plan_disclosure_status" value="비공개">
								<label class="form-check-label" for="inlineRadio1">비공개</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="radio" name="plan_disclosure_status" id="plan_disclosure_status" value="공개">
								<label class="form-check-label" for="inlineRadio2">공개</label>
							</div>
						</div>
					</div>
					
					<div class="row mt-2">
						<div class="col">						
					<button type="submit" class="d-grid btn btn-dark">등록하기</button>
						</div>
					</div>

					</form>
				</div>
			</div>
		</div>

		<div class="col">
			<img src="/travel/resources/img/map.PNG" style="width: 50rem; height: 50rem" alt="">
		</div>
	</div>

</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>
