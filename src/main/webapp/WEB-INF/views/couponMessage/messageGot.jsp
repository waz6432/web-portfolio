	
	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<title>메인 페이지</title>
	<style>
	#row1col5:hover {
		font-weight: bold;
	}
	
	#deleteButton:hover {
		font-weight: bold;
	}
	
	#messageInTrashTitle:hover {
		font-weight: bold;
	}
	#messageInStorageTitle:hover {
		font-weight: bold;
	}
	
	#deleteButton:hover {
		font-weight: bold;
	}
	
	#row1col2 {
		cursor : pointer;
	}
	#row1col2:hover {
		font-weight: bold;
	}
	
	.aa{
	color: #fcba03;
	}
	</style>
	<script type="text/javascript">
			var changeBackColor = true;
			
			
			function formatDate(date, format) {
				  var year = date.getFullYear();
				  var month = ('0' + (date.getMonth() + 1)).slice(-2);
				  var day = ('0' + date.getDate()).slice(-2);
				  var hours = ('0' + date.getHours()).slice(-2);
				  var minutes = ('0' + date.getMinutes()).slice(-2);
				  var seconds = ('0' + date.getSeconds()).slice(-2);
				  
				  format = format.replace('yy', year);
				  format = format.replace('MM', month);
				  format = format.replace('dd', day);
				  format = format.replace('hh', hours);
				  format = format.replace('mm', minutes);
				  format = format.replace('ss', seconds);
	
				  return format;
				}
			
				function ajaxTemplete(){
							
							const xhr = new XMLHttpRequest();
							
							xhr.onreadystatechange = function(){
								if(xhr.readyState == 4 && xhr.status == 200){
									const response = JSON.parse(xhr.responseText);
									// js 작업..
								}
							}
							
							//get
							xhr.open("get", "요청 url?파라메터=값");
							xhr.send();
							
							//post
							xhr.open("post", "요청 url");
							xhr.setRequestHeader("Content-type","application/x-www-form-urlencoded"); 
							xhr.send("파라메터=값");
						}
				
				// 받은 메시지 삭제
				function deleteMessageGet(messageId) {
					
					if(confirm("휴지통으로 이동시키겠습니까?")){
					const xhr = new XMLHttpRequest();
					
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							reloadMessageGet();
							
							}
						}
					//get
					xhr.open("get", "./deleteMessageGet?messageId=" + messageId);
					xhr.send();
					}
				}
				
				//보낸 메시지 삭제
				function deleteMessageSend(messageId) {
					
					if(confirm("삭제하시겠습니까?")){
					const xhr = new XMLHttpRequest();
					
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							reloadMessageSend();
							
							}
						}
					//get
					xhr.open("get", "./deleteMessageSend?messageId=" + messageId);
					xhr.send();
					}
				}
				
				function refreshMessageRead(messageId){
					
					const xhr = new XMLHttpRequest();
					
					xhr.onreadystatechange = function(){
						if(xhr.readyState == 4 && xhr.status == 200){
							const response = JSON.parse(xhr.responseText);
							// js 작업..
							
						}
					}
					
					//get
					xhr.open("get", "./refreshMessageRead?messageId=" + messageId);
					xhr.send();
					
				}
				
				
			let mySessionId = null;
			
			//받은쪽지 내용 읽기(모달)
			function openMessageGetPage(messageId, messageTitle, messageNickName, messageSendDateFormatted, messageContent) {
			
				
				const readMessageGetModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetModal");
				const messageGetTitle = document.getElementById("messageGetTitle");
				const messageGetSender = document.getElementById("messageGetSender");
	  			const messageGetTime = document.getElementById("messageGetTime");
				const messageGetContent = document.getElementById("messageGetContent");
				
				messageGetTitle.textContent = messageTitle;
				messageGetSender.textContent = messageNickName;
				messageGetTime.textContent = messageSendDateFormatted;
				messageGetContent.innerHTML = messageContent.replace(/(\r\n|\n)/g, "<br>");
				
				
				refreshMessageRead(messageId);
				readMessageGetModal.show();
				
			}
			// 보낸쪽지 내용 읽기(모달)
			function openMessageSendPage(messageTitle, messageReceiver, messageSendDateFormatted, messageContent) {
				
				
				const readMessageSendModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendModal");
				const messageSendTitle = document.getElementById("messageSendTitle");
				const messageSendReceiver = document.getElementById("messageSendReceiver");
	  			const messageSendTime = document.getElementById("messageSendTime");
				const messageSendContent = document.getElementById("messageSendContent");
				
				
				messageSendTitle.textContent = messageTitle;
				messageSendReceiver.textContent = messageReceiver;
				messageSendTime.textContent = messageSendDateFormatted;
				messageSendContent.innerHTML = messageContent.replace(/(\r\n|\n)/g, "<br>");
				
				
				
				
				readMessageSendModal.show();
				
			}
			
			// 휴지통에 있는 보낸메시지 모달 읽기
			function openMessageSendInTrashPage(messageInTrashTitle, messageSendInTrashReceiver, messageSendDateFormatted, messageInTrashContent) {
				
				const readMessageSendInTrashModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendInTrashModal");
				const messageSendInTrashTitle = document.getElementById("messageSendInTrashTitle");
				const messageSendInTrashReceiverModal = document.getElementById("messageSendInTrashReceiverModal");
	  			const messageSendInTrashSendTime = document.getElementById("messageSendInTrashSendTime");
				const messageSendInTrashContent = document.getElementById("messageSendInTrashContent");
				
				
				messageSendInTrashTitle.textContent = messageInTrashTitle;
				messageSendInTrashReceiverModal.textContent = messageSendInTrashReceiver;
				messageSendInTrashSendTime.textContent = messageSendDateFormatted;
				messageSendInTrashContent.innerHTML = messageInTrashContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageSendInTrashModal.show();
				
			}
			
			// 휴지통에 있는 받은메시지 모달 읽기
			function openMessageGetInTrashPage(messageInTrashTitle, messageGetInTrashSender, messageSendDateFormatted, messageInTrashContent) {
				
				const readMessageGetInTrashModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetInTrashModal");
				const messageGetInTrashTitle = document.getElementById("messageGetInTrashTitle");
				const messageGetInTrashSenderModal = document.getElementById("messageGetInTrashSenderModal");
	  			const messageGetInTrashSendTime = document.getElementById("messageGetInTrashSendTime");
				const messageGetInTrashContent = document.getElementById("messageGetInTrashContent");
				
				
				messageGetInTrashTitle.textContent = messageInTrashTitle;
				messageGetInTrashSenderModal.textContent = messageGetInTrashSender;
				messageGetInTrashSendTime.textContent = messageSendDateFormatted;
				messageGetInTrashContent.innerHTML = messageInTrashContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageGetInTrashModal.show();
				
			}
			
			// 보관함에 있는 보낸메시지 모달 읽기
			function openMessageSendInStoragePage(messageInStorageTitle, messageSendInStorageReceiver, messageSendDateFormatted, messageInStorageContent) {
				
				const readMessageSendInStorageModal = bootstrap.Modal.getOrCreateInstance("#readMessageSendInStorageModal");
				const messageSendInStorageTitle = document.getElementById("messageSendInStorageTitle");
				const messageSendInStorageReceiverModal = document.getElementById("messageSendInStorageReceiverModal");
	  			const messageSendInStorageSendTime = document.getElementById("messageSendInStorageSendTime");
				const messageSendInStorageContent = document.getElementById("messageSendInStorageContent");
				
				
				messageSendInStorageTitle.textContent = messageInStorageTitle;
				messageSendInStorageReceiverModal.textContent = messageSendInStorageReceiver;
				messageSendInStorageSendTime.textContent = messageSendDateFormatted;
				messageSendInStorageContent.innerHTML = messageInStorageContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageSendInStorageModal.show();
				
			}
			
			// 보관함에 있는 받은메시지 모달 읽기
			function openMessageGetInStoragePage(messageInStorageTitle, messageGetInStorageSender, messageSendDateFormatted, messageInStorageContent) {
				
				const readMessageGetInStorageModal = bootstrap.Modal.getOrCreateInstance("#readMessageGetInStorageModal");
				const messageGetInStorageTitle = document.getElementById("messageGetInStorageTitle");
				const messageGetInStorageSenderModal = document.getElementById("messageGetInStorageSenderModal");
	  			const messageGetInStorageSendTime = document.getElementById("messageGetInStorageSendTime");
				const messageGetInStorageContent = document.getElementById("messageGetInStorageContent");
				
				
				messageGetInStorageTitle.textContent = messageInStorageTitle;
				messageGetInStorageSenderModal.textContent = messageGetInStorageSender;
				messageGetInStorageSendTime.textContent = messageSendDateFormatted;
				messageGetInStorageContent.innerHTML = messageInStorageContent.replace(/(\r\n|\n)/g, "<br>");
				
				readMessageGetInStorageModal.show();
				
			}
			function getSessionId(){
				const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						if(response.result == "success"){
							mySessionId = response.userId; 
						}
					}
				}
				
				//get
				xhr.open("get", "./getMyId", false); // 딱 여기만 쓰세요...false 동기식 호출..! 권장되지 않음
				xhr.send();		
			}
			
			function changeBackGround() {	
				if (changeBackColor) {
					var container = document.querySelector('.container-fluid');
					container.style.backgroundColor = '#444444';
					
					var otherElements = container.querySelectorAll(':not(.container)');
					otherElements.forEach(function(element) {
						element.style.color = 'white';
					});
					changeBackColor = false;
				} else {
					var container = document.querySelector('.container-fluid');
					container.style.backgroundColor = 'white';
					
					var otherElements = container.querySelectorAll(':not(.container)');
					otherElements.forEach(function(element) {
						element.style.color = 'black';
					});
					changeBackColor = true;
				}
				
				
			}
			// 받은 쪽지 리스트
			function reloadMessageGet(){
				const xhr = new XMLHttpRequest();
							
							xhr.onreadystatechange = function(){
								if(xhr.readyState == 4 && xhr.status == 200){
									const response = JSON.parse(xhr.responseText);
									// js 작업..
									const targetCol = document.getElementById("targetCol");
													
									const messageType = document.getElementById("messageType");
									
									messageType.innerText = "받은 쪽지함";
									
									// 기존의 쪽지 목록을 찾아 제거
									
									
								      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
								      existingRows.forEach(function(row) {
								        targetCol.removeChild(row);
								      });
								      
								      
								      
									
									for(let data of response.messageGetList){
									console.log(response);
									if (data.messageDto.message_status && data.messageDto.message_status.indexOf("받은쪽지삭제") >= 0) {
										
									}else{									
										
									var messageId = data.messageDto.message_id;
									var messageNickName = data.userDto.user_nickname;
									var messageTitle = data.messageDto.message_title;
									var messageSendReceiver = data.messageDto.user_nickname;
									const messageContent = data.messageDto.message_content;
	
									var messageSendDate = new Date(data.messageDto.message_reg_date);
									
									var messageSendDateFormatted = formatDate(messageSendDate, 'yy-MM-dd hh:mm:ss');
									
									const row1 = document.createElement("div");
									row1.classList.add("row", "border-top", "border-1", "p-3");
									row1.setAttribute("id", "messageGetRow1");
									row1.setAttribute("messageSendReceiver", messageSendReceiver);
									
									const row1col1 = document.createElement("div");
									row1col1.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col1);
									
									const input1 = document.createElement("input");
									input1.classList.add("form-check-input");
									input1.type = "checkbox";
									input1.value = "";
									input1.id = "flexCheckDefault";
									row1col1.appendChild(input1);
									
									const row1col2 = document.createElement("div");
									row1col2.classList.add("col-auto", "d-flex", "align-self-center");
									row1col2.id ="row1col2";
									row1.appendChild(row1col2);
									
									const i1 = document.createElement("i");
									if(data.messageDto.message_status && data.messageDto.message_status.indexOf("받은쪽지보관") >= 0){
									i1.classList.add("bi", "bi-star-fill","aa");
									
									}else{
									i1.classList.add("bi", "bi-star");
									}
									i1.setAttribute("onclick", "toggleStarGet(" + messageId + ")");
									console.log(messageId);
									row1col2.appendChild(i1);
									
									const row1col3 = document.createElement("div");
									row1col3.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col3);
									
									const i2 = document.createElement("i");
									if(data.messageDto.message_read_date == null){
										i2.classList.add("bi", "bi-envelope");
									}else {
										i2.classList.add("bi", "bi-envelope-open");
									}
									row1col3.appendChild(i2);
									
									
									
									const row1col4 = document.createElement("div");
									row1col4.classList.add("col", "align-self-center","text-center");
									row1col4.innerText = data.userDto.user_nickname;
									row1.appendChild(row1col4);
									
									const row1col5 = document.createElement("div");
									row1col5.classList.add("col", "d-flex", "align-self-center");
									row1col5.setAttribute("id", "row1col5");
									row1col5.innerText = data.messageDto.message_title;
									row1col5.setAttribute("messageTitle", messageTitle);
									row1col5.setAttribute("messageNickName", messageNickName);
									row1col5.setAttribute("messageSendDateFormatted", messageSendDateFormatted);
									row1col5.setAttribute("messageContent", messageContent);
									row1col5.setAttribute("messageId", messageId);
									
									row1col5.setAttribute("onclick", "openMessageGetPage('" + messageId + "','" + messageTitle +
						                      "','" + messageNickName + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
									row1col5.style = "cursor : pointer"
									row1.appendChild(row1col5);
									
									
									
									
									
									const row1col6 = document.createElement("div");
									row1col6.classList.add("col", "align-self-center", "text-center", "ms-2");
									row1col6.innerText = messageSendDateFormatted;
									row1.appendChild(row1col6);
									
	
									
									const row1col7 = document.createElement("div");
									row1col7.classList.add("col", "align-self-center", "text-center", "ms-auto");
									row1.appendChild(row1col7);
									
									const deleteButton = document.createElement("button");
									deleteButton.classList.add("btn", "btn-sm", "border", "border-dark");
									deleteButton.type = "button";
									deleteButton.setAttribute("onclick", "deleteMessageGet(" + messageId + ")");
									deleteButton.innerText = "삭제";
									deleteButton.setAttribute("id", "deleteButton");
									row1col7.appendChild(deleteButton);
									
									targetCol.appendChild(row1);
									
									
									}
									}
									
								   
								}
							}
							
							//get
							xhr.open("get", "./reloadMessageGet");
							xhr.send();
							
	
			}
			
			// 보낸 메시지 리스트
			function reloadMessageSend(){
				
				const xhr = new XMLHttpRequest();
							
							xhr.onreadystatechange = function(){
								if(xhr.readyState == 4 && xhr.status == 200){
									const response = JSON.parse(xhr.responseText);
									// js 작업..
									const targetCol = document.getElementById("targetCol");
									
									const messageType = document.getElementById("messageType")
									messageType.innerText = "보낸 쪽지함";
									
									
									// 기존의 쪽지 목록을 찾아 제거
								      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
								      existingRows.forEach(function(row) {
								        targetCol.removeChild(row);
								      });
									
									for(data of response.messageSendList){
									if (data.message_status && data.message_status.indexOf("보낸쪽지삭제") >= 0) {
										
									}
									else{
									var messageId = data.message_id;
									var messageTitle = data.message_title;
									var messageReceiver = data.user_nickname;
									var messageContent = data.message_content;
									var messageSendDate = new Date(data.message_reg_date);
									
									var messageSendDateFormatted = formatDate(messageSendDate, 'yy-MM-dd hh:mm:ss');
									
									const row1 = document.createElement("div");
									row1.classList.add("row", "border-top", "border-1", "p-3");
									
									const row1col1 = document.createElement("div");
									row1col1.classList.add("col-auto", "d-flex", "align-self-center");
									row1.appendChild(row1col1);
									
									const input1 = document.createElement("input");
									input1.classList.add("form-check-input");
									input1.type = "checkbox";
									input1.value = "";
									input1.id = "flexCheckDefault";
									row1col1.appendChild(input1);
									
									const row1col2 = document.createElement("div");
									row1col2.classList.add("col-auto", "d-flex", "align-self-center");
									row1col2.id = "row1col2";
									row1.appendChild(row1col2);
									
									const istar2 = document.createElement("i");
									if(data.message_status && data.message_status.indexOf("받은쪽지보관") >= 0){
									istar2.classList.add("bi", "bi-star-fill", "aa");
									}else{
									istar2.classList.add("bi", "bi-star");
									}
									istar2.setAttribute("id", "restoreStar");
									istar2.setAttribute("onclick", "toggleStarSend(" + messageId + ")");
									row1col2.appendChild(istar2);
									
									const row1col3 = document.createElement("div");
									row1col3.classList.add("col-2", "align-self-center", "text-center");																
									row1.appendChild(row1col3);
									
									if(data.message_read_date == null) {
									const notReadMark = document.createElement("span");
									notReadMark.classList.add("badge", "text-wrap", "bg-secondary");
									notReadMark.innerText = "읽지않음";	
									row1col3.appendChild(notReadMark);
									} else {
									const readMark = document.createElement("span");
									readMark.classList.add("badge", "text-wrap", "bg-primary");
									readMark.innerText = "읽음";
									row1col3.appendChild(readMark);
									}
									

									
									
									const row1col4 = document.createElement("div");
									row1col4.classList.add("col", "align-self-center","text-center");
									row1col4.innerText = data.user_nickname;
									row1.appendChild(row1col4);
									
									const row1col5 = document.createElement("div");
									row1col5.classList.add("col", "d-flex", "align-self-center");
									row1col5.innerText = data.message_title;
									row1col5.setAttribute("id", "row1col5");
									row1col5.setAttribute("messageTitle", messageTitle);
									row1col5.setAttribute("messageReceiver", messageReceiver);
									row1col5.setAttribute("messageContent", messageContent);
									row1col5.setAttribute("messageSendDateFormatted", messageSendDateFormatted);
									row1col5.setAttribute("onclick", "openMessageSendPage('" + messageTitle +
						                      "','" + messageReceiver + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
									row1col5.style = "cursor : pointer"
									row1.appendChild(row1col5);
									
									
									const row1col6 = document.createElement("div");
									row1col6.classList.add("col", "align-self-center", "text-center", "ms-2");
									row1col6.innerText = messageSendDateFormatted;
									row1.appendChild(row1col6);
									
	
									
									const row1col7 = document.createElement("div");
									row1col7.classList.add("col", "align-self-center", "text-center", "ms-auto");
									row1.appendChild(row1col7);
									
									const deleteButton = document.createElement("button");
									deleteButton.classList.add("btn", "btn-sm", "border", "border-dark");
									deleteButton.type = "button";
									deleteButton.setAttribute("onclick", "deleteMessageSend(" + messageId + ")");
									deleteButton.innerText = "삭제";
									deleteButton.setAttribute("id", "deleteButton");
									row1col7.appendChild(deleteButton);
									
									targetCol.appendChild(row1);
									
									refreshStar(messageId);
										}
									
	
									}
								}
							}
							
							//get
							xhr.open("get", "./reloadMessageSend");
							xhr.send();
							
	
					
			}
			
					// 휴지통 리스트 띄우기
					function reloadTrash() {
						const xhr = new XMLHttpRequest();
						
						xhr.onreadystatechange = function(){	
							if(xhr.readyState == 4 && xhr.status == 200){
								const response = JSON.parse(xhr.responseText);
								// js 작업..
								const messageType = document.getElementById("messageType")
								messageType.innerText = "휴지통";
								const userId = response.userId;
								
								const targetCol = document.getElementById("targetCol");
								

								

								
								// 기존의 쪽지 목록을 찾아 제거
							      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
							      existingRows.forEach(function(row) {
							        targetCol.removeChild(row);
							      });
								
							      
								
								
								for(data of response.list){
								//휴지통에 있는 받은 메시지를 보낸사람
								var messageGetInTrashSender = data.userDto.user_nickname;
								//휴지통에 있는 보낸 메시지의 받는사람 
								var messageSendInTrashReceiver = data.messageDto.user_nickname;
								var messageInTrashTitle = data.messageDto.message_title;
								var messageInTrashSendDate = new Date(data.messageDto.message_reg_date);
								var messageSendDateFormatted = formatDate(messageInTrashSendDate, 'yy-MM-dd hh:mm:ss');							
								var messageInTrashContent = data.messageDto.message_content;
								var messageId = data.messageDto.message_id;
								
								
								const containerDiv = document.createElement('div');
								containerDiv.classList.add('row', 'border-top', 'border-1', 'p-3');
								containerDiv.id = 'trashList';

								// 체크박스 div 생성
								const checkboxDiv = document.createElement('div');
								checkboxDiv.classList.add('col-auto', 'd-flex', 'align-self-center');
								containerDiv.appendChild(checkboxDiv);

								// 체크박스 input 생성
								const checkboxInput = document.createElement('input');
								checkboxInput.type = 'checkbox';
								checkboxInput.classList.add('form-check-input');
								checkboxInput.value = '';
								checkboxInput.id = 'flexCheckDefault';
								checkboxDiv.appendChild(checkboxInput);

								// 닉네임 div 생성
								const nicknameDiv = document.createElement('div');
								nicknameDiv.classList.add('col', 'align-self-center', 'text-center');
								nicknameDiv.id = 'messageInTrashNickName';

								// 보낸쪽지일 경우
								if(parseInt(data.messageDto.user_id) === parseInt(userId)){
									
									
									
									const messageSendMark = document.createElement("span");
									messageSendMark.classList.add("badge", "text-wrap", "bg-secondary");
									messageSendMark.innerText = "보낸쪽지";
									
									nicknameDiv.appendChild(messageSendMark);
									
									const receiverNickname = document.createElement("span");
									receiverNickname.classList.add("text", "ms-2");
									receiverNickname.innerText = data.messageDto.user_nickname;
									
									nicknameDiv.appendChild(receiverNickname);
									
									
									
								}else{ //받는 쪽지일 경우
									nicknameDiv.innerText = data.userDto.user_nickname;						
								}								
								
								containerDiv.appendChild(nicknameDiv);
								
								
								
								// 제목 div 생성
								const titleDiv = document.createElement('div');
								titleDiv.classList.add('col', 'd-flex', 'align-self-center');
								//보낸 메시지일 경우
								if(parseInt(data.messageDto.user_id) === parseInt(userId)){
								console.log(data.messageDto.user_id);
								console.log(userId);
								titleDiv.setAttribute("onclick", "openMessageSendInTrashPage('" + messageInTrashTitle +
					                      "','" + messageSendInTrashReceiver + "','" + messageSendDateFormatted + "'," +
					                      JSON.stringify(messageInTrashContent).replace(/(\r\n|\n)/g, "<br>") + ")");
								}else{ //받은 메시지일 경우
									titleDiv.setAttribute("onclick", "openMessageGetInTrashPage('" + messageInTrashTitle +
						                      "','" + messageGetInTrashSender + "','" + messageSendDateFormatted + "'," +
						                      JSON.stringify(messageInTrashContent).replace(/(\r\n|\n)/g, "<br>") + ")");	
								}
								titleDiv.style.cursor = 'pointer';
								titleDiv.id = 'messageInTrashTitle';
								titleDiv.innerText = messageInTrashTitle;
								containerDiv.appendChild(titleDiv);

								// 전송일 div 생성
								const sendDateDiv = document.createElement('div');
								sendDateDiv.classList.add('col', 'align-self-center', 'text-center', 'ms-2');
								sendDateDiv.id = 'messageInTrashSendDate';
								sendDateDiv.innerText = messageSendDateFormatted;
								containerDiv.appendChild(sendDateDiv);
								
								// 빈 col 생성
								const blankDiv = document.createElement('div');
								blankDiv.classList.add('col-1');
								containerDiv.appendChild(blankDiv);
								
								const colDiv = document.createElement("div");
								colDiv.classList.add("col-3");

								
								const deleteButtonSpan = document.createElement("span");
								
								const deleteButton = document.createElement("button");
								deleteButton.classList.add("btn", "btn-sm", "border", "border-dark");
								deleteButton.id = "deleteButton";
								deleteButton.type = "button";
								deleteButton.innerText = "영구삭제";
								deleteButton.setAttribute("onclick", "deleteMessageInTrash(" + messageId + ")");

								deleteButtonSpan.appendChild(deleteButton);
								
								const restoreButtonSpan = document.createElement("span");
								
								const restoreButton = document.createElement("button");
								restoreButton.classList.add("btn", "btn-sm", "border", "border-dark", "ms-2");
								restoreButton.id = "restoreButton";
								restoreButton.type = "button";
								restoreButton.innerText = "복구";
								restoreButton.setAttribute("onclick", "restoreMessageInTrash(" + messageId + ")");

								restoreButtonSpan.appendChild(restoreButton);
								
								colDiv.appendChild(deleteButton);
								colDiv.appendChild(restoreButton);
								
								containerDiv.appendChild(colDiv);
								
								targetCol.appendChild(containerDiv);
								
								
								}
							}
						}
						
						//get
						xhr.open("get", "./reloadTrash");
						xhr.send();
	
			}
			
					
			function deleteMessageInTrash(messageId) {
				const xhr = new XMLHttpRequest();
				if(confirm("영구 삭제하시겠습니까?")){
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadTrash();
					}
				}
				
				//get
				xhr.open("get", "./deleteMessageInTrash?messageId=" + messageId);
				xhr.send();
				}
			}
			
			
			//보관함 리스트 불러오기
			function reloadStorage() {
				const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						
						const messageType = document.getElementById("messageType")
						messageType.innerText = "보관함";
						const userId = response.userId;
						
						const targetCol = document.getElementById("targetCol");
						

						

						
						// 기존의 쪽지 목록을 찾아 제거
					      const existingRows = targetCol.querySelectorAll(".row.border-top.border-1.p-3");
					      existingRows.forEach(function(row) {
					        targetCol.removeChild(row);
					      });
						
					      
						
						
						for(data of response.list){
						//보관함에 있는 받은 메시지를 보낸사람
						var messageGetInStorageSender = data.userDto.user_nickname;
						//보관함에 있는 보낸 메시지의 받는사람 
						var messageSendInStorageReceiver = data.messageDto.user_nickname;
						var messageInStorageTitle = data.messageDto.message_title;
						var messageInStorageSendDate = new Date(data.messageDto.message_reg_date);
						var messageSendDateFormatted = formatDate(messageInStorageSendDate, 'yy-MM-dd hh:mm:ss');							
						var messageInStorageContent = data.messageDto.message_content;
						var messageId = data.messageDto.message_id;
						
						
						const containerDiv = document.createElement('div');
						containerDiv.classList.add('row', 'border-top', 'border-1', 'p-3');
						containerDiv.id = 'storageList';

						// 체크박스 div 생성
						const checkboxDiv = document.createElement('div');
						checkboxDiv.classList.add('col-auto', 'd-flex', 'align-self-center');
						containerDiv.appendChild(checkboxDiv);

						// 체크박스 input 생성
						const checkboxInput = document.createElement('input');
						checkboxInput.type = 'checkbox';
						checkboxInput.classList.add('form-check-input');
						checkboxInput.value = '';
						checkboxInput.id = 'flexCheckDefault';
						checkboxDiv.appendChild(checkboxInput);

						// 닉네임 div 생성
						const nicknameDiv = document.createElement('div');
						nicknameDiv.classList.add('col', 'align-self-center', 'text-center');
						nicknameDiv.id = 'messageInStorageNickName';

						// 보낸쪽지일 경우
						if(parseInt(data.messageDto.user_id) === parseInt(userId)){
							
							
							
							const messageSendMark = document.createElement("span");
							messageSendMark.classList.add("badge", "text-wrap", "bg-secondary");
							messageSendMark.innerText = "보낸쪽지";
							
							nicknameDiv.appendChild(messageSendMark);
							
							const receiverNickname = document.createElement("span");
							receiverNickname.classList.add("text", "ms-2");
							receiverNickname.innerText = data.messageDto.user_nickname;
							
							nicknameDiv.appendChild(receiverNickname);
							
							
							
						}else{ //받는 쪽지일 경우
							nicknameDiv.innerText = data.userDto.user_nickname;						
						}								
						
						containerDiv.appendChild(nicknameDiv);
						
						
						
						// 제목 div 생성
						const titleDiv = document.createElement('div');
						titleDiv.classList.add('col', 'd-flex', 'align-self-center');
						//보낸 메시지일 경우
						if(parseInt(data.messageDto.user_id) === parseInt(userId)){
						console.log(data.messageDto.user_id);
						console.log(userId);
						titleDiv.setAttribute("onclick", "openMessageSendInStoragePage('" + messageInStorageTitle +
			                      "','" + messageSendInStorageReceiver + "','" + messageSendDateFormatted + "'," +
			                      JSON.stringify(messageInStorageContent).replace(/(\r\n|\n)/g, "<br>") + ")");
						}else{ //받은 메시지일 경우
							titleDiv.setAttribute("onclick", "openMessageGetInStoragePage('" + messageInStorageTitle +
				                      "','" + messageGetInStorageSender + "','" + messageSendDateFormatted + "'," +
				                      JSON.stringify(messageInStorageContent).replace(/(\r\n|\n)/g, "<br>") + ")");	
						}
						titleDiv.style.cursor = 'pointer';
						titleDiv.id = 'messageInStorageTitle';
						titleDiv.innerText = messageInStorageTitle;
						containerDiv.appendChild(titleDiv);

						// 전송일 div 생성
						const sendDateDiv = document.createElement('div');
						sendDateDiv.classList.add('col', 'align-self-center', 'text-center', 'ms-2');
						sendDateDiv.id = 'messageInStorageSendDate';
						sendDateDiv.innerText = messageSendDateFormatted;
						containerDiv.appendChild(sendDateDiv);

						// 보관해제 버튼 div 생성
						const cancelRestore = document.createElement('div');
						cancelRestore.classList.add('col', 'align-self-center', 'text-center', 'ms-auto');
						
						containerDiv.appendChild(cancelRestore);

						// 보관해제 버튼 생성
						const cancelButton = document.createElement('button');
						cancelButton.classList.add('btn', 'btn-sm', 'border', 'border-dark');
						cancelButton.id = 'deleteButton';
						cancelButton.type = 'button';
						cancelButton.setAttribute("onclick", "cancelRestore(" + messageId +")");
						cancelButton.textContent = '보관해제';
						cancelRestore.appendChild(cancelButton);
						
						
						
						targetCol.appendChild(containerDiv);
						}
					}
				}
				
				//get
				xhr.open("get", "./reloadStorage");
				xhr.send();
				
				
			
		}
			
			function toggleStarGet(messageId) {
				const xhr = new XMLHttpRequest();
				console.log(messageId);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadMessageGet();
					}
				}
				
				//get
				xhr.open("get", "./toggleStar?messageId=" + messageId);
				xhr.send();
				

			}
			
			function toggleStarSend(messageId) {
				const xhr = new XMLHttpRequest();
				console.log(messageId);
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						reloadMessageSend();
					}
				}
				
				//get
				xhr.open("get", "./toggleStar?messageId=" + messageId);
				xhr.send();
				

			}
			
			function refreshStar(messageId){
				const xhr = new XMLHttpRequest();
				
				xhr.onreadystatechange = function(){
					if(xhr.readyState == 4 && xhr.status == 200){
						const response = JSON.parse(xhr.responseText);
						// js 작업..
						const restoreStar = document.getElementById("restoreStar");
						if(response.isStored){
							
							restoreStar.classList.remove("bi-star");
							restoreStar.classList.add("bi-star-fill");
						}
					}
				}
				
				//get
				xhr.open("get", "./refreshStar?messageId=" + messageId);
				xhr.send();
				

				
			}
			
			window.addEventListener("DOMContentLoaded", function(){
				//사실상 시작 시점...
				reloadMessageGet();
			});
								
		</script>
	
	</head>
	<body>
		<div class="container-fluid">
			<jsp:include page="../common/mainTopNavi.jsp"></jsp:include>
			<div class="container-fluid">
	
				<div class="row mt-5 mb-3">
					<div class="col-2 rounded ms-4"
						style="background-color: #e8e8e8; height: 100vh; width : 15%;">
						<div class="row">
							<div class="col p-3 text-white text-center rounded-top"
								style="background-color: #17b75e">쪽지함</div>
						</div>
						
						<div class="row">
							<div class="col text-center p-3 border-secondary border-2 border-bottom"
								style="-bs-border-opacity: .5;">
								<button class="btn btn-defualt btn-lg border border-dark"
									type="button" onclick="location.href='./writeMessage'">쪽지쓰기</button>
							</div>
						</div>
						
						<div class="row border-secondary border-2 border-bottom" onclick="reloadMessageGet()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:16px;">
								<i class="bi bi-envelope"></i>
							</div>
							<div class="col-2 p-3 text-center"
								style="-bs-border-opacity: .5; margin-left:-28px;">
								<i class="bi bi-arrow-left"></i>
							</div>
							<div class="col-6 text-start p-3" style="-bs-border-opacity: .5; margin-left:-12px;">
								받은쪽지
							</div>
						</div>
						
						<div class="row border-secondary border-2 border-bottom" onclick="reloadMessageSend()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:16px;">
								<i class="bi bi-envelope"></i>
							</div>
							<div class="col-2 p-3 text-center"
								style="-bs-border-opacity: .5; margin-left:-28px;">
								<i class="bi bi-arrow-right"></i>
							</div>
							<div class="col-6 p-3 text-start"	style="-bs-border-opacity: .5; margin-left:-12px;">
								보낸쪽지
							</div>
						</div>
						
						<div class="row border-secondary border-2 border-bottom" id="trashButton" onclick="reloadTrash()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:30px;">
								<i class="bi bi-trash"></i>
							</div>
							<div class="col-6 text-center p-3"
								
								style="-bs-border-opacity: .5; margin-left: -36px">휴지통
							</div>
						</div>
						
						<div class="row text-center border-secondary border-2 border-bottom" id="storageButton" onclick="reloadStorage()" style = "cursor: pointer;">
							<div class="col-4 p-3 text-end"
								style="-bs-border-opacity: .5; margin-left:30px;">
								<i class="bi bi-star-fill aa"></i>
							</div>
							<div class="col-6 text-center p-3"
								
								style="-bs-border-opacity: .5; margin-left: -36px">보관함
							</div>
						</div>
					</div>
	
					<div class="col-9 mx-4">
						<div class="row">
							<div class="col" id="targetCol">
								<div class="row mb-3 h2">
									<div class="col" id="messageType">받은 쪽지함</div>
								</div>
								<div class="row mb-3">
									<div class="col-auto mx-3 align-self-center me-0">
										<input class="form-check-input" type="checkbox" value=""
											id="flexCheckDefault">
									</div>
	
									<div class="col-auto">
										<button class="btn btn-sm btn-default border border-dark"
											type="button" onclick="location.href='./deleteMessageAllProcess'">
										삭제</button>
									</div>
									<div class="col-6">
									
									</div>
									<div class="col-auto my-auto" style="margin-right: -10px;">
									    <i class="bi bi-search"></i>
									  </div>
									  <div class="col-auto">
									    <input type="text" id="inputPassword6" class="form-control" aria-labelledby="passwordHelpInline">
									  </div>
									  <div class="col-auto my-auto">
									    <button type="button" class="btn btn-primary btn btn-sm">검색</button>
									  </div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	
		<div class="fixed-bottom" role="alert">
			<div class="row">
				<div class="ms-auto col-3 alert alert-success">읽지 않은 쪽지가 3개
					있습니다.</div>
				<div class="col-1"></div>
			</div>
	
		</div>
	
		<div class="modal fade" id="readMessageGetModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">받은 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetSender"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2 text-end">
							<button type="button" class="btn"
								style="background-color: #17b75e; color: white;">답장</button>
						</div>
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								onclick="reloadMessageGet()" data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
		<div class="modal fade" id="readMessageSendModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">보낸 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendReceiver"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	
		<div class="modal fade" id="readMessageSendInTrashModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendInTrashTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendInTrashReceiverModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendInTrashSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendInTrashContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageGetInTrashModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetInTrashTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetInTrashSenderModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetInTrashSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetInTrashContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageSendInStorageModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageSendInStorageTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">받는 사람</div>
							<div class="col" id="messageSendInStorageReceiverModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageSendInStorageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageSendInStorageContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal fade" id="readMessageGetInStorageModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header"
						style="background-color: #17b75e; color: white;">
						<h1 class="modal-title fs-5" id="exampleModalLabel">삭제된 쪽지</h1>
						<button type="button" class="btn-close btn-light"
							data-bs-dismiss="modal" aria-label="Close" style="color: white;"></button>
					</div>
					<div class="modal-body" style="padding-top: 0;">
						<div class="row mt-3">
							<div class="col-3">제목</div>
							<div class="col" id="messageGetInStorageTitle"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 사람</div>
							<div class="col" id="messageGetInStorageSenderModal"></div>
						</div>
						<div class="row mt-1">
							<div class="col-3">보낸 시간</div>
							<div class="col" id="messageGetInStorageSendTime"></div>
						</div>
						<div class="row mt-3">
							<div class="col mx-2 px-0 border border-2" id="messageGetInStorageContent"
								style="width: 50%; height: 200px; overflow-y: scroll;"></div>
						</div>
					</div>
					<div class="modal-footer justify-content-center">
						<div class="col-2">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		

		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
			crossorigin="anonymous"></script>
	</body>
	</html>