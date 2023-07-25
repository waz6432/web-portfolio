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
			<div class="col-md-2 mt-3 ">
				<jsp:include page="../common/leftNavi.jsp"></jsp:include>
			</div>
			<c:if test="${!empty sessionUser}">
			<div class="col-md-9 offset-md-1">
				<form action="updateCouponProcess" method="post" enctype="multipart/form-data">
				<div class="row mt-3">
				  <div class="col-12 h2">
				  	쿠폰 수정 페이지
				  </div>
				</div>
				<div class="row mt-3">  
				  <div class="col-md-6">
				    <label for="inputText1" class="form-label">쿠폰명</label>
				    <input type="text" class="form-control" value="${couponDto.coupon_title}" id="intputText1" name="coupon_title">
				  </div>
				</div>
				<div class="row">
				  <div class="col-md-6 mb-3">
					  <label for="exampleFormControlTextarea1" class="form-label">쿠폰 공지</label>
					  <textarea class="form-control" id="exampleFormControlTextarea1" rows="3" name="coupon_content">${couponDto.coupon_content}</textarea>
					</div>
				</div>
				<div class="row">
				  <div class="col-6 mb-3">
				    <label for="formFile" class="form-label" >쿠폰 이미지</label>
  					<input class="form-control" type="file" id="formFile"  name="couponImage" accept="image/*">
  					<img src="/uploadFiles/${couponDto.coupon_image}" alt="Coupon Image" width="200" height="200">
				  </div>
				</div>
				<div class="row">
				  <div class="col-6 mb-3">
					  <label for="issueDate" class="form-label">발급 기한</label>
					  <div class="input-group">
					    <input class="form-control" id="issueStartDate" type="date" value="<fmt:formatDate value="${couponDto.coupon_issue_start}" pattern="yyyy-MM-dd" />" name="coupon_issue_start">
					    <span class="input-group-text">~</span>
					    <input class="form-control" id="issueDate" type="date" value="<fmt:formatDate value="${couponDto.coupon_issue_end}" pattern="yyyy-MM-dd" />" name="coupon_issue_end">
					  </div>
				  </div>
				</div>
				<div class="row mb-3">
				  <div class="col-md-6">
						<label for="useEndDate" class="form-label">사용 종료일</label>
					    <input class="form-control" id="useEndDate" type="date" value="<fmt:formatDate value="${couponDto.coupon_use_end}" pattern="yyyy-MM-dd" />" name="coupon_use_end">
				  </div>
				</div>
				<div class="row">
				  <div class="col-md-6 mb-3">
				    <label for="discount" class="form-label">할인 금액</label>
				    <div class="input-group">
				      <input class="form-control" id="discount" value="${couponDto.coupon_discount}" type="text" name="coupon_discount">
				      <span class="input-group-text">원</span>
				    </div>
				  </div>
				</div>
				<div class="row">
				  <div class="col-md-6 mb-3">
				    <label for="totalAmount" class="form-label">총 수량</label>
				    <div class="input-group">
				      <input class="form-control" id="totalAmount" value="${couponDto.coupon_amount}" type="text" name="coupon_amount">
				      <span class="input-group-text">개</span>
				    </div>
				  </div>
				</div>
				  <div class="col-12">
				    <button type="submit" class="btn btn-primary">수정</button>
				    <button type="button" class="btn btn-primary" onclick="location.href='registedCouponPage'">취소</button>
				  </div>		
				  <input type="hidden" value="${couponDto.coupon_id}" name="coupon_id">		  
				</form>
			</div>
			</c:if>
		</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
</body>
</html>