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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
</head>
<body>

<div class="container">
	<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	
	<div class="row d-flex justify-content-center">
		<div class="col-6">
			<div class="card">
				<div class="row my-3">
					<div class="col">
						<h3>임시 리뷰 작성</h3>
					</div>
				</div>
					<form action="./insertReviewProcess" method="post">
						<input type="hidden" name="hotel_reservation_id" value="${hotel_reservation_id}">
						<div class="row">
							<div class="col">
								<div class="row">
									<div class="col-auto">
										 <input name="hotel_review_point" class="form-check-input" type="checkbox" value="1.00">
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
									</div>
									<div class="col-auto">
										 <input name="hotel_review_point" class="form-check-input" type="checkbox" id="inlineCheckbox2" value="2.00">
										 <label class="form-check-label" for="inlineCheckbox2"></label>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
									</div>
									<div class="col-auto">
										 <input name="hotel_review_point" class="form-check-input" type="checkbox" id="inlineCheckbox3" value="3.00">
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
									</div>
									<div class="col-auto">
										 <input name="hotel_review_point" class="form-check-input" type="checkbox" id="inlineCheckbox4" value="4.00">
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										</div>
									<div class="col-auto">
										<input name="hotel_review_point" class="form-check-input" type="checkbox" id="inlineCheckbox5" value="5.00">
										<i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
										 <i style="color: #ebc634;"class="bi bi-star-fill"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<textarea class="form-control" name="hotel_review_content" rows="auto" cols="auto"></textarea>
							</div>
						</div>
						<div class="row">
							<div class="col">
								<button class="btn btn-dark">리뷰작성</button>
							</div>
						</div>
					</form>
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