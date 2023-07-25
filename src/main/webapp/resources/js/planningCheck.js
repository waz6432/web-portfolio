/**
 * 
 */

function planningCheck(user_id, planning_id, value) {
	// AJAX (비동기식 자바스크립트 and xml) api 활용
	
	console.log(value);
	
	const xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4 && xhr.status == 200){
			const response = JSON.parse(xhr.responseText);
			
			// js로 논리 코드 및 DOM 조작...
			// CSR ... 클라이언트 사이드 렌더링... 헬게이트...
			if (response.planningStatus != null) {
				
				console.log(response.planningStatus);
				console.log(response.planning);
				console.log(response.planningAcceptCount);
				
				// 멤버 상태 텍스트 수정
				const statusText = document.getElementById('s' + user_id);
				statusText.innerText = response.planningStatus.planning_member_status;
				
				// 아이콘 그리기
				const newIcon = document.createElement('i');
				newIcon.classList.add('bi', 'bi-file-text', 'ms-2');
				newIcon.setAttribute('data-bs-toggle', 'collapse');
				newIcon.setAttribute('href', '#user' + user_id);
				newIcon.setAttribute('role', 'button');
				newIcon.setAttribute('aria-expanded', 'false');
				newIcon.setAttribute('aria-controls', 'collapseExample');
			  	
				// 자식 요소 추가
				statusText.appendChild(newIcon);
				
				// 모집 인원 업데이트
				const memberCount = document.getElementById('memberCount');
				memberCount.innerText = response.planningAcceptCount + ' / ' + response.planning.planning_member;
			}
		}
	};
	
	xhr.open("get", "./updateApplicationaStatusByUser?user_id=" + user_id +"&planning_id=" + planning_id + "&value=" + value);
	xhr.send();
}