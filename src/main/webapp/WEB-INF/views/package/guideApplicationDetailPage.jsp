<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<title>플랜 참가 신청 페이지</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=99e2d84aee0718d5faa9b9e1821fca6b&libraries=services,drawing,clusterer"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>

var map1;
var marker1;
var infowindow1;
var coords1;
var map2;
var marker2;
var infowindow2;
var coords2;
var startPoint = '${map.guidePlanningDto.guide_planning_start_point}'; // 최초 모집장소
var user_id = '${sessionuser.user_id}';
var couponDiscountValue = 0;
var linePath = [];
var linePath2 = [
    new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
    new kakao.maps.LatLng(33.452739313807456, 126.5709308145358),
    new kakao.maps.LatLng(33.45178067090639, 126.5726886938753) 
];



let placeThumbnail2;
let placeThumbnail3;


const guidePlanningId = new URLSearchParams(location.search).get("guide_planning_id");

function addThousandSeparator(number) {
	  // 숫자를 문자열로 변환
	  const numberString = number.toString();
	  
	  // 정규식을 사용하여 천 단위 구분자(쉼표) 추가
	  const numberWithSeparator = numberString.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	  
	  return numberWithSeparator;
	}

function pay(partner_order_id, partner_user_id, item_name, total_amount) {
 const xhr = new XMLHttpRequest();

 xhr.onreadystatechange = function() {
     if (xhr.readyState === 4) {
         if (xhr.status === 200) {
             const response = JSON.parse(xhr.responseText);
             var box = response.next_redirect_pc_url;
             window.open(box);
         } else {
             
         }
     }
 }

 xhr.open("POST", "./packagePayProcess");
 xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
 xhr.send("partner_order_id=" + encodeURIComponent(partner_order_id) +
          "&partner_user_id=" + encodeURIComponent(partner_user_id) +
          "&item_name=" + encodeURIComponent(item_name) +
          "&total_amount=" + encodeURIComponent(total_amount));
}

function full(){

	swal('모집 인원 초과', ' ', 'warning'); 
	
}


function packageIn(guidePlanningId){
   	
	   const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4 && xhr.status == 200){
				const response = JSON.parse(xhr.responseText);
				
					var partner_order_id = response.partner_order_id;
					var partner_user_id = response.userId;
					var item_name = response.item_name;
					var total_amount0 = response.total_amount;
					
					var total_amount = total_amount0 - couponDiscountValue;
					
				
					
					pay(partner_order_id,partner_user_id, item_name, total_amount);
					
				
				
				
				
			}
		}
		
	
		
		xhr.open("POST", "./packageIn");
		xhr.setRequestHeader("Content-TYPE","application/x-www-form-urlencoded"); 
		xhr.send("guide_planning_id=" + guidePlanningId);
	   
	   
}

function initMap1() {
	var container = document.getElementById('map1');
	var options = {
		center: new kakao.maps.LatLng(33.450701, 126.570667),
		level: 3
	};

	map1 = new kakao.maps.Map(container, options);
}

function initMap2() {
	var container = document.getElementById('map2');
	var options = {
		center: new kakao.maps.LatLng(36.3415, 127.3894),
		level: 13
	};

	map2 = new kakao.maps.Map(container, options);
	
}

function showPlace(item) {
	  // 전달받은 element 내에서 .placeName 클래스를 가진 요소를 찾습니다.
	  var placeAddressElement = item.querySelector('.address');
	  var address = placeAddressElement.value;
	  search2(address);
	}
	


function startPointLocation() {
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(startPoint, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);

			if (marker1) {
				marker1.setPosition(coords1);
			} else {
				marker1 = new kakao.maps.Marker({
					map: map1,
					position: coords1
				});
			}

			var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + startPoint + '</div>';

			if (infowindow) {
				infowindow.setContent(content);
			} else {
				infowindow = new kakao.maps.InfoWindow({
					content: content
				});
			}

			infowindow.open(map1, marker1);

			map1.setCenter(coords1);
			map1.setLevel(4);
		}
	});
}

function showStart() {
	var address = startPoint;
	search(address);
}





function search(keyword) {
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(keyword, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);

			if (marker1) {
				marker1.setPosition(coords1);
			} else {
				marker1 = new kakao.maps.Marker({
					map: map1,
					position: coords1
				});
			}

			var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + keyword + '</div>';

			if (infowindow1) {
				infowindow1.setContent(content);
			} else {
				infowindow1 = new kakao.maps.InfoWindow({
					content: content
				});
			}

			infowindow1.open(map1, marker1);

			map1.setCenter(coords1);
			map1.setLevel(3);
		}
	});
}


function mapLine(keyword){
	var geocoder = new kakao.maps.services.Geocoder();
	
	geocoder.addressSearch(keyword, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			
			linePath.push(new kakao.maps.LatLng(result[0].y, result[0].x))
			/* const spots = new kakao.maps.LatLng(result[0].y, result[0].x);
			
			console.log(spots);
			
			linePath.push(spots); */
			
			
			
		}
	});
	
}

function Line(){
	
	var polyline = new kakao.maps.Polyline({
	    path: linePath2, // 선을 구성하는 좌표배열 입니다
	    strokeWeight: 5, // 선의 두께 입니다
	    strokeColor: '#FFAE00', // 선의 색깔입니다
	    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
	    strokeStyle: 'solid' // 선의 스타일입니다
	});
	


	polyline.setMap(map2);
	
	
}


function search2(keyword) {
	var geocoder = new kakao.maps.services.Geocoder();

	geocoder.addressSearch(keyword, function(result, status) {
		if (status === kakao.maps.services.Status.OK) {
			coords2 = new kakao.maps.LatLng(result[0].y, result[0].x);

			if (marker2) {
				marker2.setPosition(coords2);
			} else {
				marker2 = new kakao.maps.Marker({
					map: map2,
					position: coords2
				});
			}

			var content = '<div style="width:150px; text-align:center; padding:6px 0;">' + keyword + '</div>';

			if (infowindow2) {
				infowindow2.setContent(content);
			} else {
				infowindow2 = new kakao.maps.InfoWindow({
					content: content
				});
			}

			infowindow2.open(map2, marker2);

			map2.setCenter(coords2);
			map2.setLevel(3);
		}
	});
}


function planprice(){
	
	var planPrice = document.querySelector(".planprice");
	planPrice.innerText = addThousandSeparator(${map.guidePlanningDto.guide_planning_price}) + '원'
	    
}

function planningDay() {
	  var planningDay = document.querySelector(".planningDay");
	  var guidePlanningStartDate = new Date(Date.parse('${map.guidePlanningDto.guide_planning_start_date}'));

	  var planDayListSize = ${map.planDayListSize - 1};

	  var guidePlanningEndDate = new Date(guidePlanningStartDate.getTime() + (planDayListSize * 24 * 60 * 60 * 1000));

	  planningDay.innerText = formatPlanningDate(guidePlanningStartDate) + ' - ' + formatPlanningDate(guidePlanningEndDate);
	  planningDay.style.fontWeight = "bold";
	}

	function formatPlanningDate(date) {
	  const year = date.getFullYear().toString().slice(-2);
	  const month = (date.getMonth() + 1).toString().padStart(2, '0');
	  const day = date.getDate().toString().padStart(2, '0');
	  const dayOfWeek = getDayOfWeek(date);
	  return year + '.' + month + '.' + day + ' (' + dayOfWeek + ')';
	}

	function getDayOfWeek(date) {
	  const daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"];
	  const dayOfWeek = daysOfWeek[date.getDay()]; // 0부터 일요일
	  return dayOfWeek;
	}



	function calculateDate(startDate, planDay) {
		  const start = new Date(startDate);
		  const calculatedDate = new Date(start.getTime() + (planDay - 1) * 24 * 60 * 60 * 1000);
		  return formatPlanningDate(calculatedDate);
		}


	 function info() {
	    const planDetail = document.getElementById("planDetail");
	    const xhr = new XMLHttpRequest();

	    xhr.onreadystatechange = function () {
	        if (xhr.readyState === 4 && xhr.status === 200) {
	            const response = JSON.parse(xhr.responseText);

	            if (response.list != null) {

	                for (data of response.list) {
	                    // 카드 제목 생성
	                    const aaa = document.createElement("div");
	                    aaa.classList.add("card");

	                    const cardHeader = document.createElement("div");
	                    cardHeader.classList.add("card-header");

	                    const cardTitle = document.createElement("h5");
	                    cardTitle.classList.add("card-title");
	                    cardTitle.innerText = 'DAY' + data.planDay.plan_day;
	                    cardTitle.style.fontSize = "25px";
	                    cardTitle.style.fontWeight = "bold";
	                    

	                    const cardText = document.createElement("p");
	                    cardText.classList.add("card-text");
	                    cardText.innerText = calculateDate(response.guidePlanningDto.guide_planning_start_date,
	                        data.planDay.plan_day);

	                    cardHeader.appendChild(cardTitle);
	                    cardHeader.appendChild(cardText);
	                    aaa.appendChild(cardHeader);

	                    // 카드 바디 생성
	                    const cardBody = document.createElement("div");
	                    cardBody.classList.add("card-body");
	                    
	                    const row1 = document.createElement("div");
                        row1.classList.add("row");
                        cardBody.appendChild(row1);
                        
                        const col1 = document.createElement("div");
                        col1.classList.add("col");
                        row1.appendChild(col1);
                        
                        let placePhoto;

	                    for (place of data.placeList) {
	                        const row2 = document.createElement("div");
	                        row2.classList.add("row");
	                        row2.classList.add("mt-3");
	                        col1.appendChild(row2);
	                        
	                        const col2 = document.createElement("div");
	                        col2.classList.add("col");
	                        row2.appendChild(col2);

	                        // 카드 바디 내용 구성
	                        const placeNameElement = document.createElement("div");
	                        placeNameElement.classList.add("place_name");
	                        placeNameElement.addEventListener("click", function() {
	                            showPlace(this);
	                        });

	                        const placeIndex = data.placeList.indexOf(place) + 1;
	                        const iconClass = 'bi-' + placeIndex + '-circle-fill';
	                       

	                        const iconElement = document.createElement("span");
	                        iconElement.classList.add(iconClass);

	                        const spaceTextNode = document.createTextNode(" ");
	                        const content =  document.createElement("span");
	                        content.innerText = place.planPlace.plan_place_name;
	                        const city = document.createElement("span");
	                        city.innerText =  ' (' + place.planCityName+ ')';
	                        city.style.fontSize = "15px";
	                        city.style.fontWeight = "bold";
	                        city.style.color = "gray";

	                        const address = document.createElement("input");
	                        address.classList.add("address");
	                        address.setAttribute("type", "hidden");
	                        address.value = place.planPlace.plan_place_address;
	                        mapLine(place.planPlace.plan_place_address);
	                        
	                        content.style.fontSize = "20px";
	                        content.style.fontWeight = "bold";
	                        content.style.marginRight = "5px";
	                        content.style.cursor = "pointer";
	                        
	                        iconElement.style.fontSize = "20px";
	                        iconElement.style.marginRight = "5px";
							
	                        
	                        placeNameElement.appendChild(iconElement);
	                        placeNameElement.appendChild(spaceTextNode);
	                        placeNameElement.appendChild(content);
	                        placeNameElement.appendChild(city);
	                        placeNameElement.appendChild(address);

	                        col2.appendChild(placeNameElement);
	                        
	                        const row3 = document.createElement("div");
	                        row3.classList.add("row");
	                        row3.classList.add("mt-3");
	                        col1.appendChild(row3);
	                        
	                        const col3 = document.createElement("div");
	                        col3.classList.add("col-3");
	                        col3.classList.add("text-center");
	                        col3.classList.add("px-auto");
	                        col3.classList.add("mx-auto");
	                        row3.appendChild(col3);
	                        
	                        const col4 = document.createElement("div");
	                        col4.classList.add("col");
	                        row3.appendChild(col4);
	                        
	                        
	                       
	                        
	                        const placeThumbnail = document.createElement("img");
	                        placeThumbnail.classList.add("place_thumbnail");
	                        placeThumbnail.src = "/uploadFiles/mainImage/" + place.planPlace.plan_place_photo;
	                        placeThumbnail.style.width = "90px";
	                        placeThumbnail.style.height = "90px";
	                        placeThumbnail.style.borderRadius = "50%";
	                        
	                        placePhoto = place.planPlace.plan_place_photo;

	                        // placePhoto 값을 활용하여 이미지 경로를 설정하고, placeThumbnail2와 placeThumbnail3 값을 할당합니다.
	                        if (placeThumbnail2 === undefined) {
	                            placeThumbnail2 = placePhoto;
	                        } else if (placeThumbnail3 === undefined) {
	                            placeThumbnail3 = placePhoto;
	                        }
	                        
	                        
	                       
	                        
	                        
	                        

	                        const placeContent = document.createElement("p");
	                        placeContent.classList.add("place_content");
	                        placeContent.innerText = place.planPlace.plan_place_content;
	                        
		                     
		                    col3.appendChild(placeThumbnail);
		                    col4.appendChild(placeContent);
		                                     

	                       
	                    }
	         
	                   aaa.appendChild(cardBody);

	                    // 최종적으로 planDetail에 추가
	                    planDetail.appendChild(aaa);
	                    showCard(0);
	                    
	                    
	                    
	                }
	                
	                placeThumbnail();
	                

	            }
	        }
	    };

	    xhr.open("POST", "./guideApplicationDetailInfo");
	    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhr.send("guide_planning_id=" + guidePlanningId);
	} 
	 
	 
	 function placeThumbnail(){
		 
		 console.log(placeThumbnail2);
		 console.log(placeThumbnail3);
		 
		 const aaa = document.querySelector(".aaa");
		 const bbb = document.querySelector(".bbb");
		 
		 const placeThumbnails1 = document.createElement("img");
		 placeThumbnails1.classList.add("packageThumbnail2");
         placeThumbnails1.src = "/uploadFiles/mainImage/" + placeThumbnail2;
        
         
         const placeThumbnails2 = document.createElement("img");
         placeThumbnails2.classList.add("packageThumbnail3");
         placeThumbnails2.src = "/uploadFiles/mainImage/" + placeThumbnail3;
        
		 aaa.appendChild(placeThumbnails1);
		
		 bbb.appendChild(placeThumbnails2);
	 }
	 
	 let currentCardIndex = 0;

	 function showCard(index) {
		  const cards = document.getElementsByClassName("card");
		  if (index < 0) {
		    index = 0;
		  } else if (index >= cards.length) {
		    index = cards.length - 1;
		  }

		  currentCardIndex = index;

		  // 모든 카드를 숨기고, 현재 인덱스의 카드만 보여줍니다.
		  for (let i = 0; i < cards.length; i++) {
		    if (i === currentCardIndex) {
		      cards[i].style.display = "block";
		    } else {
		      cards[i].style.display = "none";
		    }
		  }
		}


	 function showPreviousCard() {
	   showCard(currentCardIndex - 1);
	 }

	 function showNextCard() {
	   showCard(currentCardIndex + 1);
	 }
	 
	
	 
	 function showCoupon(){
		
		 
		 const xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4 && xhr.status == 200){
					const response = JSON.parse(xhr.responseText);
					
					
					
					const myCoupon = document.querySelector(".myCoupon");
					
					const ccc = document.createElement("option");
					ccc.classList.add("selected");
					ccc.value = 0;
					ccc.innerText="My Coupon"
					
					myCoupon.appendChild(ccc);
					 
					if (response.list != null){
						
						for ( data of response.list){
							
							const option = document.createElement("option");
							option.value = data.couponDto.coupon_discount;
						    option.innerText = data.couponDto.coupon_title + " (" +addThousandSeparator(option.value)+"원)"
						    
						    myCoupon.appendChild(option);
							
						}
						 myCoupon.addEventListener("change", function () {
						        discount(myCoupon.value);
						      });

					}
					
					
				}
			}
			
			//get
			xhr.open("get", "./getCoupon?user_id="+user_id);
			xhr.send();
	
	 }
	 
	 function discount(couponDiscount) {
		  
		
		 const guidePlanningPrice = parseFloat(${map.guidePlanningDto.guide_planning_price});

		
		  couponDiscountValue = parseFloat(couponDiscount);

		  
		  const discountPay = guidePlanningPrice - couponDiscountValue;
		  
		 var planPrice = document.querySelector(".planprice");
			planPrice.innerText = addThousandSeparator(discountPay) + '원'
		
		}
	 
	 
		 /* function info() {
			
            const planDetail = document.getElementById("planDetail");
		    const xhr = new XMLHttpRequest();

		    xhr.onreadystatechange = function() {
		        if (xhr.readyState === 4 && xhr.status === 200) {
		            const response = JSON.parse(xhr.responseText);

		            if (response.list != null) {
		            	
		            	for ( data of response.list) {
		            		
			            	const aaa = document.getElementById("templete_planDetail").cloneNode(true);
			            	aaa.removeAttribute("id");
			            	aaa.classList.remove("d-none");
			            	
			            	aaa.querySelector(".planDetail_Day").innerText = 'DAY' + data.planDay.plan_day;
			            	aaa.querySelector(".planDetail_Date").innerText = calculateDate(response.guidePlanningDto.guide_planning_start_date, 
		                    		 data.planDay.plan_day);
			            	
			            	planDetail.appendChild(aaa);
			            		
			            		for(place of data.placeList){
			            			
			            			const bbb = document.getElementById("templete_place").cloneNode(true);
			            			bbb.removeAttribute("id");
					            	bbb.classList.remove("d-none");
					            	const placeNameElement = bbb.querySelector(".place_name");
					            	placeNameElement.setAttribute('onclick', 'showPlace(this)');
					            	const placeIndex = data.placeList.indexOf(place) + 1;
					            	const iconClass = 'bi-' + placeIndex + '-circle-fill';

					            	const iconElement = document.createElement("span");
					            	
					            	iconElement.classList.add(iconClass);
					            	const spaceTextNode = document.createTextNode(" ");

					            	const content = place.planPlace.plan_place_name 
					            	
					            	placeNameElement.innerText = '';
					            	iconElement.appendChild(spaceTextNode);
					            	placeNameElement.appendChild(iconElement);
					            	placeNameElement.append(content);
					            	
					            	const city = document.createElement("span");
					            	
					            	city.innerText = ' (' + place.planCityName+ ')';
					            	city.style.fontSize = '15px';  // 폰트 크기를 20px로 설정
					            	city.style.fontWeight = 'bold';
					            	city.style.color = 'gray';  // 텍스트 색상을 회색으로 설정
					            	placeNameElement.appendChild(city);
					            	
					            	const address = document.createElement('input');
				                     address.classList.add('address');
				                     address.setAttribute('type', 'hidden');
				                     address.value = place.planPlace.plan_place_address; 
				                     placeNameElement.appendChild(address); 
					            	
					            	
					            	bbb.querySelector(".place_thumbnail").src = "/uploadFiles/mainImage/" + place.planPlace.plan_place_photo;
					            	
					            	bbb.querySelector(".place_content").innerText = place.planPlace.plan_place_content;
					            	
					            	
					            	aaa.querySelector(".planDetail_place").appendChild(bbb);
					            	
					            	
			            		}
		            	}
		            }
		        }
		    }

		    xhr.open("POST", "./guideApplicationDetailInfo");
		    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		    xhr.send("guide_planning_id=" + guidePlanningId);
		}
		 
		
 */
 
 var commentList;
 
 function createCommentFunc() {
		var comment = document.querySelector('.comment');
		
		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				// js 작업//
				
				if (response.ok != null) {
					comment.value = '';
					getCommentList();
				}
			}
		}

		//post
		xhr.open("post", "./createInitComment");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		var params = "guide_planning_id=" + guidePlanningId + "&user_comment=" + encodeURIComponent(comment.value);
		xhr.send(params);
	}
 
 function formatDate(date) {
		var yyyy = date.getFullYear();
		var MM = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero based
		var dd = ('0' + date.getDate()).slice(-2);
		var hh = ('0' + date.getHours()).slice(-2);
		var mm = ('0' + date.getMinutes()).slice(-2);

		return yyyy + '/' + MM + '/' + dd + ' ' + hh + ':' + mm;
	}
 
 function getCommentList() {

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				if (commentList) {
					commentList.innerHTML = '';	
				}
				
		
				
				if (response.list != null) {
					var boardInfo = document.querySelector('.board-info');
					
					var replyInputCol = null;
					
					boardInfo.innerText =  '  댓글 ' + response.list.length;
					
					for (let i in response.list) {
						
						console.log(response.list[i]);
						commentList = document.querySelector('.comment-list');
						
						var date = new Date(response.list[i].guidePlanningComment.reg_date);
						var formattedDate = formatDate(date);
						
					    // Row div
					    const rowDiv = document.createElement('div');
					    rowDiv.classList.add('row', 'mb-4');
					    rowDiv.style.fontFamily = "'Noto Sans KR', sans-serif";

					    // Col-1 div
					    const col1Div = document.createElement('div');
					    col1Div.classList.add('col-1');
					    const img = document.createElement('img');
					    img.classList.add('user-thumbnail');
					    img.alt = "썸네일";
					    img.src = '/uploadFiles/profileImage/'+response.list[i].user.user_image;
					    col1Div.appendChild(img);
					    
					    // Col div
					    const colDiv = document.createElement('div');
					    colDiv.classList.add('col', 'p-0', 'mb-2');
					    const p1 = document.createElement('p');
					    p1.classList.add('m-0');
					    p1.innerText = response.list[i].user.user_nickname;
					    const p2 = document.createElement('p');
					    p2.classList.add('mb-2');
					    p2.innerText = formattedDate;
					    p2.style.fontSize = '0.7em';
					    p2.style.color = '#999999';
					    colDiv.appendChild(p1);
					    colDiv.appendChild(p2);

					    // Col-12 div
					    const col12Div = document.createElement('div');
					    col12Div.classList.add('col-12');
					    const div = document.createElement('div');
					    div.innerText = response.list[i].guidePlanningComment.user_comment;
					    col12Div.appendChild(div);
					    
					    // Another col-12 div
					    const anotherCol12Div = document.createElement('div');
					    anotherCol12Div.classList.add('col-12', 'mt-1');
					    
					    
					    var heartIcon = document.createElement("i");
					    heartIcon.className = response.list[i].isLove == 'ok' ? 'bi, bi-heart-fill text-danger' : 'bi, bi-heart'; 
					    heartIcon.onclick = function() {
							loginCheck();
							
							addLike(response.list[i].guidePlanningComment.guide_planning_comment_id);	
						}
					    const span = document.createElement('span');
					    span.classList.add('comment-love');
					    span.innerHTML = '좋아요 ' + response.list[i].totalLike + '개';
					    span.appendChild(heartIcon);
					    
					    anotherCol12Div.appendChild(span);

					    // Append all children to the row div
					    rowDiv.appendChild(col1Div);
					    rowDiv.appendChild(colDiv);
					    rowDiv.appendChild(col12Div);
					    rowDiv.appendChild(anotherCol12Div);
					    commentList.appendChild(rowDiv);
					}
				}
			}
		}
		
		//post
		xhr.open("post", "./getCommentList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("guide_planning_id="+guidePlanningId);
	}
	
	function addLike(guide_comment_id) {
	

	
	const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				if (response.ok != null) {
					getCommentList();
				}
			}
		}
		
		//post
		xhr.open("post", "./addLike");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("guide_planning_comment_id="+guide_comment_id);

	}
	
	function loginCheck() {
		var sessionUser = '${sessionuser}';
		if (sessionUser == '') {
			location.href = '../login';
		}
	}

 
 
	
document.addEventListener("DOMContentLoaded", function() {
		planningDay();
		info();
		showStart()
		planprice();
		initMap1();
		initMap2();
		showCoupon();
		getCommentList();
		 Line();

	});
 


</script>
<style>


#planDetail{
	
	
}

.card-body {
    overflow-y: scroll; /* 크롬, 사파리, 오페라, 엣지 */
    height : 500px;
}

.card-body::-webkit-scrollbar {
    display: none; /* 크롬, 사파리, 오페라, 엣지 */
}


 .user-thumbnail {
	border-radius: 50%;
	border: 2px solid #03c75a;
	margin-right: 10px;
	width: 50px;
	height: 50px;
}


.startDateBack {
	background-color: #d5f0ff;
	height: 34px;
	width: 34px;
	border-radius: 6px;
	display: inline-flex;
	align-items: center;
	justify-content: center;
}

.myPlace {
	font-size: 13px;
	font-weight: 600;
	padding-left: 10px;
}

.planDay {
	font-size: 16px;
	font-weight: 600;
	padding-left: 10px;
}

.grandChildCol {
	display: inline-block;
	width: 80px;
	height: 30px;
	border-radius: 30px;
	background: navy;
}

.childSpan {
	color: white;
	position: relative;
	left: 10px;
	top: 2px;
	font-size: 14px;
	font-weight: 600;
}

.bar {
	color: navy;
}

.packageThumbnail {
	width: 100%;
	height: 500px;
}

.packageThumbnail2 {
	width: 100%;
	height: 240px;
}

.packageThumbnail3 {
	width: 100%;
	height: 240px;
}

.place_thmbnail{
	width: 100%;
	height: 20px;
}

.line {
	border: none;
	border-top: 2px solid;
	color: black;
}


.table {
    width: 100%;
   height: 500px;
    border-collapse: collapse;
    vertical-align: middle;
   	border-top : 5px solid #ededed;
   	
}
.table th,
.table td {
    padding: 8px;
    text-align: center;
    

}
.table th {
	background-color :#fafafa;
    width: 20%;
    font-size : 20px;
}
.table td {
	background-color : white;
    width: 80%;
    font-size : 15px;
    
}

.place_name:hover{
	cursor: pointer;
}

.comment-wrapper {
	position: relative;
}

.comment::placeholder {
	font-size: 0.8em;
	color: lightgrey;
}

.comment-info {
	font-size: 0.8em;
	color: #999999;
}

.comment-button {
	position: absolute;
	top: 8px;
	right: 20px;
	border: none;
	color: #03c75a;
}

.comment-reply {
	border: none;
	font-size: 0.8em;
	padding: 0;
	color: #999999;
}

.comment-love {
	font-size: 0.8em;
	color: #999999;
}

.bi-heart,
.bi-heart-fill {
	margin-left: 0.5em;
	font-size: 0.9em;
}

</style>

</head>
<body>
	<div class="container-fluid p-0">
		<div class="container">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		</div>
		<div class="row">
			<div class="col">
				<hr class="mt-0 shadow">
			</div>
		</div>
	</div>



	<div class="container">
		<!-- 패키지 소개 -->
		<div class="row mt-2">
			<div class="col">
				<div class="row mb-3">
					<div class="col" style="font-size: 50px; font-weight: bold;">
						<!-- 패키지명 -->
						${map.guidePlanningDto.guide_planning_title}
					</div>
				</div>
				<div class="row">
					<div class="col-8">
						<!-- 썸내일 -->
						<img src="/uploadFiles/${map.planDto.plan_thumbnail }"
							class="packageThumbnail">
					</div>
					<div class="col-4">
						<div class="row mb-4">
							<div class="col aaa">


							</div>

						</div>
						<div class="row">
							<div class="col bbb">

							</div>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
				

<!-- 간단 표!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
	<div class="container mt-5">
		<div class="row">
			<div class="col-8">
				<table class="table">
				 	<tr>
				        <th><i class="bi bi-airplane-fill"></i> 패키지</th>
				        <td>${map.guidePlanningDto.guide_planning_title}</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-calendar-check-fill"></i> 날짜</th>
				        <td class="planningDay">Mark</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-balloon-heart-fill"></i> 방문명소</th>
				        <td>
				        <c:forEach items="${map.list}" var="mapItem">
				            <c:forEach items="${mapItem.placeList}" var="placeMap" varStatus="loop">
							    ${placeMap.planPlace.plan_place_name}
							    <c:if test="${!loop.last}">,</c:if>
							</c:forEach>
				        </c:forEach>
				        
				        </td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-flag-fill"></i> 출발장소</th>
				        <td>${map.guidePlanningDto.guide_planning_start_point}</td>
				    </tr>
				    <tr>
				        <th><i class="bi bi-person-check-fill member1"></i> 모집인원</th>
				        <td>
				        <c:choose>
				        	<c:when test="${map.packageMember>=map.guidePlanningDto.guide_planning_member}">
				        		모집 완료
				        	</c:when>
				        	<c:otherwise>
				        		${map.packageMember}/${map.guidePlanningDto.guide_planning_member }
				        	</c:otherwise>
				        </c:choose>
				        </td>
				    </tr>
				</table>
			</div>
			<div class="col-1"></div>
			<div class="col-3 text-center shadow" style=" border-radius: 10px; background-color :#fafafa; ">
				<div class="row mt-3">
					<div class="col">
						<span style="font-size : 20px; font-weight:bold;">${map.guide.guide_name}</span><span style="font-size : 15px; font-weight:bold;">  가이드 님</span>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col">
						<img src="/uploadFiles/profileImage/${map.user.user_image}" style="width : 100px; height:100px; border-radius:50px;">
					</div>
				</div>
				<div class="row mt-5">
					<div class="col" style="color : gray;">
						${map.guide.guide_profile }
					</div>
				</div>
				<div class="row mt-5">
					<div class="col"  >
						<span style="font-size : 20px; font-weight: bold;">패키지 비용</span><span style="font-size : 10px; color:gray;  font-weight: bold;">(성인 1인 기준)</span>
					</div>
				</div>
				<div class="row mt-1">
					<div class="col planprice" style="font-size:40px; font-weight: bold;">
						
					</div>
				</div>
				<div class="row mt-3">
					<div class="col-1">
					</div>
					<select class="col form-select myCoupon" aria-label="Default select example">
					  
					</select>
					<div class="col-1">
					</div>
				
			
				</div>
				<div class="row mt-4 mb-5 ">
					<div class="col-3"></div>
					<div class="col-6 payButton ">
						 <c:choose>
				        	<c:when test="${map.packageMember>=map.guidePlanningDto.guide_planning_member}">
				        		<a class="btn pay-button d-grid" role="button" onclick="full()"
	   						 style="font-size: 15px; font-weight: bold; background-color: gray; color: white;">모집 완료</a>
				        	</c:when>
				        	<c:otherwise>
				        		<a class="btn pay-button d-grid" role="button" onclick="packageIn(guidePlanningId)"
	   						 style="font-size: 30px; font-weight: bold; background-color: #03c75a; color: white;">결제</a>
				        	</c:otherwise>
				        </c:choose>
						
					</div>
					<div class="col-3"></div>
				</div>
			</div>
				
					
			
				      
				     
			
		</div>
	</div>
	
<div class="row mt-5 mb-5">
	<div class="col-2">
	
	</div>
	<div class="col" style="border-top : solid 3px 	#ededed;">
	
	</div>
	<div class="col-2">
		
	</div>
</div>





	<div class="container" >
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col-6">
						<div class="row "  >
								<div class="col-1"></div>
								<div class="col">
									<i class="bi-flag-fill"></i>
									<span>모집 장소 : </span>
									<span style="font-weight: bold;">${map.guidePlanningDto.guide_planning_start_point}</span>
								</div>
								<div class="col-1"></div>
							</div>
							<div class="row mt-3" >
								<div class="col-1"></div>
								<div class="col">
									<div class="map1 shadow" id="map1" style="width: 100%; height: 300px;">
									</div>		
								</div>				
								<div class="col-1"></div>
								
							</div>
						<div class="row mt-5"  >
							<div class="col-1 d-flex align-items-center ">
								<i class="bi bi-caret-left-fill" style="cursor: pointer; font-size: 30px; " onclick="showPreviousCard()"></i>

							</div>
							<div class="col" id="planDetail"  >
							</div>
							<div class="col-1 d-flex align-items-center">
								<i class="bi bi-caret-right-fill" style="cursor: pointer; font-size: 30px; " onclick="showNextCard()"></i>
								
							
							</div>
						</div>
					</div>
					<div class="col-1">
					</div>
					<div class="col-5">
						<div class= "row mt-5">
							<div class="col">
								<div class="map2 shadow" id="map2" style="width: 100%; height: 900px;">
								</div>	
							</div>
						</div>			
					</div>
				</div>
			</div>
		</div>
			<div class="row mt-5 mb-5">
				
				<div class="col" style="border-top : solid 3px 	#ededed;">
				
				</div>
				
			</div>
		<div class="row mt-5">
			<div class="col-2"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 mb-1 comment-info d-flex justify-content-between">
						<span class="board-info"></span>
					</div>
					<div class="col mb-3 comment-wrapper" onclick="loginCheck()">
						<input class="form-control comment p-2" type="text" placeholder="댓글을 입력해주세요.">
						<button class="comment-button" style = "background:white; font-size:15px;font-weight:bold;"type="button" onclick="createCommentFunc()">작성</button>
					</div>
				</div>
				<div class="row">
					<div class="col comment-list"></div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col">
			       
			       -footer-                              
			       
			</div>
		</div>
	</div>


	
	
	


	

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>