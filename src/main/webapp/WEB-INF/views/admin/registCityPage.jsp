<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<link rel="stylesheet"	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@100;300;400;500;700;900&family=Noto+Sans+KR:wght@300;400;500;700;900&display=swap" rel="stylesheet">
<title>Insert title here</title>
<style>

	body {
		font-family: 'Nanum Gothic', sans-serif;
		font-family: 'Noto Sans KR', sans-serif;		
	}
	
	#naviBack {
		background-color:black;
		color:white;
		height: 100vh;
	}
	
	#naviTS {
		font-size : 150%;		
	}
	
	.icon1 {
		font-size : 150%;
		cursor: pointer;
		color: white;
	}
	
	.naviIcon {
		font-size : 150%;		
		color:#ebebeb;
	}
	
	.naviIconText {
		font-size : 150%;
		font-weight: bold;
		color:#ebebeb;
				
	}	
	
	.smallCategory:hover {
		background-color:#303030;
	}
	
	.smallCategory {
		font-size : 120%;
		color:#ebebeb;
	}
	
	.pageTitle {
		font-weight:bold;
		font-size: 25px;
	}
</style>
</head>
<body>
<script>

	// 페이지가 로드되면 실행되는 함수
	window.onload = function() {
	  // input 요소를 찾습니다.
	  const cityNameInput = document.getElementById("CityName");
	  
	  // input 요소가 존재하면 포커스를 설정합니다.
	  if (cityNameInput) {
	    cityNameInput.focus();
	  }
	};
</script>

<div class="container-fluid">
		<div class="row">
			<div class="col-2" id="naviBack">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-8 mx-auto">
				<div class="row mt-5 pageTitle border-dark-subtle border-bottom border-2">
					<div class="col">
						지역 추가
					</div>
				</div>
				<div class="row mt-5 md-0">
				<form action="registCityProcess" method="post">
				  <div class="col-6 mb-3">
				  	<div class="row">				    
				    	<input type="text" id="CityName" class="form-control" placeholder="시/도 + 시/군/구" name="plan_city_name">
				    </div>
				   	<div class="row mt-2">
				   		<div class="col text-end">
				   			<span>
				   			<button type="submit" class="btn btn-primary">추가</button>
				   			</span>
				   			<span>
				   			<button type="button" class="btn btn-primary" onclick="location.href='registedCityPage' ">취소</button>
				   			</span>	
				   		</div>

				   	</div>
				  </div>				  
				</form>
				</div>
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>