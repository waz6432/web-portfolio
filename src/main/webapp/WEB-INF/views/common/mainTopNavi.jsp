<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	// SDK를 초기화 합니다. 사용할 앱의 JavaScript 키를 설정해야 합니다.
	document.addEventListener("DOMContentLoaded", function() {
		Kakao.init('93ae12d4c0f00044228cbd5b5f2f588b'); // 여기에 JavaScript 키를 붙여넣으세요.
	
	    // SDK 초기화 여부를 판단합니다.
		console.log(Kakao.isInitialized());
	});
	
    function logout() {
        Kakao.Auth.logout(function() {
            console.log('로그아웃이 완료되었습니다.');
            // 로그아웃이 완료되면 서버 측 로그아웃 URL로 리다이렉트
            location.href = '/travel/logoutProcess';
        });
    }
</script>
<div class="row fw-bold">
	<div class="col px-0">
		<nav class="navbar navbar-expand-lg bg-body-tertiary">
			<div class="container-fluid p-0">
				<span class="fw-bold navbar-brand mb-0 h1" style="font-size: 30px; font-weight: 700;"> TripStation</span>
				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" aria-current="page" data-bs-toggle="dropdown" href="/travel/main" aria-expanded="false">여행</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="/travel/main">맞춤여행</a></li>
								<li><a class="dropdown-item" href="/travel/package">패키지</a></li>
							</ul>
						</li>
						<li class="nav-item"><a class="nav-link" href="/travel/plan/planPage">플래너</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/crew/main" role="button">크루</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/hotel/hotelPage" role="button">숙소</a></li>
						<li class="nav-item"><a class="nav-link" href="/travel/planPlace/placePage">플레이스</a></li>
					</ul>
					<c:choose>
						<c:when test="${!empty sessionuser}">
							<ul class="navbar-nav">
								<li class="d-flex align-items-center">
									<c:choose>
										<c:when test="${sessionuser.user_image != null}">
											<img alt="썸네일" src="/uploadFiles/profileImage/${sessionuser.user_image}" style="width: 2em; height: 2em; border-radius: 50%;">
										</c:when>
										<c:otherwise>
											<img alt="썸네일" src="/travel/resources/img/icon.png" style="width: 2em; height: 2em; border-radius: 50%;">
										</c:otherwise>
									</c:choose>
								</li>
								<li class="nav-item dropdown">
									<a class="nav-link dropdown-toggle me-2" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false"> ${sessionuser.user_nickname} </a>
									<ul class="dropdown-menu" aria-labelledby="userDropdown">
										<li><a class="dropdown-item" href="/travel/myPage">마이페이지</a></li>
										<li><a class="dropdown-item" href="/travel/allCouponPage">쿠폰</a></li>
										<li><a class="dropdown-item" href="/travel/messageGot">쪽지</a></li>
										<li><a class="dropdown-item" href="javascript:logout();">로그아웃</a></li>
									</ul>
								</li>
							</ul>
						</c:when>
						<c:otherwise>
							<a class="btn me-1 nav-link" href="/travel/login" style="height: 35px;">로그인</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</nav>
	</div>
</div>
