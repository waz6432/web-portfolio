<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;600;900&display=swap" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
	document.addEventListener("DOMContentLoaded", function() {
		Kakao.init('93ae12d4c0f00044228cbd5b5f2f588b'); // 여기에 JavaScript 키를 붙여넣으세요.

	    // SDK 초기화 여부를 판단합니다.
		console.log(Kakao.isInitialized());
	});
	
    function kakaoLogin() {
        Kakao.Auth.login({
            success: function(authObj) {
                const xhr = new XMLHttpRequest();

                xhr.onreadystatechange = function() {
                   if (xhr.readyState == 4 && xhr.status == 200) {
                	   
                      // 로그인 후 페이지로 리다이렉트
                      window.location.href = './main';
                   }
                }
                
                //post
                xhr.open("post", "./kakaoLogin");
                xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
                
                // 요청을 서버에 전송합니다.
                xhr.send(JSON.stringify({access_token: authObj.access_token}));
                
            },
            fail: function(err) {
                console.log(err);
            },
            throughTalk: false // 동의 거부 시 매번 동의를 물어보는 옵션 추가
        });
    }
</script>
<head>
<title>로그인</title>
<style>
.btn22 {
	color: white;
	background: #17b75e;
	border: none;
	height: 45px;
	font-family: 'Noto Sans KR', sans-serif;
	font-weight: 500;
	letter-spacing: 2px;
	font-size: 1.3em;
	border-radius: 0.375rem;
}

.btn-kakao {
	color: black;
	background-color: rgba(255, 255, 0, 0.8); /* 80%의 불투명한 연한 노랑색 */
	border: none;
	height: 45px;
	font-family: 'Noto Sans KR', sans-serif;
	border-radius: 0.375rem;
	font-weight: 600;
	letter-spacing: 2px;
	font-size: 1.1em;
}

.card-body {
	padding: 1em 1.5em 0.5em 1.5em;
}

.myCard {
	border: 1px solid lightgrey;
	border-radius: 0.5rem;
	width: 100%;
}

.input-group {
	height: 3em;
	margin: 10px 0 10px 0;
}

.input-group-text {
	background-color: white;
}

.form-control {
	border-left: none;
}

i {
	color: #ced4da;
	font-size: 1.3em;
}

h1 {
	background: #17b75e;
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	font-weight: bold;
	font-size: 3em;
	letter-spacing: -2px;
}

.inputWrapper {
	margin-top: 25px;
}

.form-control::placeholder {
	color: #ced4da;
}

.line-with-text {
	display: flex;
	align-items: center;
	margin: 10px 0;
}

.line-with-text div {
	flex-grow: 1;
}

.line-with-text span {
	margin: 0 30px;
}

.custom-link a {
	text-decoration: none;
	color: black;
	font-family: 'Noto Sans KR', sans-serif;
}

.col-4 {
	display: flex;
	flex-direction: column;
	justify-content: center;
}

.footer-logo {
	margin-right: 10px;
	background: linear-gradient(to right, #DB4465, #FF7A85);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	font-weight: 900;
}

.nav-link, .nav-link:hover, .nav-link:focus {
	color: black;
}
</style>
</head>
<body>
	<div class="container">
		<div class="row" style="height: 100vh;">
			<div class="col"></div>
			<div class="col-4">
				<div class="row">
					<div class="col">
						<div class="myCard shadow">
							<div class="card-body">
								<h1>
									<a href="./main">TripStation</a>
								</h1>
								<div class="inputWrapper">
									<form method="POST" action="getlogin">
										<div class="input-group">
											<span class="input-group-text">
											<i class="bi bi-person"></i></span> <input type="text"
												class="form-control" id="user_email" placeholder="아이디"
												name="user_email" required>
										</div>
										<div class="input-group">
											<span class="input-group-text"> <i class="bi bi-lock"></i></span>
											<input type="password" class="form-control" id="user_pw"
												name="user_pw" placeholder="비밀번호" required>
										</div>
										<div class="d-grid mt-4">
											<button type="submit" class="btn22">로그인</button>
										</div>
										<div class="line-with-text">
											<div>
												<hr>
											</div>
											<span>OR</span>
											<div>
												<hr>
											</div>
										</div>
										<div class="d-grid">
											<button type="button" class="btn-kakao btn-primary" onclick="kakaoLogin()">
												<i class="bi bi-chat-fill text-black fs-5"></i>
												카카오 간편 로그인
											</button>
										</div>
										<div class="row mt-4">
											<div class="col custom-link">
												<a href="/travel/signin">회원가입</a>
											</div>
											<div class="col custom-link d-flex justify-content-end">
												<a href="#">아이디 / 비밀번호 찾기</a>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<jsp:include page="../common/loginBottomNavi.jsp"></jsp:include>
					</div>
				</div>
			</div>
			<div class="col"></div>
		</div>
	</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>