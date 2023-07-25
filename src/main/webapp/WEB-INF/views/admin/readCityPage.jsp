<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>
<div class="container">
		<div class="row">
			<div class="col-3 mt-3">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-9">
				<div class="row d-flex justify-content-center h1 mt-5">
					<div class="col">
					지역 상세페이지
					</div>
				</div>
				<div class="row mt-5">
				<form action="updateCityProcess" method="post">
				  <div class="mb-3">
				    <label for="bigCityName" class="form-label">시/도 명</label>
				    <select class="form-select" id="bigCityName" name="big_city_id">
				    	<option value="${map.planBigCityDto.big_city_id}" selected>${map.planBigCityDto.big_city_name}</option>
					  	<c:forEach var="list" items="${planList}">
					  		<option value="${list.big_city_id}">${list.big_city_name}</option>
					  	</c:forEach>			  
					</select>
				  </div>
				  <div class="mb-3">
				    <label for="CityName" class="form-label">도시명</label>
				    <input type="text" id="CityName" class="form-control" name="plan_city_name" value="${map.planCityDto.plan_city_name}">
				  </div>
				  
				  <div class="mb-3">
				    <label for="CityContent" class="form-label">도시 설명</label>
  					<textarea class="form-control" id="CityContent" rows="8" name="plan_city_content">${map.planCityDto.plan_city_content}</textarea>
				  </div>
				  <button type="submit" class="btn btn-primary">수정</button>
				  <button type="button" class="btn btn-primary" onclick="location.href='registedCityPage' ">취소</button>
				  <input type="hidden" value="${map.planCityDto.plan_city_id}" name="plan_city_id">
				</form>
				</div>
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>