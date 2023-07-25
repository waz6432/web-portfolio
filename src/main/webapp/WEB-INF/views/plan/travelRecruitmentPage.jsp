<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@700&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93ae12d4c0f00044228cbd5b5f2f588b&libraries=services,clusterer,drawing"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function searchAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = data.address; // 주소값
            document.getElementById("startPoint").value = addr;
        },
        width: '100%',
        height: '100%',
    }).open({
        left: (window.screen.width - 470) / 2,
        top: (window.screen.height - 630) / 2,
    });
}
</script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
	    var today = new Date(); // 오늘 날짜를 가져옵니다.
		var startDatePicker = flatpickr("#startDate", {
			minDate: today,
			dateFormat : "Y-m-d",
			locale : flatpickr.l10ns.ko, // 한국어 로케일을 설정
			onChange : function(selectedDates, dateStr, instance) {
				endDatePicker.set("minDate", dateStr);
			}
		});

		var endDatePicker = flatpickr("#endDate", {
			minDate: today,
			dateFormat : "Y-m-d",
			locale : flatpickr.l10ns.ko, // 한국어 로케일을 설정
			position : "below", // Force the position of the calendar to open below the input
			onOpen: function () {
				document.querySelector('#endDate').style.marginBottom = '200px';
			},
			onClose: function () {
				document.querySelector('#endDate').style.marginBottom = '0px';
			},
			onChange : function(selectedDates, dateStr, instance) {
				startDatePicker.set("maxDate", dateStr);
			}
		});
	});

	function calc(change) {
		// input 요소 가져오기
		var inputElement = document.querySelector(".count");
		// 현재 값 가져오기
		var currentValue = parseInt(inputElement.value);
		// 변경된 값 계산
		var newValue = currentValue + change;
		// 값이 음수가 되지 않도록 조정
		newValue = Math.max(0, newValue);
		// 값 적용
		inputElement.value = newValue;
	}
</script>
<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		initializeMap();
		getAddresList();
	});
	
	function initializeMap() {
		var mapContainer = document.getElementById('map');
		var mapOption = {
			center : new kakao.maps.LatLng(37.499630, 127.030504), // 위도, 경도
			// draggable: false, 드래그 설정(true: 가능, false: 불가능)
			level : 3
		};
	
		map = new kakao.maps.Map(mapContainer, mapOption);
	}
	
	// 줌 인 버튼 클릭 시 호출되는 함수
	function zoomIn() {
		map.setLevel(map.getLevel() - 1);
	}

	// 줌 아웃 버튼 클릭 시 호출되는 함수
	function zoomOut() {
		map.setLevel(map.getLevel() + 1);
	}

	function getAddresList() {
		var plan_id = '${plan_id}';
		var placeAddressList = [];
		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				// js 작업//
				
				if (response.list != null) {
					console.log(response.list);
					
					for (var i in response.list) {
						placeAddressList.push(response.list[i].placeDto);
					}
					addMarkers(placeAddressList);
				}
			}
		}
		
		//post
		xhr.open("post", "./getAddresList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("plan_id="+plan_id);

	}

	function placeFocus(address, keyword) {
	    var geocoder = new kakao.maps.services.Geocoder();
	    var placesService = new kakao.maps.services.Places();

	    geocoder.addressSearch(address, function(result, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	            
	            // 지도를 부드럽게 이동시키는 코드
	            map.panTo(coords);
	            
	            setTimeout(function() {
	            	map.setLevel(3);
				}, 400);
	        }
	    });
	}
	
	function addMarkers(placeDtoList) {
	    var geocoder = new kakao.maps.services.Geocoder();
	    var bounds = new kakao.maps.LatLngBounds();

	    // Promise로 각 주소를 좌표로 변환하는 비동기 작업을 관리합니다.
	    var promises = placeDtoList.map(function(placeDto, index) {
	        return new Promise(function(resolve) {
	            geocoder.addressSearch(
	                placeDto.plan_place_address,
	                function(result, status) {
	                    if (status === kakao.maps.services.Status.OK) {
	                        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	                        var content = '<div style="background-color: white; border-radius: 15px; padding: 5px; width: 100%; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); position: relative; font-weight: 700;">'
	                            + '<span style="background-color: #03c75a; border-radius: 50%; width: 30px; height: 30px; padding: 5px; display: inline-flex; align-items: center; justify-content: center;"><i class="bi bi-geo-alt-fill" style="font-size: 20px; color: white;"></i></span>'
	                            + ' ' + placeDto.plan_place_name
	                            + '<div style="position: absolute; bottom: -8px; left: 10px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
	                            + '</div>';

	                        // CustomOverlay를 생성합니다.
	                        var mainOverlay = new kakao.maps.CustomOverlay({
	                            position: coords,
	                            content: content,
	                            yAnchor: 0.7,
	                            xAnchor: 0.1
	                        });

	                        // CustomOverlay를 지도에 표시합니다.
	                        mainOverlay.setMap(map);

	                        bounds.extend(coords);
	                    }
	                    resolve();
	                });
	        });
	    });

	    // 모든 주소가 좌표로 변환되면 지도의 범위를 업데이트합니다.
	    Promise.all(promises).then(function() {
	        map.setBounds(bounds);
	    });
	}

</script>
<style type="text/css">
.col-12 {
	font-weight: 700;
}

.button {
	border: none;
	font-size: 22px;
	font-weight: 700;
	background-color: white;
}

.content {
	resize: none;
	height: 400px;
}

.image {
	border-radius: 0.375rem;
	height: 11rem;
}

.card {
	border: none;
}

.placeName {
	font-weight: 700;
	font-size: 22px;
}

.placeLove {
	font-weight: 700;
	font-size: 18px;
}

.placeAddress {
	font-weight: 700;
	font-size: 16px;
	color: #545454;
}

.count {
	border: none;
	text-align: center;
}

.form-control {
	border: none;
}

.form-control:focus {
	border-color: deepskyblue;
	box-shadow: 0 0 5px deepskyblue;
}
.form-control::placeholder {
	color: #D1D1D1;
	font-style: italic;
}

.commit {
	background-color: #03c75a;
	color: white;
	border-radius: 1rem;
	height: 2em;
}

#mapContainer {
	position: relative;
	width: 100%;
	height: 100%; /* 필요한 높이로 수정해주세요 */
}

#map {
	width: 100%;
	height: 100%;
	border-radius: 0.375rem;
}

#zoomButtons {
	position: absolute;
	bottom: 10px; /* 필요에 따라 수정해주세요 */
	right: 10px; /* 필요에 따라 수정해주세요 */
	z-index: 1;
}

#zoomInButton, #zoomOutButton {
	border: none;
	width: 40px;
	height: 36px;
	font-size: 25px;
	background-color: white;
}

#zoomInButton {
	border-radius: 0.375rem 0.375rem 0 0;
}

#zoomOutButton {
	border-radius: 0 0 0.375rem 0.375rem;
}

i {
    color: #03c75a;
}

body {
	font-family: 'Noto Sans KR', sans-serif;
}
</style>
<title>파티 모집 페이지</title>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		
		<div class="row mt-2">
			<div class="col-4">
				<form action="./travelRecruitmentProcess?plan_id=${plan_id}" method="post">
					<div class="row">
						<div class="col-12">
							<i class="bi bi-calendar-check"></i> 여행 출발 날짜
						</div>
						<div class="col mt-1">
							<input id="startDate" class="form-control" type="text" name="planning_start_date" placeholder="여행 출발 날짜">
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-12">
							<i class="bi bi-compass"></i> 모집 위치
						</div>
						<div class="col mt-1">
							<input id="startPoint" class="form-control start-point" type="text" name="planning_start_point" placeholder="ex) 위치 or 주소" onclick="searchAddress()" readonly>
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-12">
							<i class="bi bi-card-heading"></i> 모집 제목
						</div>
						<div class="col mt-1">
							<input class="form-control title" type="text" name="planning_title" placeholder="ex) 12월 3박 4일 제주도 같이 가실 동행 3분 구합니다.">
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-12">
							<i class="bi bi-chat-right-text"></i> 모집 내용
						</div>
						<div class="col mt-1">
							<textarea class="form-control content" name="planning_content" placeholder="1. 현재 동행이 있나요?&#10; ex) 혼자에요 / 동행 1명 있어요&#10;&#10;&#10;2. 어떤 동행을 찾고 있나요?&#10; ex) 맛집 탐방을 좋아하는 20대 동행을 찾고 있어요.&#10;&#10;&#10;3. 원하는 여행 코스가 있다면 알려주세요.&#10;&#10;&#10;(3000자 이내)">${data.planning_content}</textarea>
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-12">
							<i class="bi bi-people-fill"></i> 모집 인원
						</div>
						<div class="col mt-1 d-flex justify-content-between">
							<button class="button" type="button" onclick="calc(-1)">-</button>
							<span id="totalPeople">
								<input class="form-control count" type="text" value="1" name="planning_member" readonly>
							</span>
							<button class="button" type="button" onclick="calc(1)">+</button>
						</div>
					</div>
					<div class="row mt-5">
						<div class="col-12">
							<i class="bi bi-calendar-check"></i> 모집 종료 날짜
						</div>
						<div class="col mt-1">
							<input id="endDate" class="form-control" type="text" name="planning_end_date" placeholder="모집 종료 날짜">
						</div>
					</div>
					<div class="row mt-5">
						<div class="col d-grid me-3">
							<button class="button commit">모집완료</button>
						</div>
					</div>
				</form>
			</div>
			<div class="col-8">
				<div class="row" style="height: 87vh;">
					<div class="col">
						<div id="mapContainer">
							<div class="map shadow" id="map"></div>
							
						    <div id="zoomButtons">
						    	<div class="row">
						    		<div class="col">
						    			<button class="d-flex align-items-center justify-content-center" id="zoomInButton" onclick="zoomIn()">+</button>
						    		</div>
						    	</div>
						    	<div class="row">
						    		<div class="col">
						    			<button class="d-flex align-items-center justify-content-center" id="zoomOutButton" onclick="zoomOut()">-</button>
						    		</div>
						    	</div>
						    </div>
						</div>
					</div>
				</div>
				<div class="row mt-3">
					<div id="carousel" class="carousel slide" data-bs-ride="carousel">
					    <div class="carousel-inner">
					        <c:forEach items="${list}" var="data" varStatus="status">
					            <c:if test="${status.index % 3 == 0}">
									<div class="carousel-item ${status.index == 0 ? 'active' : ''}">
					                <div class="row">
					            </c:if>
									<div class="col-md-4" style="cursor: pointer;" onclick="placeFocus('${data.placeDto.plan_place_address}', '${data.placeDto.plan_place_name}')">
										<div class="card shadow">
											<img class="image" alt="이미지" src="/uploadFiles/mainImage/${data.placeDto.plan_place_photo}">
											<div class="d-flex justify-content-between">
												<span class="placeName">${data.placeDto.plan_place_name}</span>
												<div class="placeLove d-flex align-items-center">
													<i class="bi bi-heart-fill text-danger mx-2"></i>
													${data.count}
												</div>
											</div>
											<div class="placeAddress">
												<i class="bi bi-geo-alt"></i>
												${data.placeDto.plan_place_address}
			                                </div>
			                            </div>
			                        </div>
			            <c:if test="${status.index % 3 == 2 || status.index == fn:length(list) - 1}">
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
</div>

				</div>
			</div>
		</div>
	</div>
<jsp:include page="../common/bottomNavi.jsp"></jsp:include>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>