<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  


		<div class="row border-2  border-bottom border-light mt-3">
			<div class="col">
				<div class="row">

					<div class="col-9" id="naviTS">
						<div class="row">
							<div class="col">
								TripStation
							</div>		
						</div>
						
						<div class="row">
							<div class="col">
								Admin
							</div>		
						</div>
					</div>
					<c:choose>
					<c:when test="${empty sessionUser}">
					<button class="btn btn-secondary"
									type="button" onclick="location.href='./adminLoginPage'">로그인</button>
					</c:when>
					<c:otherwise>
					<div class="col-3 my-auto icon1">
						<i class="bi bi-box-arrow-up-right" onclick = "location.href='./adminLogoutProcess'"></i>		
					</div>
					</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="row">
			&nbsp;
		</div>
		<div class="row">
			  <div class="col">
			  <div class="row my-2">
			  	<div class="col-2 naviIcon">
			  		<i class="bi bi-flag-fill"></i>
			  	</div>
			  	<div class="col-10 ps-0 naviIconText">
			    지역관리
			    </div>
			  </div>
			    <div class="row border-1 border-top border-secondary smallCategory">
			    	<div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
					    <a class="nav-link" href="../admin/registedCityPage">지역정보</a>
				   </div>
				</div>	 
				<div class="row border-1 border-bottom border-secondary smallCategory">
				   <div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
					    <a class="nav-link" href="../admin/registCityPage">지역추가</a>
				   </div>
				</div> 
				
			<div class="row my-2">
				<div class="col-2 naviIcon">
					<i class="bi bi-person-check"></i>
				</div>
			    <div class="col-10 ps-0 naviIconText">
			    	고객승인
			    </div>
			  </div>
			    <div class="row border-1 border-top border-bottom  border-secondary smallCategory">
				    <div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
				    	<a class="nav-link" href="./guideApplyPage">가이드승인</a>
			   		</div>
				</div>	 

					  
			<div class="row my-2">
				<div class="col-2">
					<i class="bi bi-person-fill-slash naviIcon"></i>
				</div>
				<div class="col-10 ps-0 naviIconText">
			    신고관리
			    </div>
			  </div>
			    <div class="row border-1 border-top border-secondary smallCategory">
				   <div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
					    <a class="nav-link" href="./guideReportPage">가이드 신고</a>
				   </div>
				</div>	 

				<div class="row border-1 border-bottom border-secondary smallCategory">
				   <div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
					    <a class="nav-link" href="./userReportPage">유저 신고</a>
				   </div>
				</div>  
				


				
			<div class="row my-2">
				<div class="col-2 naviIcon">
					<i class="bi bi-file-ppt-fill"></i>					
				</div>
			  <div class="col-10 ps-0 naviIconText">
			    쿠폰관리
			    </div>
			  </div>
			    <div class="row border-1 border-top border-secondary smallCategory">
				   <div class="col-2">&nbsp;</div>
				   <div class="col-10 ps-0">
					    <a class="nav-link" href="./registedCouponPage">쿠폰 정보</a>
				   </div>
				</div>	 
				<div class="row row border-1 border-bottom border-secondary smallCategory">
				   <div class="col-2">&nbsp;</div>
				    <div class="col-10 ps-0">
					    <a class="nav-link" href="./registCouponPage">쿠폰 등록</a>
				   </div>
				</div>   
				  
				
		  </div>
		</div>