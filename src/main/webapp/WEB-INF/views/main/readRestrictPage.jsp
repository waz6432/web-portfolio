<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>메인 페이지</title>
<script type="text/javascript">
	var changeBackColor = true;

	function changeBackGround() {
		if (changeBackColor) {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = '#444444';

			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'white';
			});
			changeBackColor = false;
		} else {
			var container = document.querySelector('.container-fluid');
			container.style.backgroundColor = 'white';

			var otherElements = container.querySelectorAll(':not(.container)');
			otherElements.forEach(function(element) {
				element.style.color = 'black';
			});
			changeBackColor = true;
		}

	}
</script>
</head>
<body>
	<div class="container-fluid p-0">
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		<div class="row mt-3">
			<div class="col">
				<div id="bannerIndicators" class="carousel slide"
					data-bs-ride="true">
					<div class="carousel-indicators">
						<button type="button" data-bs-target="#bannerIndicators"
							data-bs-slide-to="0" class="active" aria-current="true"
							aria-label="Slide 1"></button>
						<button type="button" data-bs-target="#bannerIndicators"
							data-bs-slide-to="1" aria-label="Slide 2"></button>
						<button type="button" data-bs-target="#bannerIndicators"
							data-bs-slide-to="2" aria-label="Slide 3"></button>
					</div>
					<div class="carousel-inner">
						<div class="carousel-item active">
							<img class="d-block w-100" src="/travel/resources/img/banner.jpg"
								alt="banner" style="height: 400px;">
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="/travel/resources/img/banner.jpg"
								alt="banner" style="height: 400px;">
						</div>
						<div class="carousel-item">
							<img class="d-block w-100" src="/travel/resources/img/banner.jpg"
								alt="banner" style="height: 400px;">
						</div>
						<button class="carousel-control-prev" type="button"
							data-bs-target="#bannerIndicators" data-bs-slide="prev">
							<span class="carousel-control-prev-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Previous</span>
						</button>
						<button class="carousel-control-next" type="button"
							data-bs-target="#bannerIndicators" data-bs-slide="next">
							<span class="carousel-control-next-icon" aria-hidden="true"></span>
							<span class="visually-hidden">Next</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row mt-5 w-75">
			<div class="col">
				<dl class="row">

					<dt class="h1 mb-5">제한 상세내역</dt>

					<dt class="col-sm-3 mb-3">제한 유형</dt>
					<dd class="col-sm-9"></dd>
					<dt class="col-sm-3 mb-3">총 제한일</dt>
					<dd class="col-sm-9"></dd>
					<dt class="col-sm-3 mb-3">제한 종료일</dt>
					<dd class="col-sm-9"></dd>
					<dt class="col-sm-3 mb-3">제한 사유</dt>
					<dd class="col-sm-9"></dd>
					<dt class="col-sm-3 mb-3">첨부 파일</dt>
					<dd class="col-sm-9"></dd>
				</dl>
			</div>


			<div class="col">
				<dl class="row">
					<dt class="h2 mb-5">이의 신청하기</dt>
				</dl>
			</div>

			<div class="row">

				<form method="post" action="restrictGuideProcess">

					<div class="mb-3">
						<label for="formGroupExampleInput" class="form-label">Example
							label</label> <input type="text" class="form-control"
							id="formGroupExampleInput"
							placeholder="Example input placeholder">
					</div>


					<div class="mb-3">
						<label for="exampleFormControlTextarea1" class="form-label"></label>
						<textarea class="form-control" id="exampleFormControlTextarea1"
							rows="3" name="guide_restrict_reason"></textarea>
					</div>



					<div class="mt-3">
						<input type="hidden"
							value="${map.guidePlanningDto.guide_planning_id}"
							name="guide_planning_id"> <input type="hidden"
							value="${map.guideReportDto.guide_report_id}"
							name="guide_report_id"> <input type="hidden"
							value="${map.guideDto.guide_id}" name="guide_id">
						<button class="btn btn-primary" type="submit">제한</button>
						<button type="button" class="btn btn-primary"
							onclick="location.href='./guideReportPage'">뒤로가기</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>