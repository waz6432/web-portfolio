	var searchWord;
	var searchType;
	var pageNum = 1;
	var pageSize = 10;
	var totalCount = 0;
	var isLoading = false; // 추가 데이터를 가져오는 중인지 여부를 나타내는 변수

	window.onload = function() {
		searchType = 'latest';
		searchWord = "";
		travelList();

		var searchTypeSelect = document.getElementById('searchType');
		var searchWordSelect = document.getElementById('searchWord');

		// searchWord 값이 변경되었을 때 호출되는 함수
		searchWordSelect.addEventListener('change', function() {
			searchWord = searchWordSelect.value;
			pageNum = 1; // 검색어가 변경되면 페이지 번호를 초기화하고 새로운 리스트를 가져옵니다.
			clearListAndTravel();
		});

		// searchType 값이 변경되었을 때 호출되는 함수
		searchTypeSelect.addEventListener('change', function() {
			searchType = searchTypeSelect.value;
			pageNum = 1; // 검색어가 변경되면 페이지 번호를 초기화하고 새로운 리스트를 가져옵니다.
			clearListAndTravel();
		});
	}

	function goToTravelApplicationDetailPage(planningId) {
		var url = './plan/travelApplicationDetailPage?planning_id='
				+ planningId;
		window.location.href = url;
	}

	function travelList() {
		if (isLoading) {
			return; // 이미 데이터를 가져오는 중이면 중복 요청을 방지하기 위해 함수를 종료합니다.
		}

		const xhr = new XMLHttpRequest();

		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				const response = JSON.parse(xhr.responseText);

				var mainContainer = document.getElementById('mainContainer');

				// 기존 row 찾기 또는 새로 생성
				var existingRows = mainContainer.getElementsByClassName('row');
				var childRow;
				if (existingRows.length > 0) {
					childRow = existingRows[0];
				} else {
					childRow = document.createElement('div');
					childRow.setAttribute('class', 'row');
					childRow.classList.add('mt-3');
					mainContainer.appendChild(childRow);
				}

				// js로 논리 코드 및 DOM 조작...
				// CSR ... 클라이언트 사이드 렌더링... 헬게이트...
				if (response.list != null) {
					// 게시글 총 갯수 얻기
					totalCount = response.totalCount;

					for (let i = 0; i < response.list.length; i++) {
						// console.log(response.list[i]);

						var childCol = document.createElement('div');
						childCol.classList.add('col-3', 'mb-4');
						childRow.appendChild(childCol);

						var card = document.createElement('div');
						card.classList.add('card', 'shadow-lg');
						childCol.appendChild(card);

						// 이미지를 감싸는 부모 요소 생성
						var imageWrapper = document.createElement('div');
						imageWrapper.classList.add('image-wrapper');
						card.appendChild(imageWrapper);

						// 이미지 요소 생성
						var img = document.createElement('img');
						img.classList.add('card-img-top');
						img.setAttribute('src', '/uploadFiles/'
								+ response.list[i].plan.plan_thumbnail);
						imageWrapper.appendChild(img);

						// 오버레이 요소 생성
						var overlay = document.createElement('div');
						overlay.classList.add('overlay');
						imageWrapper.appendChild(overlay);

						var overlayText = document.createElement('div');
						overlayText.classList.add('overlayText', 'p-2');
						overlayText.innerText = '모집중 · '
								+ response.list[i].planning.planning_member
								+ '명';
						overlay.appendChild(overlayText);

						var cardBody = document.createElement('div');
						cardBody.classList.add('card-body', 'pb-2');
						card.appendChild(cardBody);

						var h5 = document.createElement('h5');
						h5.classList.add('card-title');
						h5.classList.add('text-truncate');
						h5.innerText = response.list[i].planning.planning_content;
						cardBody.appendChild(h5);

						var p = document.createElement('p');
						p.classList.add('card-title', 'cardTitle');
						p.innerText = response.list[i].planning.planning_title;
						cardBody.appendChild(p);

						var divSpan = document.createElement('div');
						divSpan.classList.add('divSpan', 'card-title');
						cardBody.appendChild(divSpan);

						var ageSpan = document.createElement('span');
						ageSpan.innerText = getAge(response.list[i].user.user_birth)
								+ '대 · ';
						divSpan.appendChild(ageSpan);

						var genderSpan = document.createElement('span');
						genderSpan.innerText = response.list[i].user.user_gender == 'M' ? '남성'
								: '여성';
						divSpan.appendChild(genderSpan);

						var span2 = document.createElement('span');
						span2.classList.add('ms-2');
						span2.innerText = response.list[i].user.user_nickname;
						divSpan.appendChild(span2);

						var calendarIcon = document.createElement('i');
						calendarIcon.classList.add('bi', 'bi-calendar-check',
								'me-2');

						var span1 = document.createElement('span');
						span1.classList.add('span1');
						span1.innerText = formatDate(response.list[i].planning.planning_start_date)
								+ ' - '
								+ formatDateAddDay(
										response.list[i].planning.planning_start_date,
										response.list[i].planDay)
								+ ' · '
								+ response.list[i].planDay + '일';
						span1.prepend(calendarIcon);
						cardBody.appendChild(span1);

						if (response.sessionUser != null) {
							var isSameUser = false;

							for (var j = 0; j < response.list[i].planningAcceptCount.length; j++) {
								if (response.list[i].planningAcceptCount[j].user_id == response.sessionUser.user_id) {
									isSameUser = true;
									break;
								}
							}
						}

						if (isSameUser) {
							card
									.addEventListener(
											'click',
											function() {
												goToTravelApplicationDetailPage(response.list[i].planning.planning_id);
											});
						} else {
							card.setAttribute('onclick', 'modalShow('
									+ JSON.stringify(response.list[i]) + ')');

							var iconWrapper = document.createElement('div');
							iconWrapper.classList.add('iconWrapper');
							imageWrapper.appendChild(iconWrapper);

							var pencilIcon = document.createElement('i');
							pencilIcon.classList.add('bi', 'bi-pencil-square',
									'pencilIcon');
							iconWrapper.appendChild(pencilIcon);

							var iconSpan = document.createElement('span');
							iconSpan.classList.add('iconSpan');
							iconSpan.innerText = '동행 신청';
							iconWrapper.appendChild(iconSpan);
						}
					}
					isLoading = false; // 데이터를 모두 처리한 후 isLoading 값을 false로 설정합니다.
				} else {
					console.error('게시글을 가져오는데 실패했습니다.');
				}
			}
			xhr.onerror = function() {
				console.error('네트워크 에러로 인해 게시글을 가져오는데 실패했습니다.');
			};
		};

		var params = 'pageNum=' + pageNum + '&searchType=' + searchType
				+ '&searchWord=' + encodeURIComponent(searchWord);
		xhr.open("get", "./plan/getTravelApplicationList?" + params);
		xhr.send();

		isLoading = true; // 데이터를 가져오는 중임을 나타내기 위해 isLoading 값을 true로 설정합니다.
	}

	window.onscroll = function() {
		var scrollTop = window.pageYOffset
				|| document.documentElement.scrollTop;
		var containerHeight = document.getElementById('mainContainer').offsetHeight;
		var windowHeight = window.innerHeight
				|| document.documentElement.clientHeight;

		if (scrollTop >= containerHeight - windowHeight && !isLoading) {
			pageNum++; // 페이지 번호를 증가시킵니다.

			if ((pageNum - 1) * pageSize < totalCount) {
				console.log(pageNum * pageSize);

				travelList();
			}
		}
	};

	function clearListAndTravel() {
		pageNum = 1;
		var mainContainer = document.getElementById('mainContainer');
		while (mainContainer.firstChild) {
			mainContainer.removeChild(mainContainer.firstChild);
		}
		travelList();
	}

	function modalShow(data) {
		createModal(data);
		modal = new bootstrap.Modal(document.getElementById('dynamicModal'));
		modal.show();
	}

	function removeModal() {
		var modal = document.getElementById('dynamicModal');
		modal.remove();
	}

	function createModal(data) {
		// 모달 요소 생성
		var modalDiv = document.createElement('div');
		modalDiv.classList.add('modal');
		modalDiv.classList.add('fade');
		modalDiv.id = 'dynamicModal';
		modalDiv.setAttribute('data-bs-backdrop', 'static');
		modalDiv.setAttribute('data-bs-keyboard', 'false');
		modalDiv.setAttribute('tabindex', '-1');
		modalDiv.setAttribute('aria-labelledby', 'dynamicModalLabel');
		modalDiv.setAttribute('aria-hidden', 'true');

		// 모달 다이얼로그 생성
		var modalDialogDiv = document.createElement('div');
		modalDialogDiv.classList.add('modal-dialog');
		modalDialogDiv.classList.add('modal-dialog-centered');
		modalDialogDiv.classList.add('modal-dialog-scrollable');
		modalDialogDiv.classList.add('modal-lg');

		// 모달 콘텐츠 생성
		var modalContentDiv = document.createElement('div');
		modalContentDiv.classList.add('modal-content');

		// 모달 헤더 생성
		var modalHeaderDiv = document.createElement('div');
		modalHeaderDiv.classList.add('modal-header');

		// 모달 제목 생성
		var modalTitleH1 = document.createElement('h1');
		modalTitleH1.classList.add('modal-title');
		modalTitleH1.classList.add('fs-5');
		modalTitleH1.id = 'dynamicModalLabel';
		modalTitleH1.innerText = data.planning.planning_title;

		// 모달 닫기 버튼 생성
		var closeButton = document.createElement('button');
		closeButton.type = 'button';
		closeButton.classList.add('btn-close');
		closeButton.setAttribute('data-bs-dismiss', 'modal');
		closeButton.setAttribute('aria-label', 'Close');
		closeButton.setAttribute('onclick', 'removeModal()');

		// 모달 바디 생성
		var modalBodyDiv = document.createElement('div');
		modalBodyDiv.classList.add('modal-body');

		// 모달 바디내 container생성
		var containerDiv = document.createElement('div');
		containerDiv.classList.add('container');
		modalBodyDiv.appendChild(containerDiv);

		// 모달 바디내 container내 row 생성
		var rowDiv = document.createElement('div');
		rowDiv.classList.add('row');
		containerDiv.appendChild(rowDiv);

		// 모달 바디내 container내 row내 col1 생성
		var col1Div = document.createElement('div');
		col1Div.classList.add('col');
		rowDiv.appendChild(col1Div);

		// 명소 리스트 row
		var placeRow = document.createElement('div');
		placeRow.classList.add('row', 'graphRow');
		col1Div.appendChild(placeRow);

		var placeCol = document.createElement('div');
		placeCol.classList.add('col');
		placeRow.appendChild(placeCol);

		// 그래프 요소 생성
		var graphElement = document.createElement('div');
		graphElement.classList.add('graph');

		// 라인 요소 생성
		var lineElement = document.createElement('div');
		lineElement.classList.add('line');
		graphElement.appendChild(lineElement);

		// 날짜 개수에 따른 동그라미의 위치 계산
		var circlePositions = [];
		var interval = 100 / (data.planDay - 1);
		for (var i = 1; i <= data.planDay; i++) {
			var position = (i - 1) * interval + '%';
			circlePositions.push(position);
		}

		// 팝오버를 닫는 이벤트 리스너를 문서에 한 번만 추가합니다.
		document.addEventListener('click', function(event) {
			var existingPopover = document.querySelector('.myPopover');
			if (existingPopover && !existingPopover.contains(event.target)) {
				existingPopover.remove();
			}
		});

		//날짜별로 동그라미와 날짜 요소 생성 및 추가
		for (let j = 0; j < data.planDay; j++) {
			let circle = document.createElement('div');
			circle.classList.add('circle');
			circle.style.left = circlePositions[j];
			graphElement.appendChild(circle);
			
			console.log(data.list2[j].placeList[0]);
			// 이미지 태그로 바꿔야함
			let thumbnail = document.createElement('img');
			thumbnail.classList.add('thumbnail');
			thumbnail.setAttribute('src', '/uploadFiles/mainImage/'+data.list2[j].placeList[0].plan_place_photo);
			circle.appendChild(thumbnail);

			let date = document.createElement('span');
			date.classList.add('date');
			date.style.left = circlePositions[j];
			date.textContent = 'Day' + (j + 1);
			graphElement.appendChild(date);

			// circle에 이벤트 리스너 추가
			circle.addEventListener('click', function(event) {
				// 이 이벤트가 문서의 이벤트 리스너로 전파되지 않도록 합니다.
				event.stopPropagation();

				// 팝오버 요소가 이미 존재하는 경우 제거
				var existingPopover = document.querySelector('.myPopover');
				if (existingPopover) {
					existingPopover.remove();
				}

				// 새 팝오버 요소 생성
				var popover = document.createElement('div');
				popover.classList.add('myPopover');
				
				var popoverInnerRow1 = document.createElement('div');
				popoverInnerRow1.classList.add('row');
				popover.appendChild(popoverInnerRow1);
				
				// 사진 리스트 추가
				var placeList = data.list2[j].placeList;
				for (let k = 0; k < placeList.length; k++) {
	
					var popoverInnerCol1 = document.createElement('div');
					popoverInnerCol1.classList.add('col-2');
					popoverInnerRow1.appendChild(popoverInnerCol1);
				
					// 이미지 태그로 바꿔야함
					let img = document.createElement('img');
					img.classList.add('popoverInnerImg');
					img.setAttribute('src', '/uploadFiles/mainImage/' + placeList[k].plan_place_photo);
					popoverInnerCol1.appendChild(img);
					
					let placeName = document.createElement('span');
					placeName.innerText = placeList[k].plan_place_name;
					popoverInnerCol1.appendChild(placeName);
				}

				// 팝오버 요소를 문서에 추가
				lineElement.appendChild(popover);
			});
		}

		placeCol.appendChild(graphElement);

		//////////////////////////////////// 그래프 끝

		// 첫 번째 row
		var row1 = document.createElement('div');
		row1.classList.add('row');
		row1.classList.add('mt-4');
		col1Div.appendChild(row1);

		var row1Col1 = document.createElement('div');
		row1Col1.classList.add('col');
		row1.appendChild(row1Col1);

		var row1Col1Icon = document.createElement('i');
		row1Col1Icon.classList.add('bi');
		row1Col1Icon.classList.add('bi-chat-square-dots');
		row1Col1Icon.classList.add('me-1');
		row1Col1.appendChild(row1Col1Icon);

		var row1Col1Span = document.createElement('span');
		row1Col1Span.innerText = '모집 내용';
		row1Col1.appendChild(row1Col1Span);

		var row1Col2 = document.createElement('div');
		row1Col2.classList.add('col-12');
		row1Col2.classList.add('mt-1');
		row1.appendChild(row1Col2);

		var row1Col2Span = document.createElement('span');
		row1Col2Span.classList.add('form-control');
		row1Col2Span.style.height = '300px';
		row1Col2Span.innerText = data.planning.planning_content;
		row1Col2.appendChild(row1Col2Span);

		// 두 번째 row
		var row2 = document.createElement('div');
		row2.classList.add('row');
		row2.classList.add('mt-2');
		col1Div.appendChild(row2);

		var row2Col1 = document.createElement('div');
		row2Col1.classList.add('col');
		row2.appendChild(row2Col1);

		var row2Col1Icon = document.createElement('i');
		row2Col1Icon.classList.add('bi');
		row2Col1Icon.classList.add('bi-geo-alt');
		row2Col1Icon.classList.add('me-1');
		row2Col1.appendChild(row2Col1Icon);

		var row2Col1Span = document.createElement('span');
		row2Col1Span.innerText = '모집 위치';
		row2Col1.appendChild(row2Col1Span);

		var row2Col2 = document.createElement('div');
		row2Col2.classList.add('col-12');
		row2Col2.classList.add('mt-1');
		row2.appendChild(row2Col2);

		var row2Col2Span = document.createElement('span');
		row2Col2Span.classList.add('form-control');
		row2Col2Span.innerText = data.planning.planning_start_point;
		row2Col2.appendChild(row2Col2Span);

		// 세 번째 row
		var row3 = document.createElement('div');
		row3.classList.add('row');
		row3.classList.add('mt-2');
		col1Div.appendChild(row3);

		var row3Col1 = document.createElement('div');
		row3Col1.classList.add('col');
		row3.appendChild(row3Col1);

		var row3Col1Icon = document.createElement('i');
		row3Col1Icon.classList.add('bi');
		row3Col1Icon.classList.add('bi-people');
		row3Col1Icon.classList.add('me-1');
		row3Col1.appendChild(row3Col1Icon);

		var row3Col1Span = document.createElement('span');
		row3Col1Span.innerText = '모집 인원';
		row3Col1.appendChild(row3Col1Span);

		var row3Col2 = document.createElement('div');
		row3Col2.classList.add('col');
		row3.appendChild(row3Col2);

		var row3Col2Icon = document.createElement('i');
		row3Col2Icon.classList.add('bi');
		row3Col2Icon.classList.add('bi-calendar-check');
		row3Col2Icon.classList.add('me-1');
		row3Col2.appendChild(row3Col2Icon);

		var row3Col2Span = document.createElement('span');
		row3Col2Span.innerText = '종료 날짜';
		row3Col2.appendChild(row3Col2Span);

		// 네 번째 row
		var row4 = document.createElement('div');
		row4.classList.add('row');
		col1Div.appendChild(row4);

		var row4Col1 = document.createElement('div');
		row4Col1.classList.add('col');
		row4.appendChild(row4Col1);

		var row4Col1Span = document.createElement('span');
		row4Col1Span.classList.add('form-control');
		row4Col1Span.id = 'memberCount';
		row4Col1Span.innerText = data.planningAcceptCount.length + ' / '
				+ data.planning.planning_member;
		row4Col1.appendChild(row4Col1Span);

		var row4Col2 = document.createElement('div');
		row4Col2.classList.add('col');
		row4.appendChild(row4Col2);

		var row4Col2Span = document.createElement('span');
		row4Col2Span.classList.add('form-control');
		row4Col2Span.innerText = data.planning.planning_start_date;
		row4Col2.appendChild(row4Col2Span);

		// 다섯 번째 row
		var row5 = document.createElement('div');
		row5.classList.add('row');
		row5.classList.add('mt-4');
		col1Div.appendChild(row5);

		var row5Col1 = document.createElement('div');
		row5Col1.classList.add('col');
		row5.appendChild(row5Col1);

		var row5Col1Icon = document.createElement('i');
		row5Col1Icon.classList.add('bi');
		row5Col1Icon.classList.add('bi-pencil-square');
		row5Col1Icon.classList.add('me-1');
		row5Col1.appendChild(row5Col1Icon);

		var row5Col1Span = document.createElement('span');
		row5Col1Span.innerText = '신청 코멘트';
		row5Col1.appendChild(row5Col1Span);

		var row5Col2 = document.createElement('div');
		row5Col2.classList.add('col-12');
		row5Col2.classList.add('mt-1');
		row5.appendChild(row5Col2);

		var formGroupDiv = document.createElement('div');
		formGroupDiv.classList.add('form-group');
		formGroupDiv.style.position = 'relative';

		// 폼 생성
		var form = document.createElement('form');
		form.setAttribute('method', 'POST');
		form.setAttribute('action',
				'./plan/travelApplicationProcess?planning_id='
						+ data.planning.planning_id);

		// textarea 생성
		var textarea = document.createElement('textarea');
		textarea.classList.add('form-control');
		textarea.placeholder = '작성...';
		textarea.id = 'floatingTextarea2';
		textarea.name = 'planning_application_content';
		textarea.style.height = '100px';
		textarea.style.resize = 'none';

		// "신청" 버튼 생성
		var submitButton = document.createElement('button');
		submitButton.type = 'submit';
		submitButton.classList.add('text-secondary');
		submitButton.classList.add('opacity-75');
		submitButton.classList.add('btn');
		submitButton.classList.add('btn-link');
		submitButton.style.textDecoration = 'none';
		submitButton.style.position = 'absolute';
		submitButton.style.bottom = '5px';
		submitButton.style.right = '5px';
		submitButton.innerText = '신청';

		// textarea와 버튼을 폼에 추가
		form.appendChild(textarea);
		form.appendChild(submitButton);

		formGroupDiv.appendChild(form);

		var label = document.createElement('label');
		label.setAttribute('for', 'floatingTextarea2');
		label.innerText = 'Comments';

		row5Col2.appendChild(formGroupDiv);

		// 모달 요소 구성
		modalHeaderDiv.appendChild(modalTitleH1);
		modalHeaderDiv.appendChild(closeButton);

		modalContentDiv.appendChild(modalHeaderDiv);
		modalContentDiv.appendChild(modalBodyDiv);

		modalDialogDiv.appendChild(modalContentDiv);

		modalDiv.appendChild(modalDialogDiv);

		// 모달을 추가할 요소 찾기 (예시로는 body로 가정)
		var targetElement = document.body;

		// 모달 추가
		targetElement.appendChild(modalDiv);
	}

	function formatDate(timestamp) {
		const startDate = timestamp;
		const dateObj = new Date(startDate);
		const month = dateObj.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
		const day = dateObj.getDate();

		return month + '/' + day;
	}

	function formatDateAddDay(timestamp, timestampDay) {
		const startDate = timestamp;
		const dateObj = new Date(startDate);
		const month = dateObj.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줍니다.
		const day = dateObj.getDate() + timestampDay;

		return month + '/' + day;
	}

	function getAge(timestamp) {
		// 생일(밀리초 단위의 타임스탬프)
		var birthday = timestamp; // 예시: 1992년 1월 1일

		// 현재 날짜(밀리초 단위의 타임스탬프)
		var currentDate = new Date().getTime();

		// 차이 계산
		var ageInMillis = currentDate - birthday;

		// 밀리초를 연령으로 변환
		var ageInYears = Math.floor(ageInMillis
				/ (1000 * 60 * 60 * 24 * 365.25));

		// 십의 자리로 내림
		var roundedAge = Math.floor(ageInYears / 10) * 10;

		return roundedAge;
	}