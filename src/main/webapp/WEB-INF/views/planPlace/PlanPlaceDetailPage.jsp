<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
	
<script>
	
	const planPlaceId = new URLSearchParams(location.search).get("plan_place_id");
	
	function ajaxTemplete() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
			}
		}
		
		//get
		xhr.open("get", "요청 url?파라미터=값");
		xhr.send();
		
		//post
		xhr.open("post", "요청 url");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("파라미터 = 값");
	}
	
	//로그인 상태 확인
	let sessionUserId = null;
	
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
	
	//댓글 등록
	function registerComment() {
		
		console.log("함수는 실행돼~");
		
		if (sessionUserId == null) {
			
			return;
			
		}
		
		const commentBox = document.getElementById("commentBox");
		const commentBoxValue = commentBox.value;
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				commentBox.value = "";
				
				resetCommentList();
			}
		}
		
		
		
		xhr.open("post", "./registerComment");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("plan_place_id=" + planPlaceId + "&plan_place_user_comment=" + commentBoxValue);
	
	}
	
	//좋아요 액션
	function clickHeart() {
		
		if (sessionUserId == null) {
			
			if (confirm("로그인을 하셔야 이용하실 수 있습니다. 로그인 하시겠습니까?")) {
				
				location.href = "/travel/login";
				
			}
			
			return;
		}
		
		console.log("hello");
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				resetHeart();
				resetCountOfHeart()
				
			}
		}
		
		xhr.open("get", "./clickHeart?plan_place_id=" + planPlaceId);
		xhr.send();
		
		
	}
	
	//좋아요 상태 최신화
	function resetHeart() {
		
		if (sessionUserId == null) return;
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const heartBox = document.getElementById("heartBox");
				
				if (response.heartStatus == null) {
					
					heartBox.classList.remove("bi-heart-fill");
					heartBox.classList.add("bi-heart");
					
				} else {
					
					heartBox.classList.remove("bi-heart");
					heartBox.classList.add("bi-heart-fill");
				}
			}
		}
		
		xhr.open("get", "./checkHeartStatus?plan_place_id=" + planPlaceId);
		xhr.send();
		
	}
	
	//좋아요 갯수 최신화
	function resetCountOfHeart() {
		
		console.log("hello");
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const countHeartBox = document.getElementById("countHeart");
				
				countHeartBox.innerText = response.heartCount;
			}
		}
		
		xhr.open("get", "./checkHeartCount?plan_place_id=" + planPlaceId);
		xhr.send();
		
	}
	
	//댓글 갯수 최신화
	function resetCountOfComment() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const countCommentBox = document.getElementById("countComment");
				
				countCommentBox.innerText = response.commentCount;
			}
		}
		
		xhr.open("get", "./checkCommentCount?plan_place_id=" + planPlaceId);
		xhr.send();
	}
	
	function resetCommentList() {
		
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			
			if (xhr.readyState == 4 && xhr.status == 200) {
				
				const response = JSON.parse(xhr.responseText);
				
				const commentListBox = document.getElementById("commentListBox");
				
				commentListBox.innerHTML = "";
				
				for(data of response.commentList) {
					const rowDiv0 = document.createElement("div");
					rowDiv0.setAttribute("class", 'row');
					
					
					const colDiv = document.createElement("div");
					colDiv.setAttribute("class", "col mb-2");
					rowDiv0.appendChild(colDiv);
					
					
					const rowDiv1 = document.createElement("div");
					rowDiv1.classList.add("row");
					colDiv.appendChild(rowDiv1); /*row*/
					
					const colDiv1 = document.createElement("div");
					colDiv1.classList.add("col-auto");
					rowDiv1.appendChild(colDiv1); /*col*/
				
					const profileImage = document.createElement("img");
					profileImage.setAttribute("class", "user-comment-image");
					const imageUrl = "/uploadFiles/profileImage/" + data.userDto.user_image;
					profileImage.setAttribute("src", imageUrl);
					colDiv1.appendChild(profileImage);
					
					const colDiv2 = document.createElement("div");
					colDiv2.setAttribute("class", "col-auto hello");
					rowDiv1.appendChild(colDiv2); /*col*/
					
					const rowDiv3 = document.createElement("div");
					rowDiv3.setAttribute("class", "row");
					colDiv2.appendChild(rowDiv3);
						
					const colDiv3 = document.createElement("div");
					colDiv3.setAttribute("class", "col-auto");
					rowDiv3.appendChild(colDiv3);
				
					const spanDiv1 = document.createElement("span");
					spanDiv1.style.fontSize = "13px";
					spanDiv1.style.fontWeight = "bold";
					spanDiv1.innerText = data.userDto.user_nickname;
					colDiv3.appendChild(spanDiv1);
				
					const colDiv4 = document.createElement("div");
					colDiv4.setAttribute("class", "col-auto");
					rowDiv3.appendChild(colDiv4);
					
					const spanDiv2 = document.createElement("span");
					spanDiv2.style.fontSize = "13px";
					spanDiv2.innerText = data.planPlaceCommentDto.plan_place_user_comment;
					colDiv4.appendChild(spanDiv2);
					
					const colDiv5 = document.createElement("div");
					colDiv5.setAttribute("class", "col-auto");
					rowDiv3.appendChild(colDiv5);
									
					const spanDiv3 = document.createElement("span");
					spanDiv3.style.fontSize = "12px";
										
					function formatDate(date) {
						
						  const year = date.getFullYear().toString().slice(-2); 
						  const month = ("0" + (date.getMonth() + 1)).slice(-2); 
						  const day = ("0" + date.getDate()).slice(-2);

						  return year + "." + month + "." + day;
						}
											
					const timestamp = data.planPlaceCommentDto.plan_place_reg_date; 

					const date = new Date(timestamp);			
						
					spanDiv3.innerText = formatDate(date);
					colDiv5.appendChild(spanDiv3);
										
					commentListBox.appendChild(colDiv);
	
				}
			}
		}
		
		xhr.open("get", "./commentList?plan_place_id=" + planPlaceId);
		xhr.send();
	}
	
	window.addEventListener("DOMContentLoaded", function() {
		
		getUserId();
		resetHeart();
		resetCountOfHeart();
		resetCountOfComment();
		resetCommentList();
		
	});
	
</script>

<style>
        .user-image {
  		width: 50px; 
 		height: 50px;
  		border-radius: 50%; 
  		overflow: hidden; 
		}

        .user-comment-image {
  		width: 32px; 
 		height: 32px;
  		border-radius: 50%; 
  		overflow: hidden; 
		}

</style>
    
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
        
        <div class="row mt-4 d-flex justify-content-center">
            <div class="col-8">
            
                <div class="row">
                
                	<!--작성자 프로필-->
                    <div class="col">
                        <div class="row">
                            <div class="col-auto">
                                <img class="user-image" src="/uploadFiles/profileImage/${map.userDto.user_image}" alt="">
                            </div>
                            <div class="col-auto ps-0">
                                <div class="row">
                                    <div class="col">
                                        <span style="font-weight: bold;">${map.userDto.user_nickname}</span>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col">
                                        <span style="font-size: 14px; color: gray;"><fmt:formatDate value="${map.userDto.user_reg_date}" pattern="yyyy.MM.dd"/></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!--작성일 및 신고 -->
                    <div class="col">
                        <div class="row d-flex justify-content-end">
                            <div class="col-auto">
                                <a href="#">신고</a>
                            </div>
                        </div>
                        <div class="row d-flex justify-content-end">
                            <div class="col-auto pe-1">
                                <span style="font-size: 14px; color: gray;">작성일:</span>
                            </div>
                            <div class="col-auto ps-1">
                                <span style="font-size: 14px; color: gray;"><fmt:formatDate value="${map.planPlaceDto.plan_place_reg_date}" pattern="yyyy.MM.dd HH:mm"/></span>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <hr class="my-3">
                
                <div class="row my-3">
                
                	<!--메인 이미지-->
                    <div class="col">
                        <img style="width: 100%; height: 100%; overflow: hidden;" src="/uploadFiles/mainImage/${map.planPlaceDto.plan_place_photo}" alt="">
                    </div>
                    
                </div>
                <div class="row">
                
                	<!--장소 관련 설명글-->
                    <div class="col">
                        <div class="row">
                            <div class="col">
                                <span style="font-size: 15px; font-weight: bold;">${map.planPlaceDto.plan_place_name}</span>
                            </div>
                        </div>
                        <div class="row my-3">
                            <div class="col">
                                <span style="font-size: 15px;">${map.planPlaceDto.plan_place_content}</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col text-end">
                                <span style="font-size: 14px; color: gray;">${map.planPlaceDto.plan_place_address}</span>
                            </div>
                        </div>
                    </div>
                    
                </div>
                
                <div class="row row-cols-2 my-3">
                
                	<!--장소 상세 사진-->
                    <c:forEach items="${detailPhotoList}" var="list">
                    <div class="col my-2">
                        <img style="width: 100%;" src="/uploadFiles/${list.planPlacePhotoDto.plan_place_photo_link}" alt="">
                    </div>
                    </c:forEach>
                    
                </div>
                
                <div class="row mt-5">
                
                	<!--작성자 프로필 및 좋아요, 댓글-->
                    <div class="col">
                        <div class="row">
                            <div class="col-auto">
                                <img class="user-comment-image" src="/uploadFiles/profileImage/${map.userDto.user_image}" alt="">
                            </div>
                            <div class="col-auto px-0">
                                <span style="font-size: 13px; font-weight: bold;">${map.userDto.user_nickname}</span>
                            </div>
                            <div class="col-auto px-1">
                            	<span style="font-weight: bold;">∙</span>
                            </div>
                            <div class="col-auto px-0">
                            	<span style="font-size: 13px; font-weight: bold; color: #8a92ff;">작성자</span>
                            </div>
                            <div class="col">
                                <div class="row justify-content-end align-items-center">
                                		<div class="col-auto pe-1">
                                			<i onclick="clickHeart()" id="heartBox" class="bi bi-heart" style="font-size: 23px; color: red;"></i>
                                		</div>
                                		<div class="col-auto px-1">
                                        	<span id="countHeart" style="font-size: 14px; color: gray;"></span>
                                   		</div>
                                   		<div class="col-auto px-1">
                                       		<i style="font-size: 23px;" class="bi bi-chat"></i>
                                    	</div>
                                    	<div class="col-auto px-1">
                                       		<span id="countComment" style="font-size: 14px; color: gray;"></span>
                                   	 	</div>
                                   	 	<div class="col-auto ps-1">
                                   	 		<i style="font-size: 22px;" class="bi bi-send"></i>
                                   	 	</div>
                                </div>
                            </div>
                        </div>
                        <hr class="my-2">
                    </div>
                    
                </div>
                <div class="row">
                <div id="commentListBox" class="col">
                   <%--  <c:forEach items="${commentList}" var="list">
                        <div class="col mb-2">
                            <div class="row">
                                <div class="col-auto">
                                    <img class="user-comment-image" src="/uploadFiles/profileImage/${list.userDto.user_image}" alt="">
                                </div>
                                <div class="col-auto ps-0">
                                    <div class="row">
                                        <div class="col-auto pe-1">
                                            <span style="font-size: 13px; font-weight: bold;">${list.userDto.user_nickname}</span>
                                        </div>
                                        <div class="col-auto ps-0">
                                            <span style="font-size: 13px;">${list.planPlaceCommentDto.plan_place_user_comment}</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <span style="font-size: 13px; color: gray;"><fmt:formatDate  value="${list.planPlaceCommentDto.plan_place_reg_date}" pattern="yy.MM.dd"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach> --%>
                </div>
                </div>
                <div class="row my-4 d-flex justify-content-end">
                    <div class="col">
                        <input id="commentBox" class="form-control" type="text" placeholder="댓글 달기...">
                    </div>
                    <div class="col-auto">
                        <input onclick="registerComment()" class="btn btn-outline-dark" type="button" value="게시">
                    </div>
                </div>
                <div class="row mt-5">
                    <div class="col">
                        <span style="font-size: 20px; font-weight: bold;">플레이스 인기글</span>
                        <hr class="my-3">
                    </div>
                </div>
            </div>
        </div>
    </div>


<%-- 
	<div class="container">
		<div class="row">
			<div class="col">
			</div>
		</div>
		<div class="row mt-4">
			<div class="col"></div>
			<div class="col-8 p-0 text-end">
				<a href="./placePage" class="btn btn-outline-dark">목록</a>
			</div>
			<div class="col"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 mt-2 card">
				<div class="row mt-4">
					<div class="col">
						<h4>#${map.planPlaceDto.plan_place_name}</h4>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<p class="m-0">${map.userDto.user_nickname}</p>
						<p style="font-size: smaller; color: gray;"><fmt:formatDate value="${map.planPlaceDto.plan_place_reg_date}" pattern="yyyy-MM-dd HH:mm"/></p>
					</div>
				</div>
				<hr class="my-4">
				<div class="row">
					<div class="col"
						style="display: flex; flex-direction: column; justify-content: flex-end;">
						<p
							style="display: flex; justify-content: center; align-items: center; height: 100%; margin-top: auto;">"${map.planPlaceDto.plan_place_content}"</p>
						<p style="color: gray;">${map.planPlaceDto.plan_place_address}</p>
					</div>
					<div class="col-6">
						<img
							src="/uploadFiles/mainImage/${map.planPlaceDto.plan_place_photo}"
							class="img-fluid w-100">
					</div>
				</div>
				<hr class="my-4">
				<div class="row mt-5">
					<div class="col"></div>
					<div class="col-10">
						<c:forEach items="${detailPhotoList}" var="list">
							<img src="/uploadFiles/${list.planPlacePhotoDto.plan_place_photo_link}" class="d-block w-100 mb-2" alt="...">
						</c:forEach>
					</div>
					<div class="col"></div>
				</div>
				<div class="row mt-5">
					<div class="col">
						<c:choose>
							<c:when test="${!empty sessionuser}" >
								<a href="./clickLoveProcess?plan_place_id=${map.planPlaceDto.plan_place_id}" class="${planPlaceLoveDto != null ? 'bi-heart-fill text-danger' : 'bi-heart text-danger'}"></a> 좋아요 ${loveCount} <i class="bi bi-chat-dots"></i>댓글 ${commentCount}
							</c:when>
						</c:choose>
					</div>
					<div class="col text-end">
						<a href="#">공유</a>
						<a href="#">신고</a>
					</div>
				</div>
				<hr class="my-4 mt-2">
				<div class="row">
					<div class="col">
						<h5>댓글</h5>
					</div>
				</div>
				<div class="row">
					<div class="col">
						<c:forEach items="${commentList}" var="list">
							<p class="m-0" style="font-weight: bold;">${list.userDto.user_nickname}</p>
							<p class="m-0">${list.planPlaceCommentDto.plan_place_user_comment}</p>
							<p><fmt:formatDate  value="${list.planPlaceCommentDto.plan_place_reg_date}" pattern="yyyy-MM-dd HH:mm"/>
							<br>
							<hr class="my m-0">
					</c:forEach>
					</div>
				</div>
				<div class="row mt-5 justify-content-end">
					<div class="col"></div>
					<div class="col-12 form-floating">
					<c:if test="${!empty sessionuser}">
						<form action="./writePlanPlaceCommentProcess" method="post">
							${sessionuser.user_nickname}
							<textarea class="form-control" name="plan_place_user_comment" placeholder="댓글을 남겨주세요" id="floatingTextarea2" style="height: 100px"></textarea>
							<div class="d-flex justify-content-end mt-2">
								<input type="hidden" name="user_id" value="${sessionuser.user_id}"> 
								<input type="hidden" name="plan_place_id" value="${map.planPlaceDto.plan_place_id}">
								<button class="btn btn-outline-dark">등록</button>
							</div>
						</form>
					</c:if>
					</div>
					<div class="col"></div>
				</div>
				<div class="row mt-2">
					<div class="col"></div>
					<div class="col text-end">
						<a href="./placePage" class="btn btn-outline-dark">목록</a>
					</div>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row mt-3">
			<div class="col"></div>
			<div class="col-8">
				<span style="font-weight: bold; font-size: 1.2em;">플레이스 인기글</span>
			</div>
			<div class="col"></div>
		</div>
		<div class="row mt-3">
			<div class="col"></div>
			<div class="col-8">
				<div class="row">
					<c:forEach items="${listOrderByLove}" var="love">
						
						<div class="col-1 p-0 card">
							<a href="./PlanPlaceDetailPage?plan_place_id=${love.planPlaceDto.plan_place_id}"><img src="/uploadFiles/mainImage/${love.planPlaceDto.plan_place_photo}" style="width: 100%; height: 100%; object-fit: cover;"></a>
						</div>
						<div class="col">
							<p class="mb-1" style="font-size: 14px; font-weight: bold;">${love.planPlaceDto.plan_place_name}</p>
							<p style ="font-size: 14px; color: gray;">${love.userDto.user_nickname}</p>
							<p style ="font-size: 14px;"><i style="color: gray; font-size: 14px;" class="bi bi-heart"></i>${love.loveCount} <i style="color: gray; font-size: 14px;" class="bi bi-chat-dots"></i> ${love.commentCount} </p>
						</div>
						
					</c:forEach>
				</div>
			</div>
			<div class="col"></div>
		</div>
		<div class="row mt-5">
			<div class="col"></div>
			<div class="col-8 text-center"><p>bottom navi</p></div>
			<div class="col"></div>
		</div>
	</div> --%>



	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous"></script>
</body>
</html>