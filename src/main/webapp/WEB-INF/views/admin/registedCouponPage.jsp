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
<div class="container-fluid">
		<div class="row">
			<div class="col-2" id="naviBack">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-8 mx-auto">
				<div class="row mt-5 pageTitle border-dark-subtle border-bottom border-2">
					<div class="col">
						가이드 신청 내역
					</div>
				</div>				
				<div class="row d-flex justify-content-center mt-5 mx-auto">
					<table class="table h-75 w-100">
					  <thead class="table-secondary">
					    <tr>
					      <th scope="col" class="col-1"></th>
					      <th scope="col" class="col-1">쿠폰 명</th>
					      <th scope="col" class="col-1">수량</th>
					      <th scope="col" class="col-2">쿠폰 공지</th>
					      <th scope="col" class="col-2">발급 기간</th>
					      <th scope="col" class="col-1">사용 종료일</th>
					      <th scope="col" class="col-1">수정</th>
					      <th scope="col" class="col-1">삭제</th>
					    </tr>
					  </thead>
					  <c:forEach var="list" items="${list}">
					  <tbody>
					    <tr>
					      <th scope="row">${list.coupon_id}</th>
					      <td>${list.coupon_title}</td>
					      <td>${list.coupon_amount}</td>
					      <td>${list.coupon_content}</td>					      
					      <td>
					      <div class="col">
					      	<div class="row">
					      		<div class="col ms-2">
					      			<fmt:formatDate value="${list.coupon_issue_start}" pattern="yy-MM-dd" />
					      		</div>
					        </div>
					        <div class="row">
					      		<div class="col">
					      			~<fmt:formatDate value="${list.coupon_issue_end}" pattern="yy-MM-dd" />
					      		</div>
					        </div>					      
					      </div>
					      </td>
					      <td><fmt:formatDate value="${list.coupon_use_end}" pattern="yyyy-MM-dd" /></td>	
					      <td><a href="./updateCouponPage?id=${list.coupon_id}">수정</a></td>
					      <td><button type="button" class="btn btn-danger btn-sm" onclick="location.href='deleteCouponProcess?id=${list.coupon_id}' ">삭제</button>
					    </tr>
					  </tbody>
					  </c:forEach>
					</table>
				</div>			
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>