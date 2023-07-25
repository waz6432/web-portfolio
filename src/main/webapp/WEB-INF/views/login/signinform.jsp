<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<!-- 부트스트랩 CSS 링크 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">

<style type="text/css">
		.btn-gradient {background: linear-gradient(to right, #ca4fff, #696bff, #4e33ff);}
</style>

</head>
<body>
	<div class="container">
		<div class="row mt-5">
			<div class="col">
				<div class="row my-3">
					<div class="col">
						<div class="row d-flex justify-content-center">
							<div class="col-auto px-0">
								<img style="width: 40px; margin-right: 7px;" alt="" src="/travel/resources/img/bbb.png">
							</div>
							<div class="col-auto px-0">
								<a class="navbar-brand fs-5 fw-bold" href="/travel/main">tripStation</a>
							</div>
						</div>
					</div>
				</div>
				<div class="row mt-5 d-flex justify-content-center">
					<div class="col-4">
						<div class="row">
							<div style="border: none; border-radius: 20px;"class="card shadow p-3 mb-5 bg-body rounded">
							<div class="col">
								<form action="./register" method="post" enctype="multipart/form-data">
								<div class="row my-2">
									<div class="col text-center">
										<i style="font-size: 60px;" class="bi bi-person-circle"></i>
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="file" name="profileImage">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="text" name="user_email" placeholder="이메일을 입력해주세요">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="password" name="user_pw" placeholder="비밀번호를 입력해주세요">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="text" name="user_nickname" placeholder="이름을 입력해주세요">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<select name="user_gender" class="form-select" aria-label="Default select example">
										  <option selected>성별을 선택해주세요</option>
										  <option value="none">트렌스젠더</option>
										  <option value="M">남성</option>
										  <option value="F">여성</option>
										</select>
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="text" name="user_phone" placeholder="연락처: 010-0000-0000">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="text" name="user_address" placeholder="주소를 입력해주세요">
									</div>
								</div>
								<div class="row my-2">
									<div class="col">
										<input class="form-control" type="date" name="user_birth">
									</div>
								</div>
								<div class="row my-4 d-flex justify-content-center">
									<div class="col-6">
										<a style="border-radius: 20px;" href="./main" class="btn btn-outline-dark form-control">메인으로</a>
									</div>
									<div class="col-6">
										<button style="border-radius: 20px; color: white;" class="btn-gradient form-control">회원가입</button>
									</div>
								</div>
								</form>
							</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFd BIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>
