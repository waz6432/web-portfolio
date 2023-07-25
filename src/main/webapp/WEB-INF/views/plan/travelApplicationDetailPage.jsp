<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=93ae12d4c0f00044228cbd5b5f2f588b&libraries=services,clusterer,drawing"></script>
<script type="text/javascript">
function showReportImg() {
    document.getElementById("imageUpload").addEventListener('change', function(event) {
        // clear previous images
        var previewContainer = document.getElementById('previewImages');
        previewContainer.innerHTML = '';

        for(let i = 0; i < event.target.files.length; i++) {
            let reader = new FileReader();
            reader.onload = function(e){
                let imgContainer = document.createElement('div');
                imgContainer.style.position = 'relative';
                imgContainer.style.display = 'inline-block';
                imgContainer.style.marginRight = '10px';

                let img = document.createElement('img');
                img.src = e.target.result;
                img.style.width = '100px';
                img.style.height = '100px';
                img.style.borderRadius = '0.375rem';
                imgContainer.appendChild(img);

                let removeBtn = document.createElement('button');
                removeBtn.innerText = 'x';
                removeBtn.style.border = 'none';
                removeBtn.style.backgroundColor = 'transparent';
                removeBtn.style.position = 'absolute';
                removeBtn.style.top = '-0.4em';
                removeBtn.style.right = '-0.2em';
                removeBtn.onclick = function() {
                    previewContainer.removeChild(imgContainer);
                };
                imgContainer.appendChild(removeBtn);

                previewContainer.appendChild(imgContainer);
            };
            reader.readAsDataURL(event.target.files[i]);
        }

        // Make previewImages visible
        previewContainer.style.display = 'flex';
    });
}
</script>
<script type="text/javascript">
	var commentList;
	var planning_id = '${map.planningDto.planning_id}';
	
	function loginCheck() {
		var sessionUser = '${sessionuser}';
		if (sessionUser == '') {
			location.href = '../login';
		}
	}
	
	function userInfo() {
		var birthdateStr = '${map.user.user_birth}'.replace('KST', 'GMT');
		var birthdateMs = Date.parse(birthdateStr);
		var birthdate = new Date(birthdateMs);
		var now = new Date();

		var age = now.getFullYear() - birthdate.getFullYear();
		var ageGroup = Math.floor(age / 10) * 10;

		var ageGroupStr = ageGroup + '대';
		var genderStr = '${map.user.user_gender}' === 'M' ? '남자' : '${map.user.user_gender}' === 'F' ? '여자' : '미공개';

		var userProfile = document.getElementById('user-profile');
		userProfile.textContent = ageGroupStr + ' · ' + genderStr;
	}
	
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
		var params = "planning_id=" + planning_id + "&user_comment=" + encodeURIComponent(comment.value);
		xhr.send(params);
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
					var regDate = new Date('${map.planningDto.planning_reg_date}');
					var boardRegDate = formatDate(regDate);
					var replyInputCol = null;
					
					boardInfo.innerText = boardRegDate + ' · 댓글 ' + response.list.length;
					
					for (let i in response.list) {
						
						console.log(response.list[i]);
						commentList = document.querySelector('.comment-list');
						
						var date = new Date(response.list[i].planningComment.reg_date);
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
					    img.setAttribute('data-bs-toggle', 'dropdown');

					    if (response.list[i].user.user_id != '${sessionuser.user_id}') {
					    	const dropdownMenu = document.createElement('div');
						    dropdownMenu.classList.add('dropdown-menu');

						    // 드랍다운 메뉴 엘리먼트 추가
						    const dropdownItem1 = document.createElement('a');
						    dropdownItem1.classList.add('dropdown-item');
						    dropdownItem1.innerText = '신고하기';
						    
						    const dropdownItem2 = document.createElement('a');
						    dropdownItem2.classList.add('dropdown-item');
						    dropdownItem2.innerText = '쪽지보내기';
						    
						    dropdownMenu.appendChild(dropdownItem2);
						    dropdownMenu.appendChild(dropdownItem1);
						    
						    dropdownItem1.addEventListener('click', function(e) {
						        e.preventDefault();

						        // 클로저에 현재 사용자 객체를 저장
						        var currentUser = response.list[i].user;

						        var myModalEl = document.getElementById('reportModal');
						        var myModal = new bootstrap.Modal(myModalEl, {});

						        // 모달이 보여질 때 currentUser 객체를 사용
						        myModalEl.addEventListener('shown.bs.modal', function () {
						            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
						            document.getElementById('reportedUserId').value = currentUser.user_id;
						        });

						        myModal.show();
						    });
						    
						    dropdownItem2.addEventListener('click', function(e) {
						        e.preventDefault();

						        // 클로저에 현재 사용자 객체를 저장
						        var currentUser = response.list[i].user;

						        var myModalEl = document.getElementById('noteModal');
						        var myModal = new bootstrap.Modal(myModalEl, {});

						        // 모달이 보여질 때 currentUser 객체를 사용
						        myModalEl.addEventListener('shown.bs.modal', function () {
						            // 히든 인풋 필드의 값을 currentUser.user_id로 설정
						            document.getElementById('notedUserNickname').value = currentUser.user_nickname;
						        });

						        myModal.show();
						    });
						    
						    col1Div.style.cursor = 'pointer';
						    col1Div.appendChild(dropdownMenu);
					    }
					    
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
					    div.innerText = response.list[i].planningComment.user_comment;
					    col12Div.appendChild(div);
					    
					    // Another col-12 div
					    const anotherCol12Div = document.createElement('div');
					    anotherCol12Div.classList.add('col-12', 'mt-1');
					    
					    var heartIcon = document.createElement("i");
					    heartIcon.className = response.list[i].isLove == 'ok' ? 'bi, bi-heart-fill text-danger' : 'bi, bi-heart'; 
					    heartIcon.onclick = function() {
							loginCheck();
							
							addLike(response.list[i].planningComment.planning_comment_id);	
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
		xhr.send("planning_id="+planning_id);
	}
	
	function addLike(comment_id) {
	
	console.log(comment_id);
	
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
		xhr.send("comment_id="+comment_id);

	}

	function formatDate(date) {
		var yyyy = date.getFullYear();
		var MM = ('0' + (date.getMonth() + 1)).slice(-2); // Months are zero based
		var dd = ('0' + date.getDate()).slice(-2);
		var hh = ('0' + date.getHours()).slice(-2);
		var mm = ('0' + date.getMinutes()).slice(-2);

		return yyyy + '/' + MM + '/' + dd + ' ' + hh + ':' + mm;
	}
</script>
<script type="text/javascript">
	function getCompanyList() {

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				var sessionUser = '${sessionuser.user_id}';
				
				if (response.companyList != null) {
					for (let i in response.companyList) {
						if (response.companyList[i].user_id == sessionUser) {
							var chat = document.querySelector('.chat');
							chat.style.display = 'block';
						}
					}
				}
			}
		}
		
		//post
		xhr.open("post", "./getCompanyList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("planning_id="+planning_id);
	}
</script>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		initializeMap();
		getAddresList();
		getCommentList();
		getCompanyList();
		userInfo();
		showReportImg();
		
		var isDown = false;
		var startX;
		var scrollLeft;
		var userListContainer = document.querySelector('.user-list-container');
		var scheduleList = document.querySelector('.schedule-list');
		
		userListContainer.addEventListener('mousedown', function(e) {
			isDown = true;
			startX = e.pageX - userListContainer.offsetLeft;
			scrollLeft = userListContainer.scrollLeft;
		});

		userListContainer.addEventListener('mouseleave', function() {
			isDown = false;
		});

		userListContainer.addEventListener('mouseup', function() {
			isDown = false;
		});

		userListContainer.addEventListener('mousemove', function(e) {
			if (!isDown)
				return;
			e.preventDefault();
			var x = e.pageX - userListContainer.offsetLeft;
			var walk = (x - startX) * 3; // 스크롤 속도 조절
			userListContainer.scrollLeft = scrollLeft - walk;
		});
		
		scheduleList.addEventListener('mousedown', function(e) {
			isDown = true;
			startX = e.pageX - scheduleList.offsetLeft;
			scrollLeft = scheduleList.scrollLeft;
		});

		scheduleList.addEventListener('mouseleave', function() {
			isDown = false;
		});

		scheduleList.addEventListener('mouseup', function() {
			isDown = false;
		});

		scheduleList.addEventListener('mousemove', function(e) {
			if (!isDown)
				return;
			e.preventDefault();
			var x = e.pageX - scheduleList.offsetLeft;
			var walk = (x - startX) * 3; // 스크롤 속도 조절
			scheduleList.scrollLeft = scrollLeft - walk;
		});
		
	});
</script>
<script type="text/javascript">
	function animateSize(element, duration, toWidth, toHeight) {
		var start = null;
		var initialWidth = element.offsetWidth;
		var initialHeight = element.offsetHeight;
		function step(timestamp) {
			if (!start)
				start = timestamp;
			var elapsed = timestamp - start;
			var progress = Math.min(elapsed / duration, 1);
			element.style.width = (initialWidth + progress * (toWidth - initialWidth)) + '%';
			element.style.height = (initialHeight + progress * (toHeight - initialHeight)) + 'px';
			if (progress < 1) {
				requestAnimationFrame(step);
			}
		}
		requestAnimationFrame(step);
	}
	
	var chatBox = null;
	
	function showChatBox() {
		var chatContainer = document.getElementById('chat-container');
		var chatIcon = document.querySelector('.chatIcon');
		
		if (chatBox === null) {
			chatIcon.className = 'bi bi-chat-dots chatIcon';
			
			// Create chat-box dynamically
			chatBox = document.createElement('div');
			chatBox.className = 'chat-box';
			chatBox.style.width = '0px'; // Initially the width is 0
			chatBox.style.height = '0px'; // Initially the height is 0
			chatBox.style.border = 'none';
			chatBox.style.margin = '5px 0 10px 60px';
			chatBox.style.borderRadius = '0.375rem';
			chatBox.style.boxShadow = '5px 5px 10px rgba(0, 0, 0, 0.2)'; // Add semi-transparent shadow to all directions
			chatBox.style.overflow = 'hidden';
	        chatContainer.appendChild(chatBox);
			
			var chatBoxInRow1 = document.createElement('div');
			chatBoxInRow1.className = 'row';
			
			var chatBoxInCol1 = document.createElement('div');
			chatBoxInCol1.className = 'col text-truncate';
			chatBoxInCol1.style.marginTop = '10px';
			chatBoxInCol1.style.marginBottom = '30px';
			chatBoxInCol1.style.marginLeft = '15px';
			chatBoxInCol1.style.paddingRight = '100px';
			
			chatBoxInCol1.innerText = '[동행] ' + '${map.planningDto.planning_title}';
			
			var chatBoxInRow2 = document.createElement('div');
			chatBoxInRow2.className = 'row chatScroll';
			chatBoxInRow2.style.height = '70%';
			chatBoxInRow2.style.overflowY = 'auto'; // 스크롤 추가
			
			var chatBoxInCol2 = document.createElement('div');
			chatBoxInCol2.className = 'col mt-1 mx-1 chatArea';
			
			var chatBoxInRow3 = document.createElement('div');
			chatBoxInRow3.className = 'row';
			
			var chatBoxInCol3 = document.createElement('div');
			chatBoxInCol3.className = 'col mt-1 mx-1';
			chatBoxInCol3.style.padding = '0 20px 0 20px';
			
			// 부모 요소 생성
			var inputGroup = document.createElement('div');
			inputGroup.classList.add('input-group');
			
			// 입력 필드 생성
			var input = document.createElement('input');
			input.setAttribute('type', 'text');
			input.classList.add('form-control');
			input.setAttribute('placeholder', "메세지를 입력해주세요");
			input.style.borderRight = 'none';
			inputGroup.appendChild(input);
			input.addEventListener('keypress', function(e) {
			    // Enter 키가 눌렸는지 확인
			    if (e.key === 'Enter') {
			        // Enter 키를 누르면 버튼 클릭 이벤트를 발생시킴
			        button.click();
			    }
			});

			// 버튼 생성
			var button = document.createElement('button');
			button.setAttribute('type', 'button');
			button.classList.add('bi', 'bi-send-fill');
			button.setAttribute('id', 'button-addon2');
			button.style.border = '1px solid lightgrey';
			button.style.borderRadius = '0 0.375rem 0.375rem 0';
			button.style.width = '50px';
			// 버튼 클릭 시 동작 추가
			button.addEventListener('click', function() {
			    var message = input.value;
			    insertMessage(message);
			    
			    input.value = '';
			});
			
			inputGroup.appendChild(button);
			chatBoxInCol3.appendChild(inputGroup);
			
			chatBoxInRow1.appendChild(chatBoxInCol1);
			chatBoxInRow2.appendChild(chatBoxInCol2);
			chatBoxInRow3.appendChild(chatBoxInCol3);
			
			chatBox.appendChild(chatBoxInRow1);
			chatBox.appendChild(chatBoxInRow2);
			chatBox.appendChild(chatBoxInRow3);
			
			// Animate chat-box to appear
			animateSize(chatBox, 300, 100, 500); // Change 100 and 500 to your desired width and height
			setInterval(() => getChatList(), 300);
		} else {
			chatIcon.className = 'bi bi-chat-dots-fill chatIcon';
			// Animate chat-box to disappear
			animateSize(chatBox, 300, 0, 0);

			// Once the transition is complete, remove the chat-box
			setTimeout(function() {
				chatContainer.removeChild(chatBox);
				chatBox = null;
			}, 300); // Must match the duration of the transition
		}
	};
</script>
<script type="text/javascript">
	function insertMessage(message) {
	
		const xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				
			}
		}
		
		//post
		xhr.open("post", "./insertMessage");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("chat_message=" + message + "&planning_id=" + planning_id);
	}

	function getChatList() {

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				
				var sessionUser = '${sessionuser.user_id}';
				
				if (response.list != null) {
					var chatArea = document.querySelector('.chatArea');
					var chatScroll = document.querySelector('.chatScroll');
					
					chatArea.innerText = "";
					
					for (let i in response.list) {
						if (response.list[i].chatDto.user_id == sessionUser) {
			 			    var messageDiv = document.createElement('div');
			 			    messageDiv.className = 'd-flex justify-content-end';
							messageDiv.style.padding = '0 10px';
			 			   
							var message = document.createElement('span');
							message.textContent = response.list[i].chatDto.chat_message;
							message.style.backgroundColor = "rgba(3, 199, 90, 0.2)";
							message.style.padding = '5px';
							message.style.marginBottom = '10px';
							message.style.borderRadius = '0.375rem';
							
							messageDiv.appendChild(message);
							chatArea.appendChild(messageDiv);

						} else {
			 			    var messageDiv = document.createElement('div');
			 			   	messageDiv.style.marginBottom = '15px';
				 			messageDiv.style.padding = '0 10px';
			 			   
							var user = document.createElement('div');
							user.textContent = response.list[i].user.user_nickname;
							user.style.paddingBottom = '7px';
							
			 			   	var message = document.createElement('span');
							message.textContent = response.list[i].chatDto.chat_message;
							message.style.backgroundColor = "rgba(0, 0, 255, 0.2)";
							message.style.padding = '5px';
							message.style.marginBottom = '10px';
							message.style.borderRadius = '0.375rem';
							
							messageDiv.appendChild(user);
							messageDiv.appendChild(message);
							chatArea.appendChild(messageDiv);
			 			   	
						}
					}
					
					chatScroll.scrollTop = chatArea.scrollHeight;
				}
			}
		}
		//post
		xhr.open("post", "./getChatList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("planning_id="+planning_id);
	}
</script>
<script type="text/javascript">
	function getAddresList() {
		var plan_id = '${map.plan.plan_id}';
		var placeAddressList = [];
		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);
				// js 작업//

				if (response.list != null) {

					for ( var i in response.list) {
						placeAddressList.push(response.list[i].placeDto);
					}
					addMarkers(placeAddressList);
				}
			}
		}

		//post
		xhr.open("post", "./getAddresList");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("plan_id=" + plan_id);

	}

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

	function addMarkers(placeDtoList) {
		var geocoder = new kakao.maps.services.Geocoder();
		var bounds = new kakao.maps.LatLngBounds();

		// Promise로 각 주소를 좌표로 변환하는 비동기 작업을 관리합니다.
		var promises = placeDtoList
				.map(function(placeDto, index) {
					return new Promise(
							function(resolve) {
								geocoder
										.addressSearch(
												placeDto.plan_place_address,
												function(result, status) {
													if (status === kakao.maps.services.Status.OK) {
														var coords = new kakao.maps.LatLng(
																result[0].y,
																result[0].x);

														var content = '<div style="background-color: white; border-radius: 15px; padding: 5px; width: 100%; box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3); position: relative; font-weight: 700;">'
																+ '<span style="background-color: #03c75a; border-radius: 50%; width: 30px; height: 30px; padding: 5px; display: inline-flex; align-items: center; justify-content: center;"><i class="bi bi-geo-alt-fill" style="font-size: 20px; color: white;"></i></span>'
																+ ' '
																+ placeDto.plan_place_name
																+ '<div style="position: absolute; bottom: -8px; left: 10px; width: 0; height: 0; border-left: 10px solid transparent; border-right: 10px solid transparent; border-top: 10px solid white;"></div>'
																+ '</div>';

														// CustomOverlay를 생성합니다.
														var mainOverlay = new kakao.maps.CustomOverlay(
																{
																	position : coords,
																	content : content,
																	yAnchor : 0.7,
																	xAnchor : 0.1
																});

														// CustomOverlay를 지도에 표시합니다.
														mainOverlay.setMap(map);

														bounds.extend(coords);

														resolve();
													} else {
														resolve();
													}
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
.img-wrapper {
	height: 400px;
	width: 100%;
	overflow: hidden;
}

.banner {
	object-fit: cover;
	height: 100%;
	width: 100%;
	border-radius: 0 0 0.4rem 0.4rem;
}

.planning-title {
	font-size: 2em;
	font-weight: 700;
	color: #333333;
}

.card {
	padding: 22px 22px 22px 22px;
	margin: 30px 10px 0 10px;
	font-size: 1.1em;
	font-weight: 600;
}

.card-content {
	margin-top: 2px;
	font-size: 0.7em;
	font-weight: 500;
}

.planning-content {
	font-size: 1.2em;
	margin-bottom: 1em;
	color: #7d7d7d;
}

.commit {
	background-color: #03c75a;
	font-size: 1.2em;
	font-weight: 400;
	border-radius: 0.375rem;
	color: white;
	height: 50px;
	border: none;
}

.profile {
	padding: 20px 20px 0 20px;
	border: 1px solid lightgrey;
	border-radius: 0.4rem;
	margin: 5px 0 10px 60px;
}

.chat {
	border-radius: 50%;
	font-size: 2.5em;
	display: none;
	right: 0.4em;
	position: absolute;
}

#chat-container {
	min-height: 600px;
	overflow: hidden;
}

.user-thumbnail {
	border-radius: 50%;
	border: 2px solid #03c75a;
	margin-right: 10px;
	width: 50px;
	height: 50px;
}

.user-list-container {
	overflow-x: auto;
	cursor: pointer;
	overflow: hidden;
}

.user-list {
	display: flex;
	list-style-type: none;
	padding: 0;
	margin-top: 8px;
}

.card-wrapper {
	position: relative;
	margin-bottom: 25px;
	padding-bottom: 30px;
}

.card-wrapper::after {
	content: '';
	position: absolute;
	height: 1px;
	width: 97%;
	left: 10px; /* 왼쪽 정렬 */
	bottom: 0; /* 아래쪽 정렬 */
	background-color: lightgrey;
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

body {
	font-family: 'Noto Sans KR', sans-serif;
}

.schedule-list {
	overflow-x: hidden;
	cursor: pointer;
	list-style: none;
	display: flex;
	margin: 0;
	padding: 0;
}

.schedule-list img {
	width: 18em;
	height: 12em;
	margin-right: 5em;
	margin-bottom: 0.3em;
	border-radius: 0.375rem;
}

.schedule-list li:last-child img {
	margin-right: 0;
}
</style>
<title>모집 디테일 페이지</title>
</head>
<body>
	<div class="container">
		<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
		
		<div class="row">
			<div class="col">
				<div class="row">
					<div class="col img-wrapper">
						<img class="banner" alt="배너" src="/uploadFiles/${map.plan.plan_thumbnail}">
					</div>
				</div>
				<div class="row mt-5">
					<div class="col">
						<ul class="schedule-list">
							<c:forEach items="${map.list}" var="data">
								<c:forEach items="${data.placeList}" var="item">
										<li>
											<img alt="썸네일" src="/uploadFiles/mainImage/${item.plan_place_photo}">
											<div style="font-size: 1.1em; font-weight: 600; color: #333333;">${data.planDay.plan_day}일차 - ${item.plan_place_name}</div>
											<div style="font-weight: 400; margin-top: 0.2em; color: #7d7d7d;">
												<i class="bi bi-geo-alt"></i>
												<span style="font-size: 0.9em;">${item.plan_place_address}</span>
											</div>
										</li>
								</c:forEach>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="row my-3">
					<div class="col">
						<hr>
					</div>
				</div>
				<div class="row">
					<div class="col-8" style="padding-right: 40px;">
						<div class="row">
							<div class="col main-col">
								<span class="planning-title">${map.planningDto.planning_title}</span>
								<div class="row card-wrapper">
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-people-fill fs-4"></i>
											</div>
											<div class="col">
												<div>모집인원</div>
												<div class="card-content">${map.planningDto.planning_member}명</div>
											</div>
										</div>
									</div>
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-calendar-check fs-4"></i>
											</div>
											<div class="col">
												<div>여행날짜</div>
												<div class="card-content" id="planning-date">07-07 ~
													07-10</div>
											</div>
										</div>
									</div>
									<div class="col card d-flex justify-content-center">
										<div class="row">
											<div class="col-1 d-flex align-items-center me-3">
												<i class="bi bi-compass fs-4"></i>
											</div>
											<div class="col">
												<div>모집위치</div>
												<div class="card-content">${map.planningDto.planning_start_point}</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col planning-content">${map.planningDto.planning_content}</div>
								</div>
								<div class="row" style="height: 500px;">
									<div class="col">
										<div id="mapContainer">
											<div class="map shadow" id="map"></div>

											<div id="zoomButtons">
												<div class="row">
													<div class="col">
														<button class="d-flex align-items-center justify-content-center" id="zoomInButton" onclick="zoomIn()">+</button>
														<button class="d-flex align-items-center justify-content-center" id="zoomOutButton" onclick="zoomOut()">-</button>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="row" style="margin: 1em 0;">
									<div class="col p-0">
										<hr>
									</div>
								</div>
								<div class="row">
									<div class="col-12 d-flex justify-content-start align-items-center" style="font-size: ">
										<i class="bi bi-link me-1 fs-5 mb-2"></i>
										<h5>관련 플래너</h5>
									</div>
									<c:forEach items="${map.list2}" var="data">
										<div class="col-2">
											<div>
												<a href="./travelApplicationDetailPage?planning_id=${data.planning.planning_id}">
													<img class="img-fluid" src="/uploadFiles/${data.plan2.plan_thumbnail}" style="border-radius: 0.375rem;">
												</a>
												<div class="text-truncate" style="font-weight: 700; margin-top: 0.2em;">${data.planning.planning_title}</div>
												<div class="text-truncate" style="font-size: 0.7em;">${data.planning.planning_content}</div>
											</div>
										</div>
									</c:forEach>
								</div>
								<div class="row" style="margin: 1em 0;">
									<div class="col p-0">
										<hr>
									</div>
								</div>
								<div class="row">
									<div class="col-12 mb-1 comment-info d-flex justify-content-between">
										<span class="board-info"></span>
										<a href="../main" style="color: #999999; text-decoration: none;">목록</a>
									</div>
									<div class="col mb-3 comment-wrapper" onclick="loginCheck()">
										<input class="form-control comment p-2" type="text" placeholder="댓글을 입력해주세요.">
										<button class="comment-button" type="button" onclick="createCommentFunc()">작성</button>
									</div>
								</div>
								<div class="row">
									<div class="col comment-list"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-4">
						<div class="row">
							<div class="col">
								<div class="profile">
									<div class="row">
										<div class="col-2 me-1">
											<img class="user-thumbnail my-thumb" alt="썸네일" src="/uploadFiles/profileImage/${map.user.user_image}">
										</div>
										<div class="col">
											<div class="row">
												<div class="col">${map.user.user_nickname}</div>
											</div>
											<div class="row">
												<div class="col">
													<div id="user-profile"></div>
												</div>
											</div>
										</div>
									</div>
									<div class="row mt-5">
										<div class="col d-grid">
											<div class="mb-1" style="font-weight: 500;">
												<i class="bi bi-exclamation-circle-fill" style="color: #03c75a;"></i> 지금 동행을 신청해보세요!
											</div>
											<button class="commit" type="button" data-bs-toggle="modal" data-bs-target="#modal">동행 신청하기</button>
											
											<!-- 모달 창 -->
											<div class="modal fade" id="modal">
												<div class="modal-dialog modal-dialog-centered">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title">동행 신청하기</h5>
															<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
														</div>
														<form action="./travelApplicationProcess?planning_id=${map.planningDto.planning_id}" method="post">
															<div class="modal-body">
																<div class="form-floating">
																	<textarea class="form-control" placeholder="#" id="floatingTextarea" style="resize: none; height: 100px;" name="planning_application_content"></textarea>
																	<label for="floatingTextarea">신청 내용</label>
																</div>
															</div>
															<div class="modal-footer">
																<button class="btn">신청하기</button>
															</div>
														</form>
													</div>
												</div>
											</div>
										</div>
									</div>
									<div class="row" style="margin-top: 40px;">
										<div class="col">함께하는 동행</div>
									</div>
									<div class="row">
										<div class="col">
											<div class="user-list-container">
												<ul class="user-list">
													<c:forEach items="${map.planningApplicationList}" var="data">
														<li>
															<img class="user-thumbnail" alt="썸네일" src="/uploadFiles/profileImage/${data.user_image}">
														</li>
													</c:forEach>
												</ul>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col d-flex justify-content-end pb-5" id="chat-container" style="position: relative;">
								<div class="chat" onclick="showChatBox()">
									<i class="bi bi-chat-dots-fill chatIcon" style="color: #03c75a"></i>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col">
				<div class="modal fade" id="reportModal" tabindex="-1" aria-labelledby="reportModalLabel" aria-hidden="true">
					<div class="modal-dialog  modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="reportModalLabel">신고하기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="container">
									<div class="row">
										<div class="col">
											<form action="/travel/admin/userReport?user_id=${sessionuser.user_id}" method="post" enctype="multipart/form-data">
												<!-- 신고 대상자의 아이디를 담을 hidden input field 추가 -->
												<input type="hidden" id="reportedUserId" name="reported_user_id">
												
												<div class="row">
													<div class="col">
														<div class="form-floating">
															<textarea class="form-control" placeholder="#" id="floatingTextarea2" name="user_report_desc" style="height: 15em; resize: none;"></textarea>
															<label for="floatingTextarea2" style="font-size: 0.9em;">신고사유를 적어주세요. 허위 신고시 불이익이 있을 수 있습니다.</label>
														</div>
													</div>
												</div>
												<div class="row">
													<div class="col d-flex justify-content-end mt-2">
														<input class="form-control" type="file" id="imageUpload" name="reportImages" accept="image/*" multiple>
													</div>
													<div class="col-12">
														<div id="previewImages" style="display: none; overflow-x: auto; margin: 0.5em 0 0.5em 0; padding: 0.5em;"></div>
													</div>
												</div>
												<div class="row mt-2">
													<div class="col d-flex justify-content-end">
														<button type="submit" class="btn" style="background-color: #03c75a; color: white;" >신고 제출</button>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col">
				<div class="modal fade" id="noteModal" tabindex="-1" aria-labelledby="noteModalLabel" aria-hidden="true">
					<div class="modal-dialog  modal-dialog-centered">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="noteModalLabel">쪽지보내기</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="container">
									<div class="row">
										<div class="col">
											<form action="/travel/sendMessageProcess?user_id=${sessionuser.user_id}" method="post">
												<!-- 신고 대상자의 아이디를 담을 hidden input field 추가 -->
												<input type="hidden" id="notedUserNickname" name="user_nickname">

												<div class="row mb-2">
													<div class="col">
														<input name="message_title" class="form-control" type="text" placeholder="제목">
													</div>
												</div>
												<div class="row">
													<div class="col">
														<div class="form-floating">
															<textarea class="form-control" placeholder="#" id="floatingTextarea3" name="message_content" style="height: 15em; resize: none;"></textarea>
															<label for="floatingTextarea3" style="font-size: 0.9em;">스팸성 쪽지는 제재 사유가 될 수 있습니다.</label>
														</div>
													</div>
												</div>
												<div class="row mt-2">
													<div class="col d-flex justify-content-end">
														<button class="btn" style="background-color: #03c75a; color: white;" type="submit">보내기</button>
													</div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
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