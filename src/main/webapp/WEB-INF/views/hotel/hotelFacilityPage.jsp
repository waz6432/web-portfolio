<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	<div class="row justify-content-center">
		<div class="col"></div>
		<div class="col-6">
			<div class="row my-4">
				<div class="col">
					<span>임시 편의시설 등록 페이지 </span>
				</div>
			</div>
			<form action="./insertHotelFacilityProcess" method="post" enctype="multipart/form-data">
			<div class="row mt-2">
				<div class="col">
					<input class="form-control" type="text" name="hotel_facility_name" placeholder="편의시설 이름을 입력해주세요">
				</div>
			</div>
			<div class="row mt-2">
				<div class="col">
					<input class="form-control" type="file" name="facilityImage">
				</div>
			</div>
			<div class="row my-3 justify-center">
				<div class="col"></div>
				<div class="col-3">
					<button>등록하기</button>
				</div>
				<div class="col"></div>
			</div>
			</form>
		</div>
		<div class="col"></div>
	</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</html>