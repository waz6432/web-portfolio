<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<!-- Link Swiper's CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
<script type="text/javascript">

const categoryValue = 'recent';

//플레이스 목록을 보여줍니다.
function showPlaceList() {
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		
		if(xhr.readyState == 4 && xhr.status == 200) {
			
			const response = JSON.parse(xhr.responseText);
			
			//반복문을 실행할 row를 가져오고 안의 html요소들을 초기화 합니다.
			const listStartRow = document.getElementById("listStartRow");
			
			listStartRow.innerHTML = "";
			
			//반복문을 시작합니다.
			for(data of response.list) {
				
				const divCol = document.createElement("div");
				divCol.className = "col-3 mb-4";
				listStartRow.appendChild(divCol);
				
				const divCard = document.createElement("div");
				divCard.className = "card";
				divCard.style.border = "none";
				divCol.appendChild(divCard);
				
				const divRow1 = document.createElement("div");
				divRow1.className = "row";
				divCard.appendChild(divRow1);
				
				const divCol2 = document.createElement("div");
				divCol2.className = "col";
				divRow1.appendChild(divCol2);
				
				const anchor = document.createElement("a");
				anchor.href="./PlanPlaceDetailPage?plan_place_id=" + data.planPlaceDto.plan_place_id;
				divCol2.appendChild(anchor);
				
				const image = document.createElement("img");
				image.src = "/uploadFiles/mainImage/" + data.planPlaceDto.plan_place_photo;
				image.style.width = "100%";
				image.style.height = "100%";
				image.style.objectFit = "cover";
				image.style.width = "100%";
				image.style.borderRadius = "10px";
				anchor.appendChild(image);
				
				const divRow2 = document.createElement("div");
				divRow2.className = "row align-items-center my-2";
				divCard.appendChild(divRow2);
				
				const divCol3 = document.createElement("div");
				divCol3.className = "col-auto";
				divRow2.appendChild(divCol3);
				
				const span1 = document.createElement("span");
				span1.style.fontSize = "0.9em";
				span1.style.fontWeight = "bold";
				span1.style.display = "-webkit-box";
				span1.style.webkitLineClamp = "1";
				span1.style.webkitBoxOrient = "vertical";
				span1.style.overflow = "hidden";
				span1.style.textOverflow = "ellipsis";
				span1.textContent = data.planPlaceDto.plan_place_name;
				divCol3.appendChild(span1);
				
				const divCol4 = document.createElement("div");
				divCol4.className = "col text-end pe-1";
				divRow2.appendChild(divCol4);
				
				const span2 = document.createElement("span");
				span2.className = "bi bi-heart-fill";
				span2.style.color = "#ff4f78";
				span2.style.fontSize = "12px";
				divCol4.appendChild(span2);
				
				const divCol5 = document.createElement("div");
				divCol5.className = "col-auto p-0";
				divRow2.appendChild(divCol5);
				
				const span3 = document.createElement("span");
				span3.style.fontSize = "0.9em";
				span3.style.fontWeight = "bold";
				span3.textContent = data.loveCount;
				divCol5.appendChild(span3);
				
				const divCol6 = document.createElement("div");
				divCol6.className = "col-auto pe-1";
				divRow2.appendChild(divCol6);
				
				const icon = document.createElement("i");
				icon.style.fontSize = "0.9em";
				icon.className = "bi bi-chat";
				divCol6.appendChild(icon);
				
				const divCol7 = document.createElement("div");
				divCol7.className = "col-auto ps-0";
				divRow2.appendChild(divCol7);
				
				const span5 = document.createElement("span");
				span5.style.fontSize = "0.9em";
				span5.style.fontWeight = "bold";
				span5.textContent = data.commentCount;
				divCol7.appendChild(span5);
				
				const divRow3 = document.createElement("div");
				divRow3.className = "row";
				divCard.appendChild(divRow3);
				
				const divCol8 = document.createElement("div");
				divCol8.className = "col";
				divRow3.appendChild(divCol8);
				
				const span6 = document.createElement("span");
				span6.style.fontSize = "0.9em"
				span6.style.color = "gray"
				span6.style.display = "-webkit-box"
				span6.style.webkitLineClamp = "3"
				span6.style.webkitBoxOrient = "vertical"
				span6.style.overflow = "hidden"
				span6.style.textOverflow = "ellipsis"
				span6.textContent = data.planPlaceDto.plan_place_content;
				divCol8.appendChild(span6);
				
				const divRow4 = document.createElement("div");
				divRow4.className = "row my-2";
				divCard.appendChild(divRow4);
				
				const divCol9 = document.createElement("div");
				divCol9.className = "col";
				divRow4.appendChild(divCol9);
				
				const span7 = document.createElement("span");
				span7.style.fontSize = "0.9em"
				span7.style.display = "-webkit-box"
				span7.style.webkitLimeClamp = "1"
				span7.style.webkitBoxOrient = "vertical"
				span7.style.overflow = "hidden"
				span7.style.textOverflow = "ellipsis"
				span7.textContent = data.planPlaceDto.plan_place_address;
				divCol9.appendChild(span7);
				
			}
			
		}

	}
		xhr.open("post", "./getPlaceList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("sortType=" + categoryValue);
}

window.addEventListener("DOMContentLoaded", function() {
	
	showPlaceList();
	
});

</script>



<style type="text/css">

	.registerButton {
			border-radius: 25px; 
			color: white; 
			position: fixed; 
			z-index: 9999; 
			bottom: 5%; 
			left: 50%; 
			transform: translate(-50%, -50%);
			width: auto;
			height: auto;
			padding: 12px 20px;
			background-image: linear-gradient(98deg,#03c75a,#49c6dd);
			font-size: 0.9em;
			font-weight: 600;
		}
    
    .registerButton:hover {
    	background-image: linear-gradient(98deg,#07e86b,#57def7);
    	color: #f0f0f0;
	}
    
    .categoryButton {
    	width: auto;
    	height: auto;
    	border-radius: 10px;
    	border: 1px solid lightgray;
    	font-size: 14px;
    	color: gray;
    	padding:  7px 15px;
    	background: white;
    }
    
    .categoryFont {
    	font-size: 1em;
    	font-weight: 600;
    	color: gray;
    	position: relative;
    	display: inline-block;
    	
    }
    
    a {
    	text-decoration: none;
    	color: gray;
    }
    
    a:hover {
		text-decoration: none;
		color: black;
	}
	
	ul {
		list-style: none;
	
	}
	
	/*swiper style*/
	 .swiper {
      width: 100%;
      height: 100%;
    }

    .swiper-slide {
      text-align: center;
      font-size: 1em;
	  font-weight: 600;  	
      background: #fff;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    
    :root {
    --swiper-navigation-size: 1em;
    
    .swiper-button-next, .swiper-button-prev {
		color: black;
		
	}
	
	@media (max-width: 760px) {
      .swiper-button-next {
        right: 20px;
        transform: rotate(90deg);
      }

      .swiper-button-prev {
        left: 20px;
        transform: rotate(90deg);
      }
}
</style>

</head>
<body>

    <div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		
        <div class="row mt-4 mb-2">
			<div class="col">
				 <!-- Swiper -->
				<div class="swiper">
				    <div class="swiper-wrapper">
				      <div class="swiper-slide"><a href="#">전체</a></div>
				      <div class="swiper-slide"><a href="/travel/planPlace/placePage?sortType=seoul">서울특별시</a></div>
				      <div class="swiper-slide"><a href="#">경기도</a></div>
				      <div class="swiper-slide"><a href="#">강원도</a></div>
				      <div class="swiper-slide"><a href="#">충청북도</a></div>
				      <div class="swiper-slide"><a href="#">충청남도</a></div>
				      <div class="swiper-slide"><a href="#">전라북도</a></div>
				      <div class="swiper-slide"><a href="#">전라남도</a></div>
				      <div class="swiper-slide"><a href="#">경상북도</a></div>
				      <div class="swiper-slide"><a href="#">경상남도</a></div>
				      <div class="swiper-slide"><a href="#">제주도</a></div>
				      <div class="swiper-slide"><a href="#">부산광역시</a></div>
				      <div class="swiper-slide"><a href="#">대구광역시</a></div>
				      <div class="swiper-slide"><a href="#">인천광역시</a></div>
				      <div class="swiper-slide"><a href="#">광주광역시</a></div>
				      <div class="swiper-slide"><a href="#">대전광역시</a></div>
				      <div class="swiper-slide"><a href="#">울산광역시</a></div>
				      <div class="swiper-slide"><a href="#">세종특별자치시</a></div>
				    </div>
				    <div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				  </div>
			</div>
		</div>
        <div class="row">
        	<div class="col text-center">
        		<c:if test="${!empty sessionuser}">
					<a class="registerButton" href="./registerPlacePage">
						<span>나만의 명소 등록하기</span>
						<i style="font-size: 15px;" class="bi bi-pencil-square"></i>
					</a>
				</c:if>
        	</div>
        </div>
        <div class="row my-3">
            <div class="col">
                <div class="row" id="listStartRow">
                <!-- ajax로 처리했어요 -->
                <%-- 	<c:forEach items="${planPlaceList}" var="list">
                    <div class="col-2 mb-4">
                        <div class="card" style="border: none;">
                            <div class="row">
                                <div class="col">
                                    <a href="./PlanPlaceDetailPage?plan_place_id=${list.planPlaceDto.plan_place_id}">
                                        <img src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">
                                    </a>
                                </div>
                            </div>
                            <div class="row align-items-center my-2">
                                <div class="col-auto">
                                    <span style="font-size: 14px; font-weight: bold; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_name}</span>
                                </div>
                                <div class="col text-end pe-1">
                                    <c:choose>
                                    	<c:when test="${!empty sessionuser}">
                                    		<a href="./clickLoveProcess1?plan_place_id=${list.planPlaceDto.plan_place_id}" class="bi bi-heart-fill" style="${list.searchPlanPlaceLoveDto != null ? 'color: #ff4f78; font-size: 12px;' : 'color: gray; font-size: 12px;'}"></a>
                                    	</c:when>
                                    	<c:otherwise>
                                    		<a href="/travel/login" class="bi bi-heart-fill" style="color: gray; font-size: 14px;"></a>
                                    	</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="col-auto p-0">
                                	<span id="heartCount" style="font-size: 14px; font-weight: bold">${list.loveCount}</span>
                                </div>
                                <div class="col-auto pe-1">
                                    <i style="font-size: 14px;"class="bi bi-chat"></i>
                                </div>
                                <div class="col-auto ps-0">
                                	<span style="font-size: 14px; font-weight: bold">${list.commentCount}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 14px; color: gray; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_content}</span>
                                </div>
                            </div>
                            <div class="row my-2">
                                <div class="col">
                                    <span style="font-size: 14px; display: -webkit-box; -webkit-line-clamp: 1; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_address}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                     </c:forEach> --%>
                </div>
                <div class="row">
                    <div class="col"></div>
                </div>
            </div>
        </div>
    </div>
    





	<%-- <div class="container">
		<div class="row">
			<div class="col">
			</div>
		</div>
		<div class="row mt-4 justify-content-end">
			<div class="col">
				<h4>#플레이스</h4>
			</div>
			<div class="col-auto p-0">
			<c:if test="${!empty sessionuser}">
				<a class="btn btn-outline-dark" href="./registerPlacePage">나만의
					명소 등록하기</a>
			</c:if>
			</div>
		</div>
		<div class="row mt-2 card">
			<div class="col"></div>
			<div class="col-12 text-center">
				<div class="row mt-3">
					<div class="col mx-3 d-flex justify-content-end">
						<div class="dropdown">
  							<button class="btn btn-outline-dark dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
    							필터
  							</button>
 							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=recent">최신순</a></li>
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=love">인기순</a></li>
    						<li><a class="dropdown-item" href="../planPlace/placePage?sortType=comment">댓글많은순</a></li>
  							</ul>
						</div>
					</div>
				</div>
				<div class="row">
					<c:forEach items="${planPlaceList}" var="list">
						<div class="col mt-3 d-flex justify-content-center">
							<div class="card" style="width: 17rem; height: 25rem; position: relative;">
								<div class="row">
									<div class="col">
										<a href="./PlanPlaceDetailPage?plan_place_id=${list.planPlaceDto.plan_place_id}">
											<img src="/uploadFiles/mainImage/${list.planPlaceDto.plan_place_photo}" class="card-img img-fluid">
										</a>
									</div>
								</div>
								<div class="row">
									<div class="col">
										<div class="card-body" style="overflow: hidden;">
											<h5 class="card-title text-start" style="font-size: 1.0rem; font-weight: bold; margin-bottom: 0.5rem; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">${list.planPlaceDto.plan_place_name}</h5>
											<p class="card-text text-start"
												style="font-size: 0.8rem; line-height: 1.2; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
												${list.planPlaceDto.plan_place_content}</p>
											<p class="card-text text-start"
												style="font-size: 0.6rem; line-height: 1.2; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
												${list.planPlaceDto.plan_place_address}</p>
											<c:choose>
												<c:when test="${!empty sessionuser}">
													<p class="card-text text-end" 
												style="font-size: 1.0rem; line-height: 1.2; white-space: nowrap; overflow: hidden;"><a href="./clickLoveProcess1?plan_place_id=${list.planPlaceDto.plan_place_id}" class="${list.searchPlanPlaceLoveDto != null ? 'bi-heart-fill text-danger' : 'bi-heart text-danger'}"></a> ${list.loveCount} <i class="bi bi-chat-dots"></i> ${list.commentCount}</p>
												</c:when>
												<c:otherwise>
													<p class="card-text text-end" 
												style="font-size: 1.0rem; line-height: 1.2; white-space: nowrap; overflow: hidden;"><a href="../login" class="${list.searchPlanPlaceLoveDto != null ? 'bi-heart-fill text-danger' : 'bi-heart text-danger'}"></a> ${list.loveCount} <i class="bi bi-chat-dots"></i> ${list.commentCount}</p>
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="row mb-5"></div>
			</div>
		</div>
		<div class="col"></div>
	</div> --%>


<!-- Swiper JS -->
  <script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper('.swiper', {
      slidesPerView: 8,
      direction: getDirection(),
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev',
      },
      on: {
        resize: function () {
          swiper.changeDirection(getDirection());
        },
      },
    });

    function getDirection() {
      var windowWidth = window.innerWidth;
      var direction = window.innerWidth <= 760 ? 'vertical' : 'horizontal';

      return direction;
    }
  </script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>