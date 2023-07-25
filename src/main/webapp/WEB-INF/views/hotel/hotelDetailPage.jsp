<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
 <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818488f03bbc3c53eaa216d3aaf39e13&libraries=services"></script>
<script type="text/javascript">
	
	
	window.onload = function() {
	    var mapContainer = document.getElementById('map');
	    
	    var addressElement = document.getElementById("hotel_address");
	    var hotelAddress = addressElement.innerText;
	
	    geocodeAddress(hotelAddress, function(lng, lat) {
	        if (lng && lat) {
	            var mapOption = {
	                center: new kakao.maps.LatLng(lat, lng), // 초기 중심 좌표
	                level: 3 // 지도의 확대 레벨
	            };
	            
	            var map = new kakao.maps.Map(mapContainer, mapOption);
	
	            var markerPosition = new kakao.maps.LatLng(lat, lng);
	            var marker = new kakao.maps.Marker({
	                position: markerPosition
	            });
	            marker.setMap(map);
	        } else {
	            console.log('주소 변환 실패');
	        }
	    });
	}
	
	function geocodeAddress(hotelAddress, callback) {
	    var geocoder = new kakao.maps.services.Geocoder();
	    geocoder.addressSearch(hotelAddress, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            callback(result[0].x, result[0].y);
	        } else {
	            console.log('Geocoding failed: ' + status);
	            callback(null, null);
	        }
	    });
	}

	
	
	let sessionUserId = null;
	
	//로그인 상태 확인
	function getUserId() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				if (response.result == "success") {
					
					sessionUserId = response.userId;
				}
			}
		}
		
		xhr.open("get", "/travel/getUserId", false);
		xhr.send();
	}

	
	const hotelId = new URLSearchParams(location.search).get("hotel_id");
	
	// 선택된 체크인, 체크아웃 날짜 리턴 함수 
	function getSelectedDates() {
		
		const checkInDateId = document.getElementById("checkInDate");
		const checkOutDateId = document.getElementById("checkOutDate");
		
		
		const checkInDate = new Date(checkInDateId.value);
		const checkOutDate = new Date(checkOutDateId.value);
	
		  
		return { checkInDate, checkOutDate };
		
	}
	
	// 숙소 일일 예약금 변수 초기화
	let reservationFeePerDay;
	
	// ajax 숙소 일일가격 호출 함수
	function getReservationFeePerDay() {
		
		const xhr = new XMLHttpRequest();
		  
		  xhr.onreadystatechange = function() {
			  
			  if(xhr.readyState == 4 && xhr.status == 200) {
				  
				  const response = JSON.parse(xhr.responseText);
				  
				  reservationFeePerDay = response.hotel.hotelDto.hotel_price;
				  
			  }
		  }
		  
		  xhr.open("get", "./getHotel?hotel_id=" + hotelId);
		  xhr.send();
	}
	
	let numDays = 0;
	
	// 예약금 총합 계산 함수
	function calculateReservationTotal() {
		  const { checkInDate, checkOutDate } = getSelectedDates();

		  const millisecondsPerDay = 24 * 60 * 60 * 1000;
		  
		  const checkInTime = checkInDate.getTime();
		  const checkOutTime = checkOutDate.getTime();

		  const timeDiff = checkOutTime - checkInTime;

		  numDays = Math.round(timeDiff / millisecondsPerDay);
		  
		  let numPeople = parseInt(numberOfPeople.innerText);
		  
		  const totalReservationFee = reservationFeePerDay * numDays * numPeople;
		  
		  return totalReservationFee;
		}
	
	// 예약금 총합 출력 함수
	function displayReservationTotal() {
		
	  const reservationTotal = calculateReservationTotal();
	  	  
	  const reservationTotalElement = document.getElementById("reservationTotal");
	  const reserveDay = document.getElementById("reserveDay");
	  
	  reserveDay.innerText = numDays
	  reservationTotalElement.innerText = reservationTotal;
	  
	  if (isNaN(reserveDay.innerText)) {
		  
		  reserveDay.innerText = 0;
		  
	  }
	  
	  if (isNaN(reservationTotalElement.innerText)) {
		  
		  reservationTotalElement.innerText = 0;
		  
	  }
		  
	}
	
	// 인원 감소 함수
	function clickDashButton() {
		
		let currentValue = parseInt(numberOfPeople.innerText);
		
		if (currentValue <= 1) {
			
			return;
		}
		
		numberOfPeople.innerText = currentValue - 1;
		
		displayReservationTotal();
	}
	
	// 인원 추가 함수
	function clickPlusButton() {
		
		let currentValue = parseInt(numberOfPeople.innerText);
		
		numberOfPeople.innerText = currentValue + 1;
		
		displayReservationTotal();
	}
	
	function reserveProcess() {
		
		if (sessionUserId == null) {
			
			return;
			
		}
		const guestNum = document.getElementById("numberOfPeople").innerText;
		const checkInDate = document.getElementById("checkInDate").value;
		const checkOutDate = document.getElementById("checkOutDate").value;
		const totalFee = document.getElementById("reservationTotal").innerText;
		
		if (checkInDate && checkOutDate == null) {
			
			return;
			
		}
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if(xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
			
			}
		}
		
		
		xhr.open("post", "./insertReservationInfo");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("hotel_id=" + hotelId + "&hotel_reservation_check_in=" + checkInDate + "&hotel_reservation_check_out=" + checkOutDate);
		
		window.location.href = "/travel/hotel/hotelPaymentPage?hotel_id=" + hotelId + "&guestNum=" + guestNum + "&checkInDate=" + checkInDate + "&checkOutDate=" + checkOutDate + "&totalFee=" + totalFee + "&numDays=" + numDays;
	}

		  
		  
	
	window.addEventListener("DOMContentLoaded", function() {
		
		getUserId()
		
		const checkInDateId = document.getElementById("checkInDate");
		const checkOutDateId = document.getElementById("checkOutDate");
		const numberOfPeople = document.getElementById("numberOfPeople");
		const reserveDay = document.getElementById("reserveDay");
		  
		numberOfPeople.innerText = 1;
		
		checkInDateId.addEventListener("change", displayReservationTotal);
		checkOutDateId.addEventListener("change", displayReservationTotal);
		
		getReservationFeePerDay();
		displayReservationTotal();
		
	});

	
</script>

<style>
    .hostImage {
        width: 54px;
        height: 54px;
        border-radius: 50%;
        overflow: hidden;
    }

     .hostImage2 {
        width: 62px;
        height: 62px;
        border-radius: 50%;
        overflow: hidden;
    }
    .reserveButton {
        width: 100%;
        height: 100%;
        background-image: linear-gradient(98deg,#03c75a,#49c6dd);
        border-radius: 10px;
        border: none;
        padding: 10px 20px;
        color: rgb(255, 255, 255);
        font-weight: 600;
        font-size: 0.9em;
    }
    .commentProfileImage {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        overflow: hidden;
    }
    .commentButton {
        width: auto;
        height: auto;
        border-radius: 10px;
        border: solid black 1px;
        font-weight: bold;
        font-size: 0.9em;
        background-color: rgb(255, 255, 255);
        padding: 10px 20px;
    }
    .reserveCard {
        width: auto;
        height: auto;
        border: solid rgb(218, 218, 218) 1px;
        border-radius: 15px;
        background: #ffffff;
        box-shadow: 0px 6px 9px rgba(0, 0, 0, 0.18);
        padding: 20px 20px;
    }
    
    .imageButton {
     	width: auto;
        height: auto;
        border-radius: 10px;
        border: solid black 1px;
        font-weight: bold;
        font-size: 0.9em;
        background-color: rgb(255, 255, 255);
        padding: 10px 20px;
    }
    
</style>
</head>

<body>
    
<div class="container">

	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
	</div>
	
    <div class="row mt-4">
        <div class="col">
<!--숙소 제목 및 정보들입니다.-->        
            <div class="row">
                <div class="col">
                    <span style="font-size: 25px; font-weight: 600;">${hotelMap.hotelDto.hotel_title }</span>
                </div>
            </div>
            <div class="row align-items-center mb-3">
                <div class="col-auto pe-1">
                    <i class ="bi bi-star-fill" style="font-size: 14px;"></i>
                </div>
                <div class="col-auto px-0">
                	<c:choose>
	                	<c:when test="${!empty hotelAvgReviewPoint}">
	                		<span style="font-size: 14px; font-weight: bold;">
	                			 ${hotelAvgReviewPoint}
	                		</span>
	                	</c:when>
	                	<c:otherwise>
	                		<span style="font-size: 14px; font-weight: bold;">0.0</span>
	                	</c:otherwise>
                	</c:choose>
                </div>
                <div class="col-auto px-1">
                    <span style="font-size: 14px; font-weight: bold;">∙후기</span>
                    <c:choose>
                    	<c:when test="${!empty hotelReviewPoint}">
                    		<span style="font-size: 14px; font-weight: bold;">${hotelReviewPoint}</span>
                    	</c:when>
                    	<c:otherwise>
                    		<span style="font-size: 14px; font-weight: bold;">아직없음</span>
                    	</c:otherwise>
                    </c:choose>
                </div>
                <div class="col-auto">
                    <span id="hotel_address" style="font-size: 14px;">${hotelMap.hotelDto.hotel_address}</span>
                </div>
                <div class="col px-0 d-flex justify-content-end">
                    <span style="font-size: 12px; font-weight: bold;">공유하기</span>
                </div>
                <div class="col-auto d-flex">
                    <span style="font-size: 12px; font-weight: bold;">저장</span>
                </div>
            </div>
<!--이미지를 불러옵니다.-->            
            <div class="row mb-5">
                <div class="col">
                    <img src="/uploadFiles/hotelMainImage/${hotelMap.hotelDto.hotel_main_image }" alt="" style="width: 100%; height: 38em;">
                </div>
                <div class="col">
                    <div class="row row-cols-2">
                    	<c:forEach items="${hotelImageDetailsDtoList}" var="list" begin="0" end="3">
	                        <div class="col">
	                            <img src="/uploadFiles/hotelDetailImages/${list.hotelImageDetailsDto.hotel_image_details_link }" alt="" style="width: 100%; height: 19em;">
	                        </div>
                    	</c:forEach>             
                    </div>
                </div>
            </div>
<!--숙소 호스팅 관련 옵션 소개란입니다.-->            
            <div class="row">
                <div class="col">
                    <div class="row">
                        <div class="col-auto">
                            <div class="row">
                                <div class="col-auto pe-1">
                                    <span style="font-size: 20px; font-weight: bold;">${hotelMap.userDto.user_nickname }</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 20px; font-weight: bold;">님이 호스팅하는 숙소</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 14px;">최대 인원${hotelMap.hotelDto.hotel_limit_number }명</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 14px;">침실${hotelMap.hotelDto.hotel_bedRoom }개</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 14px;">침대${hotelMap.hotelDto.hotel_bed }개</span>
                                </div>
                                <div class="col-auto px-1">
                                    <span>∙</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 14px;">욕실${hotelMap.hotelDto.hotel_bathRoom }개</span>
                                </div>
                            </div>
                        </div>
                        <div class="col d-flex justify-content-end">
                            <img class="hostImage" src="/uploadFiles/profileImage/${hotelMap.userDto.user_image }" alt="">
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 소개입니다.-->                    
                    <div class="row mb-4">
                        <div class="col-auto">
                            <i class="bi bi-door-closed" style="font-size: 25px;"></i>
                        </div>
                        <div class="col-auto">
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 14px; font-weight: 600;">셀프 체크인</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 13px; color: gray;">키패드를 이용해 체크인하세요.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-4">
                        <div class="col-auto">
                            <i class="bi bi-trophy" style="font-size: 25px;"></i>
                        </div>
                        <div class="col-auto ps-0">
                            <div class="row">
                                <div class="col-auto pe-0">
                                    <span style="font-size: 14px; font-weight: 600;">${hotelMap.userDto.user_nickname }</span>
                                </div>
                                <div class="col-auto px-0">
                                    <span style="font-size: 14px; font-weight: 600;">님은 슈퍼호스트입니다</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 13px; color: gray;">편안히 머무를 수 있도록 최선을 다하는 호스트입니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3">
                        <div class="col-auto">
                            <i class="bi bi-geo-alt" style="font-size: 25px;"></i>
                        </div>
                        <div class="col-auto">
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 14px; font-weight: 600;">훌륭한 숙소 위치</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col ps-0">
                                    <span style="font-size: 13px; color: gray;">최근 숙박한 게스트중 100%가 별점 5점을 준 숙소입니다.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 정보입니다.-->                    
                    <div class="row my-5">
                        <div class="col">
                            <span style="font-size: 14px;">
                                ${hotelMap.hotelDto.hotel_content}
                            </span>
                        </div>
                    </div>
                    <hr class="my-4">
<!--숙소 편의시설입니다.-->                    
                    <div class="row mb-3">
                        <div class="col">
                            <span style="font-size: 20px; font-weight: bold;">숙소 편의시설</span>
                        </div>
                    </div>
                    <div class="row row-cols-2">
                       	<c:forEach items="${hotelFacilityList}" var="hotelFacilityList" begin="0" end="7">
	                        <div class="col py-2">
	                            <div class="row align-items-center">
	                                <div class="col-auto">
	                                	<img alt="" src="/uploadFiles/hotelFacilityIcon/${hotelFacilityList.hotelFacilityDto.hotel_facility_image}" style="width: 23px;">
	                                </div>
	                                <div class="col ps-0">
	                                    <span style="font-size: 14px;">${hotelFacilityList.hotelFacilityDto.hotel_facility_name}</span>
	                                </div>
	                            </div>
	                        </div>
                        </c:forEach>
                    </div>
                    <div class="row mt-4">
                        <div class="col">
                        	<c:if test="${hotelFacilityCount > 6}">
                            <button class="commentButton">편의시설 ${hotelFacilityCount}개 모두 보기</button>
                            </c:if>
                        </div>
                    </div>
                </div>
<!--예약 기능이 들어있는 카드입니다.-->                
                <div class="col d-flex justify-content-end">
                    <div class="row">
                        <div class="col">
                            <div class="reserveCard">
                                <div class="row align-items-center">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col-auto pe-0">
                                                <span style="font-size: 20px; font-weight: bold;">\</span>
                                            </div>
                                            <div class="col px-0">
                                                <span style="font-size: 20px; font-weight: bold;">
                                                	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                                </span>
                                                <span style="font-size: 14px;">/박</span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-auto">
                                        <div class="row">
                                            <div class="col pe-1">
                                                <i class ="bi bi-star-fill" style="font-size: 13px;"></i>
                                            </div>
                                            <div class="col-auto px-0">
                                            	<c:choose>
                                            		<c:when test="${!empty hotelAvgReviewPoint}">
                                            			<span style="font-size: 13px; font-weight: bold;">
                                                			${hotelAvgReviewPoint}
                                                		</span>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<span style="font-size: 13px; font-weight: bold;">
                                                			0.0
                                                		</span>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span>∙</span>
                                            </div>
                                            <div class="col-auto px-0">
                                                <span style="font-size: 13px; color: gray;">∙후기</span>
                                            </div>
                                            <div class="col-auto ps-0">
                                            	<c:choose>
                                            		<c:when test="${!empty hotelReviewPoint}">
                                            			<span style="font-size: 13px; color: gray;">
                                                			${hotelReviewPoint}
                                                		</span>
                                            		</c:when>
                                            		<c:otherwise>
                                            			<span style="font-size: 13px; color: gray;">
                                                			없음
                                                		</span>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row my-3">
                                    <div class="col">
                                        <div class="row">
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <span style="font-size: 10px; font-weight: bold;">체크인</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <input type="date" class="form-control" id="checkInDate" min="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_start_date}" pattern="yyyy-MM-dd" />" max="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_end_date}" pattern="yyyy-MM-dd" />">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-6">
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <span style="font-size: 10px; font-weight: bold;">체크아웃</span>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-auto">
                                                        <input type="date" class="form-control" id="checkOutDate" min="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_start_date}" pattern="yyyy-MM-dd" />" max="<fmt:formatDate value="${hotelMap.hotelDto.hotel_reserve_end_date}" pattern="yyyy-MM-dd" />">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-auto">
                                                <span style="font-size: 10px; font-weight: bold;">인원</span>
                                            </div>
                                        </div>
                                        <div class="row py-1 align-items-center">
                                            <div class="col-auto">
                                                <i onclick="clickDashButton()" class="bi bi-dash-lg" style="font-size: 18px;"></i>
                                            </div>
                                            <div class="col-auto">
                                                <span id="numberOfPeople"></span>
                                            </div>
                                            <div class="col-auto">
                                                <i onclick="clickPlusButton()" class="bi bi-plus-lg" style="font-size: 18px;"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <button onclick="reserveProcess()" class="reserveButton">예약하기</button>
                                    </div>
                                </div>
                                <div class="row py-2">
                                    <div class="col px-3 text-center">
                                        <span style="font-size: 13px;">예약 확정 전에는 요금이 청구되지 않습니다.</span>
                                    </div>
                                </div>
                                <div class="row py-2" style="font-size: 14px; ">
                                    <div class="col-auto pe-0">
                                        <span >\</span>
                                    </div>
                                    <div class="col-auto px-0">
                                        <span>
                                        	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                        </span>
                                    </div>
                                    <div class="col-auto px-1">
                                        <span>x</span>
                                    </div>
                                    <div class="col-auto px-0">
                                        <span id="reserveDay">1</span>
                                    </div>
                                    <div class="col-auto ps-0">
                                        <span>박</span>
                                    </div>
                                    <div class="col d-flex justify-content-end" >
                                        <div class="row">
                                            <div class="col px-0">
                                                <span >\</span>
                                            </div>
                                            <div class="col-auto ps-0">
                                                <span>
                                                	<fmt:formatNumber pattern="#,###" value="${hotelMap.hotelDto.hotel_price }" var="price"/>${price }
                                               	</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row py-2" style="font-size: 14px;">
                                    <div class="col">
                                        <span style="text-decoration: underline;">트립스테이션 서비스 수수료</span>
                                    </div>
                                    <div class="col-auto">
                                        <span>무료</span>
                                    </div>
                                </div>
                                <hr class="my-3">
                                <div class="row" style="font-size: 16px; font-weight: bold;">
                                    <div class="col text-start">
                                        <span>총 합계</span>
                                    </div>
                                    <div class="col px-0 text-end">
                                        <span>\</span>
                                    </div>
                                    <div class="col-auto ps-0">
                                    	<span id="reservationTotal"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<!--별점 및 후기-->
            <hr class="my-5">
            <div class="row align-items-center">
                <div class="col-auto pe-1">
                    <i class ="bi bi-star-fill" style="font-size: 16px;"></i>
                </div>
                <div class="col-auto px-0">
                	<c:choose>
                		<c:when test="${!empty hotelAvgReviewPoint}">
                			 <span style="font-size: 20px; font-weight: bold;">${hotelAvgReviewPoint}</span>
                		</c:when>
	                	<c:otherwise>
	                		 <span style="font-size: 20px; font-weight: bold;">0.0</span>
	                	</c:otherwise>
                	</c:choose>
                </div>
                <div class="col-auto px-1">
                    <span style="font-size: 20px; font-weight: bold;">∙후기</span>
                    <c:choose>
                    	<c:when test="${!empty hotelReviewPoint}">
                    		<span style="font-size: 20px; font-weight: bold;">${hotelReviewPoint}</span>
                    	</c:when>
                    	<c:otherwise>
                    		<span style="font-size: 20px; font-weight: bold;">아직없음</span>
                    	</c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="row row-cols-2 my-4">
            	<c:forEach items="${hotelReviewDtoList}" var="list">
	                <div class="col mb-4">
	                    <div class="row align-items-center">
	                        <div class="col-auto">
	                            <img src="/uploadFiles/profileImage/${list.userDto.user_image }" alt="" class="commentProfileImage">
	                        </div>
	                        <div class="col px-0">
	                            <div class="row">
	                                <div class="col">
	                                    <span style="font-size: 15px; font-weight: bold;">${list.userDto.user_nickname }</span>
	                                </div>
	                            </div>
	                            <div class="row">
	                                <div class="col">
	                                    <span style="font-size: 15px; color: gray;">2023년 7월</span>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                    <div class="row mt-2">
	                        <div class="col">
	                            <span>${list.hotelReviewDto.hotel_review_content}</span>
	                        </div>
	                    </div>
	                </div>
                </c:forEach>
            </div>
            <div class="row">
                <div class="col">
               		<c:if test="${hotelReviewPoint > 6}">
               			<button class="commentButton"><span>${hotelReviewPoint}개 모두보기</span></button>
               		</c:if>
                </div>
            </div>
            <hr class="my-5">
<!--호스팅 지역-->            
            <div class="row mb-4">
                <div class="col">
                    <span style="font-size: 20px; font-weight: bold;">호스팅 지역</span>
                </div>
            </div>
            <div class="row pb-2">
                <div class="col">
                    <div id="map" style="width:100%; height:500px;"></div>
                </div>
            </div>
            <div class="row mt-2">
            	<div class="col">
            		<span style="font-size: 14px; font-weight: 600;">${hotelMap.hotelDto.hotel_address}</span>
            	</div>
            </div>
            <hr class="my-5">
<!--호스트 정보-->            
            <div class="row align-items-center">
                <div class="col-auto">
                    <img src="/uploadFiles/profileImage/${hotelMap.userDto.user_image }" alt="" class="hostImage2">
                </div>
                <div class="col ps-0">
                    <div class="row">
                        <div class="col-auto pe-1">
                            <span style="font-size: 20px; font-weight: bold;">호스트:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 20px; font-weight: bold;">${hotelMap.userDto.user_nickname }</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-auto pe-1">
                            <span style="font-size: 13px; color: gray;">회원 가입일:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 13px; color: gray;">2020년 5월</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row my-4">
                <div class="col-auto">
                    <i class="bi bi-star-fill" style="font-size: 14px;"></i>
                </div>
                <div class="col-auto ps-0 pe-1">
                    <span style="font-size: 14px;">후기</span>
                </div>
               	<c:choose>
                	<c:when test="${!empty hotelReviewPoint}">
               			<div class="col-auto px-0">
		                    <span style="font-size: 14px;">${hotelReviewPoint}</span> 
                		</div>
		                <div class="col-auto px-0">
		                    <span style="font-size: 14px;">개</span>
		                </div>
	                </c:when>
	                	<c:otherwise>
	                		<div class="col-auto px-0">
		                		<span style="font-size: 14px;">아직 없음</span>	                		
	                		</div>
	                	</c:otherwise>
                	</c:choose>
                <div class="col-auto">
                    <i class="bi bi-shield-fill-check" style="font-size: 14px;"></i>
                </div>
                <div class="col-auto px-0">
                    <span style="font-size: 14px;">본인 인증 완료</span>
                </div>
                <div class="col-auto">
                    <i class="bi bi-trophy-fill" style="font-size: 14px;"></i>
                </div>
                <div class="col px-0">
                    <span style="font-size: 14px;">슈퍼호스트</span>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <span style="font-size: 14px;">
                        은퇴 후 안동에 귀향하여 우리의 전통한옥을 사랑하고 연구하며 알리는 사람입니다.
                        좌우명
                        미소짓고
                        인사하고
                        대화하고
                        칭찬하자.
                        우리의 한옥에서 전세계 게스트를 통하여 한옥을 글로벌화 시키고자 합니다.
                    </span>
                </div>
            </div>
            <hr class="my-5">
<!--알아두어야 할 사항-->
            <div class="row mb-3">
                <div class="col">
                    <span style="font-size: 20px; font-weight: bold;">알아두어야 할 사항</span>
                </div>
            </div>
            <div class="row mb-5">
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">숙소 이용규칙</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 14px;">체크인 가능 시간:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 14px;">오후 ${hotelMap.hotelDto.hotel_check_in_time }:00 이후</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 14px;">체크아웃 가능 시간:</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 14px;">오전 ${hotelMap.hotelDto.hotel_check_out_time}:00 전까지</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-auto pe-1">
                            <span style="font-size: 14px;">게스트 정원</span>
                        </div>
                        <div class="col px-0">
                            <span style="font-size: 14px;">${hotelMap.hotelDto.hotel_limit_number }명</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">안전 및 숙소</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span style="font-size: 14px;">일산화탄소 경보기</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col">
                            <span style="font-size: 14px;">화재경보기</span>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="row">
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">환불 정책</span>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col">
                        	<span id="checkInDay" style="font-size: 14px;"></span>
                            <span style="font-size: 14px;">오후 12:00</span>
                            <span style="font-size: 14px;">전에 취소하면 부분 환불을 받으실수 있습니다.</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid">
    <div class="row">
        <div class="col" style="background-color: #ededed; height: 10em;">
            <div class="row">
                <div class="col">
                    <div class="row my-4">
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">트립스테이션 지원</span>
                        </div>
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">커뮤니티</span>
                        </div>
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">호스팅</span>
                        </div>
                        <div class="col">
                            <span style="font-size: 14px; font-weight: bold;">트립스테이션</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
</body>
</body>
</html>